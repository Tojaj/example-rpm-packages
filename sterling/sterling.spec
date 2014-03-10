Name:           sterling
Summary:        Sterling Archer - testing package with localization.
Version:        0.1.0
Release:        1%{?dist}
License:        GPLv2
Group:          System Environment/Base
Source0:        %{name}.tar.xz

BuildRequires: cmake
BuildRequires: glib2-devel
BuildRequires: gettext

%description
Testing package with gettext localization (*.po) files.

%prep
%setup -q -n %{name}

%build
%cmake .
make %{?_smp_mflags} RPM_OPT_FLAGS="$RPM_OPT_FLAGS"

%install
make install DESTDIR=$RPM_BUILD_ROOT/
%find_lang %{name}

%files -f %{name}.lang
%{_bindir}/%{name}

%changelog
* Thu Mar  13 2014 Tomas Mlcoch <xtojaj at gmail.com> - 0.1.0-1
- A changelog
