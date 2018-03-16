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
Subject: [PATCH v2 3/9] Staging: iio: accel: adis16201: Add _REG suffix to reisters
Date: Sat, 17 Mar 2018 01:36:20 +0530
Message-Id: <1521230786-18155-4-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add a _REG suffix to distinguish between registers and the register bit
fileds.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
v2:
   -reordered patch series.

 drivers/staging/iio/accel/adis16201.c | 84 +++++++++++++++++------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 6c06c0d..0c63cd0 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -24,62 +24,62 @@
 
 #define ADIS16201_FLASH_CNT      0x00
 
-#define ADIS16201_SUPPLY_OUT     0x02
+#define ADIS16201_SUPPLY_OUT_REG 0x02
 
-#define ADIS16201_XACCL_OUT      0x04
+#define ADIS16201_XACCL_OUT_REG  0x04
 
-#define ADIS16201_YACCL_OUT      0x06
+#define ADIS16201_YACCL_OUT_REG  0x06
 
-#define ADIS16201_AUX_ADC        0x08
+#define ADIS16201_AUX_ADC_REG        0x08
 
-#define ADIS16201_TEMP_OUT       0x0A
+#define ADIS16201_TEMP_OUT_REG       0x0A
 
-#define ADIS16201_XINCL_OUT      0x0C
+#define ADIS16201_XINCL_OUT_REG      0x0C
 
-#define ADIS16201_YINCL_OUT      0x0E
+#define ADIS16201_YINCL_OUT_REG      0x0E
 
-#define ADIS16201_XACCL_OFFS     0x10
+#define ADIS16201_XACCL_OFFS_REG     0x10
 
-#define ADIS16201_YACCL_OFFS     0x12
+#define ADIS16201_YACCL_OFFS_REG     0x12
 
-#define ADIS16201_XACCL_SCALE    0x14
+#define ADIS16201_XACCL_SCALE_REG    0x14
 
-#define ADIS16201_YACCL_SCALE    0x16
+#define ADIS16201_YACCL_SCALE_REG    0x16
 
-#define ADIS16201_XINCL_OFFS     0x18
+#define ADIS16201_XINCL_OFFS_REG     0x18
 
-#define ADIS16201_YINCL_OFFS     0x1A
+#define ADIS16201_YINCL_OFFS_REG     0x1A
 
-#define ADIS16201_XINCL_SCALE    0x1C
+#define ADIS16201_XINCL_SCALE_REG    0x1C
 
-#define ADIS16201_YINCL_SCALE    0x1E
+#define ADIS16201_YINCL_SCALE_REG    0x1E
 
-#define ADIS16201_ALM_MAG1       0x20
+#define ADIS16201_ALM_MAG1_REG       0x20
 
-#define ADIS16201_ALM_MAG2       0x22
+#define ADIS16201_ALM_MAG2_REG       0x22
 
-#define ADIS16201_ALM_SMPL1      0x24
+#define ADIS16201_ALM_SMPL1_REG      0x24
 
-#define ADIS16201_ALM_SMPL2      0x26
+#define ADIS16201_ALM_SMPL2_REG      0x26
 
-#define ADIS16201_ALM_CTRL       0x28
+#define ADIS16201_ALM_CTRL_REG       0x28
 
-#define ADIS16201_AUX_DAC        0x30
+#define ADIS16201_AUX_DAC_REG        0x30
 
-#define ADIS16201_GPIO_CTRL      0x32
+#define ADIS16201_GPIO_CTRL_REG      0x32
 
-#define ADIS16201_MSC_CTRL       0x34
+#define ADIS16201_MSC_CTRL_REG       0x34
 
-#define ADIS16201_SMPL_PRD       0x36
+#define ADIS16201_SMPL_PRD_REG       0x36
 
 /* Operation, filter configuration */
-#define ADIS16201_AVG_CNT        0x38
+#define ADIS16201_AVG_CNT_REG        0x38
 
-#define ADIS16201_SLP_CNT        0x3A
+#define ADIS16201_SLP_CNT_REG        0x3A
 
-#define ADIS16201_DIAG_STAT      0x3C
+#define ADIS16201_DIAG_STAT_REG      0x3C
 
-#define ADIS16201_GLOB_CMD       0x3E
+#define ADIS16201_GLOB_CMD_REG       0x3E
 
 
 #define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
@@ -125,10 +125,10 @@ enum adis16201_scan {
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
@@ -232,16 +232,16 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
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
@@ -261,9 +261,9 @@ static const char * const adis16201_status_error_msgs[] = {
 
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
-- 
2.7.4
