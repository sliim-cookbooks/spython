# spython CHANGELOG

This file is used to list changes made in each version of the spython cookbook.

## 0.4.0

### Breaking changes

- This cookbook now requires `Chef >= 14.14`.
- `spython_runtime`: property `version` changed to `runtime`.

### Changes

- Add `unified_mode` true to the resources [#1](https://github.com/sliim-cookbooks/spython/pull/1).
- Reload automatic `pip` attributes after package installation.
- Provides `languages/python2` & `languages/python3` automatic attributes.
- `spython_package`: add `package` property (default to `name` property.
- Global helpers & resources refactoring.

### Fixes

- Fix Ohai custom plugin for first convergence.
- Fix Ohai custom plugin when packages installed from sources.
- Fix `spython_venv` resource.
- Fix `spython_package` for venv support.

## 0.3.1

- Fix broken release 0.3.0 (missing ohai plugin file)

## 0.3.0

- Add spython ohai plugin to collect pip data
- Add new resources:
  - spython_venv
  - spython_exec
  - spython_pip

## 0.2.0

- Add Ubuntu 16.04 platform
- Add CentOS 7 platform
  
## 0.1.0

- Initial release of spython cookbook
