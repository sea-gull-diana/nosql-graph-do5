1. Go to *Open folder -> Plugins*.
2. Copy *apoc-5.24.0-core.jar* file to *plugins/* folder.
3. In Settings find line `dbms.security.procedures.unrestricted=jwt.security.*` and change it to include `,apoc.*`:

`dbms.security.procedures.unrestricted=jwt.security.*,apoc.*`

4. Restart the Noe4j instance.