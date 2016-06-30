Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/10 v4] iio: pressure: bmp280: split off an I2C Kconfig entry
Date: Thu, 30 Jun 2016 03:48:50 +0200
Message-Id: <1467251334-30594-7-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1467251334-30594-1-git-send-email-linus.walleij@linaro.org>
References: <1467251334-30594-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This creates a separate BMP280_I2C Kconfig entry that gets selected
by BMP280 for I2C transport. As we currently only support I2C
transport there is not much practical change other than getting
a separate object file (or module) for the I2C driver part. The
old Kconfig symbol BMP280 will still select the stuff we need so
that oldconfig and old defconfigs works fine.

Tested-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Rebase, no other changes.
ChangeLog v2->v3:
- Fix up Kconfig to put the dependencies to not use the old driver
  directly under the main driver instead of under the I2C part
- Export the common probe, remove and regmap symbols as the I2C driver part
  becomes its own module and need to find those symbols from the
  other parts.
ChangeLog v1->v2:
- None
---
 drivers/iio/pressure/Kconfig         | 17 ++++++++++++-----
 drivers/iio/pressure/Makefile        |  3 ++-
 drivers/iio/pressure/bmp280-core.c   |  3 +++
 drivers/iio/pressure/bmp280-regmap.c |  3 +++
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 9125a9382b3e..851c4f5aec41 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -6,17 +6,24 @@
 menu "Pressure sensors"
 
 config BMP280
-	tristate "Bosch Sensortec BMP180 and BMP280 pressure sensor driver"
+	tristate "Bosch Sensortec BMP180/BMP280 pressure sensor I2C driver"
 	depends on I2C
 	depends on !(BMP085_I2C=y || BMP085_I2C=m)
-	select REGMAP_I2C
+	select REGMAP
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
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index af981b14b954..e11635d7139e 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -16,6 +16,7 @@
 #define pr_fmt(fmt) "bmp280: " fmt
 
 #include <linux/device.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
@@ -955,6 +956,7 @@ out_disable_vddd:
 	regulator_disable(data->vddd);
 	return ret;
 }
+EXPORT_SYMBOL(bmp280_common_probe);
 
 int bmp280_common_remove(struct device *dev)
 {
@@ -964,6 +966,7 @@ int bmp280_common_remove(struct device *dev)
 	regulator_disable(data->vddd);
 	return 0;
 }
+EXPORT_SYMBOL(bmp280_common_remove);
 
 MODULE_AUTHOR("Vlad Dogaru <vlad.dogaru@intel.com>");
 MODULE_DESCRIPTION("Driver for Bosch Sensortec BMP180/BMP280 pressure and temperature sensor");
diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
index 3341189d0975..6807113ec09f 100644
--- a/drivers/iio/pressure/bmp280-regmap.c
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -1,4 +1,5 @@
 #include <linux/device.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
 
 #include "bmp280.h"
@@ -37,6 +38,7 @@ const struct regmap_config bmp180_regmap_config = {
 	.writeable_reg = bmp180_is_writeable_reg,
 	.volatile_reg = bmp180_is_volatile_reg,
 };
+EXPORT_SYMBOL(bmp180_regmap_config);
 
 static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
 {
@@ -79,3 +81,4 @@ const struct regmap_config bmp280_regmap_config = {
 	.writeable_reg = bmp280_is_writeable_reg,
 	.volatile_reg = bmp280_is_volatile_reg,
 };
+EXPORT_SYMBOL(bmp280_regmap_config);
-- 
2.4.11
