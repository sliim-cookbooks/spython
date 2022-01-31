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
  provides 'pip', 'languages/python2', 'languages/python3'

  depends 'languages'.freeze

  collect_data :default do
    pip Mash.new

    # Collect pip infos
    %w(2 3).each do |runtime|
      which = shell_out("which pip#{runtime}")
      next unless which.exitstatus == 0

      bin = which.stdout.strip
      pip[runtime] = Mash.new
      pip[runtime][:bin] = bin
      pip[runtime][:packages] = Mash.new

      shell_out("#{bin} freeze --all 2>/dev/null").stdout.each_line do |pkg|
        regex = /^([^= ]*)[= ]+(.*)$/
        package = pkg.strip[regex, 1]
        version = pkg.strip[regex, 2]
        pip[runtime][:packages][package] = Mash.new
        pip[runtime][:packages][package][:version] = version
      end
    end

    # Collect python infos, based on python ohai plugin
    %w(2 3).each do |runtime|
      which = shell_out("which python#{runtime}")
      next unless which.exitstatus == 0

      bin = which.stdout.strip
      python = Mash.new
      python[:bin] = bin

      so = shell_out("#{bin} -c \"import sys; print (sys.version)\"")
      next unless so.exitstatus == 0
      out = so.stdout.split
      python[:version] = out[0]

      if out.length >= 6
        python[:builddate] = format('%s %s %s %s', out[2], out[3], out[4], out[5].delete!(')'))
      end
      languages["python#{runtime}"] = python
    end
  end
end
