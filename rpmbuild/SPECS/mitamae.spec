Summary: mitamae is a fast, simple, and single-binary configuration management tool with a DSL like Chef
Name: mitamae
Version: 1.12.3
Release: 1
URL: https://github.com/itamae-kitchen/mitamae
Source0: https://github.com/itamae-kitchen/mitamae/releases/download/v%{version}/mitamae-%{_build_arch}-linux.tar.gz
License: MIT
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

%description
mitamae is a tool to automate configuration management using a Chef-like DSL powered by mruby.

Key Features
Fast - mitamae is optimized for local execution. It uses C functions via mruby libraries for core operations where possible, instead of executing commands on a shell or over a SSH connection like other tools, which is very slow.

Simple - Running mitamae doesn't require Chef Server, Berkshelf, Data Bags, or even RubyGems. The mitamae core provides only essential features. You can quickly be a master of mitamae.

Single Binary - mitamae can be deployed by just transferring a single binary to servers. You don't need to rely on slow operations over a SSH connection to workaround deployment problems.

%prep

%build
tar xzvf %{SOURCE0}

%install
mkdir -p %{buildroot}/%{_bindir}
%{__install} -m 755 -p mitamae-%{_build_arch}-linux %{buildroot}/%{_bindir}/mitamae

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root)
%{_bindir}/mitamae

%changelog
* Sat Mar 13 2021 Ichinose Shogo <shogo82148@gmail.com>
- bump 1.12.3
