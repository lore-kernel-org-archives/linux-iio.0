Return-Path: <SRS0=8JD8=7A=linux.intel.com=andriy.shevchenko@kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	eter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	David Lechner <david@lechnology.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] iio: tools: move to tools buildsystem
Date: Sat, 29 Jul 2017 03:36:04 +0300
Message-Id: <20170729003605.73790-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

There is a nice buildsystem dedicated for userspace tools in Linux kernel tree.
Switch iio target to be built by it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 tools/iio/Build    |  3 +++
 tools/iio/Makefile | 68 ++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 51 insertions(+), 20 deletions(-)
 create mode 100644 tools/iio/Build

diff --git a/tools/iio/Build b/tools/iio/Build
new file mode 100644
index 000000000000..f74cbda64710
--- /dev/null
+++ b/tools/iio/Build
@@ -0,0 +1,3 @@
+lsiio-y += lsiio.o iio_utils.o
+iio_event_monitor-y += iio_event_monitor.o iio_utils.o
+iio_generic_buffer-y += iio_generic_buffer.o iio_utils.o
diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index 8f08e03a9a5e..5581c062421a 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -1,31 +1,59 @@
+include ../scripts/Makefile.include
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
+
+# Do not use make's built-in rules
+# (this improves performance and avoids hard-to-debug behaviour);
+MAKEFLAGS += -r
+
 CC = $(CROSS_COMPILE)gcc
-CFLAGS += -Wall -g -D_GNU_SOURCE -D__EXPORTED_HEADERS__ -I../../include/uapi -I../../include
+LD = $(CROSS_COMPILE)ld
+CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
-BINDIR=usr/bin
-INSTALL_PROGRAM=install -m 755 -p
-DEL_FILE=rm -f
+ALL_TARGETS := iio_event_monitor lsiio iio_generic_buffer
+ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
-all: iio_event_monitor lsiio iio_generic_buffer
+all: $(ALL_PROGRAMS)
 
-iio_event_monitor: iio_event_monitor.o iio_utils.o
+export srctree OUTPUT CC LD CFLAGS
+include $(srctree)/tools/build/Makefile.include
 
-lsiio: lsiio.o iio_utils.o
+#
+# We need the following to be outside of kernel tree
+#
+$(OUTPUT)include/linux/iio: ../../include/uapi/linux/iio
+	mkdir -p $(OUTPUT)include/linux/iio 2>&1 || true
+	ln -sf $(CURDIR)/../../include/uapi/linux/iio/events.h $@
+	ln -sf $(CURDIR)/../../include/uapi/linux/iio/types.h $@
 
-iio_generic_buffer: iio_generic_buffer.o iio_utils.o
+prepare: $(OUTPUT)include/linux/iio
 
-%.o: %.c iio_utils.h
+LSIIO_IN := $(OUTPUT)lsiio-in.o
+$(LSIIO_IN): prepare FORCE
+	$(Q)$(MAKE) $(build)=lsiio
+$(OUTPUT)lsiio: $(LSIIO_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 
-install:
-	- mkdir -p $(INSTALL_ROOT)/$(BINDIR)
-	- $(INSTALL_PROGRAM) "iio_event_monitor" "$(INSTALL_ROOT)/$(BINDIR)/iio_event_monitor"
-	- $(INSTALL_PROGRAM) "lsiio" "$(INSTALL_ROOT)/$(BINDIR)/lsiio"
-	- $(INSTALL_PROGRAM) "iio_generic_buffer" "$(INSTALL_ROOT)/$(BINDIR)/iio_generic_buffer"
+IIO_EVENT_MONITOR_IN := $(OUTPUT)iio_event_monitor-in.o
+$(IIO_EVENT_MONITOR_IN): prepare FORCE
+	$(Q)$(MAKE) $(build)=iio_event_monitor
+$(OUTPUT)iio_event_monitor: $(IIO_EVENT_MONITOR_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 
-uninstall:
-	$(DEL_FILE) "$(INSTALL_ROOT)/$(BINDIR)/iio_event_monitor"
-	$(DEL_FILE) "$(INSTALL_ROOT)/$(BINDIR)/lsiio"
-	$(DEL_FILE) "$(INSTALL_ROOT)/$(BINDIR)/iio_generic_buffer"
+IIO_GENERIC_BUFFER_IN := $(OUTPUT)iio_generic_buffer-in.o
+$(IIO_GENERIC_BUFFER_IN): prepare FORCE
+	$(Q)$(MAKE) $(build)=iio_generic_buffer
+$(OUTPUT)iio_generic_buffer: $(IIO_GENERIC_BUFFER_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 
-.PHONY: clean
 clean:
-	rm -f *.o iio_event_monitor lsiio iio_generic_buffer
+	rm -f $(ALL_PROGRAMS)
+	rm -rf $(OUTPUT)include/linux/iio
+	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+
+FORCE:
+
+.PHONY: all clean FORCE prepare
-- 
2.13.2
