# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Set network as public
  config.vm.network "public_network"

  # Set box and VM name
  config.vm.box = "generic/ubuntu2004"
  config.vm.hostname = "dev-machine"

  # Install Docker
  config.vm.provision "docker",
    images: ["ubuntu:18.04"]

  # Install Kubernetes
  config.vm.provision "shell",
    inline: "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list && apt-get update && apt-get install -y kubectl kubeadm kubelet"

  # Install OpenShift
  config.vm.provision "shell",
    inline: "curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz | tar zx && mv oc /usr/local/bin"

  # Install Jenkins
  config.vm.provision "shell",
    inline: "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add - && echo 'deb https://pkg.jenkins.io/debian-stable binary/' > /etc/apt/sources.list.d/jenkins.list && apt-get update && apt-get install -y jenkins"

  # Install Nexus
  config.vm.provision "shell",
    inline: "wget -O /tmp/nexus.tar.gz https://download.sonatype.com/nexus/oss/nexus-latest.tar.gz && mkdir -p /opt/nexus && tar xzf /tmp/nexus.tar.gz -C /opt/nexus --strip-components=1"

  # Install SonarQube
  config.vm.provision "shell",
    inline: "wget -O /tmp/sonarqube.zip https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.0.1.zip && mkdir -p /opt/sonarqube && unzip /tmp/sonarqube.zip -d /opt/sonarqube"

end