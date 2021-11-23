# Cookbook:: spython
# Ohai Plugin:: spython
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

Ohai.plugin(:Spython) do
  provides 'pip'

  collect_data :default do
    pip Mash.new

    [2, 3].each do |runtime|
      which = shell_out("which pip#{runtime}")

      next unless which.exitstatus == 0

      bin = which.stdout.strip

      pip[runtime.to_s] = Mash.new
      pip[runtime.to_s][:bin] = bin
      pip[runtime.to_s][:packages] = Mash.new

      shell_out("#{bin} freeze 2>/dev/null").stdout.each_line do |pkg|
        package = pkg.strip.split('==')[0]
        version = pkg.strip.split('==')[1]
        pip[runtime.to_s][:packages][package] = Mash.new
        pip[runtime.to_s][:packages][package][:version] = version
      end
    end
  end
end
