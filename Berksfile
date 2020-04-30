source 'https://supermarket.chef.io'
metadata

group :integration do
  cookbook 'apt'
  cookbook 'yum-epel'
  cookbook 'locales',
           git: 'https://github.com/sliim-cookbooks/locales',
           ref: 'create-directory'
end
