Return-Path: <SRS0=sxJY=FG=gmail.com=himanshujha199640@kernel.org>
From: Himanshu Jha <himanshujha199640@gmail.com>
To: 21cnbao@gmail.com,
	jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 2/4] staging: iio: accel: Remove unnecessary comments and add suitable suffix
Date: Mon, 12 Feb 2018 17:24:57 +0530
Message-Id: <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Remove some unnecessary comments by giving appropriate name to macros.
Therefore, add _REG suffix for control registers. Also, align function
arguments to match open parentheses using tabs.
Group the control register and register field macros together.

Blank line before some returns improves code readability.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 226 ++++++++++++----------------------
 1 file changed, 79 insertions(+), 147 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index b2145c9..011d2c5 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -19,135 +19,63 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
-#define ADIS16201_STARTUP_DELAY	220 /* ms */
-
-/* Flash memory write count */
-#define ADIS16201_FLASH_CNT      0x00
-
-/* Output, power supply */
-#define ADIS16201_SUPPLY_OUT     0x02
-
-/* Output, x-axis accelerometer */
-#define ADIS16201_XACCL_OUT      0x04
-
-/* Output, y-axis accelerometer */
-#define ADIS16201_YACCL_OUT      0x06
-
-/* Output, auxiliary ADC input */
-#define ADIS16201_AUX_ADC        0x08
-
-/* Output, temperature */
-#define ADIS16201_TEMP_OUT       0x0A
-
-/* Output, x-axis inclination */
-#define ADIS16201_XINCL_OUT      0x0C
-
-/* Output, y-axis inclination */
-#define ADIS16201_YINCL_OUT      0x0E
-
-/* Calibration, x-axis acceleration offset */
-#define ADIS16201_XACCL_OFFS     0x10
-
-/* Calibration, y-axis acceleration offset */
-#define ADIS16201_YACCL_OFFS     0x12
-
-/* x-axis acceleration scale factor */
-#define ADIS16201_XACCL_SCALE    0x14
-
-/* y-axis acceleration scale factor */
-#define ADIS16201_YACCL_SCALE    0x16
-
-/* Calibration, x-axis inclination offset */
-#define ADIS16201_XINCL_OFFS     0x18
-
-/* Calibration, y-axis inclination offset */
-#define ADIS16201_YINCL_OFFS     0x1A
-
-/* x-axis inclination scale factor */
-#define ADIS16201_XINCL_SCALE    0x1C
-
-/* y-axis inclination scale factor */
-#define ADIS16201_YINCL_SCALE    0x1E
-
-/* Alarm 1 amplitude threshold */
-#define ADIS16201_ALM_MAG1       0x20
-
-/* Alarm 2 amplitude threshold */
-#define ADIS16201_ALM_MAG2       0x22
-
-/* Alarm 1, sample period */
-#define ADIS16201_ALM_SMPL1      0x24
-
-/* Alarm 2, sample period */
-#define ADIS16201_ALM_SMPL2      0x26
-
-/* Alarm control */
-#define ADIS16201_ALM_CTRL       0x28
-
-/* Auxiliary DAC data */
-#define ADIS16201_AUX_DAC        0x30
-
-/* General-purpose digital input/output control */
-#define ADIS16201_GPIO_CTRL      0x32
-
-/* Miscellaneous control */
-#define ADIS16201_MSC_CTRL       0x34
-
-/* Internal sample period (rate) control */
-#define ADIS16201_SMPL_PRD       0x36
-
-/* Operation, filter configuration */
-#define ADIS16201_AVG_CNT        0x38
-
-/* Operation, sleep mode control */
-#define ADIS16201_SLP_CNT        0x3A
-
-/* Diagnostics, system status register */
-#define ADIS16201_DIAG_STAT      0x3C
-
-/* Operation, system command register */
-#define ADIS16201_GLOB_CMD       0x3E
+#define ADIS16201_STARTUP_DELAY_MS		220
+#define ADIS16201_FLASH_CNT_REG			0x00
+
+/* Data Output Register Definitions */
+#define ADIS16201_SUPPLY_OUT_REG		0x02
+#define ADIS16201_XACCL_OUT_REG			0x04
+#define ADIS16201_YACCL_OUT_REG			0x06
+#define ADIS16201_AUX_ADC_REG			0x08
+#define ADIS16201_TEMP_OUT_REG			0x0A
+#define ADIS16201_XINCL_OUT_REG			0x0C
+#define ADIS16201_YINCL_OUT_REG			0x0E
+
+/* Calibration Register Definitions */
+#define ADIS16201_XACCL_OFFS_REG		0x10
+#define ADIS16201_YACCL_OFFS_REG		0x12
+#define ADIS16201_XACCL_SCALE_REG		0x14
+#define ADIS16201_YACCL_SCALE_REG		0x16
+#define ADIS16201_XINCL_OFFS_REG		0x18
+#define ADIS16201_YINCL_OFFS_REG		0x1A
+#define ADIS16201_XINCL_SCALE_REG		0x1C
+#define ADIS16201_YINCL_SCALE_REG		0x1E
+
+/* Alarm Register Definitions */
+#define ADIS16201_ALM_MAG1_REG			0x20
+#define ADIS16201_ALM_MAG2_REG			0x22
+#define ADIS16201_ALM_SMPL1_REG			0x24
+#define ADIS16201_ALM_SMPL2_REG			0x26
+#define ADIS16201_ALM_CTRL_REG			0x28
+
+#define ADIS16201_AUX_DAC_REG			0x30
+#define ADIS16201_GPIO_CTRL_REG			0x32
+#define ADIS16201_SMPL_PRD_REG			0x36
+#define ADIS16201_AVG_CNT_REG			0x38
+#define ADIS16201_SLP_CNT_REG			0x3A
 
 /* MSC_CTRL */
-
-/* Self-test enable */
-#define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
-
-/* Data-ready enable: 1 = enabled, 0 = disabled */
-#define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
-
-/* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16201_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
-
-/* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
+#define ADIS16201_MSC_CTRL_REG			0x34
+#define ADIS16201_MSC_CTRL_SELF_TEST_EN		BIT(8)
+#define ADIS16201_MSC_CTRL_DATA_RDY_EN		BIT(2)
+#define ADIS16201_MSC_CTRL_ACTIVE_HIGH		BIT(1)
 #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
 
 /* DIAG_STAT */
-
-/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
-
-/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
-
-/* SPI communications failure */
-#define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
-
-/* Flash update failure */
-#define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
-
-/* Power supply above 3.625 V */
-#define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
-
-/* Power supply below 3.15 V */
-#define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
+#define ADIS16201_DIAG_STAT_REG			0x3C
+#define ADIS16201_DIAG_STAT_ALARM2		BIT(9)
+#define ADIS16201_DIAG_STAT_ALARM1		BIT(8)
+#define ADIS16201_DIAG_STAT_SPI_FAIL_BIT	3
+#define ADIS16201_DIAG_STAT_FLASH_UPT_BIT	2
+#define ADIS16201_DIAG_STAT_POWER_HIGH_BIT	1
+#define ADIS16201_DIAG_STAT_POWER_LOW_BIT	0
 
 /* GLOB_CMD */
+#define ADIS16201_GLOB_CMD_REG			0x3E
+#define ADIS16201_GLOB_CMD_SW_RESET		BIT(7)
+#define ADIS16201_GLOB_CMD_FACTORY_CAL		BIT(1)
 
-#define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16201_GLOB_CMD_FACTORY_CAL	BIT(1)
-
-#define ADIS16201_ERROR_ACTIVE          BIT(14)
+#define ADIS16201_ERROR_ACTIVE			BIT(14)
 
 enum adis16201_scan {
 	ADIS16201_SCAN_ACC_X,
@@ -160,10 +88,10 @@ enum adis16201_scan {
 };
 
 static const u8 adis16201_addresses[] = {
-	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS,
-	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS,
-	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS,
-	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS,
+	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS_REG,
+	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS_REG,
+	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS_REG,
+	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS_REG,
 };
 
 static int adis16201_read_raw(struct iio_dev *indio_dev,
@@ -180,36 +108,36 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		return adis_single_conversion(indio_dev, chan,
-				ADIS16201_ERROR_ACTIVE, val);
+						ADIS16201_ERROR_ACTIVE, val);
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			if (chan->channel == 0) {
 				*val = 1;
-				*val2 = 220000; /* 1.22 mV */
+				*val2 = 220000;
 			} else {
 				*val = 0;
-				*val2 = 610000; /* 0.610 mV */
+				*val2 = 610000;
 			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
-			*val = -470; /* 0.47 C */
+			*val = -470;
 			*val2 = 0;
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
 			*val = 0;
-			*val2 = IIO_G_TO_M_S_2(462400); /* 0.4624 mg */
+			*val2 = IIO_G_TO_M_S_2(462400);
 			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_INCLI:
 			*val = 0;
-			*val2 = 100000; /* 0.1 degree */
+			*val2 = 100000;
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
 		}
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
+		*val = 25000 / -470 - 1278;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
@@ -226,11 +154,13 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
+
 		val16 &= (1 << bits) - 1;
 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
 		*val = val16;
 		return IIO_VAL_INT;
 	}
+
 	return -EINVAL;
 }
 
@@ -261,20 +191,21 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 		addr = adis16201_addresses[chan->scan_index];
 		return adis_write_reg_16(st, addr, val16);
 	}
+
 	return -EINVAL;
 }
 
 static const struct iio_chan_spec adis16201_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT, ADIS16201_SCAN_SUPPLY, 0, 12),
-	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT, ADIS16201_SCAN_TEMP, 0, 12),
-	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT, ADIS16201_SCAN_ACC_X,
+	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
+	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
+	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT, ADIS16201_SCAN_ACC_Y,
+	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT_REG, ADIS16201_SCAN_ACC_Y,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC, ADIS16201_SCAN_AUX_ADC, 0, 12),
-	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT, ADIS16201_SCAN_INCLI_X,
+	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
+	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT, ADIS16201_SCAN_INCLI_Y,
+	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
@@ -294,13 +225,13 @@ static const char * const adis16201_status_error_msgs[] = {
 
 static const struct adis_data adis16201_data = {
 	.read_delay = 20,
-	.msc_ctrl_reg = ADIS16201_MSC_CTRL,
-	.glob_cmd_reg = ADIS16201_GLOB_CMD,
-	.diag_stat_reg = ADIS16201_DIAG_STAT,
+	.msc_ctrl_reg = ADIS16201_MSC_CTRL_REG,
+	.glob_cmd_reg = ADIS16201_GLOB_CMD_REG,
+	.diag_stat_reg = ADIS16201_DIAG_STAT_REG,
 
 	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
-	.startup_delay = ADIS16201_STARTUP_DELAY,
+	.startup_delay = ADIS16201_STARTUP_DELAY_MS,
 
 	.status_error_msgs = adis16201_status_error_msgs,
 	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
@@ -311,17 +242,15 @@ static const struct adis_data adis16201_data = {
 
 static int adis16201_probe(struct spi_device *spi)
 {
-	int ret;
-	struct adis *st;
 	struct iio_dev *indio_dev;
+	struct adis *st;
+	int ret;
 
-	/* setup the industrialio driver allocated elements */
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = spi->dev.driver->name;
@@ -335,6 +264,7 @@ static int adis16201_probe(struct spi_device *spi)
 	ret = adis_init(st, indio_dev, spi, &adis16201_data);
 	if (ret)
 		return ret;
+
 	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
 	if (ret)
 		return ret;
@@ -347,10 +277,12 @@ static int adis16201_probe(struct spi_device *spi)
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
 		goto error_cleanup_buffer_trigger;
+
 	return 0;
 
 error_cleanup_buffer_trigger:
 	adis_cleanup_buffer_and_trigger(st, indio_dev);
+
 	return ret;
 }
 
-- 
2.7.4
