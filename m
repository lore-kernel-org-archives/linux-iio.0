Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33151 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbeJXTGh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Oct 2018 15:06:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id u1-v6so5030773wrn.0
        for <linux-iio@vger.kernel.org>; Wed, 24 Oct 2018 03:39:02 -0700 (PDT)
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 1/2] iio: potentiometer: tpl0102: switch to using pointer to chip config
Date: Wed, 24 Oct 2018 11:38:57 +0100
Message-Id: <20181024103858.28201-2-matt.ranostay@konsulko.com>
In-Reply-To: <20181024103858.28201-1-matt.ranostay@konsulko.com>
References: <20181024103858.28201-1-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

More concise to have a pointer to tpl0102_cfg struct in the iio_priv
data than an integer to an index of an array.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/potentiometer/tpl0102.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
index ca1cce58fe20..8e8adabe672b 100644
--- a/drivers/iio/potentiometer/tpl0102.c
+++ b/drivers/iio/potentiometer/tpl0102.c
@@ -37,7 +37,7 @@ static const struct tpl0102_cfg tpl0102_cfg[] = {
 
 struct tpl0102_data {
 	struct regmap *regmap;
-	unsigned long devid;
+	const struct tpl0102_cfg *cfg;
 };
 
 static const struct regmap_config tpl0102_regmap_config = {
@@ -72,8 +72,8 @@ static int tpl0102_read_raw(struct iio_dev *indio_dev,
 		return ret ? ret : IIO_VAL_INT;
 	}
 	case IIO_CHAN_INFO_SCALE:
-		*val = 1000 * tpl0102_cfg[data->devid].kohms;
-		*val2 = tpl0102_cfg[data->devid].max_pos;
+		*val = 1000 * data->cfg->kohms;
+		*val2 = data->cfg->max_pos;
 		return IIO_VAL_FRACTIONAL;
 	}
 
@@ -89,7 +89,7 @@ static int tpl0102_write_raw(struct iio_dev *indio_dev,
 	if (mask != IIO_CHAN_INFO_RAW)
 		return -EINVAL;
 
-	if (val >= tpl0102_cfg[data->devid].max_pos || val < 0)
+	if (val >= data->cfg->max_pos || val < 0)
 		return -EINVAL;
 
 	return regmap_write(data->regmap, chan->channel, val);
@@ -113,7 +113,7 @@ static int tpl0102_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 
-	data->devid = id->driver_data;
+	data->cfg = &tpl0102_cfg[id->driver_data];
 	data->regmap = devm_regmap_init_i2c(client, &tpl0102_regmap_config);
 	if (IS_ERR(data->regmap)) {
 		dev_err(dev, "regmap initialization failed\n");
@@ -123,7 +123,7 @@ static int tpl0102_probe(struct i2c_client *client,
 	indio_dev->dev.parent = dev;
 	indio_dev->info = &tpl0102_info;
 	indio_dev->channels = tpl0102_channels;
-	indio_dev->num_channels = tpl0102_cfg[data->devid].wipers;
+	indio_dev->num_channels = data->cfg->wipers;
 	indio_dev->name = client->name;
 
 	return devm_iio_device_register(dev, indio_dev);
-- 
2.17.1
