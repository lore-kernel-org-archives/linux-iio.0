Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:61598 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbaJRTqp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 18 Oct 2014 15:46:45 -0400
Message-ID: <5442C3A0.7080501@gmx.de>
Date: Sat, 18 Oct 2014 21:46:40 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: IIO <linux-iio@vger.kernel.org>
CC: David Barksdale <dbarksdale@uplogix.com>
Subject: [PATCH]iio:humidity:si7020: cleanup read_raw and probe
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In si7020_read_raw() the pointer to the i2c client was obtained as second level pointer, although a simple pointer would be sufficient. Cleaned this.
When reading temperature or humidity values, a right-shift of two bits needs to be applied, and only for the humidity channel a mask of the lower 12 bits needs to be applied. This reduces code repetition.
During probe, i2c_set_clientdata() was used, although its counterpart was not, so drop it.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index e336af7..b541646 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -45,21 +45,20 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
 {
-	struct i2c_client **client = iio_priv(indio_dev);
+	struct i2c_client *client = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = i2c_smbus_read_word_data(*client,
+		ret = i2c_smbus_read_word_data(client,
 					       chan->type == IIO_TEMP ?
 					       SI7020CMD_TEMP_HOLD :
 					       SI7020CMD_RH_HOLD);
 		if (ret < 0)
 			return ret;
-		if (chan->type == IIO_TEMP)
-			*val = ret >> 2;
-		else
-			*val = (ret & 0x3FFF) >> 2;
+		*val = ret >> 2;
+		if (chan->type == IIO_HUMIDITYRELATIVE)
+			*val &= GENMASK(11, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_TEMP)
@@ -133,7 +132,6 @@ static int si7020_probe(struct i2c_client *client,
 
 	data = iio_priv(indio_dev);
 	*data = client;
-	i2c_set_clientdata(client, indio_dev);
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = dev_name(&client->dev);
