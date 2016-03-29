Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14294 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757117AbcC2MV1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 29 Mar 2016 08:21:27 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Markus Pargmann <mpa@pengutronix.de>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v3 1/1] iio: accel: bmc150: use common definition for regmap conf
Date: Tue, 29 Mar 2016 15:21:21 +0300
Message-Id: <1459254081-8546-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

bmc150_i2c_regmap_conf is defined three times (in bmc150-accel-core.c,
bmc150-accel-i2c.c and and bmc150-accel-spi.c), although the
definition is the same.

Use one common definition for bmc150_i2c_regmap_conf in all
included files.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---

Changes from v2:
 - fix spi build errors

Changes from v1:
  - instead of removing the unused definition from the core,
share it between the i2c and spi files
  - renamed the subject line from "iio: accel: bmc150: remove
unused definition" to better reflect the new change

 drivers/iio/accel/bmc150-accel-core.c | 3 ++-
 drivers/iio/accel/bmc150-accel-i2c.c  | 7 +------
 drivers/iio/accel/bmc150-accel-spi.c  | 8 +-------
 drivers/iio/accel/bmc150-accel.h      | 1 +
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index f3d096f..e631ee9 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -246,11 +246,12 @@ static const struct {
 				       {500000, BMC150_ACCEL_SLEEP_500_MS},
 				       {1000000, BMC150_ACCEL_SLEEP_1_SEC} };
 
-static const struct regmap_config bmc150_i2c_regmap_conf = {
+const struct regmap_config bmc150_regmap_conf = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0x3f,
 };
+EXPORT_SYMBOL_GPL(bmc150_regmap_conf);
 
 static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
 				 enum bmc150_power_modes mode,
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index b41404b..8ca8041 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -28,11 +28,6 @@
 
 #include "bmc150-accel.h"
 
-static const struct regmap_config bmc150_i2c_regmap_conf = {
-	.reg_bits = 8,
-	.val_bits = 8,
-};
-
 static int bmc150_accel_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
@@ -43,7 +38,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 		i2c_check_functionality(client->adapter,
 					I2C_FUNC_SMBUS_READ_I2C_BLOCK);
 
-	regmap = devm_regmap_init_i2c(client, &bmc150_i2c_regmap_conf);
+	regmap = devm_regmap_init_i2c(client, &bmc150_regmap_conf);
 	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
 		return PTR_ERR(regmap);
diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
index 16b66f2..006794a7 100644
--- a/drivers/iio/accel/bmc150-accel-spi.c
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -25,18 +25,12 @@
 
 #include "bmc150-accel.h"
 
-static const struct regmap_config bmc150_spi_regmap_conf = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = 0x3f,
-};
-
 static int bmc150_accel_probe(struct spi_device *spi)
 {
 	struct regmap *regmap;
 	const struct spi_device_id *id = spi_get_device_id(spi);
 
-	regmap = devm_regmap_init_spi(spi, &bmc150_spi_regmap_conf);
+	regmap = devm_regmap_init_spi(spi, &bmc150_regmap_conf);
 	if (IS_ERR(regmap)) {
 		dev_err(&spi->dev, "Failed to initialize spi regmap\n");
 		return PTR_ERR(regmap);
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index ba03359..38a8b11 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -16,5 +16,6 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 			    const char *name, bool block_supported);
 int bmc150_accel_core_remove(struct device *dev);
 extern const struct dev_pm_ops bmc150_accel_pm_ops;
+extern const struct regmap_config bmc150_regmap_conf;
 
 #endif  /* _BMC150_ACCEL_H_ */
-- 
1.9.1

