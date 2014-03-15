Name:           tdcc
Summary:        Hello word package.
Version:        1.2.3
Release:        4%{?dist}
License:        GPLv2
Group:          System Environment/Base
Source0:        %{name}.tar.xz
BuildArch:      noarch

BuildRequires: cmake
BuildRequires: python
Requires:   python-%{name} = %{version}-%{release}

%description
Package with GTK hello world GUI app.

%package -n python-%{name}
Summary: Python library for the tdcc GTK hello word GUI app.
Group: Development/Languages
Requires: pygtk2
Requires: pygobject2

%description -n python-%{name}
Python library for the tdcc GTK hello word GUI app.

%prep
%setup -q -n %{name}

%build
%cmake .
make %{?_smp_mflags} RPM_OPT_FLAGS="$RPM_OPT_FLAGS"

%install
make install DESTDIR=$RPM_BUILD_ROOT/

%files
%{_bindir}/%{name}
%{_datadir}/applications/tdcc.desktop

%files -n python-%{name}
%{python_sitearch}/tdcc/

%changelog
* Sat Mar  15 2014 Tomas Mlcoch <xtojaj at gmail.com> - 1.2.3-4
- A changelog
