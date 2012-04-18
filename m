Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41009 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab2DRNOC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:14:02 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 03/14] staging:iio: scan_index_timestamp move to iio_dev from buffer
Date: Wed, 18 Apr 2012 14:13:43 +0100
Message-Id: <1334754834-13622-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1334754834-13622-1-git-send-email-jic23@kernel.org>
References: <1334754834-13622-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is just a locally cached value that is device specific (rather
than buffer specific.) Hence it wants to come out of the buffer before
we add multiple buffer support.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/buffer.h              |    2 --
 drivers/staging/iio/iio.h                 |    2 ++
 drivers/staging/iio/industrialio-buffer.c |    7 +++----
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index df2046d..3d3ea9e 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -56,7 +56,6 @@ struct iio_buffer_access_funcs {
  * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
  *			control method is used
  * @scan_mask:		[INTERN] bitmask used in masking scan mode elements
- * @scan_index_timestamp:[INTERN] cache of the index to the timestamp
  * @scan_timestamp:	[INTERN] does the scan mode include a timestamp
  * @access:		[DRIVER] buffer access functions associated with the
  *			implementation.
@@ -74,7 +73,6 @@ struct iio_buffer {
 	struct attribute_group			*scan_el_attrs;
 	long					*scan_mask;
 	bool					scan_timestamp;
-	unsigned				scan_index_timestamp;
 	const struct iio_buffer_access_funcs	*access;
 	struct list_head			scan_el_dev_attr_list;
 	struct attribute_group			scan_el_group;
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index a562763..6832c98 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -305,6 +305,7 @@ struct iio_buffer_setup_ops {
  * @masklength:		[INTERN] the length of the mask established from
  *			channels
  * @active_scan_mask:	[INTERN] union of all scan masks requested by buffers
+ * @scan_index_timestamp:[INTERN] cache of the index to the timestamp
  * @trig:		[INTERN] current device trigger (buffer modes)
  * @pollfunc:		[DRIVER] function run on trigger being received
  * @channels:		[DRIVER] channel specification structure table
@@ -339,6 +340,7 @@ struct iio_dev {
 	const unsigned long		*available_scan_masks;
 	unsigned			masklength;
 	const unsigned long		*active_scan_mask;
+	unsigned			scan_index_timestamp;
 	struct iio_trigger		*trig;
 	struct iio_poll_func		*pollfunc;
 
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 639b41a..efa44c4 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -296,7 +296,7 @@ int iio_buffer_register(struct iio_dev *indio_dev,
 				goto error_cleanup_dynamic;
 			attrcount += ret;
 			if (channels[i].type == IIO_TIMESTAMP)
-				buffer->scan_index_timestamp =
+				indio_dev->scan_index_timestamp =
 					channels[i].scan_index;
 		}
 		if (indio_dev->masklength && buffer->scan_mask == NULL) {
@@ -525,8 +525,7 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev, const long *mask,
 	}
 	if (timestamp) {
 		ch = iio_find_channel_from_si(indio_dev,
-					      indio_dev
-					      ->buffer->scan_index_timestamp);
+					      indio_dev->scan_index_timestamp);
 		length = ch->scan_type.storagebits / 8;
 		bytes = ALIGN(bytes, length);
 		bytes += length;
@@ -721,7 +720,7 @@ int iio_update_demux(struct iio_dev *indio_dev)
 			goto error_clear_mux_table;
 		}
 		ch = iio_find_channel_from_si(indio_dev,
-			buffer->scan_index_timestamp);
+			indio_dev->scan_index_timestamp);
 		length = ch->scan_type.storagebits/8;
 		if (out_loc % length)
 			out_loc += length - out_loc % length;
-- 
1.7.0.4

