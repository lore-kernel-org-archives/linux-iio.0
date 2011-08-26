Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 06/14] staging:iio:trivial add a string array for IIO_RAW and IIO_PROCESSED.
Date: Fri, 26 Aug 2011 11:05:40 +0100
Message-Id: <1314353148-6670-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353148-6670-1-git-send-email-jic23@cam.ac.uk>
References: <1314353148-6670-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Introduce IIO_RAW and IIO_PROCESSED and an array for their strings.
Also move one function to just above where it is called.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    5 +++
 drivers/staging/iio/industrialio-core.c |   57 ++++++++++++++----------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 098d827..1c24d13 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -22,6 +22,11 @@
  * Currently assumes nano seconds.
  */
 
+enum iio_data_type {
+	IIO_RAW,
+	IIO_PROCESSED,
+};
+
 enum iio_chan_type {
 	/* real channel types */
 	IIO_IN,
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 8b8e1fb..e83d626 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -37,6 +37,11 @@ struct bus_type iio_bus_type = {
 };
 EXPORT_SYMBOL(iio_bus_type);
 
+static const char * const iio_data_type_name[] = {
+	[IIO_RAW] = "raw",
+	[IIO_PROCESSED] = "input",
+};
+
 static const char * const iio_chan_type_name_spec_shared[] = {
 	[IIO_IN] = "in",
 	[IIO_OUT] = "out",
@@ -253,16 +258,6 @@ static int iio_event_getfd(struct iio_dev *indio_dev)
 				indio_dev->event_interface, O_RDONLY);
 }
 
-static void iio_setup_ev_int(struct iio_event_interface *ev_int)
-{
-	mutex_init(&ev_int->event_list_lock);
-	/* discussion point - make this variable? */
-	ev_int->max_events = 10;
-	ev_int->current_events = 0;
-	INIT_LIST_HEAD(&ev_int->det_events);
-	init_waitqueue_head(&ev_int->wait);
-}
-
 static int __init iio_init(void)
 {
 	int ret;
@@ -584,26 +579,18 @@ static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
 {
 	int ret, i;
 
-
 	if (chan->channel < 0)
 		return 0;
-	if (chan->processed_val)
-		ret = __iio_add_chan_devattr("input", NULL, chan,
-					     &iio_read_channel_info,
-					     NULL,
-					     0,
-					     0,
-					     &dev_info->dev,
-					     &dev_info->channel_attr_list);
-	else
-		ret = __iio_add_chan_devattr("raw", NULL, chan,
-					     &iio_read_channel_info,
-					     (chan->type == IIO_OUT ?
-					     &iio_write_channel_info : NULL),
-					     0,
-					     0,
-					     &dev_info->dev,
-					     &dev_info->channel_attr_list);
+
+	ret = __iio_add_chan_devattr(iio_data_type_name[chan->processed_val],
+				     NULL, chan,
+				     &iio_read_channel_info,
+				     (chan->type == IIO_OUT ?
+				      &iio_write_channel_info : NULL),
+				     0,
+				     0,
+				     &dev_info->dev,
+				     &dev_info->channel_attr_list);
 	if (ret)
 		goto error_ret;
 
@@ -815,7 +802,6 @@ static ssize_t iio_ev_value_store(struct device *dev,
 static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 				      struct iio_chan_spec const *chan)
 {
-
 	int ret = 0, i, mask = 0;
 	char *postfix;
 	if (!chan->event_mask)
@@ -908,10 +894,10 @@ static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info)
 {
 	int j;
 	int ret;
+
 	INIT_LIST_HEAD(&dev_info->event_interface->dev_attr_list);
 	/* Dynically created from the channels array */
 	for (j = 0; j < dev_info->num_channels; j++) {
-
 		ret = iio_device_add_event_sysfs(dev_info,
 						 &dev_info->channels[j]);
 		if (ret)
@@ -937,12 +923,23 @@ static struct attribute_group iio_events_dummy_group = {
 static bool iio_check_for_dynamic_events(struct iio_dev *dev_info)
 {
 	int j;
+
 	for (j = 0; j < dev_info->num_channels; j++)
 		if (dev_info->channels[j].event_mask != 0)
 			return true;
 	return false;
 }
 
+static void iio_setup_ev_int(struct iio_event_interface *ev_int)
+{
+	mutex_init(&ev_int->event_list_lock);
+	/* discussion point - make this variable? */
+	ev_int->max_events = 10;
+	ev_int->current_events = 0;
+	INIT_LIST_HEAD(&ev_int->det_events);
+	init_waitqueue_head(&ev_int->wait);
+}
+
 static int iio_device_register_eventset(struct iio_dev *dev_info)
 {
 	int ret = 0;
-- 
1.7.3.4
