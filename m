Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:55317 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbaJYSWK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 25 Oct 2014 14:22:10 -0400
Message-ID: <544BE747.80403@gmx.de>
Date: Sat, 25 Oct 2014 20:09:11 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: IIO <linux-iio@vger.kernel.org>
CC: David Barksdale <dbarksdale@uplogix.com>
Subject: [PATCH]iio:humidity:si7020: cleanup read_raw and probe
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When reading temperature or humidity values, a shift of two bits to the right
needs to be applied, and only for the humidity channel a mask of the lower
12 bits needs to be applied. This reduces code repetition.
During probe, i2c_set_clientdata() was used, although its counterpart was not,
so drop it.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index 62d74d3..b541646 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -56,10 +56,9 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
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

