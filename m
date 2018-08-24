Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41504 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeHYAAm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Aug 2018 20:00:42 -0400
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] iio: dac: ti-dac5571: make vref regulator optional
Date: Fri, 24 Aug 2018 22:24:47 +0200
Message-Id: <20180824202447.21804-1-marcus.folkesson@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The `vref` regulator is declared as optional in the device-tree binding,
but the driver does require it.

Go for the device-tree binding and make the `vref` regulator optional.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/dac/ti-dac5571.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index f6dcd8bce2b0..bf21cc312096 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -251,6 +251,9 @@ static int dac5571_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
+		if (!data->vref)
+			return -EOPNOTSUPP;
+
 		ret = regulator_get_voltage(data->vref);
 		if (ret < 0)
 			return ret;
@@ -335,13 +338,21 @@ static int dac5571_probe(struct i2c_client *client,
 	indio_dev->num_channels = spec->num_channels;
 	data->spec = spec;
 
-	data->vref = devm_regulator_get(dev, "vref");
-	if (IS_ERR(data->vref))
-		return PTR_ERR(data->vref);
+	data->vref = devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(data->vref)) {
+		if (PTR_ERR(data->vref) == -ENODEV) {
+			data->vref = NULL;
+		} else {
+			dev_err(dev, "failed to get regulator (%ld)\n",
+					PTR_ERR(data->vref));
+			return PTR_ERR(data->vref);
+		}
 
-	ret = regulator_enable(data->vref);
-	if (ret < 0)
-		return ret;
+	} else {
+		ret = regulator_enable(data->vref);
+		if (ret)
+			return ret;
+	}
 
 	mutex_init(&data->lock);
 
@@ -373,7 +384,9 @@ static int dac5571_probe(struct i2c_client *client,
 	return 0;
 
  err:
-	regulator_disable(data->vref);
+	if (data->vref)
+		regulator_disable(data->vref);
+
 	return ret;
 }
 
@@ -383,7 +396,8 @@ static int dac5571_remove(struct i2c_client *i2c)
 	struct dac5571_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	regulator_disable(data->vref);
+	if (data->vref)
+		regulator_disable(data->vref);
 
 	return 0;
 }
-- 
2.18.0
