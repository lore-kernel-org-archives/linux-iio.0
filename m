Return-Path: <SRS0=G8mi=GG=gmail.com=himanshujha199640@kernel.org>
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com,
	21cnbao@gmail.com,
	Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH v2 4/9] Staging: iio: accel: adis16201: Group register definitions
Date: Sat, 17 Mar 2018 01:36:21 +0530
Message-Id: <1521230786-18155-5-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Group register definitions with its register field bits to improve
readability and easy identification. A small comment is also added to
denote the purpose/functionality of the grouped register definitions.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
v2:
   -reordered patch series.

 drivers/staging/iio/accel/adis16201.c | 138 +++++++++++++---------------------
 1 file changed, 54 insertions(+), 84 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 0c63cd0..8de3f27 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -20,99 +20,69 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
-#define ADIS16201_STARTUP_DELAY_MS	220
-
-#define ADIS16201_FLASH_CNT      0x00
-
-#define ADIS16201_SUPPLY_OUT_REG 0x02
-
-#define ADIS16201_XACCL_OUT_REG  0x04
-
-#define ADIS16201_YACCL_OUT_REG  0x06
-
-#define ADIS16201_AUX_ADC_REG        0x08
-
-#define ADIS16201_TEMP_OUT_REG       0x0A
-
-#define ADIS16201_XINCL_OUT_REG      0x0C
-
-#define ADIS16201_YINCL_OUT_REG      0x0E
-
-#define ADIS16201_XACCL_OFFS_REG     0x10
-
-#define ADIS16201_YACCL_OFFS_REG     0x12
-
-#define ADIS16201_XACCL_SCALE_REG    0x14
-
-#define ADIS16201_YACCL_SCALE_REG    0x16
-
-#define ADIS16201_XINCL_OFFS_REG     0x18
-
-#define ADIS16201_YINCL_OFFS_REG     0x1A
-
-#define ADIS16201_XINCL_SCALE_REG    0x1C
-
-#define ADIS16201_YINCL_SCALE_REG    0x1E
-
-#define ADIS16201_ALM_MAG1_REG       0x20
-
-#define ADIS16201_ALM_MAG2_REG       0x22
-
-#define ADIS16201_ALM_SMPL1_REG      0x24
-
-#define ADIS16201_ALM_SMPL2_REG      0x26
-
-#define ADIS16201_ALM_CTRL_REG       0x28
-
-#define ADIS16201_AUX_DAC_REG        0x30
-
-#define ADIS16201_GPIO_CTRL_REG      0x32
-
-#define ADIS16201_MSC_CTRL_REG       0x34
-
-#define ADIS16201_SMPL_PRD_REG       0x36
-
+#define ADIS16201_STARTUP_DELAY_MS			220
+#define ADIS16201_FLASH_CNT				0x00
+
+/* Data Output Register Information */
+#define ADIS16201_SUPPLY_OUT_REG			0x02
+#define ADIS16201_XACCL_OUT_REG				0x04
+#define ADIS16201_YACCL_OUT_REG				0x06
+#define ADIS16201_AUX_ADC_REG				0x08
+#define ADIS16201_TEMP_OUT_REG				0x0A
+#define ADIS16201_XINCL_OUT_REG				0x0C
+#define ADIS16201_YINCL_OUT_REG				0x0E
+
+/* Calibration Register Definition */
+#define ADIS16201_XACCL_OFFS_REG			0x10
+#define ADIS16201_YACCL_OFFS_REG			0x12
+#define ADIS16201_XACCL_SCALE_REG			0x14
+#define ADIS16201_YACCL_SCALE_REG			0x16
+#define ADIS16201_XINCL_OFFS_REG			0x18
+#define ADIS16201_YINCL_OFFS_REG			0x1A
+#define ADIS16201_XINCL_SCALE_REG			0x1C
+#define ADIS16201_YINCL_SCALE_REG			0x1E
+
+/* Alarm Register Definition */
+#define ADIS16201_ALM_MAG1_REG				0x20
+#define ADIS16201_ALM_MAG2_REG				0x22
+#define ADIS16201_ALM_SMPL1_REG				0x24
+#define ADIS16201_ALM_SMPL2_REG				0x26
+#define ADIS16201_ALM_CTRL_REG				0x28
+
+#define ADIS16201_AUX_DAC_REG				0x30
+#define ADIS16201_GPIO_CTRL_REG				0x32
+#define ADIS16201_SMPL_PRD_REG				0x36
 /* Operation, filter configuration */
-#define ADIS16201_AVG_CNT_REG        0x38
-
-#define ADIS16201_SLP_CNT_REG        0x3A
-
-#define ADIS16201_DIAG_STAT_REG      0x3C
-
-#define ADIS16201_GLOB_CMD_REG       0x3E
-
-
-#define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
+#define ADIS16201_AVG_CNT_REG				0x38
+#define ADIS16201_SLP_CNT_REG				0x3A
 
+/* Miscellaneous Control Register Definition */
+#define ADIS16201_MSC_CTRL_REG				0x34
+#define  ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
 /* Data-ready enable: 1 = enabled, 0 = disabled */
-#define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
-
+#define  ADIS16201_MSC_CTRL_DATA_RDY_EN			BIT(2)
 /* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	        BIT(1)
-
+#define  ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	BIT(1)
 /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
-#define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
-
-
-#define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
-
-#define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
-
-#define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
-
-#define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT  2
-
+#define  ADIS16201_MSC_CTRL_DATA_RDY_DIO1		BIT(0)
+
+/* Diagnostics System Status Register Definition */
+#define ADIS16201_DIAG_STAT_REG				0x3C
+#define  ADIS16201_DIAG_STAT_ALARM2			BIT(9)
+#define  ADIS16201_DIAG_STAT_ALARM1			BIT(8)
+#define  ADIS16201_DIAG_STAT_SPI_FAIL_BIT		3
+#define  ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT		2
 /* Power supply above 3.625 V */
-#define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
-
+#define  ADIS16201_DIAG_STAT_POWER_HIGH_BIT		1
 /* Power supply below 3.15 V */
-#define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
-
+#define  ADIS16201_DIAG_STAT_POWER_LOW_BIT		0
 
-#define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16201_GLOB_CMD_FACTORY_RESET	BIT(1)
+/* System Command Register Definition */
+#define ADIS16201_GLOB_CMD_REG				0x3E
+#define  ADIS16201_GLOB_CMD_SW_RESET			BIT(7)
+#define  ADIS16201_GLOB_CMD_FACTORY_RESET		BIT(1)
 
-#define ADIS16201_ERROR_ACTIVE          BIT(14)
+#define ADIS16201_ERROR_ACTIVE				BIT(14)
 
 enum adis16201_scan {
 	ADIS16201_SCAN_ACC_X,
-- 
2.7.4
