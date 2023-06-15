Vagrant.configure("2") do |config|
  
  
  config.vm.provider "virtualbox" do |v|
		v.name = "OpenShift"
  end
   
  # Set a static private IP for the VM
  config.vm.network "public_network"
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Set box and VM name
  config.vm.box = "ubuntu/bionic64"
  # config.vm.hostname = "devEnv"

  # Update packages
  config.vm.provision "shell",
    inline: <<-SHELL
		sudo apt-get update 
		sudo apt-get -y upgrade
	SHELL
	
  # Install Java JDK 11
  config.vm.provision "shell",
    inline: <<-SHELL
		sudo apt-get -y install openjdk-11-jdk
	SHELL

  # Install Docker
  config.vm.provision "shell",
    inline: <<-SHELL
		sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common 
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
		sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable' 
		sudo apt-get update && sudo apt-get -y install docker-ce 
		sudo systemctl start docker 
		sudo systemctl enable docker
		echo "Docker installed successfully. Please log out and log back in to apply group membership changes."
	SHELL
	
  # Install Kubernetes
  config.vm.provision "shell",
    inline: <<-SHELL
		curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
		sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
		sudo apt-get update
		sudo apt-get -y install kubectl kubeadm kubelet
		sudo sed -i '/ swap / s/^/#/' /etc/fstab
		sudo swapoff -a
		sudo modprobe br_netfilter
		sudo echo "br_netfilter" | sudo tee /etc/modules-load.d/k8s.conf
		sudo echo "net.bridge.bridge-nf-call-ip6tables = 1" | sudo tee -a /etc/sysctl.conf
		sudo echo "net.bridge.bridge-nf-call-iptables = 1" | sudo tee -a /etc/sysctl.conf
		sudo sysctl -p
		echo "Kubernetes installed successfully. Please reboot the system to apply kernel changes."
	SHELL
	
  # Install OpenShift
  config.vm.provision "shell",
    inline: <<-SHELL
		curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz | tar zx 
		sudo mv oc /usr/local/bin
	SHELL
	
  # Install Jenkins
  config.vm.provision "shell",
    inline: <<-SHELL
		sudo apt-get -y install openjdk-11-jdk && wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add - 
		sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' 
		sudo apt-get update 
		sudo apt-get -y install jenkins 
		sudo systemctl enable jenkins 
		sudo systemctl start jenkins
		echo "Jenkins installed successfully. Please reboot the system to apply kernel changes."
	SHELL
	
  # Install Nexus
  config.vm.provision "shell",
    inline: <<-SHELL
		sudo apt-get -y install wget 
		sudo wget -O /tmp/nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz 
		sudo mkdir -p /opt/nexus && sudo tar xzf /tmp/nexus.tar.gz -C /opt/nexus --strip-components=1 
		sudo useradd nexus && sudo chown -R nexus:nexus /opt/nexus 
		sudo sh -c 'echo \"run_as_user=nexus\" >> /opt/nexus/bin/nexus.vmoptions' 
		sudo sh -c 'echo \"nexus.scripts.allowCreation=true\" >> /opt/nexus/etc/nexus-default.properties' 
		sudo sh -c 'echo \"nexus.security.randompassword=false\" >> /opt/nexus/etc/nexus-default.properties' 
		sudo systemctl enable --now nexus
		echo "Nexus installed successfully. Please reboot the system to apply kernel changes."
	SHELL
	
  # Install SonarQube
  config.vm.provision "shell",
    inline: <<-SHELL
		sudo apt-get -y install wget 
		sudo wget -O /tmp/sonarqube.zip https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-lts.zip 
		sudo mkdir -p /opt/sonarqube 
		sudo unzip /tmp/sonarqube.zip -d /opt/sonarqube 
		sudo groupadd sonar 
		sudo useradd -c 'SonarQube' -d /opt/sonarqube -g sonar sonar 
		sudo chown -R sonar:sonar /opt/sonarqube
	SHELL
	
  # Install Maven
  config.vm.provision "shell",
    inline: <<-SHELL
		sudo apt-get -y install maven
	SHELL
end