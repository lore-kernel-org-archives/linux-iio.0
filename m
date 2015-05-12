Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org,
	octavian.purdila@intel.com,
	linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH] iio: accel: bmc150: decouple buffer and triggers
Date: Tue, 12 May 2015 17:03:24 +0300
Message-Id: <1431439404-30001-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

If the interrupt pins are not available, we should still be able to use
the buffer with an external trigger.  However, we won't be able to use
the hardware fifo since we have no means of signalling when the
watermark is reached.

I also added a comment to indicate that the timestamps in
bmc150_accel_data are only used for hardware fifo, since initially I was
confused about duplication with pf->timestamp.

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 55 +++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 73e8773..4e70f51 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -196,7 +196,7 @@ struct bmc150_accel_data {
 	u32 slope_thres;
 	u32 range;
 	int ev_enable_state;
-	int64_t timestamp, old_timestamp;
+	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
 	const struct bmc150_accel_chip_info *chip_info;
 };
 
@@ -1183,7 +1183,6 @@ static const struct iio_info bmc150_accel_info = {
 	.write_event_value	= bmc150_accel_write_event,
 	.write_event_config	= bmc150_accel_write_event_config,
 	.read_event_config	= bmc150_accel_read_event_config,
-	.validate_trigger	= bmc150_accel_validate_trigger,
 	.driver_module		= THIS_MODULE,
 };
 
@@ -1222,7 +1221,7 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	mutex_unlock(&data->mutex);
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-					   data->timestamp);
+					   pf->timestamp);
 err_read:
 	iio_trigger_notify_done(indio_dev->trig);
 
@@ -1535,6 +1534,13 @@ static int bmc150_accel_fifo_set_mode(struct bmc150_accel_data *data)
 	return ret;
 }
 
+static int bmc150_accel_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct bmc150_accel_data *data = iio_priv(indio_dev);
+
+	return bmc150_accel_set_power_state(data, true);
+}
+
 static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
@@ -1591,9 +1597,18 @@ out:
 	return 0;
 }
 
+static int bmc150_accel_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct bmc150_accel_data *data = iio_priv(indio_dev);
+
+	return bmc150_accel_set_power_state(data, false);
+}
+
 static const struct iio_buffer_setup_ops bmc150_accel_buffer_ops = {
+	.preenable = bmc150_accel_buffer_preenable,
 	.postenable = bmc150_accel_buffer_postenable,
 	.predisable = bmc150_accel_buffer_predisable,
+	.postdisable = bmc150_accel_buffer_postdisable,
 };
 
 static int bmc150_accel_probe(struct i2c_client *client,
@@ -1636,6 +1651,15 @@ static int bmc150_accel_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmc150_accel_info;
 
+	ret = iio_triggered_buffer_setup(indio_dev,
+					 &iio_pollfunc_store_time,
+					 bmc150_accel_trigger_handler,
+					 &bmc150_accel_buffer_ops);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed: iio triggered buffer setup\n");
+		return ret;
+	}
+
 	if (client->irq < 0)
 		client->irq = bmc150_accel_gpio_probe(client, data);
 
@@ -1648,7 +1672,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 						BMC150_ACCEL_IRQ_NAME,
 						indio_dev);
 		if (ret)
-			return ret;
+			goto err_buffer_cleanup;
 
 		/*
 		 * Set latched mode interrupt. While certain interrupts are
@@ -1661,24 +1685,14 @@ static int bmc150_accel_probe(struct i2c_client *client,
 					     BMC150_ACCEL_INT_MODE_LATCH_RESET);
 		if (ret < 0) {
 			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
-			return ret;
+			goto err_buffer_cleanup;
 		}
 
 		bmc150_accel_interrupts_setup(indio_dev, data);
 
 		ret = bmc150_accel_triggers_setup(indio_dev, data);
 		if (ret)
-			return ret;
-
-		ret = iio_triggered_buffer_setup(indio_dev,
-						 &iio_pollfunc_store_time,
-						 bmc150_accel_trigger_handler,
-						 &bmc150_accel_buffer_ops);
-		if (ret < 0) {
-			dev_err(&client->dev,
-				"Failed: iio triggered buffer setup\n");
-			goto err_trigger_unregister;
-		}
+			goto err_buffer_cleanup;
 
 		if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
 		    i2c_check_functionality(client->adapter,
@@ -1692,7 +1706,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "Unable to register iio device\n");
-		goto err_buffer_cleanup;
+		goto err_trigger_unregister;
 	}
 
 	ret = pm_runtime_set_active(&client->dev);
@@ -1708,11 +1722,10 @@ static int bmc150_accel_probe(struct i2c_client *client,
 
 err_iio_unregister:
 	iio_device_unregister(indio_dev);
-err_buffer_cleanup:
-	if (indio_dev->pollfunc)
-		iio_triggered_buffer_cleanup(indio_dev);
 err_trigger_unregister:
 	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
+err_buffer_cleanup:
+	iio_triggered_buffer_cleanup(indio_dev);
 
 	return ret;
 }
@@ -1730,6 +1743,8 @@ static int bmc150_accel_remove(struct i2c_client *client)
 
 	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
 
+	iio_triggered_buffer_cleanup(indio_dev);
+
 	mutex_lock(&data->mutex);
 	bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_DEEP_SUSPEND, 0);
 	mutex_unlock(&data->mutex);
-- 
1.9.1
