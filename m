Return-Path: <tolga.ceylan@gmail.com>
From: Tolga Ceylan <tolga.ceylan@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Josef Gajdusek <atx@atalax.net>,
	Tolga Ceylan <tolga.ceylan@gmail.com>,
	linux-iio@vger.kernel.org ,
	devel@driverdev.osuosl.org ,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Staging: iio: Coding Style Correction
Date: Sun,  8 Feb 2015 00:04:53 -0800
Message-Id: <1423382693-4189-1-git-send-email-tolga.ceylan@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Indentation corrections in struct initializations and
one line over 80 characters split into two lines

Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
---
 drivers/staging/iio/magnetometer/hmc5843_i2c.c | 34 +++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843_i2c.c b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
index 6acd614..e221a58 100644
--- a/drivers/staging/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
@@ -19,49 +19,49 @@
 #include "hmc5843.h"
 
 static const struct regmap_range hmc5843_readable_ranges[] = {
-		regmap_reg_range(0, HMC5843_ID_END),
+	regmap_reg_range(0, HMC5843_ID_END),
 };
 
 static struct regmap_access_table hmc5843_readable_table = {
-		.yes_ranges = hmc5843_readable_ranges,
-		.n_yes_ranges = ARRAY_SIZE(hmc5843_readable_ranges),
+	.yes_ranges = hmc5843_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(hmc5843_readable_ranges),
 };
 
 static const struct regmap_range hmc5843_writable_ranges[] = {
-		regmap_reg_range(0, HMC5843_MODE_REG),
+	regmap_reg_range(0, HMC5843_MODE_REG),
 };
 
 static struct regmap_access_table hmc5843_writable_table = {
-		.yes_ranges = hmc5843_writable_ranges,
-		.n_yes_ranges = ARRAY_SIZE(hmc5843_writable_ranges),
+	.yes_ranges = hmc5843_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(hmc5843_writable_ranges),
 };
 
 static const struct regmap_range hmc5843_volatile_ranges[] = {
-		regmap_reg_range(HMC5843_DATA_OUT_MSB_REGS, HMC5843_STATUS_REG),
+	regmap_reg_range(HMC5843_DATA_OUT_MSB_REGS, HMC5843_STATUS_REG),
 };
 
 static struct regmap_access_table hmc5843_volatile_table = {
-		.yes_ranges = hmc5843_volatile_ranges,
-		.n_yes_ranges = ARRAY_SIZE(hmc5843_volatile_ranges),
+	.yes_ranges = hmc5843_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(hmc5843_volatile_ranges),
 };
 
 static struct regmap_config hmc5843_i2c_regmap_config = {
-		.reg_bits = 8,
-		.val_bits = 8,
+	.reg_bits = 8,
+	.val_bits = 8,
 
-		.rd_table = &hmc5843_readable_table,
-		.wr_table = &hmc5843_writable_table,
-		.volatile_table = &hmc5843_volatile_table,
+	.rd_table = &hmc5843_readable_table,
+	.wr_table = &hmc5843_writable_table,
+	.volatile_table = &hmc5843_volatile_table,
 
-		.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int hmc5843_i2c_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	return hmc5843_common_probe(&client->dev,
-			devm_regmap_init_i2c(client, &hmc5843_i2c_regmap_config),
-			id->driver_data);
+		devm_regmap_init_i2c(client, &hmc5843_i2c_regmap_config),
+		id->driver_data);
 }
 
 static int hmc5843_i2c_remove(struct i2c_client *client)
-- 
2.3.0
