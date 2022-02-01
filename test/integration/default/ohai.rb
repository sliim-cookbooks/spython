# Cookbook:: spython
# Suite:: default
# Control:: ohai
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

def ohai(attribute)
  ohai_cmd = "ohai --directory /tmp/kitchen/ohai/cookbook_plugins #{attribute}"
  result = inspec.backend.run_command(ohai_cmd)

  if result.exit_status != 0
    Chef::Log.warn("Ohai command `#{ohai_cmd}` failed with exitstatus #{result.exit_status}")
    return {}
  end

  JSON.parse(result.stdout)
end

runtime = input('runtime').to_s
ohai_pip = ohai('pip')
pip_packages = ohai_pip[runtime]['packages']

input('packages').each do |package, version|
  describe package do
    it { should be_in pip_packages.keys }
  end

  next unless version
  describe pip_packages do
    it { should include package => { 'version' => version.to_s } }
  end
end

ohai_py = ohai("languages/python#{runtime}")

describe ohai_py.keys do
  it { should include 'bin' }
  it { should include 'version' }
  it { should include 'builddate' }
end

if ohai_py.key?('bin')
  describe ohai_py['bin'].split('/').last do
    it { should eq "python#{runtime}" }
  end
end

if ohai_py.key?('version')
  describe ohai_py['version'] do
    it { should start_with runtime }
  end
end
