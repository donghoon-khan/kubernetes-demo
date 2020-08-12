#!/bin/bash
 
set -e
EXITCODE=0
 
_AUTHOR="dhkang"
 
PROGNAME=$(basename $0)
TOOLSDIR="${HOME}/_tmp"
 
#error handler
#param: error msg
function ErrorExit()
{
    echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
    exit 1
}
 
#install $1 package
#param: package name (ex: "vim openssh-server ... etc")
function InstallPackage()
{
    sudo apt-get install -y $1
    if [[ $? > 0 ]]; then
        ErrorExit "$LINENO: error, failed installing package"
    fi
}
 
#remove $1 package
#param: packer name(ex: "vim openssh-server ... etc")
function RemovePackage()
{
    sudo apt-get remove -y $1
    if [[ $? >0 ]]; then
        ErrorExit "$LINENO: error, failed remove package"
    fi
}
 
#install Debian package
#param: $1-pkg path
function DpkgInstall()
{
    #check dpkg binary
    local dpkg=/usr/bin/dpkg
    if [ ! -x ${dpkg} ]; then
        ErrorEixt "$LINENO: error, (${dpkg}) not found"
    fi
 
    #install dpkg
    sudo ${dpkg} -i $1
    if [ $? -ne 0 ]; then
        ErrorExit "$LINENO: error, ($1)dpkg not found"
    fi
}
 
#wget function
#param: $1-url, $2-path
function Wget()
{
    #check wget
    local wget=/usr/bin/wget
    if [ ! -x ${wget} ]; then
        ErrorExit "$LINENO: error, (${wget}) not found"
    fi
 
    #wget url -O path
    local url="$1"
    local target="$2"
    ${wget} -O ${target} ${url}
    if [ $? -ne 0 ]; then
        ErrorExit "$LINENO: error, failed wget url(${url})"
    fi
}
 
#extract tar
#param: $1-path tar.gz, $2-dst path
function ExtractTar()
{
    #check tar binary
    local tar=/bin/tar
    if [ ! -x ${tar} ]; then
        ErrorExit "$LINENO: error, (${tar}) not found"
    fi
 
    #check tar.gz file
    if [ ! -e $1 ]; then
        ErrorExit "$LINENO: error, ($1) not found"
    fi
 
    #extract
    ${tar} -xvzf $1 -C $2
    if [ $? -ne 0]; then
        ErrorExit "$LINENO: error, failed extract file($1)"
    fi
}
 
 
#install utils
#param: none
function InstallUtils()
{
    echo "########## install utils ##########"
    InstallPackage "vim net-tools ifupdown openssh-server curl tar \
            apt-transport-https ca-certificates software-properties-common \
            socat ebtables ethtool wget keepalived haproxy"
}
 
#ping_test function
#param: ip
function Ping()
{
    #check ping binary
    local ping=/bin/ping
    if [ ! -x ${ping} ]; then
        ErrorExit "$LINENO: error, (${ping}) not found"
    fi
     
    ${ping} -c 1 -w 1 $1 &> /dev/null
    if [ $? != "0" ] ; then
        ErrorExit "$LINENO: error, failed ping testing"
    fi
}
 
#change ubuntu mirror server
#param: k-kakao, n-neowiz, h-harukasan
function ChangeUbuntuMirror()
{
    echo "########## change ubuntu mirror ##########"
    local sourcesList=/etc/apt/sources.list
    local kakao=mirror.kakao.com
    local neowiz=ftp.neowiz.com
    local haru=ftp.harukasan.org
    local repos
 
    case $1 in
        k)
            echo "param [k]: use kakao mirror($kakao)"
            repos=${kakao}
            ;;
        n)
            echo "param [n]: use neowiz mirror($neowiz)"
            repos=${neowiz}
            ;;
        h)
            echo "param [h]: use harukasan mirror($harukasan)"
            repos=${haru}
            ;;
        *)
            ErrorExit "$LINENO: error, unknown argument[$1]"
            ;;
    esac
     
    echo "sources path=(${sourcesList})"
    echo "using repository=(${repos})"
    sudo sed -i.bak -re "s/([a-z]{2}.)?archive.ubuntu.com|security.ubuntu.com/${repos}/g" ${sourcesList}
    sudo apt update
}
 
#install docker
#param: $1-docker.deb path
function InstallDocker()
{
    echo "########## install docker ##########"
    InstallPackage "libc6 libglib2.0-0 libx11-6 libltdl7"
 
    local dockerPool="https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64"
    Wget "${dockerPool}/containerd.io_1.2.0-1_amd64.deb" $1/containerd.io.deb
    Wget "${dockerPool}/docker-ce_18.09.0~3-0~ubuntu-bionic_amd64.deb" $1/docker-ce.deb
    Wget "${dockerPool}/docker-ce-cli_18.09.0~3-0~ubuntu-bionic_amd64.deb" $1/docker-ce-cli.deb
    DpkgInstall $1/containerd.io.deb
    DpkgInstall $1/docker-ce-cli.deb
    DpkgInstall $1/docker-ce.deb
}
 
#install kubernetes pkg
function InstallK8s()
{
    echo "########## install k8s ##########"
    InstallPackage "apt-transport-https curl"
 
    #get apt-key.gpg and add key
    local curl=/usr/bin/curl
    if [ ! -x ${curl} ]; then
        ErrorExit "$LINENO: error, not found(${curl})"
    fi
    sudo ${curl} -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    if [ $? != "0" ]; then
        ErrorExit "$LINENO: error, failed apt-key add"
    fi
 
    #add,install kubernetes pkg and mark hold
    sudo sh -c 'echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list'
    sudo apt-get update
    InstallPackage "kubelet kubeadm kubectl"
    sudo apt-mark hold kubelet kubeadm kubectl
    if [ $? != "0" ]; then
        ErrorExit "$LINENO: error, apt-mark hold k8s"
    fi
 
 
    #swap 해제
    sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
    if [ $? != "0" ]; then
        ErrorExit "$LINENO: error, disable swap"
    fi
}
 
function Main()
{
    if [ ! -d ${TOOLSDIR} ]; then
        echo "########## mkdir ${TOOLSDIR} ##########"
        mkdir ${TOOLSDIR}
    fi
    ChangeUbuntuMirror k
    InstallUtils
    Ping 8.8.8.8
    InstallDocker ${TOOLSDIR}
    InstallK8s
    rm -rf ${TOOLSDIR}
}
 
function _ForDebug()
{
    sudo rm -rf ${TOOLSDIR}
    sudo rm -rf ${HOME}/testbin
    sudo rm -rf /var/lib/{kube-controller-manager,kubelet,kube-proxy,kube-scheduler}
    sudo rm -rf /etc/{kubernetes,sysconfig}
    sudo rm -rf /etc/kubernetes/manifests
}
 
Main
echo "SUCCESS"
exit $EXITCODE
