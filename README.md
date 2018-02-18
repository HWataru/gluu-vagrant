# Gluu server

Edit `config.yaml` and finish installatioin of Gluu Server

```sh
> vagrant ssh
$ sudo /sbin/gluu-serverd-3.1.2 login
# cd /install/community-edition-setup/
# ./setup.py -e -n -f ./setup.properties
```

## Base box

see base branch.

## TODO

gluu setup.py `-cas` options doesn't work with default properties.

```sh
# ./setup.py -cas -e -n -f ./setup.properties
```

If you want install install CAS, Shibboleth SAML IDP and Asimba SAML Proxy, you should setup manually.

```sh
> vagrant ssh
$ sudo /sbin/gluu-serverd-3.1.2 login
# cd /install/community-edition-setup/
# ./setup.py
```