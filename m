Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:37779 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755028AbcGEKXX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 06:23:23 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 4/4] iio: light: vcnl4000: Add missing locking
Date: Tue,  5 Jul 2016 12:23:21 +0200
Message-Id: <1467714201-11429-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1467714201-11429-1-git-send-email-pmeerw@pmeerw.net>
References: <1467714201-11429-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/iio/light/vcnl4000.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 9f94b6b..360b6e9 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -48,6 +48,7 @@
 
 struct vcnl4000_data {
 	struct i2c_client *client;
+	struct mutex lock;
 };
 
 static const struct i2c_device_id vcnl4000_id[] = {
@@ -63,16 +64,18 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 	__be16 buf;
 	int ret;
 
+	mutex_lock(&data->lock);
+
 	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
 					req_mask);
 	if (ret < 0)
-		return ret;
+		goto fail;
 
 	/* wait for data to become ready */
 	while (tries--) {
 		ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
 		if (ret < 0)
-			return ret;
+			goto fail;
 		if (ret & rdy_mask)
 			break;
 		msleep(20); /* measurement takes up to 100 ms */
@@ -81,17 +84,23 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 	if (tries < 0) {
 		dev_err(&data->client->dev,
 			"vcnl4000_measure() failed, data not ready\n");
-		return -EIO;
+		ret = -EIO;
+		goto fail;
 	}
 
 	ret = i2c_smbus_read_i2c_block_data(data->client,
 		data_reg, sizeof(buf), (u8 *) &buf);
 	if (ret < 0)
-		return ret;
+		goto fail;
 
+	mutex_unlock(&data->lock);
 	*val = be16_to_cpu(buf);
 
 	return 0;
+
+fail:
+	mutex_unlock(&data->lock);
+	return ret;
 }
 
 static const struct iio_chan_spec vcnl4000_channels[] = {
@@ -163,6 +172,7 @@ static int vcnl4000_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
+	mutex_init(&data->lock);
 
 	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_PROD_REV);
 	if (ret < 0)
-- 
1.7.10.4

