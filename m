Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: cristina.opriceana@gmail.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio: Delete some commented out lines in Kconfig and Makefile.
Date: Sat, 21 Nov 2015 20:15:58 +0000
Message-Id: <1448136958-29917-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

These should have been removed with the driver move out of staging
but instead were commented out.  This was missed in reviews at the
time so fixing it up now.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/Kconfig  | 28 ----------------------------
 drivers/staging/iio/Makefile |  7 -------
 2 files changed, 35 deletions(-)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 85de1985df8e..0e044cb0def8 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -17,32 +17,4 @@ source "drivers/staging/iio/meter/Kconfig"
 source "drivers/staging/iio/resolver/Kconfig"
 source "drivers/staging/iio/trigger/Kconfig"
 
-#config IIO_DUMMY_EVGEN
-#       tristate
-#
-#config IIO_SIMPLE_DUMMY
-#       tristate "An example driver with no hardware requirements"
-#       help
-#	 Driver intended mainly as documentation for how to write
-#	 a driver. May also be useful for testing userspace code
-#	 without hardware.
-
-#if IIO_SIMPLE_DUMMY
-
-#config IIO_SIMPLE_DUMMY_EVENTS
-#       bool "Event generation support"
-#       select IIO_DUMMY_EVGEN
-#      help
-#        Add some dummy events to the simple dummy driver.
-
-#config IIO_SIMPLE_DUMMY_BUFFER
-#	bool "Buffered capture support"
-#	select IIO_BUFFER
-# select IIO_TRIGGER
-#	select IIO_KFIFO_BUF
-#	help
-#	  Add buffered data capture to the simple dummy driver.
-
-#endif # IIO_SIMPLE_DUMMY
-
 endmenu
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 355824ab733b..3e616b4437f5 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -2,13 +2,6 @@
 # Makefile for the industrial I/O core.
 #
 
-#obj-$(CONFIG_IIO_SIMPLE_DUMMY) += iio_dummy.o
-#iio_dummy-y := iio_simple_dummy.o
-#iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_EVENTS) += iio_simple_dummy_events.o
-#iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_BUFFER) += iio_simple_dummy_buffer.o
-
-#obj-$(CONFIG_IIO_DUMMY_EVGEN) += iio_dummy_evgen.o
-
 obj-y += accel/
 obj-y += adc/
 obj-y += addac/
-- 
2.6.2
