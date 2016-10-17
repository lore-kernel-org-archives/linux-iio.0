Return-Path: <eraretuya@gmail.com>
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org,
	outreachy-kernel@googlegroups.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH] staging: iio: cdc: ad7746: add additional config defines
Date: Mon, 17 Oct 2016 11:21:49 +0800
Message-Id: <1476674510-10734-1-git-send-email-eraretuya@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Introduce defines for shifting and mask under the config register for
better readability.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index f41251c..751f0d1 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -70,8 +70,12 @@
 #define AD7746_EXCSETUP_EXCLVL(x)	(((x) & 0x3) << 0)
 
 /* Config Register Bit Designations (AD7746_REG_CFG) */
-#define AD7746_CONF_VTFS(x)		((x) << 6)
-#define AD7746_CONF_CAPFS(x)		((x) << 3)
+#define AD7746_CONF_VTFS_SHIFT		6
+#define AD7746_CONF_CAPFS_SHIFT		3
+#define AD7746_CONF_VTFS_MASK		0x3
+#define AD7746_CONF_CAPFS_MASK		0x7
+#define AD7746_CONF_VTFS(x)		((x) << AD7746_CONF_VTFS_SHIFT)
+#define AD7746_CONF_CAPFS(x)		((x) << AD7746_CONF_CAPFS_SHIFT)
 #define AD7746_CONF_MODE_IDLE		(0 << 0)
 #define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
 #define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
@@ -224,8 +228,8 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
 	case IIO_CAPACITANCE:
 		cap_setup = (chan->address & 0xFF) | AD7746_CAPSETUP_CAPEN;
 		vt_setup = chip->vt_setup & ~AD7746_VTSETUP_VTEN;
-		delay = ad7746_cap_filter_rate_table[(chip->config >> 3) &
-			0x7][1];
+		delay = ad7746_cap_filter_rate_table[(chip->config &
+			AD7746_CONF_CAPFS_MASK) >> AD7746_CONF_CAPFS_SHIFT][1];
 
 		if (chip->capdac_set != chan->channel) {
 			ret = i2c_smbus_write_byte_data(chip->client,
@@ -246,8 +250,8 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
 	case IIO_TEMP:
 		vt_setup = (chan->address & 0xFF) | AD7746_VTSETUP_VTEN;
 		cap_setup = chip->cap_setup & ~AD7746_CAPSETUP_CAPEN;
-		delay = ad7746_cap_filter_rate_table[(chip->config >> 6) &
-			0x3][1];
+		delay = ad7746_cap_filter_rate_table[(chip->config &
+			AD7746_CONF_VTFS_MASK) >> AD7746_CONF_VTFS_SHIFT][1];
 		break;
 	default:
 		return -EINVAL;
@@ -369,7 +373,7 @@ static int ad7746_store_cap_filter_rate_setup(struct ad7746_chip_info *chip,
 	if (i >= ARRAY_SIZE(ad7746_cap_filter_rate_table))
 		i = ARRAY_SIZE(ad7746_cap_filter_rate_table) - 1;
 
-	chip->config &= ~AD7746_CONF_CAPFS(0x7);
+	chip->config &= ~AD7746_CONF_CAPFS(AD7746_CONF_CAPFS_MASK);
 	chip->config |= AD7746_CONF_CAPFS(i);
 
 	return 0;
@@ -387,7 +391,7 @@ static int ad7746_store_vt_filter_rate_setup(struct ad7746_chip_info *chip,
 	if (i >= ARRAY_SIZE(ad7746_vt_filter_rate_table))
 		i = ARRAY_SIZE(ad7746_vt_filter_rate_table) - 1;
 
-	chip->config &= ~AD7746_CONF_VTFS(0x3);
+	chip->config &= ~AD7746_CONF_VTFS(AD7746_CONF_VTFS_MASK);
 	chip->config |= AD7746_CONF_VTFS(i);
 
 	return 0;
@@ -636,12 +640,14 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_CAPACITANCE:
 			*val = ad7746_cap_filter_rate_table[
-					(chip->config >> 3) & 0x7][0];
+				(chip->config & AD7746_CONF_CAPFS_MASK) >>
+					AD7746_CONF_CAPFS_SHIFT][0];
 			ret = IIO_VAL_INT;
 			break;
 		case IIO_VOLTAGE:
 			*val = ad7746_vt_filter_rate_table[
-					(chip->config >> 6) & 0x3][0];
+				(chip->config & AD7746_CONF_VTFS_MASK) >>
+					AD7746_CONF_VTFS_SHIFT][0];
 			break;
 		default:
 			ret = -EINVAL;
-- 
2.7.4
