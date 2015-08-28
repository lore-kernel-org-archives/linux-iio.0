Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:65506 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825AbbH1WAV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 28 Aug 2015 18:00:21 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 5/6] iio:dac:m62332: address some style issues
Date: Fri, 28 Aug 2015 23:59:57 +0200
Message-Id: <b13c6db25dbc9e82017692089b0bf26795f1deba.1440459082.git.knaack.h@gmx.de>
In-Reply-To: <cover.1440459082.git.knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
In-Reply-To: <cover.1440459082.git.knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix some indentation issues and separate returns by empty lines (IIO
style). Also rename the channel mask in _read_raw() to mask.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/dac/m62332.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 1b65fc007bce..fdb3e042c14d 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -40,8 +40,7 @@ struct m62332_data {
 #endif
 };
 
-static int m62332_set_value(struct iio_dev *indio_dev,
-	u8 val, int channel)
+static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
 {
 	struct m62332_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
@@ -87,30 +86,35 @@ static int m62332_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
 			   int *val2,
-			   long m)
+			   long mask)
 {
 	struct m62332_data *data = iio_priv(indio_dev);
 
-	switch (m) {
+	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		/* Corresponds to Vref / 2^(bits) */
 		*val = data->vref_mv;
 		*val2 = 8;
+
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_RAW:
 		*val = data->raw[chan->channel];
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = 1;
+
 		return IIO_VAL_INT;
 	default:
 		break;
 	}
+
 	return -EINVAL;
 }
 
 static int m62332_write_raw(struct iio_dev *indio_dev,
-	struct iio_chan_spec const *chan, int val, int val2, long mask)
+			    struct iio_chan_spec const *chan, int val, int val2,
+			    long mask)
 {
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -195,6 +199,7 @@ static int m62332_probe(struct i2c_client *client,
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
+
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
@@ -230,6 +235,7 @@ static int m62332_probe(struct i2c_client *client,
 
 err:
 	iio_map_array_unregister(indio_dev);
+
 	return ret;
 }
 
-- 
2.4.6

