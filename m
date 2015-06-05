Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59891 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754424AbbFELBl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 5 Jun 2015 07:01:41 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net
Cc: daniel.baluta@intel.com, knaack.h@gmx.de, lars@metafoo.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 6/6] iio: magnetometer: mmc35240: Add compensation for raw values
Date: Fri,  5 Jun 2015 14:03:15 +0300
Message-Id: <1433502195-30296-7-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1433502195-30296-1-git-send-email-daniel.baluta@intel.com>
References: <1433502195-30296-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds compensation formula to raw readings, borrowed
from Memsic's input driver.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/magnetometer/mmc35240.c | 62 ++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 73fa111..7540bbf 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -58,6 +58,31 @@
 #define MMC35240_WAIT_CHARGE_PUMP	50000	/* us */
 #define MMC53240_WAIT_SET_RESET		1000	/* us */
 
+/*
+ * Memsic OTP process code piece is put here for reference:
+ *
+ * #define OTP_CONVERT(REG)  ((float)((REG) >=32 ? (32 - (REG)) : (REG)) * 0.006
+ * 1) For X axis, the COEFFICIENT is always 1.
+ * 2) For Y axis, the COEFFICIENT is as below:
+ *    f_OTP_matrix[4] = OTP_CONVERT(((reg_data[1] & 0x03) << 4) |
+ *                                   (reg_data[2] >> 4)) + 1.0;
+ * 3) For Z axis, the COEFFICIENT is as below:
+ *    f_OTP_matrix[8] = (OTP_CONVERT(reg_data[3] & 0x3f) + 1) * 1.35;
+ * We implemented the OTP logic into driver.
+ */
+
+/* scale = 1000 here for Y otp */
+#define MMC35240_OTP_CONVERT_Y(REG) (((REG) >= 32 ? (32 - (REG)) : (REG)) * 6)
+
+/* 0.6 * 1.35 = 0.81, scale 10000 for Z otp */
+#define MMC35240_OTP_CONVERT_Z(REG) (((REG) >= 32 ? (32 - (REG)) : (REG)) * 81)
+
+#define MMC35240_X_COEFF(x)	(x)
+#define MMC35240_Y_COEFF(y)	(y + 1000)
+#define MMC35240_Z_COEFF(z)	(z + 13500)
+
+#define MMC35240_OTP_START_ADDR		0x1B
+
 enum mmc35240_resolution {
 	MMC35240_16_BITS_SLOW = 0, /* 100 Hz */
 	MMC35240_16_BITS_FAST,     /* 200 Hz */
@@ -102,6 +127,10 @@ struct mmc35240_data {
 	struct mutex mutex;
 	struct regmap *regmap;
 	enum mmc35240_resolution res;
+
+	/* OTP compensation */
+	int axis_coef[3];
+	int axis_scale[3];
 };
 
 static const int mmc35240_samp_freq[] = {100, 200, 333, 666};
@@ -172,8 +201,9 @@ static int mmc35240_hw_set(struct mmc35240_data *data, bool set)
 
 static int mmc35240_init(struct mmc35240_data *data)
 {
-	int ret;
+	int ret, y_convert, z_convert;
 	unsigned int reg_id;
+	u8 otp_data[6];
 
 	ret = regmap_read(data->regmap, MMC35240_REG_ID, &reg_id);
 	if (ret < 0) {
@@ -197,9 +227,30 @@ static int mmc35240_init(struct mmc35240_data *data)
 		return ret;
 
 	/* set default sampling frequency */
-	return regmap_update_bits(data->regmap, MMC35240_REG_CTRL1,
-				  MMC35240_CTRL1_BW_MASK,
-				  data->res << MMC35240_CTRL1_BW_SHIFT);
+	ret = regmap_update_bits(data->regmap, MMC35240_REG_CTRL1,
+				 MMC35240_CTRL1_BW_MASK,
+				 data->res << MMC35240_CTRL1_BW_SHIFT);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_bulk_read(data->regmap, MMC35240_OTP_START_ADDR,
+			       (u8 *)otp_data, sizeof(otp_data));
+	if (ret < 0)
+		return ret;
+
+	y_convert = MMC35240_OTP_CONVERT_Y(((otp_data[1] & 0x03) << 4) |
+					   (otp_data[2] >> 4));
+	z_convert = MMC35240_OTP_CONVERT_Z(otp_data[3] & 0x3f);
+
+	data->axis_coef[0] = MMC35240_X_COEFF(1);
+	data->axis_coef[1] = MMC35240_Y_COEFF(y_convert);
+	data->axis_coef[2] = MMC35240_Z_COEFF(z_convert);
+
+	data->axis_scale[0] = 1;
+	data->axis_scale[1] = 1000;
+	data->axis_scale[2] = 10000;
+
+	return 0;
 }
 
 static int mmc35240_take_measurement(struct mmc35240_data *data)
@@ -286,6 +337,9 @@ static int mmc35240_raw_to_mgauss(struct mmc35240_data *data, int index,
 	default:
 		return -EINVAL;
 	}
+	/* apply OTP compensation */
+	*val = (*val) * data->axis_coef[index] / data->axis_scale[index];
+
 	return 0;
 }
 
-- 
1.9.1

