# Gluu server

Edit `config.yaml` and finish installatioin of Gluu Server

```sh
> vagrant ssh
$ sudo /sbin/gluu-serverd-3.1.2 login
# cd /install/community-edition-setup/
# ./setup.py -asr -e -n -f ./setup.properties
```

## Base box

see base branch.

## MEMO

```sh
Install oxAuth OAuth2 Authorization Server? [Yes] :
Install oxTrust Admin UI? [Yes] :
Install LDAP Server? [Yes] :
Install (1) Gluu OpenDJ (2) OpenLDAP Gluu Edition [1|2] [1] :
Install Apache HTTPD Server [Yes] :
Install Shibboleth SAML IDP? [No] : y
Install Asimba SAML Proxy? [No] : y
Install oxAuth RP? [No] : y
Install Passport? [No] : y
Install JCE 1.8? [Yes] : y
```

<https://support.gluu.org/installation/4037/identity-oxtrust-returns-503-service-unavailable-response/>
<https://support.gluu.org/installation/3971/gluu-server-503-error/>

```sh
# netstat -antlp | grep 1636 | grep LISTEN
# ps -ef | grep slapd
```