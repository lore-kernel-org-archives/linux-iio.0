Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.208]:42343 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbcCXQFW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Mar 2016 12:05:22 -0400
Date: Thu, 24 Mar 2016 17:06:01 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: peda@axentia.se
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
Subject: [PATCH] iio: potentiometer: mcp4531: use pointer to access model
 parameters
Message-ID: <20160324160601.GA7819@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use const pointer to element from model configuration array rather then array
index, as it will not change anyway.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/iio/potentiometer/mcp4531.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index a3f6687..385f568 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -79,7 +79,7 @@ static const struct mcp4531_cfg mcp4531_cfg[] = {
 
 struct mcp4531_data {
 	struct i2c_client *client;
-	unsigned long devid;
+	const struct mcp4531_cfg *cfg;
 };
 
 #define MCP4531_CHANNEL(ch) {					\
@@ -113,8 +113,8 @@ static int mcp4531_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 1000 * mcp4531_cfg[data->devid].kohms;
-		*val2 = mcp4531_cfg[data->devid].max_pos;
+		*val = 1000 * data->cfg->kohms;
+		*val2 = data->cfg->max_pos;
 		return IIO_VAL_FRACTIONAL;
 	}
 
@@ -130,7 +130,7 @@ static int mcp4531_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val > mcp4531_cfg[data->devid].max_pos || val < 0)
+		if (val > data->cfg->max_pos || val < 0)
 			return -EINVAL;
 		break;
 	default:
@@ -152,7 +152,6 @@ static int mcp4531_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
-	unsigned long devid = id->driver_data;
 	struct mcp4531_data *data;
 	struct iio_dev *indio_dev;
 
@@ -168,12 +167,12 @@ static int mcp4531_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
-	data->devid = devid;
+	data->cfg = &mcp4531_cfg[id->driver_data];
 
 	indio_dev->dev.parent = dev;
 	indio_dev->info = &mcp4531_info;
 	indio_dev->channels = mcp4531_channels;
-	indio_dev->num_channels = mcp4531_cfg[devid].wipers;
+	indio_dev->num_channels = data->cfg->wipers;
 	indio_dev->name = client->name;
 
 	return devm_iio_device_register(dev, indio_dev);
-- 
2.7.4
