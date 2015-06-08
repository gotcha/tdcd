require "serverspec"
require "docker"
#require 'pry-byebug'

describe "jenkins Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('images/jenkins')

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
    set :docker_container_create_options, {'Cmd' => ['/usr/local/bin/jenkins.sh']}
  end
  
  it "jenkins user" do
    expect(ps_aux).to include("jenkins")
  end

  def ps_aux
    command("ps aux").stdout
  end
  
  describe process("java") do
    it { should be_running }
  end
end
