Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:43719 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab2DYOzI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Apr 2012 10:55:08 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/5] IIO: Move the core files to drivers/iio
Date: Wed, 25 Apr 2012 15:54:59 +0100
Message-Id: <1335365700-1138-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1335365700-1138-1-git-send-email-jic23@kernel.org>
References: <1335365700-1138-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Take the core support + the kfifo buffer implentation out of
staging.  Whilst we are far from done in improving this subsystem
it is now at a stage where the userspae interfaces (provided by
the core) can be considered stable.

Drivers will follow over a longer time scale.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/Kconfig                                  |    2 +
 drivers/Makefile                                 |    1 +
 drivers/iio/Kconfig                              |   51 ++++++++++++++++++++++
 drivers/iio/Makefile                             |   10 ++++
 drivers/{staging => }/iio/iio_core.h             |    0
 drivers/{staging => }/iio/iio_core_trigger.h     |    0
 drivers/{staging => }/iio/industrialio-buffer.c  |    0
 drivers/{staging => }/iio/industrialio-core.c    |    0
 drivers/{staging => }/iio/industrialio-event.c   |    0
 drivers/{staging => }/iio/industrialio-trigger.c |    0
 drivers/{staging => }/iio/inkern.c               |    0
 drivers/{staging => }/iio/kfifo_buf.c            |    0
 drivers/staging/iio/Kconfig                      |   44 +-----------------
 drivers/staging/iio/Makefile                     |    6 ---
 14 files changed, 67 insertions(+), 47 deletions(-)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index d236aef..0265cb1 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -140,4 +140,6 @@ source "drivers/virt/Kconfig"
 
 source "drivers/devfreq/Kconfig"
 
+source "drivers/iio/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 95952c8..cdbe362 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -134,3 +134,4 @@ obj-$(CONFIG_VIRT_DRIVERS)	+= virt/
 obj-$(CONFIG_HYPERV)		+= hv/
 
 obj-$(CONFIG_PM_DEVFREQ)	+= devfreq/
+obj-$(CONFIG_IIO)		+= iio/
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
new file mode 100644
index 0000000..3ab7d48
--- /dev/null
+++ b/drivers/iio/Kconfig
@@ -0,0 +1,51 @@
+#
+# Industrial I/O subsytem configuration
+#
+
+menuconfig IIO
+	tristate "Industrial I/O support"
+	depends on GENERIC_HARDIRQS
+	help
+	  The industrial I/O subsystem provides a unified framework for
+	  drivers for many different types of embedded sensors using a
+	  number of different physical interfaces (i2c, spi, etc). See
+	  Documentation/iio for more information.
+
+if IIO
+
+config IIO_BUFFER
+	bool "Enable buffer support within IIO"
+	help
+	  Provide core support for various buffer based data
+	  acquisition methods.
+
+if IIO_BUFFER
+
+config IIO_KFIFO_BUF
+	select IIO_TRIGGER
+	tristate "Industrial I/O buffering based on kfifo"
+	help
+	  A simple fifo based on kfifo.  Use this if you want a fifo
+	  rather than a ring buffer. Note that this currently provides
+	  no buffer events so it is up to userspace to work out how
+	  often to read from the buffer.
+
+endif # IIO_BUFFER
+
+config IIO_TRIGGER
+	boolean "Enable triggered sampling support"
+	help
+	  Provides IIO core support for triggers.  Currently these
+	  are used to initialize capture of samples to push into
+	  ring buffers.  The triggers are effectively a 'capture
+	  data now' interrupt.
+
+config IIO_CONSUMERS_PER_TRIGGER
+       int "Maximum number of consumers per trigger"
+       depends on IIO_TRIGGER
+       default "2"
+       help
+	This value controls the maximum number of consumers that a
+	given trigger may handle. Default is 2.
+
+endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
new file mode 100644
index 0000000..d5fc57d
--- /dev/null
+++ b/drivers/iio/Makefile
@@ -0,0 +1,10 @@
+#
+# Makefile for the industrial I/O core.
+#
+
+obj-$(CONFIG_IIO) += industrialio.o
+industrialio-y := industrialio-core.o industrialio-event.o inkern.o
+industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
+industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
+
+obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
diff --git a/drivers/staging/iio/iio_core.h b/drivers/iio/iio_core.h
similarity index 100%
rename from drivers/staging/iio/iio_core.h
rename to drivers/iio/iio_core.h
diff --git a/drivers/staging/iio/iio_core_trigger.h b/drivers/iio/iio_core_trigger.h
similarity index 100%
rename from drivers/staging/iio/iio_core_trigger.h
rename to drivers/iio/iio_core_trigger.h
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
similarity index 100%
rename from drivers/staging/iio/industrialio-buffer.c
rename to drivers/iio/industrialio-buffer.c
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
similarity index 100%
rename from drivers/staging/iio/industrialio-core.c
rename to drivers/iio/industrialio-core.c
diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
similarity index 100%
rename from drivers/staging/iio/industrialio-event.c
rename to drivers/iio/industrialio-event.c
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
similarity index 100%
rename from drivers/staging/iio/industrialio-trigger.c
rename to drivers/iio/industrialio-trigger.c
diff --git a/drivers/staging/iio/inkern.c b/drivers/iio/inkern.c
similarity index 100%
rename from drivers/staging/iio/inkern.c
rename to drivers/iio/inkern.c
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
similarity index 100%
rename from drivers/staging/iio/kfifo_buf.c
rename to drivers/iio/kfifo_buf.c
diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index fe15867..c1054a1 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -1,16 +1,9 @@
 #
 # Industrial I/O subsytem configuration
 #
+menu "IIO staging drivers"
+	depends on IIO
 
-menuconfig IIO
-	tristate "Industrial I/O support"
-	depends on GENERIC_HARDIRQS
-	help
-	  The industrial I/O subsystem provides a unified framework for
-	  drivers for many different types of embedded sensors using a
-	  number of different physical interfaces (i2c, spi, etc). See
-	  drivers/staging/iio/Documentation for more information.
-if IIO
 config IIO_ST_HWMON
 	tristate "Hwmon driver that uses channels specified via iio maps"
 	depends on HWMON
@@ -19,12 +12,6 @@ config IIO_ST_HWMON
 	  map allows IIO devices to provide  basic hwmon functionality
 	  for those channels specified in the map.
 
-config IIO_BUFFER
-	bool "Enable buffer support within IIO"
-	help
-	  Provide core support for various buffer based data
-	  acquisition methods.
-
 if IIO_BUFFER
 
 config IIO_SW_RING
@@ -36,33 +23,8 @@ config IIO_SW_RING
 	  with the intention that some devices would be able to write
 	  in interrupt context.
 
-config IIO_KFIFO_BUF
-	select IIO_TRIGGER
-	tristate "Industrial I/O buffering based on kfifo"
-	help
-	  A simple fifo based on kfifo.  Use this if you want a fifo
-	  rather than a ring buffer. Note that this currently provides
-	  no buffer events so it is up to userspace to work out how
-	  often to read from the buffer.
-
 endif # IIO_BUFFER
 
-config IIO_TRIGGER
-	boolean "Enable triggered sampling support"
-	help
-	  Provides IIO core support for triggers.  Currently these
-	  are used to initialize capture of samples to push into
-	  ring buffers.  The triggers are effectively a 'capture
-	  data now' interrupt.
-
-config IIO_CONSUMERS_PER_TRIGGER
-       int "Maximum number of consumers per trigger"
-       depends on IIO_TRIGGER
-       default "2"
-       help
-	This value controls the maximum number of consumers that a
-	given trigger may handle. Default is 2.
-
 source "drivers/staging/iio/accel/Kconfig"
 source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
@@ -104,4 +66,4 @@ config IIO_SIMPLE_DUMMY_BUFFER
 
 endif # IIO_SIMPLE_DUMMY
 
-endif # IIO
+endmenu
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 5075291..2acd42f 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -2,13 +2,7 @@
 # Makefile for the industrial I/O core.
 #
 
-obj-$(CONFIG_IIO) += industrialio.o
-industrialio-y := industrialio-core.o industrialio-event.o inkern.o
-industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
-industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
-
 obj-$(CONFIG_IIO_SW_RING) += ring_sw.o
-obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
 
 obj-$(CONFIG_IIO_SIMPLE_DUMMY) += iio_dummy.o
 iio_dummy-y := iio_simple_dummy.o
-- 
1.7.0.4

