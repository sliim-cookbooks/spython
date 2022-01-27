Spython cookbook - Sliim's python cookbook
==========================================

Simple cookbook to manage python installations.  
[![Cookbook Version](https://img.shields.io/cookbook/v/spython.svg)](https://supermarket.chef.io/cookbooks/spython) 

Requirements
------------
#### Platforms
The following platforms and versions are tested and supported using Opscode's test-kitchen.
- Debian 9
- Debian 10
- Debian bullseye
- Ubuntu 16.04
- Ubuntu 18.04
- Centos 7

Attributes
----------
#### spython::2
| Key                                | Type        | Description                                                                                            |
| ---------------------------------- | ----------- | ------------------------------------------------------------------------------------------------------ |
| `[spython][2][packages]`           | Array       | System packages to install python 2 (default: platform specific).                                      |
| `[spython][2][pip_packages]`       | Hash        | Pip packages to install (default: `{}`).                                                               |
| `[spython][2][pip_upgrade]`        | Bool/String | Upgrade pip after python install (default: `false`). Pass a string to install specific version.        |
| `[spython][2][setuptools_upgrade]` | Bool/String | Upgrade setuptools after python install (default: `false`). Pass a string to install specific version. |

#### spython::3
| Key                                | Type        | Description                                                                                            |
| ---------------------------------- | ----------- | ------------------------------------------------------------------------------------------------------ |
| `[spython][3][packages]`           | Array       | System packages to install python 3 (default: platform specific).                                      |
| `[spython][3][pip_packages]`       | Hash        | Pip packages to install (default: `{}`).                                                               |
| `[spython][3][pip_upgrade]`        | Bool/String | Upgrade pip after python install (default: `false`). Pass a string to install specific version.        |
| `[spython][3][setuptools_upgrade]` | Bool/String | Upgrade setuptools after python install (default: `false`). Pass a string to install specific version. |

Usage
-----
#### spython::2
Just include `spython::2` in your node's `run_list` to install Python2:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[spython::2]"
  ]
}
```

#### spython::3
Just include `spython::3` in your node's `run_list` to install Python3:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[spython::3]"
  ]
}
```

LWRP
----
#### spython_runtime
Install python runtime
```
spython_runtime '3'
```

#### spython_package
Install python pip package
```
spython_package 'PyYaml' do
  runtime '3'
  version '3.13'
end
```

#### spython_venv
Create python virtualenv
```
spython_venv '/path/to/my/venv' do
  runtime '3'
end
```

#### spython_exec
Execute python command
```
spython_exec 'setup.py install' do
  runtime '3'
  cwd '/path/to/my/project'
end
```

#### spython_pip
Execute pip command
```
spython_pip 'install -r requirements.txt' do
  runtime '3'
  cwd '/path/to/my/project'
end
```

See resources files for more infos about resources properties.

Testing
-------
See [TESTING.md](TESTING.md)

Contributing
------------
See [CONTRIBUTING.md](CONTRIBUTING.md)

License and Authors
-------------------
Authors: Sliim <sliim@mailoo.org> 

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
