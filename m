Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:35200
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbbBYPzg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Feb 2015 10:55:36 -0500
From: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>
To: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Cc: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH 3/7] iio: mlx90614: Add processed temperature output
Date: Wed, 25 Feb 2015 16:55:08 +0100
Message-Id: <1424879712-28304-4-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com>
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Provide processed temperature in milli-Celsius through the
in_temp_*_input interface.

Also correct the formula in the comment as 1/20 = 0.05 instead of 0.02.

Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
---
 drivers/iio/temperature/mlx90614.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index a2e3aa6..d5b41fd 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -2,6 +2,7 @@
  * mlx90614.c - Support for Melexis MLX90614 contactless IR temperature sensor
  *
  * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
+ * Copyright (c) 2015 Essensium NV
  *
  * This file is subject to the terms and conditions of version 2 of
  * the GNU General Public License.  See the file COPYING in the main
@@ -62,7 +63,8 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 	s32 ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW: /* 0.02K / LSB */
+	case IIO_CHAN_INFO_RAW: /* 0.05K / LSB */
+	case IIO_CHAN_INFO_PROCESSED:
 		switch (channel->channel2) {
 		case IIO_MOD_TEMP_AMBIENT:
 			ret = i2c_smbus_read_word_data(data->client,
@@ -79,7 +81,14 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-		*val = ret;
+		switch (mask) {
+		case IIO_CHAN_INFO_RAW:
+			*val = ret;
+			break;
+		case IIO_CHAN_INFO_PROCESSED:
+			*val = ret * 20 - 273150;
+			break;
+		}
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = 13657;
@@ -98,7 +107,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
 		.type = IIO_TEMP,
 		.modified = 1,
 		.channel2 = IIO_MOD_TEMP_AMBIENT,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		    BIT(IIO_CHAN_INFO_PROCESSED),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		    BIT(IIO_CHAN_INFO_SCALE),
 	},
@@ -106,7 +116,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
 		.type = IIO_TEMP,
 		.modified = 1,
 		.channel2 = IIO_MOD_TEMP_OBJECT,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		    BIT(IIO_CHAN_INFO_PROCESSED),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		    BIT(IIO_CHAN_INFO_SCALE),
 	},
@@ -170,5 +181,6 @@ static struct i2c_driver mlx90614_driver = {
 module_i2c_driver(mlx90614_driver);
 
 MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
+MODULE_AUTHOR("Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>");
 MODULE_DESCRIPTION("Melexis MLX90614 contactless IR temperature sensor driver");
 MODULE_LICENSE("GPL");
-- 
2.3.0

