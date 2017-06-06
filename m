Return-Path: <SRS0=N3n8=5L=redhat.com=hdegoede@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] Revert "iio: accel: bma180: Add support for BMA250E"
Date: Tue,  6 Jun 2017 22:35:38 +0200
Message-Id: <20170606203538.15250-3-hdegoede@redhat.com>
In-Reply-To: <20170606203538.15250-1-hdegoede@redhat.com>
References: <20170606203538.15250-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

This reverts commit f1320b09517bceb261fed887fe261d6cbab2094e.

The BMA250E is already handled by the bmc150-accel-i2c driver, which
supports the "E" variants of the BMA??? accelerometers better then the
bma180 driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bma180.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 3d66948..efc6773 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -36,7 +36,6 @@
 enum chip_ids {
 	BMA180,
 	BMA250,
-	BMA250E,
 };
 
 struct bma180_data;
@@ -56,7 +55,6 @@ struct bma180_part_info {
 	u8 power_reg, power_mask, lowpower_val;
 	u8 int_enable_reg, int_enable_mask;
 	u8 softreset_reg;
-	u8 chip_id;
 
 	int (*chip_config)(struct bma180_data *data);
 	void (*chip_disable)(struct bma180_data *data);
@@ -114,8 +112,6 @@ struct bma180_part_info {
 #define BMA250_INT1_DATA_MASK	BIT(0)
 #define BMA250_INT_RESET_MASK	BIT(7) /* Reset pending interrupts */
 
-#define BMA250E_CHIP_ID		0xf9
-
 struct bma180_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
@@ -313,7 +309,7 @@ static int bma180_chip_init(struct bma180_data *data)
 
 	if (ret < 0)
 		return ret;
-	if (ret != data->part_info->chip_id)
+	if (ret != BMA180_ID_REG_VAL)
 		return -ENODEV;
 
 	ret = bma180_soft_reset(data);
@@ -636,7 +632,6 @@ static const struct bma180_part_info bma180_part_info[] = {
 		BMA180_TCO_Z, BMA180_MODE_CONFIG, BMA180_LOW_POWER,
 		BMA180_CTRL_REG3, BMA180_NEW_DATA_INT,
 		BMA180_RESET,
-		BMA180_CHIP_ID,
 		bma180_chip_config,
 		bma180_chip_disable,
 	},
@@ -651,22 +646,6 @@ static const struct bma180_part_info bma180_part_info[] = {
 		BMA250_POWER_REG, BMA250_LOWPOWER_MASK, 1,
 		BMA250_INT_ENABLE_REG, BMA250_DATA_INTEN_MASK,
 		BMA250_RESET_REG,
-		BMA180_CHIP_ID,
-		bma250_chip_config,
-		bma250_chip_disable,
-	},
-	[BMA250E] = {
-		bma250_channels, ARRAY_SIZE(bma250_channels),
-		bma250_scale_table, ARRAY_SIZE(bma250_scale_table),
-		bma250_bw_table, ARRAY_SIZE(bma250_bw_table),
-		BMA250_INT_RESET_REG, BMA250_INT_RESET_MASK,
-		BMA250_POWER_REG, BMA250_SUSPEND_MASK,
-		BMA250_BW_REG, BMA250_BW_MASK,
-		BMA250_RANGE_REG, BMA250_RANGE_MASK,
-		BMA250_POWER_REG, BMA250_LOWPOWER_MASK, 1,
-		BMA250_INT_ENABLE_REG, BMA250_DATA_INTEN_MASK,
-		BMA250_RESET_REG,
-		BMA250E_CHIP_ID,
 		bma250_chip_config,
 		bma250_chip_disable,
 	},
@@ -866,7 +845,6 @@ static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
 static struct i2c_device_id bma180_ids[] = {
 	{ "bma180", BMA180 },
 	{ "bma250", BMA250 },
-	{ "bma250e", BMA250E },
 	{ }
 };
 
-- 
2.9.4
