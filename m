Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-020.synserver.de ([212.40.185.20]:1084 "EHLO
	smtp-out-017.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755303Ab3JGOJw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 10:09:52 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 14/20] staging:iio:simple_dummy: Switch to new event config interface
Date: Mon,  7 Oct 2013 16:11:28 +0200
Message-Id: <1381155094-20166-14-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-1-git-send-email-lars@metafoo.de>
References: <1381155094-20166-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Switch the simple_dummy driver to the new IIO event config interface as the old
one is going to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/iio_simple_dummy.c        | 30 ++++++++++------
 drivers/staging/iio/iio_simple_dummy.h        | 22 ++++++++----
 drivers/staging/iio/iio_simple_dummy_events.c | 49 +++++++++++++++++++--------
 3 files changed, 70 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index 141ec61..cdb8898 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -57,6 +57,20 @@ static const struct iio_dummy_accel_calibscale dummy_scales[] = {
 	{ 733, 13, 0x9 }, /* 733.000013 */
 };
 
+#ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
+
+/*
+ * simple event - triggered when value rises above
+ * a threshold
+ */
+static const struct iio_event_spec iio_dummy_event = {
+	.type = IIO_EV_TYPE_THRESH,
+	.dir = IIO_EV_DIR_RISING,
+	.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
+};
+
+#endif
+
 /*
  * iio_dummy_channels - Description of available channels
  *
@@ -104,12 +118,8 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 			.shift = 0, /* zero shift */
 		},
 #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
-		/*
-		 * simple event - triggered when value rises above
-		 * a threshold
-		 */
-		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH,
-					 IIO_EV_DIR_RISING),
+		.event_spec = &iio_dummy_event,
+		.num_event_specs = 1,
 #endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS */
 	},
 	/* Differential ADC channel in_voltage1-voltage2_raw etc*/
@@ -360,10 +370,10 @@ static const struct iio_info iio_dummy_info = {
 	.read_raw = &iio_dummy_read_raw,
 	.write_raw = &iio_dummy_write_raw,
 #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
-	.read_event_config = &iio_simple_dummy_read_event_config,
-	.write_event_config = &iio_simple_dummy_write_event_config,
-	.read_event_value = &iio_simple_dummy_read_event_value,
-	.write_event_value = &iio_simple_dummy_write_event_value,
+	.read_event_config_new = &iio_simple_dummy_read_event_config,
+	.write_event_config_new = &iio_simple_dummy_write_event_config,
+	.read_event_value_new = &iio_simple_dummy_read_event_value,
+	.write_event_value_new = &iio_simple_dummy_write_event_value,
 #endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS */
 };
 
diff --git a/drivers/staging/iio/iio_simple_dummy.h b/drivers/staging/iio/iio_simple_dummy.h
index c9e8702..b126196 100644
--- a/drivers/staging/iio/iio_simple_dummy.h
+++ b/drivers/staging/iio/iio_simple_dummy.h
@@ -45,19 +45,29 @@ struct iio_dummy_state {
 struct iio_dev;
 
 int iio_simple_dummy_read_event_config(struct iio_dev *indio_dev,
-				       u64 event_code);
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir);
 
 int iio_simple_dummy_write_event_config(struct iio_dev *indio_dev,
-					u64 event_code,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir,
 					int state);
 
 int iio_simple_dummy_read_event_value(struct iio_dev *indio_dev,
-				      u64 event_code,
-				      int *val);
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      enum iio_event_info info, int *val,
+				      int *val2);
 
 int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
-				       u64 event_code,
-				       int val);
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir,
+				       enum iio_event_info info, int val,
+				       int val2);
 
 int iio_simple_dummy_events_register(struct iio_dev *indio_dev);
 int iio_simple_dummy_events_unregister(struct iio_dev *indio_dev);
diff --git a/drivers/staging/iio/iio_simple_dummy_events.c b/drivers/staging/iio/iio_simple_dummy_events.c
index 317b774..812ebd0 100644
--- a/drivers/staging/iio/iio_simple_dummy_events.c
+++ b/drivers/staging/iio/iio_simple_dummy_events.c
@@ -23,13 +23,17 @@
 /**
  * iio_simple_dummy_read_event_config() - is event enabled?
  * @indio_dev: the device instance data
- * @event_code: event code of the event being queried
+ * @chan: channel for the event whose state is being queried
+ * @type: type of the event whose state is being queried
+ * @dir: direction of the vent whose state is being queried
  *
  * This function would normally query the relevant registers or a cache to
  * discover if the event generation is enabled on the device.
  */
 int iio_simple_dummy_read_event_config(struct iio_dev *indio_dev,
-				       u64 event_code)
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir)
 {
 	struct iio_dummy_state *st = iio_priv(indio_dev);
 
@@ -39,7 +43,9 @@ int iio_simple_dummy_read_event_config(struct iio_dev *indio_dev,
 /**
  * iio_simple_dummy_write_event_config() - set whether event is enabled
  * @indio_dev: the device instance data
- * @event_code: event code of event being enabled/disabled
+ * @chan: channel for the event whose state is being set
+ * @type: type of the event whose state is being set
+ * @dir: direction of the vent whose state is being set
  * @state: whether to enable or disable the device.
  *
  * This function would normally set the relevant registers on the devices
@@ -47,7 +53,9 @@ int iio_simple_dummy_read_event_config(struct iio_dev *indio_dev,
  * value.
  */
 int iio_simple_dummy_write_event_config(struct iio_dev *indio_dev,
-					u64 event_code,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir,
 					int state)
 {
 	struct iio_dummy_state *st = iio_priv(indio_dev);
@@ -56,12 +64,11 @@ int iio_simple_dummy_write_event_config(struct iio_dev *indio_dev,
 	 *  Deliberately over the top code splitting to illustrate
 	 * how this is done when multiple events exist.
 	 */
-	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	switch (chan->type) {
 	case IIO_VOLTAGE:
-		switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+		switch (type) {
 		case IIO_EV_TYPE_THRESH:
-			if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			    IIO_EV_DIR_RISING)
+			if (dir == IIO_EV_DIR_RISING)
 				st->event_en = state;
 			else
 				return -EINVAL;
@@ -79,7 +86,10 @@ int iio_simple_dummy_write_event_config(struct iio_dev *indio_dev,
 /**
  * iio_simple_dummy_read_event_value() - get value associated with event
  * @indio_dev: device instance specific data
- * @event_code: event code for the event whose value is being queried
+ * @chan: channel for the event whose value is being read
+ * @type: type of the event whose value is being read
+ * @dir: direction of the vent whose value is being read
+ * @info: info type of the event whose value is being read
  * @val: value for the event code.
  *
  * Many devices provide a large set of events of which only a subset may
@@ -89,25 +99,34 @@ int iio_simple_dummy_write_event_config(struct iio_dev *indio_dev,
  * the enabled event is changed.
  */
 int iio_simple_dummy_read_event_value(struct iio_dev *indio_dev,
-				      u64 event_code,
-				      int *val)
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+					  enum iio_event_info info,
+				      int *val, int *val2)
 {
 	struct iio_dummy_state *st = iio_priv(indio_dev);
 
 	*val = st->event_val;
 
-	return 0;
+	return IIO_VAL_INT;
 }
 
 /**
  * iio_simple_dummy_write_event_value() - set value associate with event
  * @indio_dev: device instance specific data
- * @event_code: event code for the event whose value is being set
+ * @chan: channel for the event whose value is being set
+ * @type: type of the event whose value is being set
+ * @dir: direction of the vent whose value is being set
+ * @info: info type of the event whose value is being set
  * @val: the value to be set.
  */
 int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
-				       u64 event_code,
-				       int val)
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir,
+					   enum iio_event_info info,
+				       int val, int val2)
 {
 	struct iio_dummy_state *st = iio_priv(indio_dev);
 
-- 
1.8.0

