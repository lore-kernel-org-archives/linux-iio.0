Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35102 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbcFVUyZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2016 16:54:25 -0400
Received: by mail-lf0-f45.google.com with SMTP id l188so81461053lfe.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2016 13:54:24 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6/9 v2] iio: pressure: bmp280: split off an I2C Kconfig entry
Date: Wed, 22 Jun 2016 22:53:36 +0200
Message-Id: <1466628819-29784-7-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This creates a separate BMP280_I2C Kconfig entry that gets selected
by BMP280 for I2C transport. As we currently only support I2C
transport there is not much practical change other than getting
a separate object file (or module) for the I2C driver part. The
old Kconfig symbol BMP280 will still select the stuff we need so
that oldconfig and old defconfigs works fine.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/pressure/Kconfig  | 18 ++++++++++++------
 drivers/iio/pressure/Makefile |  3 ++-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 9125a9382b3e..94ad8e7ad0ec 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -6,17 +6,23 @@
 menu "Pressure sensors"
 
 config BMP280
-	tristate "Bosch Sensortec BMP180 and BMP280 pressure sensor driver"
+	tristate "Bosch Sensortec BMP180/BMP280 pressure sensor I2C driver"
 	depends on I2C
-	depends on !(BMP085_I2C=y || BMP085_I2C=m)
-	select REGMAP_I2C
+	select BMP280_I2C if (I2C)
 	help
 	  Say yes here to build support for Bosch Sensortec BMP180 and BMP280
 	  pressure and temperature sensors. Also supports the BE280 with
-	  an additional humidty sensor channel.
+	  an additional humidity sensor channel.
 
-	  To compile this driver as a module, choose M here: the module
-	  will be called bmp280.
+	  To compile this driver as a module, choose M here: the modules
+	  will be called bmp280-i2c and bmp280.
+
+config BMP280_I2C
+	tristate
+	depends on BMP280
+	depends on I2C
+	depends on !(BMP085_I2C=y || BMP085_I2C=m)
+	select REGMAP_I2C
 
 config HID_SENSOR_PRESS
 	depends on HID_SENSOR_HUB
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 2d98a7ff77a8..736f4305fe46 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -4,7 +4,8 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_BMP280) += bmp280.o
-bmp280-objs := bmp280-core.o bmp280-regmap.o bmp280-i2c.o
+bmp280-objs := bmp280-core.o bmp280-regmap.o
+obj-$(CONFIG_BMP280_I2C) += bmp280-i2c.o
 obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
 obj-$(CONFIG_HP03) += hp03.o
 obj-$(CONFIG_MPL115) += mpl115.o
-- 
2.4.11

