Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/5] staging:iio:fine iio channel from scan index util function
Date: Thu, 20 Oct 2011 17:29:26 +0100
Message-Id: <1319128169-3722-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319128169-3722-1-git-send-email-jic23@cam.ac.uk>
References: <1319128169-3722-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Useful for getting to the channel based on scan mask alone.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    8 ++++++++
 drivers/staging/iio/industrialio-core.c |   11 +++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index f3d88cd..429589f 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -322,6 +322,14 @@ struct iio_dev {
 };
 
 /**
+ * iio_find_channel_from_si() - get channel from its scan index
+ * @indio_dev:		device
+ * @si:			scan index to match
+ */
+const struct iio_chan_spec
+*iio_find_channel_from_si(struct iio_dev *indio_dev, int si);
+
+/**
  * iio_device_register() - register a device with the IIO subsystem
  * @indio_dev:		Device structure filled by the device driver
  **/
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 326e967..00ef005 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -88,6 +88,17 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_AVERAGE_RAW_SHARED/2] = "mean_raw",
 };
 
+const struct iio_chan_spec
+*iio_find_channel_from_si(struct iio_dev *indio_dev, int si)
+{
+	int i;
+
+	for (i = 0; i < indio_dev->num_channels; i++)
+		if (indio_dev->channels[i].scan_index == si)
+			return &indio_dev->channels[i];
+	return NULL;
+}
+
 /**
  * struct iio_detected_event_list - list element for events that have occurred
  * @list:		linked list header
-- 
1.7.7
