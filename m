Return-Path: <bijosh.t@hotmail.com>
Message-ID: <BLU436-SMTP1368781E78F120E82EF730980B90@phx.gbl>
From: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
To: gregkh@linuxfoundation.org,
	knaack.h@gmx.de,
	jic23@kernel.org,
	lars@metafoo.de,
	pmeerw@pmeerw.net
CC: mahfouz.saif.elyazal@gmail.com,
	ciorneiioana@gmail.com,
	cristina.moraru09@gmail.com,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 1/1] staging: coding style cleanups for staging/iio/light/tsl2583 driver
Date: Sun, 28 Feb 2016 23:01:11 +0530
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch fixes following coding style warning reported by check patch
script, in tsl2583 driver:
    - Block comments use a trailing */ on a separate line

Signed-off-by: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
---
 drivers/staging/iio/light/tsl2583.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 3100d96..8c9e304 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -240,8 +240,10 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 		}
 	}
 
-	/* clear status, really interrupt status (interrupts are off), but
-	 * we use the bit anyway - don't forget 0x80 - this is a command*/
+	/*
+	 * Clear status, really interrupt status (interrupts are off), but
+	 * we use the bit anyway - don't forget 0x80 - this is a command
+	 */
 	ret = i2c_smbus_write_byte(chip->client,
 				   (TSL258X_CMD_REG | TSL258X_CMD_SPL_FN |
 				    TSL258X_CMD_ALS_INT_CLR));
@@ -429,8 +431,10 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 	chip->als_saturation = als_count * 922; /* 90% of full scale */
 	chip->als_time_scale = (als_time + 25) / 50;
 
-	/* TSL258x Specific power-on / adc enable sequence
-	 * Power on the device 1st. */
+	/*
+	 * TSL258x Specific power-on / adc enable sequence
+	 * Power on the device 1st.
+	 */
 	utmp = TSL258X_CNTL_PWR_ON;
 	ret = i2c_smbus_write_byte_data(chip->client,
 					TSL258X_CMD_REG | TSL258X_CNTRL, utmp);
@@ -439,8 +443,10 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	/* Use the following shadow copy for our delay before enabling ADC.
-	 * Write all the registers. */
+	/*
+	 * Use the following shadow copy for our delay before enabling ADC.
+	 * Write all the registers.
+	 */
 	for (i = 0, uP = chip->taos_config; i < TSL258X_REG_MAX; i++) {
 		ret = i2c_smbus_write_byte_data(chip->client,
 						TSL258X_CMD_REG + i,
@@ -453,8 +459,10 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 	}
 
 	usleep_range(3000, 3500);
-	/* NOW enable the ADC
-	 * initialize the desired mode of operation */
+	/*
+	 * NOW enable the ADC
+	 * initialize the desired mode of operation
+	 */
 	utmp = TSL258X_CNTL_PWR_ON | TSL258X_CNTL_ADC_ENBL;
 	ret = i2c_smbus_write_byte_data(chip->client,
 					TSL258X_CMD_REG | TSL258X_CNTRL,
@@ -695,8 +703,10 @@ static ssize_t taos_luxtable_show(struct device *dev,
 				  taos_device_lux[i].ch0,
 				  taos_device_lux[i].ch1);
 		if (taos_device_lux[i].ratio == 0) {
-			/* We just printed the first "0" entry.
-			 * Now get rid of the extra "," and break. */
+			/*
+			 * We just printed the first "0" entry.
+			 * Now get rid of the extra "," and break.
+			 */
 			offset--;
 			break;
 		}
-- 
2.1.4
