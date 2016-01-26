Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-188.synserver.de ([212.40.185.188]:1323 "EHLO
	smtp-out-124.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S965570AbcAZNRF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2016 08:17:05 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: Add helper function for calculating scan index storage size
Date: Tue, 26 Jan 2016 14:16:41 +0100
Message-Id: <1453814201-31557-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We have the same code for computing the scan index storage size in bytes
all over the place. Factor this out into a helper function. makes the code
a bit shorter and makes it easier to do future modifications to the
implementation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 52 ++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 139ae91..e026a09 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -512,33 +512,35 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
 	return sprintf(buf, "%d\n", iio_buffer_is_active(indio_dev->buffer));
 }
 
+static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
+	unsigned int scan_index)
+{
+	const struct iio_chan_spec *ch;
+	unsigned int bytes;
+
+	ch = iio_find_channel_from_si(indio_dev, scan_index);
+	bytes = ch->scan_type.storagebits / 8;
+	if (ch->scan_type.repeat > 1)
+		bytes *= ch->scan_type.repeat;
+	return bytes;
+}
+
 static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 				const unsigned long *mask, bool timestamp)
 {
-	const struct iio_chan_spec *ch;
 	unsigned bytes = 0;
 	int length, i;
 
 	/* How much space will the demuxed element take? */
 	for_each_set_bit(i, mask,
 			 indio_dev->masklength) {
-		ch = iio_find_channel_from_si(indio_dev, i);
-		if (ch->scan_type.repeat > 1)
-			length = ch->scan_type.storagebits / 8 *
-				ch->scan_type.repeat;
-		else
-			length = ch->scan_type.storagebits / 8;
+		length = iio_storage_bytes_for_si(indio_dev, i);
 		bytes = ALIGN(bytes, length);
 		bytes += length;
 	}
 	if (timestamp) {
-		ch = iio_find_channel_from_si(indio_dev,
-					      indio_dev->scan_index_timestamp);
-		if (ch->scan_type.repeat > 1)
-			length = ch->scan_type.storagebits / 8 *
-				ch->scan_type.repeat;
-		else
-			length = ch->scan_type.storagebits / 8;
+		length = iio_storage_bytes_for_si(indio_dev,
+			indio_dev->scan_index_timestamp);
 		bytes = ALIGN(bytes, length);
 		bytes += length;
 	}
@@ -1288,7 +1290,6 @@ static int iio_buffer_add_demux(struct iio_buffer *buffer,
 static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 				   struct iio_buffer *buffer)
 {
-	const struct iio_chan_spec *ch;
 	int ret, in_ind = -1, out_ind, length;
 	unsigned in_loc = 0, out_loc = 0;
 	struct iio_demux_table *p = NULL;
@@ -1315,21 +1316,11 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 			in_ind = find_next_bit(indio_dev->active_scan_mask,
 					       indio_dev->masklength,
 					       in_ind + 1);
-			ch = iio_find_channel_from_si(indio_dev, in_ind);
-			if (ch->scan_type.repeat > 1)
-				length = ch->scan_type.storagebits / 8 *
-					ch->scan_type.repeat;
-			else
-				length = ch->scan_type.storagebits / 8;
+			length = iio_storage_bytes_for_si(indio_dev, in_ind);
 			/* Make sure we are aligned */
 			in_loc = roundup(in_loc, length) + length;
 		}
-		ch = iio_find_channel_from_si(indio_dev, in_ind);
-		if (ch->scan_type.repeat > 1)
-			length = ch->scan_type.storagebits / 8 *
-				ch->scan_type.repeat;
-		else
-			length = ch->scan_type.storagebits / 8;
+		length = iio_storage_bytes_for_si(indio_dev, in_ind);
 		out_loc = roundup(out_loc, length);
 		in_loc = roundup(in_loc, length);
 		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
@@ -1340,13 +1331,8 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 	}
 	/* Relies on scan_timestamp being last */
 	if (buffer->scan_timestamp) {
-		ch = iio_find_channel_from_si(indio_dev,
+		length = iio_storage_bytes_for_si(indio_dev,
 			indio_dev->scan_index_timestamp);
-		if (ch->scan_type.repeat > 1)
-			length = ch->scan_type.storagebits / 8 *
-				ch->scan_type.repeat;
-		else
-			length = ch->scan_type.storagebits / 8;
 		out_loc = roundup(out_loc, length);
 		in_loc = roundup(in_loc, length);
 		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
-- 
2.1.4

