require "serverspec"
require "docker"

describe "serverspec Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('images/serverspec')

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end

  it "installs rspec" do
    expect(rspec_path).to include("/usr/local/bundle/bin")
  end

  it "installs docker" do
    expect(docker_path).to include("/usr/bin")
  end

  def rspec_path
    command("which rspec").stdout
  end

  def docker_path
    command("which docker").stdout
  end
end
