Return-Path: <SRS0=wcSp=76=aclimalabs.com=colin.parker@kernel.org>
Sender: Colin Parker <colin.parker@aclimalabs.com>
From: Colin Parker <colin.foeparker@aclima.io>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	ak@it-klinger.de,
	foeparker.colin@gmail.com,
	Colin Parker <colin.parker@aclima.io>
Subject: [PATCH] IIO: BME280: Updates to Humidity readings need ctrl_reg write!
Date: Mon, 28 Aug 2017 16:21:39 -0700
Message-Id: <1503962499-11417-1-git-send-email-colin.parker@aclimalabs.com>
List-ID: <linux-iio@vger.kernel.org>

From: Colin Parker <colin.parker@aclima.io>

The ctrl_reg register needs to be written after any write to
the humidity registers. The value written to the ctrl_reg register
does not necessarily need to change, but a write operation must
occur.

The regmap_update_bits functions will not write to a register
if the register value matches the value to be written. This saves
unnecessary bus operations.  The change in this patch forces a bus
write during the chip_config operation by switching to
regmap_write_bits.

This will fix issues where the Humidity Sensor Oversampling bits
are not updated after initialization.

Signed-off-by: Colin Parker <colin.parker@aclima.io>
---
 drivers/iio/pressure/bmp280-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 0d2ea3e..8f26428 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -573,7 +573,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 	u8 osrs = BMP280_OSRS_TEMP_X(data->oversampling_temp + 1) |
 		  BMP280_OSRS_PRESS_X(data->oversampling_press + 1);
 
-	ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_MEAS,
+	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
 				 BMP280_OSRS_TEMP_MASK |
 				 BMP280_OSRS_PRESS_MASK |
 				 BMP280_MODE_MASK,
-- 
2.1.4
