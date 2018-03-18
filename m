Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51272 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753790AbeCRNh0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Mar 2018 09:37:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id h21so10724549wmd.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Mar 2018 06:37:25 -0700 (PDT)
Date: Sun, 18 Mar 2018 14:37:22 +0100
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 11/11] Move resolver ad2c1200 driver out of staging to
 mainline iio
Message-ID: <58a756a65d15d9d7e9032476c963e6aaea238cf9.1521379685.git.davidjulianveenstra@gmail.com>
References: <cover.1521379685.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521379685.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
 drivers/iio/Kconfig                           |  1 +
 drivers/iio/Makefile                          |  1 +
 drivers/iio/resolver/Kconfig                  | 17 +++++++++++++++++
 drivers/iio/resolver/Makefile                 |  5 +++++
 drivers/{staging => }/iio/resolver/ad2s1200.c |  0
 drivers/staging/iio/resolver/Kconfig          | 12 ------------
 drivers/staging/iio/resolver/Makefile         |  1 -
 7 files changed, 24 insertions(+), 13 deletions(-)
 create mode 100644 drivers/iio/resolver/Kconfig
 create mode 100644 drivers/iio/resolver/Makefile
 rename drivers/{staging => }/iio/resolver/ad2s1200.c (100%)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index b3c8c6ef0dff..4bec3ccbf4a1 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -92,6 +92,7 @@ source "drivers/iio/potentiometer/Kconfig"
 source "drivers/iio/potentiostat/Kconfig"
 source "drivers/iio/pressure/Kconfig"
 source "drivers/iio/proximity/Kconfig"
+source "drivers/iio/resolver/Kconfig"
 source "drivers/iio/temperature/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index b16b2e9ddc40..1865361b8714 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -35,5 +35,6 @@ obj-y += potentiometer/
 obj-y += potentiostat/
 obj-y += pressure/
 obj-y += proximity/
+obj-y += resolver/
 obj-y += temperature/
 obj-y += trigger/
diff --git a/drivers/iio/resolver/Kconfig b/drivers/iio/resolver/Kconfig
new file mode 100644
index 000000000000..2ced9f22aa70
--- /dev/null
+++ b/drivers/iio/resolver/Kconfig
@@ -0,0 +1,17 @@
+#
+# Resolver/Synchro drivers
+#
+menu "Resolver to digital converters"
+
+config AD2S1200
+	tristate "Analog Devices ad2s1200/ad2s1205 driver"
+	depends on SPI
+	depends on GPIOLIB || COMPILE_TEST
+	help
+	  Say yes here to build support for Analog Devices spi resolver
+	  to digital converters, ad2s1200 and ad2s1205, provides direct access
+	  via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad2s1200.
+endmenu
diff --git a/drivers/iio/resolver/Makefile b/drivers/iio/resolver/Makefile
new file mode 100644
index 000000000000..4e1dccae07e7
--- /dev/null
+++ b/drivers/iio/resolver/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for Resolver/Synchro drivers
+#
+
+obj-$(CONFIG_AD2S1200) += ad2s1200.o
diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
similarity index 100%
rename from drivers/staging/iio/resolver/ad2s1200.c
rename to drivers/iio/resolver/ad2s1200.c
diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
index 1c7e2860d6b7..6a469ee6101f 100644
--- a/drivers/staging/iio/resolver/Kconfig
+++ b/drivers/staging/iio/resolver/Kconfig
@@ -13,18 +13,6 @@ config AD2S90
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad2s90.
 
-config AD2S1200
-	tristate "Analog Devices ad2s1200/ad2s1205 driver"
-	depends on SPI
-	depends on GPIOLIB || COMPILE_TEST
-	help
-	  Say yes here to build support for Analog Devices spi resolver
-	  to digital converters, ad2s1200 and ad2s1205, provides direct access
-	  via sysfs.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad2s1200.
-
 config AD2S1210
 	tristate "Analog Devices ad2s1210 driver"
 	depends on SPI
diff --git a/drivers/staging/iio/resolver/Makefile b/drivers/staging/iio/resolver/Makefile
index 14375e444ebf..8d901dc7500b 100644
--- a/drivers/staging/iio/resolver/Makefile
+++ b/drivers/staging/iio/resolver/Makefile
@@ -3,5 +3,4 @@
 #
 
 obj-$(CONFIG_AD2S90) += ad2s90.o
-obj-$(CONFIG_AD2S1200) += ad2s1200.o
 obj-$(CONFIG_AD2S1210) += ad2s1210.o
-- 
2.16.2

