Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: jbrenner@taosinc.com,
	amit.kucheria@verdurent.com,
	pmeerw@pmeerw.net,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/5] staging:iio:light:tsl2563 clean comments up.
Date: Sat, 12 Jan 2013 10:35:21 +0000
Message-Id: <1357986924-11471-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1357986924-11471-1-git-send-email-jic23@kernel.org>
References: <1357986924-11471-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Fix formatting of some comments and drop a few generic information
free ones.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/light/tsl2563.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 1ee0a6f..547203c 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -190,8 +190,10 @@ static int tsl2563_configure(struct tsl2563_chip *chip)
 	ret = i2c_smbus_write_byte_data(chip->client,
 			TSL2563_CMD | TSL2563_REG_LOWHIGH,
 			(chip->low_thres >> 8) & 0xFF);
-/* Interrupt register is automatically written anyway if it is relevant
-   so is not here */
+/*
+ * Interrupt register is automatically written anyway if it is relevant
+ * so is not here.
+ */
 error_ret:
 	return ret;
 }
@@ -423,9 +425,7 @@ static const struct tsl2563_lux_coeff lux_table[] = {
 	},
 };
 
-/*
- * Convert normalized, scaled ADC values to lux.
- */
+/* Convert normalized, scaled ADC values to lux. */
 static unsigned int adc_to_lux(u32 adc0, u32 adc1)
 {
 	const struct tsl2563_lux_coeff *lp = lux_table;
@@ -441,11 +441,6 @@ static unsigned int adc_to_lux(u32 adc0, u32 adc1)
 	return (unsigned int) (lux >> ADC_FRAC_BITS);
 }
 
-/*--------------------------------------------------------------*/
-/*                      Sysfs interface                         */
-/*--------------------------------------------------------------*/
-
-
 /* Apply calibration coefficient to ADC count. */
 static u32 calib_adc(u32 adc, u32 calib)
 {
@@ -684,9 +679,6 @@ error_ret:
 	return ret;
 }
 
-/*--------------------------------------------------------------*/
-/*                      Probe, Attach, Remove                   */
-/*--------------------------------------------------------------*/
 static struct i2c_driver tsl2563_i2c_driver;
 
 static const struct iio_info tsl2563_info_no_irq = {
-- 
1.8.1
