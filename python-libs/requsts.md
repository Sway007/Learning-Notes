## Body Content Workflow

- By default, when you make a request, the body of the response is downloaded immediately. You  can override this behaviour and defer downloading the response body until you access the Response.content attribute with the stream parameter:

```python
tarball_url = 'https://github.com/requests/requests/tarball/master'
r = requests.get(tarball_url, stream=True)
```