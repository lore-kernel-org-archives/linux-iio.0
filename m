Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/7] staging:iio: make iio_sw_buffer_preenable much more general.
Date: Mon,  5 Dec 2011 21:37:13 +0000
Message-Id: <1323121036-21094-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1323121036-21094-1-git-send-email-jic23@kernel.org>
References: <1323121036-21094-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Also introduces active_scan_mask storage to tell the core what is
really being currently captured from the device (different from
what is desired as often has bonus channels).

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Tested-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/iio.h                 |    2 +
 drivers/staging/iio/industrialio-buffer.c |   63 +++++++++++++++++------------
 2 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 4fb8f2f..c225542 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -280,6 +280,7 @@ struct iio_info {
  * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
  * @masklength:		[INTERN] the length of the mask established from
  *			channels
+ * @active_scan_mask:	[INTERN] union of all scan masks requested by buffers
  * @trig:		[INTERN] current device trigger (buffer modes)
  * @pollfunc:		[DRIVER] function run on trigger being received
  * @channels:		[DRIVER] channel specification structure table
@@ -307,6 +308,7 @@ struct iio_dev {
 
 	unsigned long			*available_scan_masks;
 	unsigned			masklength;
+	unsigned long			*active_scan_mask;
 	struct iio_trigger		*trig;
 	struct iio_poll_func		*pollfunc;
 
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index b2cf3e3..e088a5c 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -531,32 +531,6 @@ ssize_t iio_buffer_show_enable(struct device *dev,
 }
 EXPORT_SYMBOL(iio_buffer_show_enable);
 
-int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
-{
-	struct iio_buffer *buffer = indio_dev->buffer;
-	size_t size;
-	dev_dbg(&indio_dev->dev, "%s\n", __func__);
-	/* Check if there are any scan elements enabled, if not fail*/
-	if (!(buffer->scan_count || buffer->scan_timestamp))
-		return -EINVAL;
-	if (buffer->scan_timestamp)
-		if (buffer->scan_count)
-			/* Timestamp (aligned to s64) and data */
-			size = (((buffer->scan_count * buffer->bpe)
-					+ sizeof(s64) - 1)
-				& ~(sizeof(s64) - 1))
-				+ sizeof(s64);
-		else /* Timestamp only  */
-			size = sizeof(s64);
-	else /* Data only */
-		size = buffer->scan_count * buffer->bpe;
-	buffer->access->set_bytes_per_datum(buffer, size);
-
-	return 0;
-}
-EXPORT_SYMBOL(iio_sw_buffer_preenable);
-
-
 /* note NULL used as error indicator as it doesn't make sense. */
 static unsigned long *iio_scan_mask_match(unsigned long *av_masks,
 					  unsigned int masklength,
@@ -572,6 +546,43 @@ static unsigned long *iio_scan_mask_match(unsigned long *av_masks,
 	return NULL;
 }
 
+int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer = indio_dev->buffer;
+	const struct iio_chan_spec *ch;
+	unsigned bytes = 0;
+	int length, i;
+	dev_dbg(&indio_dev->dev, "%s\n", __func__);
+
+	/* How much space will the demuxed element take? */
+	for_each_set_bit(i, buffer->scan_mask,
+			 indio_dev->masklength) {
+		ch = iio_find_channel_from_si(indio_dev, i);
+		length = ch->scan_type.storagebits/8;
+		bytes = ALIGN(bytes, length);
+		bytes += length;
+	}
+	if (buffer->scan_timestamp) {
+		ch = iio_find_channel_from_si(indio_dev,
+					      buffer->scan_index_timestamp);
+		length = ch->scan_type.storagebits/8;
+		bytes = ALIGN(bytes, length);
+		bytes += length;
+	}
+	buffer->access->set_bytes_per_datum(buffer, bytes);
+
+	/* What scan mask do we actually have ?*/
+	if (indio_dev->available_scan_masks)
+		indio_dev->active_scan_mask =
+			iio_scan_mask_match(indio_dev->available_scan_masks,
+					    indio_dev->masklength,
+					    buffer->scan_mask);
+	else
+		indio_dev->active_scan_mask = buffer->scan_mask;
+	return 0;
+}
+EXPORT_SYMBOL(iio_sw_buffer_preenable);
+
 /**
  * iio_scan_mask_set() - set particular bit in the scan mask
  * @buffer: the buffer whose scan mask we are interested in
-- 
1.7.7.4
