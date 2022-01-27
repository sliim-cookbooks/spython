ignore(/flycheck_*/)

guard :rubocop, cli: ['-r', 'cookstyle'] do
  watch(/.+\.rb$/)
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
