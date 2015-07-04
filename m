Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH 3/5] iio:light:stk3310: add more error handling
Date: Sat,  4 Jul 2015 17:56:59 +0200
Message-Id: <e0c5af9c11193697c772e0c5174e2434fe589037.1436024257.git.knaack.h@gmx.de>
In-Reply-To: <cover.1436024257.git.knaack.h@gmx.de>
References: <cover.1436024257.git.knaack.h@gmx.de>
In-Reply-To: <cover.1436024257.git.knaack.h@gmx.de>
References: <cover.1436024257.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Check for the following error cases:
  * lower boundary for val in _write_event
  * return value of regmap_(field_)read
  * possible values for chan->type
  * return value of stk3310_gpio_probe

Also add an error-cleanup path in _probe to handle failure in
iio_device_register and devm_request_threaded_irq.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/light/stk3310.c | 60 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index c52c730..3650c0c 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -241,8 +241,11 @@ static int stk3310_write_event(struct iio_dev *indio_dev,
 	struct stk3310_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
 
-	regmap_field_read(data->reg_ps_gain, &index);
-	if (val > stk3310_ps_max[index])
+	ret = regmap_field_read(data->reg_ps_gain, &index);
+	if (ret < 0)
+		return ret;
+
+	if (val < 0 || val > stk3310_ps_max[index])
 		return -EINVAL;
 
 	if (dir == IIO_EV_DIR_RISING)
@@ -266,9 +269,12 @@ static int stk3310_read_event_config(struct iio_dev *indio_dev,
 				     enum iio_event_direction dir)
 {
 	unsigned int event_val;
+	int ret;
 	struct stk3310_data *data = iio_priv(indio_dev);
 
-	regmap_field_read(data->reg_int_ps, &event_val);
+	ret = regmap_field_read(data->reg_int_ps, &event_val);
+	if (ret < 0)
+		return ret;
 
 	return event_val;
 }
@@ -307,14 +313,16 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
 	struct stk3310_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
 
+	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (chan->type == IIO_LIGHT)
 			reg = STK3310_REG_ALS_DATA_MSB;
-		else if (chan->type == IIO_PROXIMITY)
-			reg = STK3310_REG_PS_DATA_MSB;
 		else
-			return -EINVAL;
+			reg = STK3310_REG_PS_DATA_MSB;
+
 		mutex_lock(&data->lock);
 		ret = regmap_bulk_read(data->regmap, reg, &buf, 2);
 		if (ret < 0) {
@@ -327,17 +335,23 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_INT_TIME:
 		if (chan->type == IIO_LIGHT)
-			regmap_field_read(data->reg_als_it, &index);
+			ret = regmap_field_read(data->reg_als_it, &index);
 		else
-			regmap_field_read(data->reg_ps_it, &index);
+			ret = regmap_field_read(data->reg_ps_it, &index);
+		if (ret < 0)
+			return ret;
+
 		*val = stk3310_it_table[index][0];
 		*val2 = stk3310_it_table[index][1];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_LIGHT)
-			regmap_field_read(data->reg_als_gain, &index);
+			ret = regmap_field_read(data->reg_als_gain, &index);
 		else
-			regmap_field_read(data->reg_ps_gain, &index);
+			ret = regmap_field_read(data->reg_ps_gain, &index);
+		if (ret < 0)
+			return ret;
+
 		*val = stk3310_scale_table[index][0];
 		*val2 = stk3310_scale_table[index][1];
 		return IIO_VAL_INT_PLUS_MICRO;
@@ -354,6 +368,9 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
 	int index;
 	struct stk3310_data *data = iio_priv(indio_dev);
 
+	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
 		index = stk3310_get_index(stk3310_it_table,
@@ -435,7 +452,10 @@ static int stk3310_init(struct iio_dev *indio_dev)
 	struct stk3310_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
 
-	regmap_read(data->regmap, STK3310_REG_ID, &chipid);
+	ret = regmap_read(data->regmap, STK3310_REG_ID, &chipid);
+	if (ret < 0)
+		return ret;
+
 	if (chipid != STK3310_CHIP_ID_VAL &&
 	    chipid != STK3311_CHIP_ID_VAL) {
 		dev_err(&client->dev, "invalid chip id: 0x%x\n", chipid);
@@ -611,11 +631,14 @@ static int stk3310_probe(struct i2c_client *client,
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "device_register failed\n");
-		stk3310_set_state(data, STK3310_STATE_STANDBY);
+		goto err_standby;
 	}
 
-	if (client->irq <= 0)
+	if (client->irq <= 0) {
 		client->irq = stk3310_gpio_probe(client);
+		if (client->irq < 0)
+			goto err_unregister;
+	}
 
 	if (client->irq >= 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
@@ -624,11 +647,20 @@ static int stk3310_probe(struct i2c_client *client,
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						STK3310_EVENT, indio_dev);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_err(&client->dev, "request irq %d failed\n",
 					client->irq);
+			goto err_unregister;
+		}
 	}
 
+	return 0;
+
+err_unregister:
+	iio_device_unregister(indio_dev);
+err_standby:
+	stk3310_set_state(data, STK3310_STATE_STANDBY);
+
 	return ret;
 }
 
-- 
2.3.6
