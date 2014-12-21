Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47234 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448AbaLUAqr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 20 Dec 2014 19:46:47 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v2 08/11] iio: bmc150: introduce bmc150_accel_interrupt
Date: Sun, 21 Dec 2014 02:42:33 +0200
Message-Id: <1419122556-8100-9-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since both triggers and events can share an interrupt, add a data
structure that tracks the users of an interrupt so that it enables or
disables it only for the first users and respectively last user.

This will allows us to easily add more events or triggers.

The patch also adds an interrupt enabled counter, so that we can
easily know if we need to put the device in normal mode when the
resume callback is issued.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 87 +++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index aaad2fb..7c905f6 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -151,10 +151,19 @@ struct bmc150_accel_interrupt_info {
 	u8 en_bitmask;
 };
 
+struct bmc150_accel_interrupt {
+	struct bmc150_accel_interrupt_info *info;
+	atomic_t users;
+};
+
+#define BMC150_ACCEL_INTERRUPTS		2
+
 struct bmc150_accel_data {
 	struct i2c_client *client;
+	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
 	struct iio_trigger *dready_trig;
 	struct iio_trigger *motion_trig;
+	atomic_t active_intr;
 	struct mutex mutex;
 	s16 buffer[8];
 	u8 bw_bits;
@@ -436,7 +445,8 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 }
 #endif
 
-static struct bmc150_accel_interrupt_info bmc150_accel_interrupts[] = {
+static struct bmc150_accel_interrupt_info
+bmc150_accel_interrupts[BMC150_ACCEL_INTERRUPTS] = {
 	{ /* data ready interrupt */
 		.map_reg = BMC150_ACCEL_REG_INT_MAP_1,
 		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_DATA,
@@ -453,12 +463,30 @@ static struct bmc150_accel_interrupt_info bmc150_accel_interrupts[] = {
 	},
 };
 
+static void bmc150_accel_interrupts_setup(struct iio_dev *indio_dev,
+					 struct bmc150_accel_data *data)
+{
+	int i;
+
+	for (i = 0; i < BMC150_ACCEL_INTERRUPTS; i++)
+		data->interrupts[i].info = &bmc150_accel_interrupts[i];
+}
+
 static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data,
-				      struct bmc150_accel_interrupt_info *info,
+				      struct bmc150_accel_interrupt *intr,
 				      bool state)
 {
+	struct bmc150_accel_interrupt_info *info = intr->info;
 	int ret;
 
+	if (state) {
+		if (atomic_inc_return(&intr->users) > 1)
+			return 0;
+	} else {
+		if (atomic_dec_return(&intr->users) > 0)
+			return 0;
+	}
+
 	/*
 	 * We will expect the enable and disable to do operation in
 	 * in reverse order. This will happen here anyway as our
@@ -509,22 +537,12 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data,
 		return ret;
 	}
 
-	return 0;
-}
-
-static int bmc150_accel_setup_any_motion_interrupt(
-					struct bmc150_accel_data *data,
-					bool status)
-{
-	return bmc150_accel_set_interrupt(data, &bmc150_accel_interrupts[1],
-					  status);
-}
+	if (state)
+		atomic_inc(&data->active_intr);
+	else
+		atomic_dec(&data->active_intr);
 
-static int bmc150_accel_setup_new_data_interrupt(struct bmc150_accel_data *data,
-					   bool status)
-{
-	return bmc150_accel_set_interrupt(data, &bmc150_accel_interrupts[0],
-					  status);
+	return 0;
 }
 
 static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
@@ -769,23 +787,12 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
 		return 0;
 
 	mutex_lock(&data->mutex);
-
-	if (!state && data->motion_trigger_on) {
-		data->ev_enable_state = 0;
-		mutex_unlock(&data->mutex);
-		return 0;
-	}
-
-	ret =  bmc150_accel_setup_any_motion_interrupt(data, state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
-
-	data->ev_enable_state = state;
+	ret = bmc150_accel_set_interrupt(data, &data->interrupts[1], state);
+	if (!ret)
+		data->ev_enable_state = state;
 	mutex_unlock(&data->mutex);
 
-	return 0;
+	return ret;
 }
 
 static int bmc150_accel_validate_trigger(struct iio_dev *indio_dev,
@@ -1013,16 +1020,12 @@ static int bmc150_accel_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		}
 	}
 
-	if (!state && data->ev_enable_state && data->motion_trigger_on) {
-		data->motion_trigger_on = false;
-		mutex_unlock(&data->mutex);
-		return 0;
-	}
-
 	if (data->motion_trig == trig)
-		ret =  bmc150_accel_setup_any_motion_interrupt(data, state);
+		ret = bmc150_accel_set_interrupt(data, &data->interrupts[1],
+						 state);
 	else
-		ret = bmc150_accel_setup_new_data_interrupt(data, state);
+		ret = bmc150_accel_set_interrupt(data, &data->interrupts[0],
+						 state);
 	if (ret < 0) {
 		mutex_unlock(&data->mutex);
 		return ret;
@@ -1209,6 +1212,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 			return ret;
 		}
 
+		bmc150_accel_interrupts_setup(indio_dev, data);
 
 		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
 							   "%s-dev%d",
@@ -1325,8 +1329,7 @@ static int bmc150_accel_resume(struct device *dev)
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 
 	mutex_lock(&data->mutex);
-	if (data->dready_trigger_on || data->motion_trigger_on ||
-							data->ev_enable_state)
+	if (atomic_read(&data->active_intr))
 		bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
 	mutex_unlock(&data->mutex);
 
-- 
1.9.1

