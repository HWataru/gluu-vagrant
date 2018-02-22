# Gluu server

Setup Gluu server for centos/7 and Ubuntu-16.04. [I can not set up with Ansible](https://github.com/dotariel/gluu-vagrant), so I make simple shell scripts.

## Quick Start

Edit `config.yaml` for your environment.

```sh
> vagrant up
```

if you want to install Asimba Saml Proxy, oxAuth RP or Passport, add options to setup.py command in [setup_gluu.sh](./provision/setup_gluu.sh).

## MEMO

The Gluu Server 3.1.2 does not work by this provisioning scripts. It's seems ldap service could not start but I could not find the root case.

<https://support.gluu.org/installation/4037/identity-oxtrust-returns-503-service-unavailable-response/>
<https://support.gluu.org/installation/3971/gluu-server-503-error/>

```sh
root@sso# netstat -antlp | grep 1636 | grep LISTEN
# nothing....
root@sso# pgrep slapd
# nothing...
```