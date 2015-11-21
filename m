Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: cristina.opriceana@gmail.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio: Delete some commented out lines in Kconfig.
Date: Sat, 21 Nov 2015 18:22:44 +0000
Message-Id: <1448130164-29097-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

These should have been removed with the driver move out of staging
but instead were commented out.  This was missed in reviews at the
time so fixing it up now.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/Kconfig | 28 ----------------------------
 1 file changed, 28 deletions(-)

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
-- 
2.6.2
