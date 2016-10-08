Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35391 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756517AbcJHQjf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 12:39:35 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 18/18] staging:iio:accel:sca3000 Move out of staging.
Date: Sat,  8 Oct 2016 17:39:18 +0100
Message-Id: <20161008163918.18758-19-jic23@kernel.org>
In-Reply-To: <20161008163918.18758-1-jic23@kernel.org>
References: <20161008163918.18758-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now the driver is in a reasonable state, lets get it (finally) out
of staging.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/Kconfig                 | 12 ++++++++++++
 drivers/iio/accel/Makefile                |  2 ++
 drivers/{staging => }/iio/accel/sca3000.c |  0
 drivers/staging/iio/accel/Kconfig         | 11 -----------
 drivers/staging/iio/accel/Makefile        |  2 --
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index ac56e0add42e..946e99a1a818 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -283,6 +283,18 @@ config MXC6255
 	  To compile this driver as a module, choose M here: the module will be
 	  called mxc6255.
 
+config SCA3000
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
+	depends on SPI
+	tristate "VTI SCA3000 series accelerometers"
+	help
+	  Say Y here to build support for the VTI SCA3000 series of SPI
+	  accelerometers. These devices use a hardware ring buffer.
+
+	  To compile this driver as a module, say M here: the module will be
+	  called sca3000.
+
 config STK8312
 	tristate "Sensortek STK8312 3-Axis Accelerometer Driver"
 	depends on I2C
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 03848148ad4b..c0bdc984793b 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -33,6 +33,8 @@ obj-$(CONFIG_MMA9553)		+= mma9553.o
 obj-$(CONFIG_MXC4005)		+= mxc4005.o
 obj-$(CONFIG_MXC6255)		+= mxc6255.o
 
+obj-$(CONFIG_SCA3000)		+= sca3000.o
+
 obj-$(CONFIG_STK8312)		+= stk8312.o
 obj-$(CONFIG_STK8BA50)		+= stk8ba50.o
 
diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
similarity index 100%
rename from drivers/staging/iio/accel/sca3000.c
rename to drivers/iio/accel/sca3000.c
diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index 53389bfdd100..c6b0f5eae7ab 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -51,15 +51,4 @@ config ADIS16240
 	  To compile this driver as a module, say M here: the module will be
 	  called adis16240.
 
-config SCA3000
-	select IIO_BUFFER
-	select IIO_KFIFO_BUF
-	depends on SPI
-	tristate "VTI SCA3000 series accelerometers"
-	help
-	  Say Y here to build support for the VTI SCA3000 series of SPI
-	  accelerometers. These devices use a hardware ring buffer.
-
-	  To compile this driver as a module, say M here: the module will be
-	  called sca3000.
 endmenu
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index 1d49b6ab87ab..febb137b60c4 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -13,5 +13,3 @@ obj-$(CONFIG_ADIS16209) += adis16209.o
 
 adis16240-y             := adis16240_core.o
 obj-$(CONFIG_ADIS16240) += adis16240.o
-
-obj-$(CONFIG_SCA3000)	+= sca3000.o
-- 
2.10.0

