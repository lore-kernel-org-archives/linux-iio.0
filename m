Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/2] RFC add naming to channels
Date: Thu, 28 Apr 2011 15:24:22 +0100
Message-Id: <1304000663-5176-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304000663-5176-1-git-send-email-jic23@cam.ac.uk>
References: <1304000663-5176-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

---
 drivers/staging/iio/iio.h               |   26 ++++++++++++++++++++++-
 drivers/staging/iio/industrialio-core.c |   34 +++++++++++++++++++++---------
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 7f94197..210577e 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -35,6 +35,7 @@ enum iio_chan_type {
 	IIO_GYRO,
 	IIO_MAGN,
 	IIO_LIGHT,
+	IIO_INTENSITY,
 	IIO_PROXIMITY,
 	IIO_TEMP,
 	IIO_INCLI,
@@ -91,6 +92,8 @@ struct iio_chan_spec {
 	} scan_type;
 	const long info_mask;
 	const long event_mask;
+	const char *extend_name;
+	unsigned processed_val:1;
 };
 /* Meant for internal use only */
 void __iio_device_attr_deinit(struct device_attribute *dev_attr);
@@ -113,12 +116,33 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 			.address = _address,				\
 			.scan_index = _si, .scan_type = _stype }
 
-#define IIO_CHAN_EV(_type, _chan, _inf_mask, _address, _si,		\
+#define IIO_CHAN_EV(_type, _chan, _inf_mask, _address, _si,	\
 		    _stype, _event_mask)				\
 	{ .type = _type,						\
 			.channel = _chan,				\
 			.info_mask = _inf_mask,				\
 			.address = _address,				\
+			.scan_type = _stype,				\
+			.event_mask = _event_mask }
+
+#define IIO_CHAN_UNPROC_EV(_type, _name, _chan, _inf_mask, _address, _si,	\
+			   _stype, _event_mask)				\
+	{ .type = _type,						\
+			.extend_name = _name,				\
+			.channel = _chan,				\
+			.info_mask = _inf_mask,				\
+			.address = _address,				\
+			.scan_index = _si, .scan_type = _stype,		\
+			.event_mask = _event_mask }
+
+#define IIO_CHAN_PROC_EV(_type, _name, _chan, _inf_mask, _address, _si,	\
+			 _stype, _event_mask)				\
+	{ .type = _type,						\
+			.extend_name = _name,				\
+			.processed_val = 1,				\
+			.channel = _chan,				\
+			.info_mask = _inf_mask,				\
+			.address = _address,				\
 			.scan_index = _si, .scan_type = _stype,		\
 			.event_mask = _event_mask }
 
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index b9776de..c7edb12 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -67,6 +67,8 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_INCLI] = "incli_%c",
 	[IIO_ROT] = "rot_%c",
 	[IIO_ANGL] = "angl_%c",
+	[IIO_INTENSITY] = "intensity%d",
+	[IIO_LIGHT] = "illuminance%d",
 };
 
 /* relies on pairs of these shared then separate */
@@ -468,6 +470,11 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 			= kasprintf(GFP_KERNEL, "%s_%s",
 				    iio_chan_type_name_spec_shared[chan->type],
 				    postfix);
+	else if (chan->extend_name)
+		name_format = kasprintf(GFP_KERNEL, "%s_%s_%s",
+					iio_chan_type_name_spec[chan->type],
+					chan->extend_name,
+					postfix);
 	else
 		name_format = kasprintf(GFP_KERNEL, "%s_%s",
 					iio_chan_type_name_spec[chan->type],
@@ -476,7 +483,6 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-
 	dev_attr->attr.name = kasprintf(GFP_KERNEL,
 					name_format,
 					chan->channel,
@@ -572,17 +578,24 @@ static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
 {
 	int ret, i;
 
-
 	if (chan->channel < 0)
 		return 0;
-
-	ret = __iio_add_chan_devattr("raw", NULL, chan,
-				     &iio_read_channel_info,
-				     NULL,
-				     0,
-				     0,
-				     &dev_info->dev,
-				     &dev_info->channel_attr_list);
+	if (chan->processed_val)
+		ret = __iio_add_chan_devattr("input", NULL, chan,
+					     &iio_read_channel_info,
+					     NULL,
+					     0,
+					     0,
+					     &dev_info->dev,
+					     &dev_info->channel_attr_list);
+	else
+		ret = __iio_add_chan_devattr("raw", NULL, chan,
+					     &iio_read_channel_info,
+					     NULL,
+					     0,
+					     0,
+					     &dev_info->dev,
+					     &dev_info->channel_attr_list);
 	if (ret)
 		goto error_ret;
 
@@ -824,6 +837,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 		switch (chan->type) {
 			/* Switch this to a table at some point */
 		case IIO_IN:
+		case IIO_INTENSITY:
 			mask = IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
 						    i/IIO_EV_TYPE_MAX,
 						    i%IIO_EV_TYPE_MAX);
-- 
1.7.3.4
