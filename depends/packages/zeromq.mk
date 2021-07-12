package=zeromq
$(package)_version=4.3.4
$(package)_download_path=https://github.com/zeromq/libzmq/releases/download/v$($(package)_version)/
$(package)_file_name=$(package)-$($(package)_version).tar.gz
$(package)_sha256_hash=c593001a89f5a85dd2ddf564805deb860e02471171b3f204944857336295c3e5
$(package)_patches=clock-unused-nsecs.patch

define $(package)_set_vars
  $(package)_config_opts=--without-documentation --disable-shared --without-libsodium --disable-curve
  $(package)_config_opts_linux=--with-pic
  $(package)_cxxflags=-std=c++11
endef

define $(package)_preprocess_cmds
  patch -p1 < $($(package)_patch_dir)/clock-unused-nsecs.patch && \
  ./autogen.sh
endef

define $(package)_config_cmds
  $($(package)_autoconf)
endef

define $(package)_build_cmds
  $(MAKE) ./src/libzmq.la
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install-libLTLIBRARIES install-includeHEADERS install-pkgconfigDATA
endef

define $(package)_postprocess_cmds
  rm -rf bin share
endef
