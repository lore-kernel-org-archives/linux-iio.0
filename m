Return-Path: <SRS0=MTIs=MC=gmail.com=songqiang1304521@kernel.org>
From: Song Qiang <songqiang1304521@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	shubhrajyoti@ti.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH] iio: magnetometer: hmc5843: Clean up redundant code.
Date: Thu, 20 Sep 2018 22:13:21 +0800
Message-Id: <20180920141321.15251-1-songqiang1304521@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Regmap tables are both defined in hmc5843_spi.c and hmc5843_i2c.c, while
the only difference between these two set of tables is SPI need a read
mask, which is set only in 'regmap_config' structrue. This patch moves
the other structrues into hmc5843_core.c to reduce redundance.

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 drivers/iio/magnetometer/hmc5843.h      |  4 ++++
 drivers/iio/magnetometer/hmc5843_core.c | 28 +++++++++++++++++++++++++
 drivers/iio/magnetometer/hmc5843_i2c.c  | 27 ------------------------
 drivers/iio/magnetometer/hmc5843_spi.c  | 27 ------------------------
 4 files changed, 32 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
index 76a5d7484d8d..0ab400f27c97 100644
--- a/drivers/iio/magnetometer/hmc5843.h
+++ b/drivers/iio/magnetometer/hmc5843.h
@@ -46,6 +46,10 @@ struct hmc5843_data {
 	__be16 buffer[8];
 };
 
+extern const struct regmap_access_table hmc5843_readable_table;
+extern const struct regmap_access_table hmc5843_writable_table;
+extern const struct regmap_access_table hmc5843_volatile_table;
+
 int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
 			 enum hmc5843_ids id, const char *name);
 int hmc5843_common_remove(struct device *dev);
diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index ada142fb7aa3..a18e6d89f42a 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -92,6 +92,34 @@ static const char *const hmc5843_meas_conf_modes[] = {"normal", "positivebias",
 static const char *const hmc5983_meas_conf_modes[] = {"normal", "positivebias",
 						      "negativebias",
 						      "disabled"};
+
+static const struct regmap_range hmc5843_readable_ranges[] = {
+		regmap_reg_range(0, HMC5843_ID_END),
+};
+
+const struct regmap_access_table hmc5843_readable_table = {
+		.yes_ranges = hmc5843_readable_ranges,
+		.n_yes_ranges = ARRAY_SIZE(hmc5843_readable_ranges),
+};
+
+static const struct regmap_range hmc5843_writable_ranges[] = {
+		regmap_reg_range(0, HMC5843_MODE_REG),
+};
+
+const struct regmap_access_table hmc5843_writable_table = {
+		.yes_ranges = hmc5843_writable_ranges,
+		.n_yes_ranges = ARRAY_SIZE(hmc5843_writable_ranges),
+};
+
+static const struct regmap_range hmc5843_volatile_ranges[] = {
+		regmap_reg_range(HMC5843_DATA_OUT_MSB_REGS, HMC5843_STATUS_REG),
+};
+
+const struct regmap_access_table hmc5843_volatile_table = {
+		.yes_ranges = hmc5843_volatile_ranges,
+		.n_yes_ranges = ARRAY_SIZE(hmc5843_volatile_ranges),
+};
+
 /* Scaling factors: 10000000/Gain */
 static const int hmc5843_regval_to_nanoscale[] = {
 	6173, 7692, 10309, 12821, 18868, 21739, 25641, 35714
diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
index 3de7f4426ac4..a2c45a23e3c9 100644
--- a/drivers/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/iio/magnetometer/hmc5843_i2c.c
@@ -17,33 +17,6 @@
 
 #include "hmc5843.h"
 
-static const struct regmap_range hmc5843_readable_ranges[] = {
-	regmap_reg_range(0, HMC5843_ID_END),
-};
-
-static const struct regmap_access_table hmc5843_readable_table = {
-	.yes_ranges = hmc5843_readable_ranges,
-	.n_yes_ranges = ARRAY_SIZE(hmc5843_readable_ranges),
-};
-
-static const struct regmap_range hmc5843_writable_ranges[] = {
-	regmap_reg_range(0, HMC5843_MODE_REG),
-};
-
-static const struct regmap_access_table hmc5843_writable_table = {
-	.yes_ranges = hmc5843_writable_ranges,
-	.n_yes_ranges = ARRAY_SIZE(hmc5843_writable_ranges),
-};
-
-static const struct regmap_range hmc5843_volatile_ranges[] = {
-	regmap_reg_range(HMC5843_DATA_OUT_MSB_REGS, HMC5843_STATUS_REG),
-};
-
-static const struct regmap_access_table hmc5843_volatile_table = {
-	.yes_ranges = hmc5843_volatile_ranges,
-	.n_yes_ranges = ARRAY_SIZE(hmc5843_volatile_ranges),
-};
-
 static const struct regmap_config hmc5843_i2c_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
index 535f03a70d63..19541f5bb38f 100644
--- a/drivers/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/iio/magnetometer/hmc5843_spi.c
@@ -14,33 +14,6 @@
 
 #include "hmc5843.h"
 
-static const struct regmap_range hmc5843_readable_ranges[] = {
-		regmap_reg_range(0, HMC5843_ID_END),
-};
-
-static const struct regmap_access_table hmc5843_readable_table = {
-		.yes_ranges = hmc5843_readable_ranges,
-		.n_yes_ranges = ARRAY_SIZE(hmc5843_readable_ranges),
-};
-
-static const struct regmap_range hmc5843_writable_ranges[] = {
-		regmap_reg_range(0, HMC5843_MODE_REG),
-};
-
-static const struct regmap_access_table hmc5843_writable_table = {
-		.yes_ranges = hmc5843_writable_ranges,
-		.n_yes_ranges = ARRAY_SIZE(hmc5843_writable_ranges),
-};
-
-static const struct regmap_range hmc5843_volatile_ranges[] = {
-		regmap_reg_range(HMC5843_DATA_OUT_MSB_REGS, HMC5843_STATUS_REG),
-};
-
-static const struct regmap_access_table hmc5843_volatile_table = {
-		.yes_ranges = hmc5843_volatile_ranges,
-		.n_yes_ranges = ARRAY_SIZE(hmc5843_volatile_ranges),
-};
-
 static const struct regmap_config hmc5843_spi_regmap_config = {
 		.reg_bits = 8,
 		.val_bits = 8,
-- 
2.17.1
