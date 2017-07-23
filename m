Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55638 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbdGWQ0n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2017 12:26:43 -0400
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 18/45] iio:light: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Sun, 23 Jul 2017 17:26:00 +0100
Message-Id: <20170723162627.22534-19-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/acpi-als.c           | 1 -
 drivers/iio/light/adjd_s311.c          | 1 -
 drivers/iio/light/al3320a.c            | 1 -
 drivers/iio/light/apds9300.c           | 2 --
 drivers/iio/light/apds9960.c           | 1 -
 drivers/iio/light/bh1750.c             | 1 -
 drivers/iio/light/bh1780.c             | 1 -
 drivers/iio/light/cm32181.c            | 1 -
 drivers/iio/light/cm3232.c             | 1 -
 drivers/iio/light/cm3323.c             | 1 -
 drivers/iio/light/cm3605.c             | 1 -
 drivers/iio/light/cm36651.c            | 1 -
 drivers/iio/light/cros_ec_light_prox.c | 1 -
 drivers/iio/light/gp2ap020a00f.c       | 2 --
 drivers/iio/light/hid-sensor-als.c     | 1 -
 drivers/iio/light/hid-sensor-prox.c    | 1 -
 drivers/iio/light/isl29018.c           | 2 --
 drivers/iio/light/isl29028.c           | 1 -
 drivers/iio/light/isl29125.c           | 1 -
 drivers/iio/light/jsa1212.c            | 1 -
 drivers/iio/light/lm3533-als.c         | 1 -
 drivers/iio/light/ltr501.c             | 4 ----
 drivers/iio/light/max44000.c           | 1 -
 drivers/iio/light/opt3001.c            | 1 -
 drivers/iio/light/pa12203001.c         | 1 -
 drivers/iio/light/rpr0521.c            | 2 --
 drivers/iio/light/si1145.c             | 3 ---
 drivers/iio/light/stk3310.c            | 1 -
 drivers/iio/light/tcs3414.c            | 1 -
 drivers/iio/light/tcs3472.c            | 1 -
 drivers/iio/light/tsl2563.c            | 2 --
 drivers/iio/light/tsl2583.c            | 1 -
 drivers/iio/light/tsl4531.c            | 1 -
 drivers/iio/light/us5182d.c            | 1 -
 drivers/iio/light/vcnl4000.c           | 1 -
 drivers/iio/light/veml6070.c           | 1 -
 drivers/iio/light/vl6180.c             | 1 -
 37 files changed, 47 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index f0b47c501f4e..c35e2f8df339 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -171,7 +171,6 @@ static int acpi_als_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info acpi_als_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= acpi_als_read_raw,
 };
 
diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 0113fc843a81..e45bb6a277c2 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -245,7 +245,6 @@ static const struct iio_info adjd_s311_info = {
 	.read_raw = adjd_s311_read_raw,
 	.write_raw = adjd_s311_write_raw,
 	.update_scan_mode = adjd_s311_update_scan_mode,
-	.driver_module = THIS_MODULE,
 };
 
 static int adjd_s311_probe(struct i2c_client *client,
diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 6aac6513fd41..66623facea9a 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -168,7 +168,6 @@ static int al3320a_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info al3320a_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= al3320a_read_raw,
 	.write_raw	= al3320a_write_raw,
 	.attrs		= &al3320a_attribute_group,
diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index 649b26f67813..d283005a294b 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -337,12 +337,10 @@ static int apds9300_write_interrupt_config(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info apds9300_info_no_irq = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= apds9300_read_raw,
 };
 
 static const struct iio_info apds9300_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= apds9300_read_raw,
 	.read_event_value	= apds9300_read_thresh,
 	.write_event_value	= apds9300_write_thresh,
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 518a47e9377b..a8fa00e31c39 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -744,7 +744,6 @@ static int apds9960_write_event_config(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info apds9960_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &apds9960_attribute_group,
 	.read_raw = apds9960_read_raw,
 	.write_raw = apds9960_write_raw,
diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 6c61187e630f..a814828e69f5 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -217,7 +217,6 @@ static const struct attribute_group bh1750_attribute_group = {
 };
 
 static const struct iio_info bh1750_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &bh1750_attribute_group,
 	.read_raw = bh1750_read_raw,
 	.write_raw = bh1750_write_raw,
diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index b54dcba05a82..036f3bbe323c 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -128,7 +128,6 @@ static int bh1780_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info bh1780_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = bh1780_read_raw,
 	.debugfs_reg_access = bh1780_debugfs_reg_access,
 };
diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index d6fd0dace74f..aebf7dd071af 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -292,7 +292,6 @@ static const struct attribute_group cm32181_attribute_group = {
 };
 
 static const struct iio_info cm32181_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= &cm32181_read_raw,
 	.write_raw		= &cm32181_write_raw,
 	.attrs			= &cm32181_attribute_group,
diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index 263e97235ea0..c639cf276ee6 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -322,7 +322,6 @@ static const struct attribute_group cm3232_attribute_group = {
 };
 
 static const struct iio_info cm3232_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= &cm3232_read_raw,
 	.write_raw		= &cm3232_write_raw,
 	.attrs			= &cm3232_attribute_group,
diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index d823c112d54b..83b08b6dc60f 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -211,7 +211,6 @@ static int cm3323_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info cm3323_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= cm3323_read_raw,
 	.write_raw	= cm3323_write_raw,
 	.attrs		= &cm3323_attribute_group,
diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 980624e9ffb5..e454bc6a33c6 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -126,7 +126,6 @@ static int cm3605_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info cm3605_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = cm3605_read_raw,
 };
 
diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
index 9d66e89c57ef..1dd8ed0121b3 100644
--- a/drivers/iio/light/cm36651.c
+++ b/drivers/iio/light/cm36651.c
@@ -612,7 +612,6 @@ static const struct attribute_group cm36651_attribute_group = {
 };
 
 static const struct iio_info cm36651_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= &cm36651_read_raw,
 	.write_raw		= &cm36651_write_raw,
 	.read_event_value	= &cm36651_read_prox_thresh,
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 721722376fd0..b2a46b390d5c 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -175,7 +175,6 @@ static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
 static const struct iio_info cros_ec_light_prox_info = {
 	.read_raw = &cros_ec_light_prox_read,
 	.write_raw = &cros_ec_light_prox_write,
-	.driver_module = THIS_MODULE,
 };
 
 static int cros_ec_light_prox_probe(struct platform_device *pdev)
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 6ada9149f142..44b13fbcd093 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1384,7 +1384,6 @@ static const struct iio_info gp2ap020a00f_info = {
 	.read_event_config = &gp2ap020a00f_read_event_config,
 	.write_event_value = &gp2ap020a00f_write_event_val,
 	.write_event_config = &gp2ap020a00f_write_event_config,
-	.driver_module = THIS_MODULE,
 };
 
 static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
@@ -1481,7 +1480,6 @@ static const struct iio_buffer_setup_ops gp2ap020a00f_buffer_setup_ops = {
 };
 
 static const struct iio_trigger_ops gp2ap020a00f_trigger_ops = {
-	.owner = THIS_MODULE,
 };
 
 static int gp2ap020a00f_probe(struct i2c_client *client,
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 059d964772c7..befd693a4a31 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -177,7 +177,6 @@ static int als_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info als_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &als_read_raw,
 	.write_raw = &als_write_raw,
 };
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 73fced8a63b7..45107f7537b5 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -156,7 +156,6 @@ static int prox_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info prox_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &prox_read_raw,
 	.write_raw = &prox_write_raw,
 };
diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 61f5924b472d..b45400f8fef4 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -624,14 +624,12 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
 
 static const struct iio_info isl29018_info = {
 	.attrs = &isl29018_group,
-	.driver_module = THIS_MODULE,
 	.read_raw = isl29018_read_raw,
 	.write_raw = isl29018_write_raw,
 };
 
 static const struct iio_info isl29023_info = {
 	.attrs = &isl29023_group,
-	.driver_module = THIS_MODULE,
 	.read_raw = isl29018_read_raw,
 	.write_raw = isl29018_write_raw,
 };
diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 3d09c1fc4dad..f9912ab4f65c 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -536,7 +536,6 @@ static const struct iio_chan_spec isl29028_channels[] = {
 
 static const struct iio_info isl29028_info = {
 	.attrs = &isl29108_group,
-	.driver_module = THIS_MODULE,
 	.read_raw = isl29028_read_raw,
 	.write_raw = isl29028_write_raw,
 };
diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index 1d2c0c8a1d4f..ed38edcd5efe 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -214,7 +214,6 @@ static const struct iio_info isl29125_info = {
 	.read_raw = isl29125_read_raw,
 	.write_raw = isl29125_write_raw,
 	.attrs = &isl29125_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int isl29125_buffer_preenable(struct iio_dev *indio_dev)
diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
index e8a8931b4f50..811505d925b3 100644
--- a/drivers/iio/light/jsa1212.c
+++ b/drivers/iio/light/jsa1212.c
@@ -271,7 +271,6 @@ static const struct iio_chan_spec jsa1212_channels[] = {
 };
 
 static const struct iio_info jsa1212_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= &jsa1212_read_raw,
 };
 
diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 0443fd2e8757..36208a3652e9 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -827,7 +827,6 @@ static int lm3533_als_disable(struct lm3533_als *als)
 static const struct iio_info lm3533_als_info = {
 	.attrs		= &lm3533_als_attribute_group,
 	.event_attrs	= &lm3533_als_event_attribute_group,
-	.driver_module	= THIS_MODULE,
 	.read_raw	= &lm3533_als_read_raw,
 };
 
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 67838edd8b37..830a2d45aa4d 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1158,7 +1158,6 @@ static const struct iio_info ltr501_info_no_irq = {
 	.read_raw = ltr501_read_raw,
 	.write_raw = ltr501_write_raw,
 	.attrs = &ltr501_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ltr501_info = {
@@ -1169,14 +1168,12 @@ static const struct iio_info ltr501_info = {
 	.write_event_value	= &ltr501_write_event,
 	.read_event_config	= &ltr501_read_event_config,
 	.write_event_config	= &ltr501_write_event_config,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ltr301_info_no_irq = {
 	.read_raw = ltr501_read_raw,
 	.write_raw = ltr501_write_raw,
 	.attrs = &ltr301_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ltr301_info = {
@@ -1187,7 +1184,6 @@ static const struct iio_info ltr301_info = {
 	.write_event_value	= &ltr501_write_event,
 	.read_event_config	= &ltr501_read_event_config,
 	.write_event_config	= &ltr501_write_event_config,
-	.driver_module = THIS_MODULE,
 };
 
 static struct ltr501_chip_info ltr501_chip_info_tbl[] = {
diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index 81bd8e8da4a6..bcdb0eb9e537 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -402,7 +402,6 @@ static const struct attribute_group max44000_attribute_group = {
 };
 
 static const struct iio_info max44000_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= max44000_read_raw,
 	.write_raw		= max44000_write_raw,
 	.write_raw_get_fmt	= max44000_write_raw_get_fmt,
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index b91ebc3483ce..54d88b60e303 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -585,7 +585,6 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 }
 
 static const struct iio_info opt3001_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &opt3001_attribute_group,
 	.read_raw = opt3001_read_raw,
 	.write_raw = opt3001_write_raw,
diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index 76a9e12b46bc..30ea1a088dd9 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -306,7 +306,6 @@ static int pa12203001_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info pa12203001_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw = pa12203001_read_raw,
 	.write_raw = pa12203001_write_raw,
 	.attrs = &pa12203001_attr_group,
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index a6efa12613a2..ffe9ce798ea2 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -538,7 +538,6 @@ static int rpr0521_pxs_drdy_set_state(struct iio_trigger *trigger,
 
 static const struct iio_trigger_ops rpr0521_trigger_ops = {
 	.set_trigger_state = rpr0521_pxs_drdy_set_state,
-	.owner = THIS_MODULE,
 	};
 
 
@@ -830,7 +829,6 @@ static int rpr0521_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info rpr0521_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= rpr0521_read_raw,
 	.write_raw	= rpr0521_write_raw,
 	.attrs		= &rpr0521_attribute_group,
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 096034c126a4..76f16f9c7616 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -989,14 +989,12 @@ static const struct attribute_group si114x_attribute_group = {
 static const struct iio_info si1132_info = {
 	.read_raw = si1145_read_raw,
 	.write_raw = si1145_write_raw,
-	.driver_module = THIS_MODULE,
 	.attrs = &si1132_attribute_group,
 };
 
 static const struct iio_info si114x_info = {
 	.read_raw = si1145_read_raw,
 	.write_raw = si1145_write_raw,
-	.driver_module = THIS_MODULE,
 	.attrs = &si114x_attribute_group,
 };
 
@@ -1237,7 +1235,6 @@ static int si1145_trigger_set_state(struct iio_trigger *trig, bool state)
 }
 
 static const struct iio_trigger_ops si1145_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = si1145_trigger_set_state,
 };
 
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 45cf8b0a4363..6e2a169da950 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -409,7 +409,6 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info stk3310_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= stk3310_read_raw,
 	.write_raw		= stk3310_write_raw,
 	.attrs			= &stk3310_attribute_group,
diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index a795afb7667b..205e5659ce6b 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -241,7 +241,6 @@ static const struct iio_info tcs3414_info = {
 	.read_raw = tcs3414_read_raw,
 	.write_raw = tcs3414_write_raw,
 	.attrs = &tcs3414_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int tcs3414_buffer_preenable(struct iio_dev *indio_dev)
diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 09e6ca5e332e..9540a5c1d746 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -246,7 +246,6 @@ static const struct iio_info tcs3472_info = {
 	.read_raw = tcs3472_read_raw,
 	.write_raw = tcs3472_write_raw,
 	.attrs = &tcs3472_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int tcs3472_probe(struct i2c_client *client,
diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index e7d4ea75e007..6a52b47cb49a 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -697,13 +697,11 @@ static int tsl2563_read_interrupt_config(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info tsl2563_info_no_irq = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &tsl2563_read_raw,
 	.write_raw = &tsl2563_write_raw,
 };
 
 static const struct iio_info tsl2563_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &tsl2563_read_raw,
 	.write_raw = &tsl2563_write_raw,
 	.read_event_value = &tsl2563_read_thresh,
diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 1679181d2bdd..5d5bc0b7341a 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -804,7 +804,6 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info tsl2583_info = {
 	.attrs = &tsl2583_attribute_group,
-	.driver_module = THIS_MODULE,
 	.read_raw = tsl2583_read_raw,
 	.write_raw = tsl2583_write_raw,
 };
diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
index cf94ec72b181..06171cb76e23 100644
--- a/drivers/iio/light/tsl4531.c
+++ b/drivers/iio/light/tsl4531.c
@@ -144,7 +144,6 @@ static const struct iio_info tsl4531_info = {
 	.read_raw = tsl4531_read_raw,
 	.write_raw = tsl4531_write_raw,
 	.attrs = &tsl4531_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int tsl4531_check_id(struct i2c_client *client)
diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index d571ad7291ed..68e52943879a 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -714,7 +714,6 @@ static int us5182d_write_event_config(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info us5182d_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw = us5182d_read_raw,
 	.write_raw = us5182d_write_raw,
 	.attrs = &us5182d_attr_group,
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 360b6e98137a..c599a90506ad 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -155,7 +155,6 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info vcnl4000_info = {
 	.read_raw = vcnl4000_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int vcnl4000_probe(struct i2c_client *client,
diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index bc1c4cb782cd..f4bf3c5b5eda 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -136,7 +136,6 @@ static int veml6070_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info veml6070_info = {
 	.read_raw = veml6070_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int veml6070_probe(struct i2c_client *client,
diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 6e25b724d941..2306967f574f 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -429,7 +429,6 @@ static const struct iio_info vl6180_info = {
 	.read_raw = vl6180_read_raw,
 	.write_raw = vl6180_write_raw,
 	.attrs = &vl6180_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int vl6180_init(struct vl6180_data *data)
-- 
2.13.3

