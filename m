Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	daniel.baluta@intel.com,
	adriana.reus@intel.com,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH] iio: accel: kxcjk1013: allow using an external trigger
Date: Fri,  3 Apr 2015 15:03:02 +0300
Message-Id: <1428062582-3092-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

In its present state, the driver mandates that its buffer only be
triggered by one of the device's own triggers (data ready or any
motion).  This is not always desirable, for example because the
interrupt pins may not be wired in.

Patch the driver to be able to accept using an external trigger, such as
one based on hrtimer.  When using such a trigger, we need to ensure that
the device is powered on when the buffer is started.  We do that by
setting setup_ops for the buffer.

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---

I used the hrtimer-based trigger patches that Daniel sent earlier this week to
test these changes.

 drivers/iio/accel/kxcjk-1013.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index a98b5d2..7ae1bdb 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -875,15 +875,18 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static int kxcjk1013_validate_trigger(struct iio_dev *indio_dev,
-				      struct iio_trigger *trig)
+static int kxcjk1013_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 
-	if (data->dready_trig != trig && data->motion_trig != trig)
-		return -EINVAL;
+	return kxcjk1013_set_power_state(data, true);
+}
 
-	return 0;
+static int kxcjk1013_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct kxcjk1013_data *data = iio_priv(indio_dev);
+
+	return kxcjk1013_set_power_state(data, false);
 }
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
@@ -935,6 +938,13 @@ static const struct iio_chan_spec kxcjk1013_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_buffer_setup_ops kxcjk1013_buffer_setup_ops = {
+	.preenable		= kxcjk1013_buffer_preenable,
+	.postenable		= iio_triggered_buffer_postenable,
+	.postdisable		= kxcjk1013_buffer_postdisable,
+	.predisable		= iio_triggered_buffer_predisable,
+};
+
 static const struct iio_info kxcjk1013_info = {
 	.attrs			= &kxcjk1013_attrs_group,
 	.read_raw		= kxcjk1013_read_raw,
@@ -943,7 +953,6 @@ static const struct iio_info kxcjk1013_info = {
 	.write_event_value	= kxcjk1013_write_event,
 	.write_event_config	= kxcjk1013_write_event_config,
 	.read_event_config	= kxcjk1013_read_event_config,
-	.validate_trigger	= kxcjk1013_validate_trigger,
 	.driver_module		= THIS_MODULE,
 };
 
@@ -1276,16 +1285,15 @@ static int kxcjk1013_probe(struct i2c_client *client,
 			data->motion_trig = NULL;
 			goto err_trigger_unregister;
 		}
+	}
 
-		ret = iio_triggered_buffer_setup(indio_dev,
-						&iio_pollfunc_store_time,
-						kxcjk1013_trigger_handler,
-						NULL);
-		if (ret < 0) {
-			dev_err(&client->dev,
-					"iio triggered buffer setup failed\n");
-			goto err_trigger_unregister;
-		}
+	ret = iio_triggered_buffer_setup(indio_dev,
+					 &iio_pollfunc_store_time,
+					 kxcjk1013_trigger_handler,
+					 &kxcjk1013_buffer_setup_ops);
+	if (ret < 0) {
+		dev_err(&client->dev, "iio triggered buffer setup failed\n");
+		goto err_trigger_unregister;
 	}
 
 	ret = iio_device_register(indio_dev);
-- 
1.9.1
