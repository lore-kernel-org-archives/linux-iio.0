Return-Path: <pbrobinson@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] tools: iio: Add ability to install/uninstall
Date: Wed, 25 May 2016 14:31:13 +0100
Message-Id: <1464183073-4379-1-git-send-email-pbrobinson@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add options to the Makefile for install/uninstall similar to other tools.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 tools/iio/Makefile | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index 3a7a54f..5c32e90 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -1,6 +1,10 @@
 CC = $(CROSS_COMPILE)gcc
 CFLAGS += -Wall -g -D_GNU_SOURCE
 
+BINDIR=usr/bin
+INSTALL_PROGRAM=install -m 755 -p
+DEL_FILE=rm -f
+
 all: iio_event_monitor lsiio generic_buffer
 
 iio_event_monitor: iio_event_monitor.o iio_utils.o
@@ -11,6 +15,17 @@ generic_buffer: generic_buffer.o iio_utils.o
 
 %.o: %.c iio_utils.h
 
+install:
+	- mkdir -p $(INSTALL_ROOT)/$(BINDIR)
+	- $(INSTALL_PROGRAM) "iio_event_monitor" "$(INSTALL_ROOT)/$(BINDIR)/iio_event_monitor"
+	- $(INSTALL_PROGRAM) "lsiio" "$(INSTALL_ROOT)/$(BINDIR)/lsiio"
+	- $(INSTALL_PROGRAM) "generic_buffer" "$(INSTALL_ROOT)/$(BINDIR)/generic_buffer"
+
+uninstall:
+	$(DEL_FILE) "$(INSTALL_ROOT)/$(BINDIR)/iio_event_monitor"
+	$(DEL_FILE) "$(INSTALL_ROOT)/$(BINDIR)/lsiio"
+	$(DEL_FILE) "$(INSTALL_ROOT)/$(BINDIR)/generic_buffer"
+
 .PHONY: clean
 clean:
 	rm -f *.o iio_event_monitor lsiio generic_buffer
-- 
2.7.4
