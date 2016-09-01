Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 07/15 v2] iio: accel: kxsd9: Add I2C transport
Date: Thu,  1 Sep 2016 11:44:41 +0200
Message-Id: <1472723089-25113-7-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
References: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This adds I2C regmap transport for the KXSD9 driver.
Tested on the KXSD9 sensor on the APQ8060 Dragonboard.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase and account for the .remove() function being present
  and necessary to call from the earlier refactorings.
---
 drivers/iio/accel/Kconfig     | 12 ++++++++-
 drivers/iio/accel/Makefile    |  1 +
 drivers/iio/accel/kxsd9-i2c.c | 63 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/accel/kxsd9-i2c.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 0ac316fbba38..ab1c87ce07ed 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -98,7 +98,7 @@ config KXSD9
 	tristate "Kionix KXSD9 Accelerometer Driver"
 	help
 	  Say yes here to build support for the Kionix KXSD9 accelerometer.
-	  Currently this only supports the device via an SPI interface.
+	  It can be accessed using an (optional) SPI or I2C interface.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called kxsd9.
@@ -113,6 +113,16 @@ config KXSD9_SPI
 	  Say yes here to enable the Kionix KXSD9 accelerometer
 	  SPI transport channel.
 
+config KXSD9_I2C
+	tristate "Kionix KXSD9 I2C transport"
+	depends on KXSD9
+	depends on I2C
+	default KXSD9
+	select REGMAP_I2C
+	help
+	  Say yes here to enable the Kionix KXSD9 accelerometer
+	  I2C transport channel.
+
 config KXCJK1013
 	tristate "Kionix 3-Axis Accelerometer Driver"
 	depends on I2C
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 22a5770f62a9..7031e842c2cb 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
 obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
 obj-$(CONFIG_KXSD9)	+= kxsd9.o
 obj-$(CONFIG_KXSD9_SPI)	+= kxsd9-spi.o
+obj-$(CONFIG_KXSD9_I2C)	+= kxsd9-i2c.o
 
 obj-$(CONFIG_MMA7455)		+= mma7455_core.o
 obj-$(CONFIG_MMA7455_I2C)	+= mma7455_i2c.o
diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
new file mode 100644
index 000000000000..4aaa27d0aa32
--- /dev/null
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -0,0 +1,63 @@
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/regmap.h>
+
+#include "kxsd9.h"
+
+static int kxsd9_i2c_probe(struct i2c_client *i2c,
+			   const struct i2c_device_id *id)
+{
+	static const struct regmap_config config = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x0e,
+	};
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(i2c, &config);
+	if (IS_ERR(regmap)) {
+		dev_err(&i2c->dev, "Failed to register i2c regmap %d\n",
+			(int)PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return kxsd9_common_probe(&i2c->dev,
+				  regmap,
+				  i2c->name);
+}
+
+static int kxsd9_i2c_remove(struct i2c_client *client)
+{
+	return kxsd9_common_remove(&client->dev);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id kxsd9_of_match[] = {
+	{ .compatible = "kionix,kxsd9", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, kxsd9_of_match);
+#else
+#define kxsd9_of_match NULL
+#endif
+
+static const struct i2c_device_id kxsd9_i2c_id[] = {
+	{"kxsd9", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, kxsd9_i2c_id);
+
+static struct i2c_driver kxsd9_i2c_driver = {
+	.driver = {
+		.name	= "kxsd9",
+		.of_match_table = of_match_ptr(kxsd9_of_match),
+	},
+	.probe		= kxsd9_i2c_probe,
+	.remove		= kxsd9_i2c_remove,
+	.id_table	= kxsd9_i2c_id,
+};
+module_i2c_driver(kxsd9_i2c_driver);
-- 
2.7.4
