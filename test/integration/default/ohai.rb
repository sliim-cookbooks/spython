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

ohai = JSON.parse(inspec.backend.run_command('ohai --directory /tmp/kitchen/ohai/cookbook_plugins/ pip').stdout)
packages = ohai[input('runtime')]['packages']

input('packages').each do |package, version|
  describe package do
    it { should be_in packages.keys }
  end

  next unless version
  describe packages do
    it { should include package => { 'version' => version.to_s } }
  end
end
