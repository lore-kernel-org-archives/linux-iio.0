Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vs-m.tc.umn.edu ([134.84.119.120]:56734 "EHLO vs-m.tc.umn.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536AbbKGPSQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Nov 2015 10:18:16 -0500
Received: from mail-yk0-f169.google.com (mail-yk0-f169.google.com [209.85.160.169])
	by vs-m.tc.umn.edu (UMN smtpd) with ESMTP
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128/128);
	for <linux-iio@vger.kernel.org>; Sat, 7 Nov 2015 09:02:14 -0600 (CST)
Received: by ykdr3 with SMTP id r3so213000513ykd.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Nov 2015 07:02:04 -0800 (PST)
Date: Sat, 7 Nov 2015 09:06:10 -0600
From: Evan Hosseini <hosse005@umn.edu>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: iio: Fix some character line limit coding style
 issues
Message-ID: <20151107150610.GA3250@archBox.attlocal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Resolved some character line limit warnings emitted by the checkpatch.pl
tool in some ADI accelerometer modules.

Signed-off-by: Evan Hosseini <hosse005@umn.edu>
---
 drivers/staging/iio/accel/adis16201.h      | 157 ++++++++++++++++++++--------
 drivers/staging/iio/accel/adis16203.h      | 135 +++++++++++++++++-------
 drivers/staging/iio/accel/adis16204.h      | 162 +++++++++++++++++++++--------
 drivers/staging/iio/accel/adis16220_core.c |  15 ++-
 4 files changed, 343 insertions(+), 126 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.h b/drivers/staging/iio/accel/adis16201.h
index e6b8c9a..a31d8ad 100644
--- a/drivers/staging/iio/accel/adis16201.h
+++ b/drivers/staging/iio/accel/adis16201.h
@@ -3,53 +3,128 @@
 
 #define ADIS16201_STARTUP_DELAY	220 /* ms */
 
-#define ADIS16201_FLASH_CNT      0x00 /* Flash memory write count */
-#define ADIS16201_SUPPLY_OUT     0x02 /* Output, power supply */
-#define ADIS16201_XACCL_OUT      0x04 /* Output, x-axis accelerometer */
-#define ADIS16201_YACCL_OUT      0x06 /* Output, y-axis accelerometer */
-#define ADIS16201_AUX_ADC        0x08 /* Output, auxiliary ADC input */
-#define ADIS16201_TEMP_OUT       0x0A /* Output, temperature */
-#define ADIS16201_XINCL_OUT      0x0C /* Output, x-axis inclination */
-#define ADIS16201_YINCL_OUT      0x0E /* Output, y-axis inclination */
-#define ADIS16201_XACCL_OFFS     0x10 /* Calibration, x-axis acceleration offset */
-#define ADIS16201_YACCL_OFFS     0x12 /* Calibration, y-axis acceleration offset */
-#define ADIS16201_XACCL_SCALE    0x14 /* x-axis acceleration scale factor */
-#define ADIS16201_YACCL_SCALE    0x16 /* y-axis acceleration scale factor */
-#define ADIS16201_XINCL_OFFS     0x18 /* Calibration, x-axis inclination offset */
-#define ADIS16201_YINCL_OFFS     0x1A /* Calibration, y-axis inclination offset */
-#define ADIS16201_XINCL_SCALE    0x1C /* x-axis inclination scale factor */
-#define ADIS16201_YINCL_SCALE    0x1E /* y-axis inclination scale factor */
-#define ADIS16201_ALM_MAG1       0x20 /* Alarm 1 amplitude threshold */
-#define ADIS16201_ALM_MAG2       0x22 /* Alarm 2 amplitude threshold */
-#define ADIS16201_ALM_SMPL1      0x24 /* Alarm 1, sample period */
-#define ADIS16201_ALM_SMPL2      0x26 /* Alarm 2, sample period */
-#define ADIS16201_ALM_CTRL       0x28 /* Alarm control */
-#define ADIS16201_AUX_DAC        0x30 /* Auxiliary DAC data */
-#define ADIS16201_GPIO_CTRL      0x32 /* General-purpose digital input/output control */
-#define ADIS16201_MSC_CTRL       0x34 /* Miscellaneous control */
-#define ADIS16201_SMPL_PRD       0x36 /* Internal sample period (rate) control */
-#define ADIS16201_AVG_CNT        0x38 /* Operation, filter configuration */
-#define ADIS16201_SLP_CNT        0x3A /* Operation, sleep mode control */
-#define ADIS16201_DIAG_STAT      0x3C /* Diagnostics, system status register */
-#define ADIS16201_GLOB_CMD       0x3E /* Operation, system command register */
+/* Flash memory write count */
+#define ADIS16201_FLASH_CNT      0x00
+
+/* Output, power supply */
+#define ADIS16201_SUPPLY_OUT     0x02
+
+/* Output, x-axis accelerometer */
+#define ADIS16201_XACCL_OUT      0x04
+
+/* Output, y-axis accelerometer */
+#define ADIS16201_YACCL_OUT      0x06
+
+/* Output, auxiliary ADC input */
+#define ADIS16201_AUX_ADC        0x08
+
+/* Output, temperature */
+#define ADIS16201_TEMP_OUT       0x0A
+
+/* Output, x-axis inclination */
+#define ADIS16201_XINCL_OUT      0x0C
+
+/* Output, y-axis inclination */
+#define ADIS16201_YINCL_OUT      0x0E
+
+/* Calibration, x-axis acceleration offset */
+#define ADIS16201_XACCL_OFFS     0x10
+
+/* Calibration, y-axis acceleration offset */
+#define ADIS16201_YACCL_OFFS     0x12
+
+/* x-axis acceleration scale factor */
+#define ADIS16201_XACCL_SCALE    0x14
+
+/* y-axis acceleration scale factor */
+#define ADIS16201_YACCL_SCALE    0x16
+
+/* Calibration, x-axis inclination offset */
+#define ADIS16201_XINCL_OFFS     0x18
+
+/* Calibration, y-axis inclination offset */
+#define ADIS16201_YINCL_OFFS     0x1A
+
+/* x-axis inclination scale factor */
+#define ADIS16201_XINCL_SCALE    0x1C
+
+/* y-axis inclination scale factor */
+#define ADIS16201_YINCL_SCALE    0x1E
+
+/* Alarm 1 amplitude threshold */
+#define ADIS16201_ALM_MAG1       0x20
+
+/* Alarm 2 amplitude threshold */
+#define ADIS16201_ALM_MAG2       0x22
+
+/* Alarm 1, sample period */
+#define ADIS16201_ALM_SMPL1      0x24
+
+/* Alarm 2, sample period */
+#define ADIS16201_ALM_SMPL2      0x26
+
+/* Alarm control */
+#define ADIS16201_ALM_CTRL       0x28
+
+/* Auxiliary DAC data */
+#define ADIS16201_AUX_DAC        0x30
+
+/* General-purpose digital input/output control */
+#define ADIS16201_GPIO_CTRL      0x32
+
+/* Miscellaneous control */
+#define ADIS16201_MSC_CTRL       0x34
+
+/* Internal sample period (rate) control */
+#define ADIS16201_SMPL_PRD       0x36
+
+/* Operation, filter configuration */
+#define ADIS16201_AVG_CNT        0x38
+
+/* Operation, sleep mode control */
+#define ADIS16201_SLP_CNT        0x3A
+
+/* Diagnostics, system status register */
+#define ADIS16201_DIAG_STAT      0x3C
+
+/* Operation, system command register */
+#define ADIS16201_GLOB_CMD       0x3E
 
 /* MSC_CTRL */
-#define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)  /* Self-test enable */
-#define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)  /* Data-ready enable: 1 = enabled, 0 = disabled */
-#define ADIS16201_MSC_CTRL_ACTIVE_HIGH	        BIT(1)  /* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)  /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
+/* Self-test enable */
+#define ADIS16201_MSC_CTRL_SELF_TEST_EN         BIT(8)
+
+/* Data-ready enable: 1 = enabled, 0 = disabled */
+#define ADIS16201_MSC_CTRL_DATA_RDY_EN          BIT(2)
+
+/* Data-ready polarity: 1 = active high, 0 = active low */
+#define ADIS16201_MSC_CTRL_ACTIVE_HIGH          BIT(1)
+
+/* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
+#define ADIS16201_MSC_CTRL_DATA_RDY_DIO1        BIT(0)
 
 /* DIAG_STAT */
-#define ADIS16201_DIAG_STAT_ALARM2        BIT(9) /* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16201_DIAG_STAT_ALARM1        BIT(8) /* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3 /* SPI communications failure */
-#define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2 /* Flash update failure */
-#define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1 /* Power supply above 3.625 V */
-#define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0 /* Power supply below 3.15 V */
+/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
+#define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
+
+/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
+#define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
+
+/* SPI communications failure */
+#define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
+
+/* Flash update failure */
+#define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
+
+/* Power supply above 3.625 V */
+#define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
+
+/* Power supply below 3.15 V */
+#define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
 
 /* GLOB_CMD */
-#define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16201_GLOB_CMD_FACTORY_CAL	BIT(1)
+#define ADIS16201_GLOB_CMD_SW_RESET     BIT(7)
+#define ADIS16201_GLOB_CMD_FACTORY_CAL  BIT(1)
 
 #define ADIS16201_ERROR_ACTIVE          BIT(14)
 
diff --git a/drivers/staging/iio/accel/adis16203.h b/drivers/staging/iio/accel/adis16203.h
index 6426e38..fa65842 100644
--- a/drivers/staging/iio/accel/adis16203.h
+++ b/drivers/staging/iio/accel/adis16203.h
@@ -3,48 +3,111 @@
 
 #define ADIS16203_STARTUP_DELAY	220 /* ms */
 
-#define ADIS16203_FLASH_CNT      0x00 /* Flash memory write count */
-#define ADIS16203_SUPPLY_OUT     0x02 /* Output, power supply */
-#define ADIS16203_AUX_ADC        0x08 /* Output, auxiliary ADC input */
-#define ADIS16203_TEMP_OUT       0x0A /* Output, temperature */
-#define ADIS16203_XINCL_OUT      0x0C /* Output, x-axis inclination */
-#define ADIS16203_YINCL_OUT      0x0E /* Output, y-axis inclination */
-#define ADIS16203_INCL_NULL      0x18 /* Incline null calibration */
-#define ADIS16203_ALM_MAG1       0x20 /* Alarm 1 amplitude threshold */
-#define ADIS16203_ALM_MAG2       0x22 /* Alarm 2 amplitude threshold */
-#define ADIS16203_ALM_SMPL1      0x24 /* Alarm 1, sample period */
-#define ADIS16203_ALM_SMPL2      0x26 /* Alarm 2, sample period */
-#define ADIS16203_ALM_CTRL       0x28 /* Alarm control */
-#define ADIS16203_AUX_DAC        0x30 /* Auxiliary DAC data */
-#define ADIS16203_GPIO_CTRL      0x32 /* General-purpose digital input/output control */
-#define ADIS16203_MSC_CTRL       0x34 /* Miscellaneous control */
-#define ADIS16203_SMPL_PRD       0x36 /* Internal sample period (rate) control */
-#define ADIS16203_AVG_CNT        0x38 /* Operation, filter configuration */
-#define ADIS16203_SLP_CNT        0x3A /* Operation, sleep mode control */
-#define ADIS16203_DIAG_STAT      0x3C /* Diagnostics, system status register */
-#define ADIS16203_GLOB_CMD       0x3E /* Operation, system command register */
+/* Flash memory write count */
+#define ADIS16203_FLASH_CNT      0x00
+
+/* Output, power supply */
+#define ADIS16203_SUPPLY_OUT     0x02
+
+/* Output, auxiliary ADC input */
+#define ADIS16203_AUX_ADC        0x08
+
+/* Output, temperature */
+#define ADIS16203_TEMP_OUT       0x0A
+
+/* Output, x-axis inclination */
+#define ADIS16203_XINCL_OUT      0x0C
+
+/* Output, y-axis inclination */
+#define ADIS16203_YINCL_OUT      0x0E
+
+/* Incline null calibration */
+#define ADIS16203_INCL_NULL      0x18
+
+/* Alarm 1 amplitude threshold */
+#define ADIS16203_ALM_MAG1       0x20
+
+/* Alarm 2 amplitude threshold */
+#define ADIS16203_ALM_MAG2       0x22
+
+/* Alarm 1, sample period */
+#define ADIS16203_ALM_SMPL1      0x24
+
+/* Alarm 2, sample period */
+#define ADIS16203_ALM_SMPL2      0x26
+
+/* Alarm control */
+#define ADIS16203_ALM_CTRL       0x28
+
+/* Auxiliary DAC data */
+#define ADIS16203_AUX_DAC        0x30
+
+/* General-purpose digital input/output control */
+#define ADIS16203_GPIO_CTRL      0x32
+
+/* Miscellaneous control */
+#define ADIS16203_MSC_CTRL       0x34
+
+/* Internal sample period (rate) control */
+#define ADIS16203_SMPL_PRD       0x36
+
+/* Operation, filter configuration */
+#define ADIS16203_AVG_CNT        0x38
+
+/* Operation, sleep mode control */
+#define ADIS16203_SLP_CNT        0x3A
+
+/* Diagnostics, system status register */
+#define ADIS16203_DIAG_STAT      0x3C
+
+/* Operation, system command register */
+#define ADIS16203_GLOB_CMD       0x3E
 
 /* MSC_CTRL */
-#define ADIS16203_MSC_CTRL_PWRUP_SELF_TEST	BIT(10) /* Self-test at power-on: 1 = disabled, 0 = enabled */
-#define ADIS16203_MSC_CTRL_REVERSE_ROT_EN	BIT(9)  /* Reverses rotation of both inclination outputs */
-#define ADIS16203_MSC_CTRL_SELF_TEST_EN	        BIT(8)  /* Self-test enable */
-#define ADIS16203_MSC_CTRL_DATA_RDY_EN	        BIT(2)  /* Data-ready enable: 1 = enabled, 0 = disabled */
-#define ADIS16203_MSC_CTRL_ACTIVE_HIGH	        BIT(1)  /* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16203_MSC_CTRL_DATA_RDY_DIO1	BIT(0)  /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
+/* Self-test at power-on: 1 = disabled, 0 = enabled */
+#define ADIS16203_MSC_CTRL_PWRUP_SELF_TEST      BIT(10)
+
+/* Reverses rotation of both inclination outputs */
+#define ADIS16203_MSC_CTRL_REVERSE_ROT_EN       BIT(9)
+
+/* Self-test enable */
+#define ADIS16203_MSC_CTRL_SELF_TEST_EN         BIT(8)
+
+/* Data-ready enable: 1 = enabled, 0 = disabled */
+#define ADIS16203_MSC_CTRL_DATA_RDY_EN          BIT(2)
+
+/* Data-ready polarity: 1 = active high, 0 = active low */
+#define ADIS16203_MSC_CTRL_ACTIVE_HIGH          BIT(1)
+
+/* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
+#define ADIS16203_MSC_CTRL_DATA_RDY_DIO1        BIT(0)
 
 /* DIAG_STAT */
-#define ADIS16203_DIAG_STAT_ALARM2        BIT(9) /* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16203_DIAG_STAT_ALARM1        BIT(8) /* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT 5 /* Self-test diagnostic error flag */
-#define ADIS16203_DIAG_STAT_SPI_FAIL_BIT      3 /* SPI communications failure */
-#define ADIS16203_DIAG_STAT_FLASH_UPT_BIT     2 /* Flash update failure */
-#define ADIS16203_DIAG_STAT_POWER_HIGH_BIT    1 /* Power supply above 3.625 V */
-#define ADIS16203_DIAG_STAT_POWER_LOW_BIT     0 /* Power supply below 3.15 V */
+/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
+#define ADIS16203_DIAG_STAT_ALARM2        BIT(9)
+
+/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
+#define ADIS16203_DIAG_STAT_ALARM1        BIT(8)
+
+/* Self-test diagnostic error flag */
+#define ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT 5
+
+/* SPI communications failure */
+#define ADIS16203_DIAG_STAT_SPI_FAIL_BIT      3
+
+/* Flash update failure */
+#define ADIS16203_DIAG_STAT_FLASH_UPT_BIT     2
+
+/* Power supply above 3.625 V */
+#define ADIS16203_DIAG_STAT_POWER_HIGH_BIT    1
+
+/* Power supply below 3.15 V */
+#define ADIS16203_DIAG_STAT_POWER_LOW_BIT     0
 
 /* GLOB_CMD */
-#define ADIS16203_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16203_GLOB_CMD_CLEAR_STAT	BIT(4)
-#define ADIS16203_GLOB_CMD_FACTORY_CAL	BIT(1)
+#define ADIS16203_GLOB_CMD_SW_RESET     BIT(7)
+#define ADIS16203_GLOB_CMD_CLEAR_STAT   BIT(4)
+#define ADIS16203_GLOB_CMD_FACTORY_CAL  BIT(1)
 
 #define ADIS16203_ERROR_ACTIVE          BIT(14)
 
diff --git a/drivers/staging/iio/accel/adis16204.h b/drivers/staging/iio/accel/adis16204.h
index 0b23f0b..863eea2 100644
--- a/drivers/staging/iio/accel/adis16204.h
+++ b/drivers/staging/iio/accel/adis16204.h
@@ -3,56 +3,130 @@
 
 #define ADIS16204_STARTUP_DELAY	220 /* ms */
 
-#define ADIS16204_FLASH_CNT      0x00 /* Flash memory write count */
-#define ADIS16204_SUPPLY_OUT     0x02 /* Output, power supply */
-#define ADIS16204_XACCL_OUT      0x04 /* Output, x-axis accelerometer */
-#define ADIS16204_YACCL_OUT      0x06 /* Output, y-axis accelerometer */
-#define ADIS16204_AUX_ADC        0x08 /* Output, auxiliary ADC input */
-#define ADIS16204_TEMP_OUT       0x0A /* Output, temperature */
-#define ADIS16204_X_PEAK_OUT     0x0C /* Twos complement */
-#define ADIS16204_Y_PEAK_OUT     0x0E /* Twos complement */
-#define ADIS16204_XACCL_NULL     0x10 /* Calibration, x-axis acceleration offset null */
-#define ADIS16204_YACCL_NULL     0x12 /* Calibration, y-axis acceleration offset null */
-#define ADIS16204_XACCL_SCALE    0x14 /* X-axis scale factor calibration register */
-#define ADIS16204_YACCL_SCALE    0x16 /* Y-axis scale factor calibration register */
-#define ADIS16204_XY_RSS_OUT     0x18 /* XY combined acceleration (RSS) */
-#define ADIS16204_XY_PEAK_OUT    0x1A /* Peak, XY combined output (RSS) */
-#define ADIS16204_CAP_BUF_1      0x1C /* Capture buffer output register 1 */
-#define ADIS16204_CAP_BUF_2      0x1E /* Capture buffer output register 2 */
-#define ADIS16204_ALM_MAG1       0x20 /* Alarm 1 amplitude threshold */
-#define ADIS16204_ALM_MAG2       0x22 /* Alarm 2 amplitude threshold */
-#define ADIS16204_ALM_CTRL       0x28 /* Alarm control */
-#define ADIS16204_CAPT_PNTR      0x2A /* Capture register address pointer */
-#define ADIS16204_AUX_DAC        0x30 /* Auxiliary DAC data */
-#define ADIS16204_GPIO_CTRL      0x32 /* General-purpose digital input/output control */
-#define ADIS16204_MSC_CTRL       0x34 /* Miscellaneous control */
-#define ADIS16204_SMPL_PRD       0x36 /* Internal sample period (rate) control */
-#define ADIS16204_AVG_CNT        0x38 /* Operation, filter configuration */
-#define ADIS16204_SLP_CNT        0x3A /* Operation, sleep mode control */
-#define ADIS16204_DIAG_STAT      0x3C /* Diagnostics, system status register */
-#define ADIS16204_GLOB_CMD       0x3E /* Operation, system command register */
+/* Flash memory write count */
+#define ADIS16204_FLASH_CNT      0x00
+
+/* Output, power supply */
+#define ADIS16204_SUPPLY_OUT     0x02
+
+/* Output, x-axis accelerometer */
+#define ADIS16204_XACCL_OUT      0x04
+
+/* Output, y-axis accelerometer */
+#define ADIS16204_YACCL_OUT      0x06
+
+/* Output, auxiliary ADC input */
+#define ADIS16204_AUX_ADC        0x08
+
+/* Output, temperature */
+#define ADIS16204_TEMP_OUT       0x0A
+
+/* Twos complement */
+#define ADIS16204_X_PEAK_OUT     0x0C
+#define ADIS16204_Y_PEAK_OUT     0x0E
+
+/* Calibration, x-axis acceleration offset null */
+#define ADIS16204_XACCL_NULL     0x10
+
+/* Calibration, y-axis acceleration offset null */
+#define ADIS16204_YACCL_NULL     0x12
+
+/* X-axis scale factor calibration register */
+#define ADIS16204_XACCL_SCALE    0x14
+
+/* Y-axis scale factor calibration register */
+#define ADIS16204_YACCL_SCALE    0x16
+
+/* XY combined acceleration (RSS) */
+#define ADIS16204_XY_RSS_OUT     0x18
+
+/* Peak, XY combined output (RSS) */
+#define ADIS16204_XY_PEAK_OUT    0x1A
+
+/* Capture buffer output register 1 */
+#define ADIS16204_CAP_BUF_1      0x1C
+
+/* Capture buffer output register 2 */
+#define ADIS16204_CAP_BUF_2      0x1E
+
+/* Alarm 1 amplitude threshold */
+#define ADIS16204_ALM_MAG1       0x20
+
+/* Alarm 2 amplitude threshold */
+#define ADIS16204_ALM_MAG2       0x22
+
+/* Alarm control */
+#define ADIS16204_ALM_CTRL       0x28
+
+/* Capture register address pointer */
+#define ADIS16204_CAPT_PNTR      0x2A
+
+/* Auxiliary DAC data */
+#define ADIS16204_AUX_DAC        0x30
+
+/* General-purpose digital input/output control */
+#define ADIS16204_GPIO_CTRL      0x32
+
+/* Miscellaneous control */
+#define ADIS16204_MSC_CTRL       0x34
+
+/* Internal sample period (rate) control */
+#define ADIS16204_SMPL_PRD       0x36
+
+/* Operation, filter configuration */
+#define ADIS16204_AVG_CNT        0x38
+
+/* Operation, sleep mode control */
+#define ADIS16204_SLP_CNT        0x3A
+
+/* Diagnostics, system status register */
+#define ADIS16204_DIAG_STAT      0x3C
+
+/* Operation, system command register */
+#define ADIS16204_GLOB_CMD       0x3E
 
 /* MSC_CTRL */
-#define ADIS16204_MSC_CTRL_PWRUP_SELF_TEST	BIT(10) /* Self-test at power-on: 1 = disabled, 0 = enabled */
-#define ADIS16204_MSC_CTRL_SELF_TEST_EN	        BIT(8)  /* Self-test enable */
-#define ADIS16204_MSC_CTRL_DATA_RDY_EN	        BIT(2)  /* Data-ready enable: 1 = enabled, 0 = disabled */
-#define ADIS16204_MSC_CTRL_ACTIVE_HIGH	        BIT(1)  /* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16204_MSC_CTRL_DATA_RDY_DIO2	BIT(0)  /* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
+/* Self-test at power-on: 1 = disabled, 0 = enabled */
+#define ADIS16204_MSC_CTRL_PWRUP_SELF_TEST      BIT(10)
+
+/* Self-test enable */
+#define ADIS16204_MSC_CTRL_SELF_TEST_EN         BIT(8)
+
+/* Data-ready enable: 1 = enabled, 0 = disabled */
+#define ADIS16204_MSC_CTRL_DATA_RDY_EN          BIT(2)
+
+/* Data-ready polarity: 1 = active high, 0 = active low */
+#define ADIS16204_MSC_CTRL_ACTIVE_HIGH          BIT(1)
+
+/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
+#define ADIS16204_MSC_CTRL_DATA_RDY_DIO2        BIT(0)
 
 /* DIAG_STAT */
-#define ADIS16204_DIAG_STAT_ALARM2        BIT(9) /* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16204_DIAG_STAT_ALARM1        BIT(8) /* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16204_DIAG_STAT_SELFTEST_FAIL_BIT 5 /* Self-test diagnostic error flag: 1 = error condition,
-						0 = normal operation */
-#define ADIS16204_DIAG_STAT_SPI_FAIL_BIT      3 /* SPI communications failure */
-#define ADIS16204_DIAG_STAT_FLASH_UPT_BIT     2 /* Flash update failure */
-#define ADIS16204_DIAG_STAT_POWER_HIGH_BIT    1 /* Power supply above 3.625 V */
-#define ADIS16204_DIAG_STAT_POWER_LOW_BIT     0 /* Power supply below 2.975 V */
+/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
+#define ADIS16204_DIAG_STAT_ALARM2        BIT(9)
+
+/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
+#define ADIS16204_DIAG_STAT_ALARM1        BIT(8)
+
+/* Self-test diagnostic error flag: 1 = error condition, 0 = normal operation */
+#define ADIS16204_DIAG_STAT_SELFTEST_FAIL_BIT 5
+
+/* SPI communications failure */
+#define ADIS16204_DIAG_STAT_SPI_FAIL_BIT      3
+
+/* Flash update failure */
+#define ADIS16204_DIAG_STAT_FLASH_UPT_BIT     2
+
+/* Power supply above 3.625 V */
+#define ADIS16204_DIAG_STAT_POWER_HIGH_BIT    1
+
+/* Power supply below 2.975 V */
+#define ADIS16204_DIAG_STAT_POWER_LOW_BIT     0
 
 /* GLOB_CMD */
-#define ADIS16204_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16204_GLOB_CMD_CLEAR_STAT	BIT(4)
-#define ADIS16204_GLOB_CMD_FACTORY_CAL	BIT(1)
+#define ADIS16204_GLOB_CMD_SW_RESET     BIT(7)
+#define ADIS16204_GLOB_CMD_CLEAR_STAT   BIT(4)
+#define ADIS16204_GLOB_CMD_FACTORY_CAL  BIT(1)
 
 #define ADIS16204_ERROR_ACTIVE          BIT(14)
 
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index e46a91c..752eae9 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -387,11 +387,16 @@ static const struct iio_info adis16220_info = {
 };
 
 static const char * const adis16220_status_error_msgs[] = {
-	[ADIS16220_DIAG_STAT_VIOLATION_BIT] = "Capture period violation/interruption",
-	[ADIS16220_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
-	[ADIS16220_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
-	[ADIS16220_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
-	[ADIS16220_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
+	[ADIS16220_DIAG_STAT_VIOLATION_BIT] =
+	"Capture period violation/interruption",
+	[ADIS16220_DIAG_STAT_SPI_FAIL_BIT] =
+	"SPI failure",
+	[ADIS16220_DIAG_STAT_FLASH_UPT_BIT] =
+	"Flash update failed",
+	[ADIS16220_DIAG_STAT_POWER_HIGH_BIT] =
+	"Power supply above 3.625V",
+	[ADIS16220_DIAG_STAT_POWER_LOW_BIT] =
+	"Power supply below 3.15V",
 };
 
 static const struct adis_data adis16220_data = {
-- 
2.6.2

