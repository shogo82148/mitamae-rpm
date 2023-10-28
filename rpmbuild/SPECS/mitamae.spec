Summary: mitamae is a fast, simple, and single-binary configuration management tool with a DSL like Chef
Name: mitamae
Version: 1.14.0
Release: 4
URL: https://github.com/itamae-kitchen/mitamae
Source0: https://github.com/itamae-kitchen/mitamae/archive/refs/tags/v%{version}.tar.gz
Patch0: pull-126-bump-specinfra-v2.87.0.patch
License: MIT
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root
BuildRequires: autoconf
BuildRequires: automake
BuildRequires: git
BuildRequires: libtool
BuildRequires: patch
BuildRequires: ruby
BuildRequires: wget

%description
mitamae is a tool to automate configuration management using a Chef-like DSL powered by mruby.

Key Features
Fast - mitamae is optimized for local execution. It uses C functions via mruby libraries for core operations where possible, instead of executing commands on a shell or over a SSH connection like other tools, which is very slow.

Simple - Running mitamae doesn't require Chef Server, Berkshelf, Data Bags, or even RubyGems. The mitamae core provides only essential features. You can quickly be a master of mitamae.

Single Binary - mitamae can be deployed by just transferring a single binary to servers. You don't need to rely on slow operations over a SSH connection to workaround deployment problems.

%prep

%build
tar xvf %{SOURCE0}
cd mitamae-%{version}
patch -p1 < %{PATCH0}
bundle install
bundle exec rake release:build:linux-%{_build_arch}

%install
mkdir -p %{buildroot}/%{_bindir}
%{__install} -m 755 -p mitamae-%{version}/mitamae-build/mitamae-%{_build_arch}-linux %{buildroot}/%{_bindir}/mitamae

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root)
%{_bindir}/mitamae

%changelog
* Sat Oct 28 2023 ICHINOSE Shogo <shogo82148@gmail.com> - 1.14.0-4
- fix aaarch64 build not uploading

* Sat Oct 28 2023 ICHINOSE Shogo <shogo82148@gmail.com> - 1.14.0-3
- improve Amazon Linux 2023 detection

* Thu Oct 26 2023 ICHINOSE Shogo <shogo82148@gmail.com> - 1.14.0-2
- add Amazon Linux 2023 distribution

* Mon Aug 08 2022 Ichinose Shogo <shogo82148@gmail.com> - 1.14.0-1
- bump v1.14.0

* Tue Aug 02 2022 Ichinose Shogo <shogo82148@gmail.com> - 1.13.1-1
- bump v1.13.1
- add Rocky Linux 9 distribution

* Wed Jul 06 2022 Ichinose Shogo <shogo82148@gmail.com> - 1.13.0-1
- bump v1.13.0

* Wed Jul 06 2022 Ichinose Shogo <shogo82148@gmail.com> - 1.12.10-2
- add AlmaLinux 9 distribution

* Wed Jun 15 2022 ICHINOSE Shogo <shogo82148@gmail.com> - 1.12.10-1
- bump v1.12.10

* Mon Jan 31 2022 Ichinose Shogo <shogo82148@gmail.com>
- bump v1.12.9

* Fri Dec 31 2021 Ichinose Shogo <shogo82148@gmail.com>
- bump v1.12.8

* Wed Jun 16 2021 Ichinose Shogo <shogo82148@gmail.com>
- bump v1.12.7

* Thu Jun 03 2021 Ichinose Shogo <shogo82148@gmail.com>
- bump v1.12.6

* Sat Mar 13 2021 Ichinose Shogo <shogo82148@gmail.com>
- bump v1.12.3
