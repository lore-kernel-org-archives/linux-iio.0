Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:63523 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbaJYSWL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 25 Oct 2014 14:22:11 -0400
Message-ID: <544BE742.8030004@gmx.de>
Date: Sat, 25 Oct 2014 20:09:06 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: IIO <linux-iio@vger.kernel.org>
CC: David Barksdale <dbarksdale@uplogix.com>
Subject: [PATCH]iio:humidity:si7020: fix pointer to i2c client
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In si7020_read_raw() the pointer to the i2c client was obtained as second level
pointer, although a simple pointer is appropriate.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index e336af7..62d74d3 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -45,12 +45,12 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
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

