Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:41226 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934931AbaGPSdG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Jul 2014 14:33:06 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 10/13] iio:bma180: Introduce part-specific _config() and disable() code
Date: Wed, 16 Jul 2014 20:32:53 +0200
Message-Id: <1405535576-26482-11-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
References: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

move part of bma180_init() to bma180_config() (split initialization and
configuration code); configuration is heavily chip-specific

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/accel/bma180.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index fc7c7b8..a25b060 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -37,6 +37,8 @@ struct bma180_part_info {
 	unsigned num_scales;
 	const int *bw_table;
 	unsigned num_bw;
+	int (*chip_config)(struct bma180_data *data);
+	void (*chip_disable)(struct bma180_data *data);
 };
 
 /* Register set */
@@ -279,21 +281,28 @@ static int bma180_chip_init(struct bma180_data *data)
 	int ret = i2c_smbus_read_byte_data(data->client, BMA180_CHIP_ID);
 
 	if (ret < 0)
-		goto err;
-	if (ret != BMA180_ID_REG_VAL) {
-		ret = -ENODEV;
-		goto err;
-	}
+		return ret;
+	if (ret != BMA180_ID_REG_VAL)
+		return -ENODEV;
 
 	ret = bma180_soft_reset(data);
 	if (ret)
-		goto err;
+		return ret;
 	/*
 	 * No serial transaction should occur within minimum 10 us
 	 * after soft_reset command
 	 */
 	msleep(20);
 
+	return 0;
+}
+
+static int bma180_chip_config(struct bma180_data *data)
+{
+	int ret = bma180_chip_init(data);
+
+	if (ret)
+		goto err;
 	ret = bma180_set_bits(data, BMA180_CTRL_REG0, BMA180_DIS_WAKE_UP, 1);
 	if (ret)
 		goto err;
@@ -319,7 +328,7 @@ static int bma180_chip_init(struct bma180_data *data)
 	return 0;
 
 err:
-	dev_err(&data->client->dev, "failed to init the chip\n");
+	dev_err(&data->client->dev, "failed to config the chip\n");
 	return ret;
 }
 
@@ -507,6 +516,8 @@ static const struct bma180_part_info bma180_part_info[] = {
 		bma180_channels, ARRAY_SIZE(bma180_channels),
 		bma180_scale_table, ARRAY_SIZE(bma180_scale_table),
 		bma180_bw_table, ARRAY_SIZE(bma180_bw_table),
+		bma180_chip_config,
+		bma180_chip_disable,
 	},
 };
 
@@ -578,7 +589,7 @@ static int bma180_probe(struct i2c_client *client,
 	data->client = client;
 	data->part_info = &bma180_part_info[id->driver_data];
 
-	ret = bma180_chip_init(data);
+	ret = data->part_info->chip_config(data);
 	if (ret < 0)
 		goto err_chip_disable;
 
@@ -640,7 +651,7 @@ err_trigger_unregister:
 err_trigger_free:
 	iio_trigger_free(data->trig);
 err_chip_disable:
-	bma180_chip_disable(data);
+	data->part_info->chip_disable(data);
 
 	return ret;
 }
@@ -658,7 +669,7 @@ static int bma180_remove(struct i2c_client *client)
 	}
 
 	mutex_lock(&data->mutex);
-	bma180_chip_disable(data);
+	data->part_info->chip_disable(data);
 	mutex_unlock(&data->mutex);
 
 	return 0;
-- 
1.9.1

