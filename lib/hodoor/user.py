import fcntl, pwd, os
import yaml
from hodoor.config import CONFIG


class HodoorUser:
    def __init__(self):
        if "BBS_USER" in os.environ:
            self.__username = os.environ["BBS_USER"]
        elif "SUDO_USER" in os.environ:
            self.__username = os.environ["SUDO_USER"]
        else:
            self.__username = "bbs"

        pwent = pwd.getpwnam(self.__username)
        self.__uid = pwent.pw_uid
        self.__display_name = pwent.pw_gecos.rstrip(",")

        try:
            with open(os.path.join(CONFIG.data_dir, "userdata.{}.yaml".format(self.username))) as userdata_in:
                fcntl.lockf(userdata_in, fcntl.LOCK_SH)
                self.userdata = yaml.load(userdata_in)
        except FileNotFoundError:
            self.userdata = {}


    @property
    def username(self):
        return self.__username


    @property
    def uid(self):
        return self.__uid


    @property
    def display_name(self):
        return self.__display_name


    def save(self):
        with open(os.path.join(CONFIG.data_dir, "userdata.{}.yaml".format(self.username)), "a+") as userdata_out:
            fcntl.lockf(userdata_out, fcntl.LOCK_EX)
            userdata_out.seek(0, 0)
            userdata_out.truncate()
            yaml.dump(self.userdata, userdata_out)


USER = HodoorUser()
