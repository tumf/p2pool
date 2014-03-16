## setup

```
bundle
```

## Chef usage

### set up node

```
knife prepare cook <node>
```

Edit generated node file

    vi chef-repo/nodes/<node>.json

as follows:

```
{
  "bitcoind": {
    "rpcpassword" : "your-rpc-password-here"
  },
  "run_list":[p2pool]
}
```

### provision

```
knife solo cook <node>
```

## Vagrant

```
vagrant up
```
