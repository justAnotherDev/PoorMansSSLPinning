# Poor Man's SSL Pinning

When performing network requests on a Mac/iOS device it is very easy for a bad actor to listen in and see all the information traveling to and from the device. Even if using `https` data can still be easily viewed in plain text by using a man in the middle proxy like [Charles](https://www.charlesproxy.com).

The common countermeasure to protect against this is by doing SSL Pinning. Unfortunately SSL pinning is both difficult and costly (requires a private SSL cert). SSL Pinning works against non-jailbroken devices, but there are existing jailbroken tweaks to quickly bypass pinning.

**Poor Man's SSL Pinning** is a simple check that will easily defeat MITM attacks on non-jailbroken phones without requiring a SSL cert or any complexities. All it does is check to see if a proxy is currently being used. If the call returns `true` simply don't execute the request.


## Usage

```swift
let url = URL(string: "www.someurl.com/private_api/get_contents")!
if url.isProxied {
    print("the url has been proxied, refusing to perform the request")
    return
}

// perform the request
```

## License
[MIT](https://choosealicense.com/licenses/mit/)