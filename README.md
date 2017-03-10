# sal-saml
A Docker container for Sal that uses SAML

You will almost certainly need to edit `settings.py` and provide your own metadata.xml file from your SAML provider.

### settings.py changes you will certainly need to make
- `SAML_ATTRIBUTE_MAPPING` (These values come from OpenLDAP, Active Directory, etc)
- `SAML_CONFIG`
  - `entityid` Ex: https://sal.domain.tld/saml2/metadata/
  - `assertion_consumer_service` Ex: https://sal.domain.tld/saml2/acs/
  - `single_logout_service` Ex: https://sal.domain.tld/saml2/ls/ and https://sal.domain.tld/saml2/post
  - `required_attributes` - These should match the values from SAML_ATTRIBUTE_MAPPING
  - `idp`
    - `root url` Ex: https://app.onelogin.com/saml/metadata/1234567890
    - `single_sign_on_service` Ex: https://apps.onelogin.com/trust/saml2/http-post/sso/1234567890
    - `single_logout_service` Ex: https://apps.onelogin.com/trust/saml2/http-redirect/slo/1234567890

### An example Docker run

Please note that this docker run is **incomplete**, but shows where to pass the `metadata.xml` and `settings.py`

```bash
docker run -d --name="sal" \
-p 80:8000 \
-v /yourpath/metadata.xml:/home/docker/sal/sal/metadata.xml \
-v /yourpath/settings.py:/home/docker/sal/sal/settings.py \
--restart="always" \
macadmins/sal-saml:latest
```

For more information on what to put in your settings.py, look at https://github.com/knaperek/djangosaml2
