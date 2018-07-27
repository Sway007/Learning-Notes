## Configuration files

- location: _`/etc/salt/`_

## Salt Intro

- > Salt works by having a "master" server sending commands to one or multiple "minion" servers. The master server is the "command center". It is going to be the place where you store your configuration files, aka: "which server is the db, which is the web server, and what libraries and software they should have installed". The minions receive orders from the master. Minions are the servers actually performing work for your business.
- Pillars are tree-like structures of data defined on the Salt Master and passed through to minions. They allow confidential, targeted data to be securely sent only to the relevant minion.

- salt call:
    ```bash
    salt '<target>' <function> [arguments]
    ```

    - target filter:
        - grain system (-G)
        - regular expression (-E)
        - list (-L)
        - combined (-C)

# Python Client API

```python
class salt.client.LocalClient(c_path=u'/etc/salt/master', mopts=None, skip_perm_errors=False, io_loop=None, keep_loop=False, auto_reconnect=False)
```
- `LocalClient` is used to send a command to Salt minions to execute execution modules and return the results to the Salt Master.
- Importing and using LocalClient must be done on the same machine as the Salt Master and it must be done using the same user that the Salt Master is running as. (Unless external_auth is configured and authentication credentials are included in the execution).