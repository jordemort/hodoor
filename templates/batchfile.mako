@echo off
d:
cd \doors\${doorname}
${command}
% if exitemu:
exitemu
% else:
echo Type 'exitemu' to exit the emulator.
% endif
