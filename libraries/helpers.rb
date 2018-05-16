#
# Cookbook Name:: kibana5
# Library:: helpers
#
# Copyright:: 2017, Parallels International GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Kibana
  module Helpers
    # Returns download URL for Kibana artifact
    def kibana_artifact_url(version, install_method)
      return node['kibana5']['url'] unless node['kibana5']['url'].nil?

      case install_method
      when 'release'
        "#{node['kibana5']['distribution_base_url']}/kibana-#{version}-linux-#{kibana_arch}.tar.gz"
      when 'windows'
        "#{node['kibana5']['distribution_base_url']}/kibana-#{version}-windows-x86.zip"
      when 'darwin'
        "#{node['kibana5']['distribution_base_url']}/kibana-#{version}-darwin-x86_64.tar.gz"
      end
    end

    # Returns SHA256 checksum of specific Kibana artifact
    def kibana_artifact_checksum(version, install_method)
      return node['kibana5']['checksum'] unless node['kibana5']['checksum'].nil?

      sums = kibana_checksum_map[version]
      raise "Kibana version #{version} is not supported by the cookbook!" unless sums

      begin
        case install_method
        when 'release'
          sums['release'][kibana_arch]['checksum']
        when 'windows'
          sums['windows']['x86']['checksum']
        end
      rescue
        raise "Install method #{install_method} is not supported for this version of Kibana!"
      end
    end

    def kibana_arch
      (node['kernel']['machine'] == 'x86_64') ? 'x86_64' : 'x86'
    end

    # Returns SHA256 checksum map for Kibana artifacts
    def kibana_checksum_map
      {
        '6.2.4' => {
          'release' => {
            'x86_64' => {
              'checksum' => '53fb5ddcb3055209f8e3dffcad62d24bdbdedbe8e2f66c1773bac4a1f8b629af',
            },
            'x86' => {
              'checksum' => '4df1c6fd3b2e41d92fe8ec850dd5253c554285d8c8cdabbefbf744e74f732345',
            },
          },
          'windows' => {
            'x86' => {
              'checksum' => 'd9fe5dcb8d4d931317d25c16ccaf2e8dbc6464eb1dd22d081c33822d2993dab4',
            },
          },
          'darwin' => {
            'x86_64' => {
              'checksum' => '53fb5ddcb3055209f8e3dffcad62d24bdbdedbe8e2f66c1773bac4a1f8b629af',
            },
          },
        },
        '5.6.5' => {
          'release' => {
            'x86_64' => {
              'checksum' => 'd9c5b0fa82226aa2c31e91ce88fa9d48d86f0de297c2e7350b9260d70a986c25',
            },
            'x86' => {
              'checksum' => '6b3501b3efd858edb626632a22043f5242030c01bf729231df299ec743308162',
            },
          },
          'windows' => {
            'x86' => {
              'checksum' => '07b2c45c985eba3f3a0bae27acb0e5c423e2352d816fc62117ca50f216f0c557',
            },
          },
          'darwin' => {
            'x86_64' => {
              'checksum' => 'e233b099f1d3a928e38066825a103cc1ae2c58c18178bfe4a954273627ce44f4',
            },
          },
        },
        '5.6.3' => {
          'release' => {
            'x86_64' => {
              'checksum' => '6f3df48dabf51917252b1d99bea03a66e981812b27097645cc3cbb53281a1c71',
            },
            'x86' => {
              'checksum' => 'a34e20bae6c0d3165a185919460293d0c060fe8ea94b7488cf1d73c5cff9e0f2',
            },
          },
          'windows' => {
            'x86' => {
              'checksum' => '81f8a9375ec3a39507753164d3b97867c3647a4ed4659065b451bec825068066',
            },
          },
          'darwin' => {
            'x86_64' => {
              'checksum' => '65bc363542ad29e636f1f0fec3446c489a5ab7bd333dc160a6f0d25ecfbdb057',
            },
          },
        },
        '5.4.1' => {
          'release' => {
            'x86_64' => {
              'checksum' => 'efab73464c6cbc90089acf9275e43c7b3c2bbe8fb62c710567ac523a65c3394b',
            },
            'x86' => {
              'checksum' => '25b309435ae4760332e2072e80a83848852245f5c91af6f72bf09771a0bd73fa',
            },
          },
          'windows' => {
            'x86' => {
              'checksum' => 'bf88a207b5d4be62c02b83cf2d1cce14aac1a48a9feb084817b93e4690b00983',
            },
          },
          'darwin' => {
            'x86_64' => {
              'checksum' => 'ea66827790ed6dbce241ccdee37e25f3da6ea01c0b1ca5a018032cef626c6239',
            },
          },
        },
        '5.4.0' => {
          'release' => {
            'x86_64' => {
              'checksum' => '58838dcb5b3195455e1eb05926fed27d882a3476370facfc35d39d837940b1bc',
            },
            'x86' => {
              'checksum' => 'fbeda3f125cd95cc914c1eb49f65313eb55ce65c9300f231f2d050f4c6bbb65f',
            },
          },
          'windows' => {
            'x64' => {
              'checksum' => '9c3c36c042962794b1eb9f45a585302f3eb4c01aecca7c06fb53097b7e7d2852',
            },
          },
        },
        '5.3.0' => {
          'release' => {
            'x86_64' => {
              'checksum' => 'f31369c32d655370f0e51290018004cfbc54e2d648f0f79dba88e36b4d6cce6f',
            },
            'x86' => {
              'checksum' => 'eddc77334032ed30f98289715781d01e7677d598cf4a3ad5595618cc057a8bfc',
            },
          },
          'windows' => {
            'x64' => {
              'checksum' => '56c5fbd5767dea313ab11489cfed6da063677f9ad38fe9c0420535a46bfdbdaf',
            },
          },
        },
        '5.2.2' => {
          'release' => {
            'x86_64' => {
              'checksum' => '9c7c526ce286da7f63aed9fb9f9d752ec182ff16bf374c55e55e5a0536a33563',
            },
            'x86' => {
              'checksum' => 'de0421728aca00e9d4114b45ad5519b843b700006eb0795fcc2df4371d6baa1d',
            },
          },
          'windows' => {
            'x64' => {
              'checksum' => '8d6435aa6cfef1a8ce8d4a84361139d0ea3848abfe87283765b4da4fbaefdd3f',
            },
          },
        },
        '5.2.1' => {
          'release' => {
            'x86_64' => {
              'checksum' => '82f06fc998385f08eac1c26bb0a48b29a34d179fdb7d0e8be216b35782f12bff',
            },
            'x86' => {
              'checksum' => 'c3f27b73e29a9b51a89b9b58798a0ea087df29978424255acb441a8b3e3540bf',
            },
          },
          'windows' => {
            'x64' => {
              'checksum' => '8753db954a89a7a5c19a2c93886b523d1f8054bd31ce24c772bd873555a949d8',
            },
          },
        },
        '5.2.0' => {
          'release' => {
            'x86_64' => {
              'checksum' => '729af8ab00f719f2038f6c499e508744b274487756e0214b660535ebead6f28a',
            },
            'x86' => {
              'checksum' => '9df75d2dc05937064f1ec905edc705ab1a83e8aaddef6b2fa90b2826f6cc2ea4',
            },
          },
          'windows' => {
            'x64' => {
              'checksum' => 'bd1be9758b11b071bc033e9ed996598f4da6cdb18b28c475993c429f1c17db31',
            },
          },
        },
      }
    end
  end
end

::Chef::Recipe.send(:include, Kibana::Helpers)
::Chef::Resource.send(:include, Kibana::Helpers)
