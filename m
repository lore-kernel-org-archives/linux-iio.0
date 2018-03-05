Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36927 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeCEHuE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Mar 2018 02:50:04 -0500
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 03/11] Staging: iio: accel: Remove unnecessary comments
Date: Mon,  5 Mar 2018 13:19:22 +0530
Message-Id: <1520236170-14668-4-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove unnecessary comments since the definitions are pretty clear
with their macro names.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 82 +++++------------------------------
 1 file changed, 10 insertions(+), 72 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 0fae8aa..59c1166 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -20,87 +20,42 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
-#define ADIS16201_STARTUP_DELAY	220 /* ms */
+#define ADIS16201_STARTUP_DELAY		220
 
-/* Flash memory write count */
 #define ADIS16201_FLASH_CNT      0x00
 
-/* Output, power supply */
+/* Data Output Register Information */
 #define ADIS16201_SUPPLY_OUT     0x02
-
-/* Output, x-axis accelerometer */
 #define ADIS16201_XACCL_OUT      0x04
-
-/* Output, y-axis accelerometer */
 #define ADIS16201_YACCL_OUT      0x06
-
-/* Output, auxiliary ADC input */
 #define ADIS16201_AUX_ADC        0x08
-
-/* Output, temperature */
 #define ADIS16201_TEMP_OUT       0x0A
-
-/* Output, x-axis inclination */
 #define ADIS16201_XINCL_OUT      0x0C
-
-/* Output, y-axis inclination */
 #define ADIS16201_YINCL_OUT      0x0E
 
-/* Calibration, x-axis acceleration offset */
+/* Calibration Register Definition */
 #define ADIS16201_XACCL_OFFS     0x10
-
-/* Calibration, y-axis acceleration offset */
 #define ADIS16201_YACCL_OFFS     0x12
-
-/* x-axis acceleration scale factor */
 #define ADIS16201_XACCL_SCALE    0x14
-
-/* y-axis acceleration scale factor */
 #define ADIS16201_YACCL_SCALE    0x16
-
-/* Calibration, x-axis inclination offset */
 #define ADIS16201_XINCL_OFFS     0x18
-
-/* Calibration, y-axis inclination offset */
 #define ADIS16201_YINCL_OFFS     0x1A
-
-/* x-axis inclination scale factor */
 #define ADIS16201_XINCL_SCALE    0x1C
-
-/* y-axis inclination scale factor */
 #define ADIS16201_YINCL_SCALE    0x1E
 
-/* Alarm 1 amplitude threshold */
+/* Alarm Register Definition */
 #define ADIS16201_ALM_MAG1       0x20
-
-/* Alarm 2 amplitude threshold */
 #define ADIS16201_ALM_MAG2       0x22
-
-/* Alarm 1, sample period */
 #define ADIS16201_ALM_SMPL1      0x24
-
-/* Alarm 2, sample period */
 #define ADIS16201_ALM_SMPL2      0x26
-
-/* Alarm control */
 #define ADIS16201_ALM_CTRL       0x28
 
-/* Auxiliary DAC data */
 #define ADIS16201_AUX_DAC        0x30
-
-/* General-purpose digital input/output control */
 #define ADIS16201_GPIO_CTRL      0x32
-
-/* Miscellaneous control */
 #define ADIS16201_MSC_CTRL       0x34
 
-/* Internal sample period (rate) control */
 #define ADIS16201_SMPL_PRD       0x36
-
-/* Operation, filter configuration */
 #define ADIS16201_AVG_CNT        0x38
-
-/* Operation, sleep mode control */
 #define ADIS16201_SLP_CNT        0x3A
 
 /* Diagnostics, system status register */
@@ -109,42 +64,28 @@
 /* Operation, system command register */
 #define ADIS16201_GLOB_CMD       0x3E
 
-/* MSC_CTRL */
 
-/* Self-test enable */
 #define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
 
-/* Data-ready enable: 1 = enabled, 0 = disabled */
 #define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
 
-/* Data-ready polarity: 1 = active high, 0 = active low */
 #define ADIS16201_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
 
-/* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
 #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
 
-/* DIAG_STAT */
 
-/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
 #define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
 
-/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
 #define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
 
-/* SPI communications failure */
 #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
 
-/* Flash update failure */
 #define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
 
-/* Power supply above 3.625 V */
 #define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
 
-/* Power supply below 3.15 V */
 #define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
 
-/* GLOB_CMD */
-
 #define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
 #define ADIS16201_GLOB_CMD_FACTORY_CAL	BIT(1)
 
@@ -187,30 +128,30 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
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
@@ -318,13 +259,11 @@ static int adis16201_probe(struct spi_device *spi)
 	struct adis *st;
 	struct iio_dev *indio_dev;
 
-	/* setup the industrialio driver allocated elements */
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = spi->dev.driver->name;
@@ -343,7 +282,6 @@ static int adis16201_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	/* Get the device into a sane initial state */
 	ret = adis_initial_startup(st);
 	if (ret)
 		goto error_cleanup_buffer_trigger;
-- 
2.7.4

