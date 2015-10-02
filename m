Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:32926 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbbJBMis (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Oct 2015 08:38:48 -0400
Received: by wiclk2 with SMTP id lk2so31967528wic.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2015 05:38:46 -0700 (PDT)
From: Crt Mori <cmo@melexis.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
	Vianney le Clement de Saint-Marcq
	<vianney.leclement@essensium.com>,
	Peter Meerwald <pmeerw@pmeerw.net>, Crt Mori <cmo@melexis.com>
Subject: [PATCH v2] [BUGFIX] iio: mlx96014: Error checking from positive to negative
Date: Fri,  2 Oct 2015 14:24:21 +0200
Message-Id: <1443788661-31167-1-git-send-email-cmo@melexis.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dan Carpenter reported a static checker report and after his mail I
noticed that we actually return from function if positive value is
obtained from i2c read. This was remainder from when code was not in
separate function (which I changed during the review process).

Static checker reported
  drivers/iio/temperature/mlx90614.c:167
  mlx90614_iir_search()
    warn: this cast is a no-op
which meant that cast before negating is useless. Dan also proposed a
solution on nicer bit operation form.

Also changed magic number to macro in process as that was confusing.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90614.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 3fd3ba4..a570c2e 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -72,6 +72,7 @@
 #define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
 #define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for emissivity */
 #define MLX90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~ 0.000015259 */
+#define MLX90614_CONST_FIR 0x7 /* Fixed value for FIR part of low pass filter */
 
 struct mlx90614_data {
 	struct i2c_client *client;
@@ -156,15 +157,16 @@ static inline s32 mlx90614_iir_search(const struct i2c_client *client,
 	 * changes
 	 */
 	ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG);
-	if (ret > 0)
+	if (ret < 0)
 		return ret;
 
+	ret &= ~MLX90614_CONFIG_FIR_MASK;
+	ret |= MLX90614_CONST_FIR << MLX90614_CONFIG_FIR_SHIFT;
+	ret &= ~MLX90614_CONFIG_IIR_MASK;
+	ret |= i << MLX90614_CONFIG_IIR_SHIFT;
+
 	/* Write changed values */
-	ret = mlx90614_write_word(client, MLX90614_CONFIG,
-			(i << MLX90614_CONFIG_IIR_SHIFT) |
-			(((u16) ((0x7 << MLX90614_CONFIG_FIR_SHIFT) |
-			((u16) ret & (~((u16) MLX90614_CONFIG_FIR_MASK))))) &
-			(~(u16) MLX90614_CONFIG_IIR_MASK)));
+	ret = mlx90614_write_word(client, MLX90614_CONFIG, ret);
 	return ret;
 }
 
-- 
2.1.4

