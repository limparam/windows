Basic config for windows deployment server (WDS)


1) Create silent$ file share:

GPEDIT
Computer Configuration → Windows Settings → Security Options

Accounts: Guest account status – change to Enabled
Network access: Let Everyone permissions apply to anonymous users – change to Enabled
Network access: Restrict anonymous access to Named Pipes and Shares – change to Disabled
Network access: Shares that can be accessed anonymously – enter name of share you created in the text field silent$

Security settings fo this folder - Everyone Read & execute

2) Setup answer file to your install.wim
3) Copy bat file to your share location
