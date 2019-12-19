task default: %w[build]

file "lemminge" do |t|
  system ("git clone ssh://git@gitlab.anlatana.net:30001/anlatana/lemminge.git")
end

task build: ["lemminge"] do |t|
  system ("cd lemminge && docker build .")
end
