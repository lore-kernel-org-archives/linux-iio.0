Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50872 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448AbaLUArL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 20 Dec 2014 19:47:11 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v2 10/11] iio: bmc150: introduce bmc150_accel_event
Date: Sun, 21 Dec 2014 02:42:35 +0200
Message-Id: <1419122556-8100-11-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add a separate structure for events and add the infrastructure to
support an arbitrary number of events. Each event is associated
with an interrupt and has an enabled/disabled state.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 177 ++++++++++++++++++++++++++++++---------
 1 file changed, 139 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index cd2f5d9..14509be 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -163,21 +163,37 @@ struct bmc150_accel_trigger {
 	bool enabled;
 };
 
+struct bmc150_accel_event {
+	struct bmc150_accel_interrupt *intr;
+	struct bmc150_accel_data *data;
+	enum iio_event_type type;
+	bool enabled;
+	int (*read)(struct bmc150_accel_event *event, enum iio_event_info info,
+		    int *val, int *val2);
+	int (*write)(struct bmc150_accel_event *event, enum iio_event_info info,
+		     int val, int val2);
+	union {
+		struct {
+			u32 duration;
+			u32 threshold;
+		} slope;
+	};
+};
+
 #define BMC150_ACCEL_INTERRUPTS		2
 #define BMC150_ACCEL_TRIGGERS		2
+#define BMC150_ACCEL_EVENTS		1
 
 struct bmc150_accel_data {
 	struct i2c_client *client;
 	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
 	atomic_t active_intr;
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
+	struct bmc150_accel_event events[BMC150_ACCEL_EVENTS];
 	struct mutex mutex;
 	s16 buffer[8];
 	u8 bw_bits;
-	u32 slope_dur;
-	u32 slope_thres;
 	u32 range;
-	int ev_enable_state;
 	int64_t timestamp;
 	const struct bmc150_accel_chip_info *chip_info;
 };
@@ -287,7 +303,8 @@ static int bmc150_accel_set_bw(struct bmc150_accel_data *data, int val,
 	return -EINVAL;
 }
 
-static int bmc150_accel_update_slope_threshold(struct bmc150_accel_data *data,
+static int bmc150_accel_update_slope_threshold(struct bmc150_accel_event *event,
+					       struct bmc150_accel_data *data,
 					       int val)
 {
 	int ret = 0;
@@ -300,14 +317,15 @@ static int bmc150_accel_update_slope_threshold(struct bmc150_accel_data *data,
 		dev_err(&data->client->dev, "Error writing reg_int_6\n");
 		return ret;
 	}
-	data->slope_thres = val;
+	event->slope.threshold = val;
 
 	dev_dbg(&data->client->dev, "%s: %x\n", __func__, val);
 
 	return ret;
 }
 
-static int bmc150_accel_update_slope_duration(struct bmc150_accel_data *data,
+static int bmc150_accel_update_slope_duration(struct bmc150_accel_event *event,
+					      struct bmc150_accel_data *data,
 					      int val)
 {
 	int ret;
@@ -326,7 +344,7 @@ static int bmc150_accel_update_slope_duration(struct bmc150_accel_data *data,
 		dev_err(&data->client->dev, "Error write reg_int_5\n");
 		return ret;
 	}
-	data->slope_dur = val;
+	event->slope.duration = val;
 
 	dev_dbg(&data->client->dev, "%s: %x\n", __func__, val);
 
@@ -372,12 +390,12 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 	data->range = BMC150_ACCEL_DEF_RANGE_4G;
 
 	/* Set default slope duration and thresholds */
-	ret = bmc150_accel_update_slope_duration(data,
+	ret = bmc150_accel_update_slope_duration(&data->events[0], data,
 					 BMC150_ACCEL_DEF_SLOPE_DURATION);
 	if (ret < 0)
 		return ret;
 
-	ret = bmc150_accel_update_slope_threshold(data,
+	ret = bmc150_accel_update_slope_threshold(&data->events[0], data,
 					  BMC150_ACCEL_DEF_SLOPE_THRESHOLD);
 	if (ret < 0)
 		return ret;
@@ -713,22 +731,30 @@ static int bmc150_accel_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int bmc150_accel_read_event(struct iio_dev *indio_dev,
-				   const struct iio_chan_spec *chan,
-				   enum iio_event_type type,
-				   enum iio_event_direction dir,
-				   enum iio_event_info info,
-				   int *val, int *val2)
+static struct bmc150_accel_event*
+bmc150_accel_get_event(struct iio_dev *indio_dev, enum iio_event_type type)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	int i;
+
+	for (i = 0; i < BMC150_ACCEL_EVENTS; i++)
+		if (data->events[i].type == type)
+			return &data->events[i];
+
+	return NULL;
+}
 
+static int bmc150_accel_event_roc_read(struct bmc150_accel_event *event,
+				       enum iio_event_info info,
+				       int *val, int *val2)
+{
 	*val2 = 0;
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
-		*val = data->slope_thres;
+		*val = event->slope.threshold;
 		break;
 	case IIO_EV_INFO_PERIOD:
-		*val = data->slope_dur;
+		*val = event->slope.duration;
 		break;
 	default:
 		return -EINVAL;
@@ -737,28 +763,40 @@ static int bmc150_accel_read_event(struct iio_dev *indio_dev,
 	return IIO_VAL_INT;
 }
 
-static int bmc150_accel_write_event(struct iio_dev *indio_dev,
-				    const struct iio_chan_spec *chan,
-				    enum iio_event_type type,
-				    enum iio_event_direction dir,
-				    enum iio_event_info info,
-				    int val, int val2)
+static int bmc150_accel_read_event(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int *val, int *val2)
 {
-	struct bmc150_accel_data *data = iio_priv(indio_dev);
-	int ret;
+	struct bmc150_accel_event *event;
 
-	if (data->ev_enable_state)
-		return -EBUSY;
+	event = bmc150_accel_get_event(indio_dev, type);
+	if (!event || !event->read)
+		return -EINVAL;
+
+	return event->read(event, info, val, val2);
+}
+
+static int bmc150_accel_event_roc_write(struct bmc150_accel_event *event,
+					enum iio_event_info info,
+					int val, int val2)
+{
+	struct bmc150_accel_data *data = event->data;
+	int ret;
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		mutex_lock(&data->mutex);
-		ret = bmc150_accel_update_slope_threshold(data, val);
+		ret = bmc150_accel_update_slope_threshold(event, event->data,
+							  val);
 		mutex_unlock(&data->mutex);
 		break;
 	case IIO_EV_INFO_PERIOD:
 		mutex_lock(&data->mutex);
-		ret = bmc150_accel_update_slope_duration(data, val);
+		ret = bmc150_accel_update_slope_duration(event, event->data,
+							 val);
 		mutex_unlock(&data->mutex);
 		break;
 	default:
@@ -768,15 +806,37 @@ static int bmc150_accel_write_event(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int bmc150_accel_write_event(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int val, int val2)
+{
+	struct bmc150_accel_event *event;
+
+	event = bmc150_accel_get_event(indio_dev, type);
+	if (!event || !event->write)
+		return -EINVAL;
+
+	if (event->enabled)
+		return -EBUSY;
+
+	return event->write(event, info, val, val2);
+}
+
 static int bmc150_accel_read_event_config(struct iio_dev *indio_dev,
 					  const struct iio_chan_spec *chan,
 					  enum iio_event_type type,
 					  enum iio_event_direction dir)
 {
+	struct bmc150_accel_event *event;
 
-	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	event = bmc150_accel_get_event(indio_dev, type);
+	if (!event)
+		return -EINVAL;
 
-	return data->ev_enable_state;
+	return event->enabled;
 }
 
 static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
@@ -786,15 +846,20 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
 					   int state)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	struct bmc150_accel_event *event;
 	int ret;
 
-	if (state == data->ev_enable_state)
+	event = bmc150_accel_get_event(indio_dev, type);
+	if (!event)
+		return -EINVAL;
+
+	if (state == event->enabled)
 		return 0;
 
 	mutex_lock(&data->mutex);
-	ret = bmc150_accel_set_interrupt(data, &data->interrupts[1], state);
+	ret = bmc150_accel_set_interrupt(data, event->intr, state);
 	if (!ret)
-		data->ev_enable_state = state;
+		event->enabled = state;
 	mutex_unlock(&data->mutex);
 
 	return ret;
@@ -826,12 +891,14 @@ static const struct attribute_group bmc150_accel_attrs_group = {
 	.attrs = bmc150_accel_attributes,
 };
 
-static const struct iio_event_spec bmc150_accel_event = {
+static const struct iio_event_spec bmc150_accel_events[BMC150_ACCEL_EVENTS] = {
+	{
 		.type = IIO_EV_TYPE_ROC,
 		.dir = IIO_EV_DIR_RISING | IIO_EV_DIR_FALLING,
 		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
 				 BIT(IIO_EV_INFO_ENABLE) |
 				 BIT(IIO_EV_INFO_PERIOD)
+	},
 };
 
 #define BMC150_ACCEL_CHANNEL(_axis, bits) {				\
@@ -848,8 +915,8 @@ static const struct iio_event_spec bmc150_accel_event = {
 		.storagebits = 16,					\
 		.shift = 16 - (bits),					\
 	},								\
-	.event_spec = &bmc150_accel_event,				\
-	.num_event_specs = 1						\
+	.event_spec = bmc150_accel_events,				\
+	.num_event_specs = ARRAY_SIZE(bmc150_accel_events)		\
 }
 
 #define BMC150_ACCEL_CHANNELS(bits) {					\
@@ -1091,7 +1158,7 @@ static irqreturn_t bmc150_accel_data_rdy_trig_poll(int irq, void *private)
 		}
 	}
 
-	if (data->ev_enable_state)
+	if (data->events[0].enabled)
 		return IRQ_WAKE_THREAD;
 	else
 		return IRQ_HANDLED;
@@ -1203,6 +1270,38 @@ static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static struct {
+	int intr;
+	enum iio_event_type type;
+	int (*read)(struct bmc150_accel_event *event, enum iio_event_info info,
+		    int *val, int *val2);
+	int (*write)(struct bmc150_accel_event *event, enum iio_event_info info,
+		     int val, int val2);
+} bmc150_accel_events_info[BMC150_ACCEL_EVENTS] = {
+	{
+		.intr = 1,
+		.type = IIO_EV_TYPE_ROC,
+		.read = bmc150_accel_event_roc_read,
+		.write = bmc150_accel_event_roc_write,
+	},
+};
+
+static void bmc150_accel_events_setup(struct iio_dev *indio_dev,
+				      struct bmc150_accel_data *data)
+{
+	int i;
+
+	for (i = 0; i < BMC150_ACCEL_EVENTS; i++) {
+		int intr = bmc150_accel_events_info[i].intr;
+
+		data->events[i].intr = &data->interrupts[intr];
+		data->events[i].data = data;
+		data->events[i].type = bmc150_accel_events_info[i].type;
+		data->events[i].read = bmc150_accel_events_info[i].read;
+		data->events[i].write = bmc150_accel_events_info[i].write;
+	}
+}
+
 static int bmc150_accel_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
@@ -1277,6 +1376,8 @@ static int bmc150_accel_probe(struct i2c_client *client,
 		if (ret)
 			return ret;
 
+		bmc150_accel_events_setup(indio_dev, data);
+
 		ret = iio_triggered_buffer_setup(indio_dev,
 						 &iio_pollfunc_store_time,
 						 bmc150_accel_trigger_handler,
-- 
1.9.1

