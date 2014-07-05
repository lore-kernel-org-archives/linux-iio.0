Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:49286 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755326AbaGEMim (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 5 Jul 2014 08:38:42 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/3] iio:tcs3472: Check for buffer enabled and locking
Date: Sat,  5 Jul 2014 14:38:32 +0200
Message-Id: <1404563914-27516-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1404563914-27516-1-git-send-email-pmeerw@pmeerw.net>
References: <1404563914-27516-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Peter Meerwald <p.meerwald@bct-electronic.com>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/tcs3472.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index fe063a0..7525699 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -52,6 +52,7 @@
 
 struct tcs3472_data {
 	struct i2c_client *client;
+	struct mutex lock;
 	u8 enable;
 	u8 control;
 	u8 atime;
@@ -116,10 +117,17 @@ static int tcs3472_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (iio_buffer_enabled(indio_dev))
+			return -EBUSY;
+
+		mutex_lock(&data->lock);
 		ret = tcs3472_req_data(data);
-		if (ret < 0)
+		if (ret < 0) {
+			mutex_unlock(&data->lock);
 			return ret;
+		}
 		ret = i2c_smbus_read_word_data(data->client, chan->address);
+		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
 		*val = ret;
@@ -255,6 +263,7 @@ static int tcs3472_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
+	mutex_init(&data->lock);
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &tcs3472_info;
-- 
1.9.1

