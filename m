Return-Path: <bijosh.t@hotmail.com>
Message-ID: <BLU437-SMTP46745C0D4BEFE546C5C7A280B90@phx.gbl>
From: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
CC: mahfouz.saif.elyazal@gmail.com,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] staging: coding style cleanups for staging/iio/light/tsl2583 driver
Date: Sun, 28 Feb 2016 13:58:24 +0530
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch fixes following coding style warning reported by check patch
script, in tsl2583 driver:
    - Block comments use a trailing */ on a separate line

Signed-off-by: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
---
 drivers/staging/iio/light/tsl2583.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 3100d96..9159298 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -241,7 +241,8 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 	}
 
 	/* clear status, really interrupt status (interrupts are off), but
-	 * we use the bit anyway - don't forget 0x80 - this is a command*/
+	 * we use the bit anyway - don't forget 0x80 - this is a command
+	 */
 	ret = i2c_smbus_write_byte(chip->client,
 				   (TSL258X_CMD_REG | TSL258X_CMD_SPL_FN |
 				    TSL258X_CMD_ALS_INT_CLR));
@@ -430,7 +431,8 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 	chip->als_time_scale = (als_time + 25) / 50;
 
 	/* TSL258x Specific power-on / adc enable sequence
-	 * Power on the device 1st. */
+	 * Power on the device 1st.
+	 */
 	utmp = TSL258X_CNTL_PWR_ON;
 	ret = i2c_smbus_write_byte_data(chip->client,
 					TSL258X_CMD_REG | TSL258X_CNTRL, utmp);
@@ -440,7 +442,8 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 	}
 
 	/* Use the following shadow copy for our delay before enabling ADC.
-	 * Write all the registers. */
+	 * Write all the registers.
+	 */
 	for (i = 0, uP = chip->taos_config; i < TSL258X_REG_MAX; i++) {
 		ret = i2c_smbus_write_byte_data(chip->client,
 						TSL258X_CMD_REG + i,
@@ -454,7 +457,8 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 
 	usleep_range(3000, 3500);
 	/* NOW enable the ADC
-	 * initialize the desired mode of operation */
+	 * initialize the desired mode of operation
+	 */
 	utmp = TSL258X_CNTL_PWR_ON | TSL258X_CNTL_ADC_ENBL;
 	ret = i2c_smbus_write_byte_data(chip->client,
 					TSL258X_CMD_REG | TSL258X_CNTRL,
@@ -696,7 +700,8 @@ static ssize_t taos_luxtable_show(struct device *dev,
 				  taos_device_lux[i].ch1);
 		if (taos_device_lux[i].ratio == 0) {
 			/* We just printed the first "0" entry.
-			 * Now get rid of the extra "," and break. */
+			 * Now get rid of the extra "," and break.
+			 */
 			offset--;
 			break;
 		}
-- 
2.1.4
