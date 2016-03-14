Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33976 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678AbcCNGfA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Mar 2016 02:35:00 -0400
Received: by mail-pa0-f48.google.com with SMTP id fe3so133942556pab.1
        for <linux-iio@vger.kernel.org>; Sun, 13 Mar 2016 23:34:59 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: potentiometer: tpl0102: add hi-z enable/disable support
Date: Sun, 13 Mar 2016 23:34:44 -0700
Message-Id: <1457937284-16318-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/potentiometer/tpl0102.c | 43 ++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
index 313124b..1413419c 100644
--- a/drivers/iio/potentiometer/tpl0102.c
+++ b/drivers/iio/potentiometer/tpl0102.c
@@ -12,8 +12,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
- *
- * TODO: enable/disable hi-z output control
  */
 
 #include <linux/module.h>
@@ -39,7 +37,7 @@ static const struct tpl0102_cfg tpl0102_cfg[] = {
 	[CAT5140_503] = { .wipers = 1, .max_pos = 256, .kohms = 50, },
 	[CAT5140_104] = { .wipers = 1, .max_pos = 256, .kohms = 100, },
 	/* ti parts */
-	[TPL0102_104] = { .wipers = 2, .max_pos = 256, .kohms = 100 },
+	[TPL0102_104] = { .wipers = 3, .max_pos = 256, .kohms = 100 },
 	[TPL0401_103] = { .wipers = 1, .max_pos = 128, .kohms = 10, },
 };
 
@@ -65,6 +63,15 @@ static const struct regmap_config tpl0102_regmap_config = {
 static const struct iio_chan_spec tpl0102_channels[] = {
 	TPL0102_CHANNEL(0),
 	TPL0102_CHANNEL(1),
+	/* hi-z enable/disable */
+	{
+		.type = IIO_RESISTANCE,
+		.output = 1,
+		.address = 0x10,
+		.channel = BIT(6),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+	}
 };
 
 static int tpl0102_read_raw(struct iio_dev *indio_dev,
@@ -72,13 +79,20 @@ static int tpl0102_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct tpl0102_data *data = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW: {
-		int ret = regmap_read(data->regmap, chan->channel, val);
+	case IIO_CHAN_INFO_ENABLE:
+		ret = regmap_read(data->regmap, chan->address, val);
+
+		if (!ret)
+			*val = !!(*val & chan->channel);
+
+		return ret ? ret : IIO_VAL_INT;
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(data->regmap, chan->channel, val);
 
 		return ret ? ret : IIO_VAL_INT;
-	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000 * tpl0102_cfg[data->devid].kohms;
 		*val2 = tpl0102_cfg[data->devid].max_pos;
@@ -94,13 +108,18 @@ static int tpl0102_write_raw(struct iio_dev *indio_dev,
 {
 	struct tpl0102_data *data = iio_priv(indio_dev);
 
-	if (mask != IIO_CHAN_INFO_RAW)
-		return -EINVAL;
-
-	if (val >= tpl0102_cfg[data->devid].max_pos || val < 0)
-		return -EINVAL;
+	switch (mask) {
+	case IIO_CHAN_INFO_ENABLE:
+		return regmap_update_bits(data->regmap, chan->address,
+					  chan->channel,
+					  !!val ? chan->channel : 0);
+	case IIO_CHAN_INFO_RAW:
+		if (val >= tpl0102_cfg[data->devid].max_pos || val < 0)
+			return -EINVAL;
+		return regmap_write(data->regmap, chan->channel, val);
+	}
 
-	return regmap_write(data->regmap, chan->channel, val);
+	return -EINVAL;
 }
 
 static const struct iio_info tpl0102_info = {
-- 
2.7.0

