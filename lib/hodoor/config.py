import os, pwd
from frozendict import frozendict
import yaml


class HodoorConfigException(Exception): pass
class InvalidConfigDirException(HodoorConfigException): pass
class UnknownConfigDirException(HodoorConfigException): pass
class InvalidConfigException(HodoorConfigException): pass
class UnknownConfigKeyException(HodoorConfigException): pass


class DoorConfig:
    def __init__(self, parent, name, **kwargs):
        self.__parent = parent
        self.__name = name
        self.__config = {
            'path': None,
            'display_name': None,
            'description': None,
            'nodes': 1,
            'bps': 115200,
            'door_command': None,
            'sysop_command': None,
            'cron_command': None
        }

        for key, value in kwargs.items():
            if key not in self.__config:
                raise UnknownConfigKeyException("I don't know what to do with '{}' in doors.yaml")
            self.__config[key] = value

        for key, value in self.__config.items():
            if key == 'nodes' or key == 'bps':
                if type(value) is not int:
                    raise InvalidConfigException("'nodes' for door '{}' is not an int?".format(name))
                elif value < 1:
                    raise InvalidConfigException("You can't have less than 1 node for door '{}'".format(name))
            elif value is not None:
                if type(value) is not str:
                    raise InvalidConfigException("'{}' for door '{}' is not a string?".format(key, name))

        if self.__config['door_command'] is None:
            raise InvalidConfigException("Missing door_command for '{}'".format(name))

        if not os.path.isdir(self.path):
            raise InvalidConfigException("Path '{}' for door '{}' doesn't exist or isn't a directory".format(self.path, name))


    @property
    def name(self):
        return self.__name


    @property
    def path(self):
        if self.__config['path'] is None:
            return os.path.join(self.__parent.door_dir, self.name)
        return self.__config['path']


    @property
    def display_name(self):
        return self.__config['display_name']


    @property
    def description(self):
        return self.__config['description']


    @property
    def nodes(self):
        return self.__config['nodes']


    @property
    def bps(self):
        return self.__config['bps']


    @property
    def door_command(self):
        return self.__config['door_command']


    @property
    def sysop_command(self):
        return self.__config['sysop_command']


    @property
    def cron_command(self):
        return self.__config['cron_command']


class HodoorConfig:
    def __init__(self):
        if "HODOOR_CONFIG" in os.environ:
            if os.path.isdir(os.environ["HODOOR_CONFIG"]):
                self.__config_dir = os.environ["HODOOR_CONFIG"]
            else:
                raise InvalidConfigDirException("HODOOR_CONFIG '{}' doesn't exist or isn't a directory")
        elif os.path.isdir(os.path.join(os.path.expanduser("~"), ".hodoor")):
            self.__config_dir = os.path.join(os.path.expanduser("~"), ".hodoor")
        elif os.path.isdir("/etc/hodoor"):
            self.__config_dir = "/etc/hodoor"
        else:
            raise UnknownConfigDirException("Maybe you should set HODOOR_CONFIG?")

        self.__config = {
            "bbs_user": "bbs",
            "bbs_root": "/srv/bbs",
            "data_dir": None,
            "door_dir": None,
            "dos_dir": None,
            "lock_dir": "/run/lock",
            "run_dir": "/run/bbs",
            "template_dir": None
        }

        if os.path.exists(os.path.join(self.__config_dir, "config.yaml")):
            with open(os.path.join(self.__config_dir, "config.yaml"), "r") as config_in:
                config_yaml = yaml.load(config_in)
                if type(config_yaml) is not dict:
                    raise InvalidConfigException("Whoa buddy config.yaml isn't even a dict")

                for key, value in config_yaml.items():
                    if key not in self.__config:
                        raise UnknownConfigKeyException("I don't know what to do with '{}' in config.yaml".format(key))
                    if type(value) is not str:
                        raise InvalidConfigException("'{}' isn't even a string?".format(key))
                    if key.endswith("_dir") or key.endswith("_root"):
                        if not os.path.isdir(value):
                            raise InvalidConfigException("{} '{}' doesn't exist or isn't a directory".format(key, value))
                    elif key == 'bbs_user':
                        try:
                            pwd.getpwnam(value)
                        except KeyError:
                            raise InvalidConfigException("bbs_user '{}' doesn't exist?".format(value))

                    self.__config[key] = value

        self.__doors = {}

        if os.path.exists(os.path.join(self.__config_dir, "doors.yaml")):
            with open(os.path.join(self.__config_dir, "doors.yaml"), "r") as doors_in:
                doors_yaml = yaml.load(doors_in)
                if type(doors_yaml) is not dict:
                    raise InvalidConfigException("Whoa buddy doors.yaml isn't even a dict")

                for key, value in doors_yaml.items():
                    if type(value) is not dict:
                        raise InvalidConfigException("Whoa buddy '%s' in doors.yaml isn't even a dict".format(key))
                    self.__doors[key] = DoorConfig(self, key, **value)

        self.__doors = frozendict(self.__doors)


    @property
    def config_dir(self):
        return self.__config_dir


    @property
    def bbs_root(self):
        return self.__config["bbs_root"]


    @property
    def data_dir(self):
        if self.__config["data_dir"] is None:
            return os.path.join(self.bbs_root, 'data')
        return self.__config["data_dir"]


    @property
    def door_dir(self):
        if self.__config["door_dir"] is None:
            return os.path.join(self.bbs_root, 'doors')
        return self.__config["door_dir"]


    @property
    def doors(self):
        return self.__doors


    @property
    def dos_dir(self):
        if self.__config["dos_dir"] is None:
            return os.path.join(self.bbs_root, 'dos')
        return self.__config["dos_dir"]


    @property
    def lock_dir(self):
        return self.__config["lock_dir"]


    @property
    def run_dir(self):
        return self.__config["run_dir"]


    @property
    def template_dir(self):
        if self.__config["template_dir"] is None:
            return os.path.join(self.bbs_root, 'templates')
        return self.__config["template_dir"]


CONFIG = HodoorConfig()
