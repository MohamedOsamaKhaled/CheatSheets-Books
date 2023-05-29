Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "public_network"

  config.vm.provision "shell", inline: <<-SHELL
    # Update packages
    sudo apt-get update

    # Install Java JDK 11, Maven, and Kubernetes
    sudo apt-get install -y openjdk-11-jdk maven
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/

    # Install Jenkins
    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt-get update
    sudo apt-get install -y jenkins

    # Start Jenkins service
    sudo systemctl start jenkins
  SHELL
end