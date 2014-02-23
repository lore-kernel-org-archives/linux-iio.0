Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47623 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514AbaBWTuf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 23 Feb 2014 14:50:35 -0500
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 2/5] IIO: core: Modify scan element type
Date: Sun, 23 Feb 2014 11:50:45 -0800
Message-Id: <1393185048-4004-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1393185048-4004-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1393185048-4004-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The current scan element type uses the following format:
  [be|le]:[s|u]bits/storagebits[>>shift].
To specify multiple elements in this type, added a repeat value.
So new format is:
  [be|le]:([s|u]bits/storagebits){repeat}[>>shift].
Here repeat is specifying how may times, real/storage bits are repeating.

When repeat is value is 0 or 1, then repeat value is not used in the format,
and it will be same as existing format.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/industrialio-buffer.c | 41 +++++++++++++++++++++++++++++++++------
 include/linux/iio/iio.h           |  9 +++++++++
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index c67d83b..598eacd 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -150,7 +150,16 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 		type = IIO_BE;
 #endif
 	}
-	return sprintf(buf, "%s:%c%d/%d>>%u\n",
+	if (this_attr->c->scan_type.repeat > 1)
+		return sprintf(buf, "%s:(%c%d/%d){%d}>>%u\n",
+		       iio_endian_prefix[type],
+		       this_attr->c->scan_type.sign,
+		       this_attr->c->scan_type.realbits,
+		       this_attr->c->scan_type.storagebits,
+		       this_attr->c->scan_type.repeat,
+		       this_attr->c->scan_type.shift);
+		else
+			return sprintf(buf, "%s:%c%d/%d>>%u\n",
 		       iio_endian_prefix[type],
 		       this_attr->c->scan_type.sign,
 		       this_attr->c->scan_type.realbits,
@@ -475,14 +484,22 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 	for_each_set_bit(i, mask,
 			 indio_dev->masklength) {
 		ch = iio_find_channel_from_si(indio_dev, i);
-		length = ch->scan_type.storagebits / 8;
+		if (ch->scan_type.repeat > 1)
+			length = ch->scan_type.storagebits / 8 *
+				ch->scan_type.repeat;
+		else
+			length = ch->scan_type.storagebits / 8;
 		bytes = ALIGN(bytes, length);
 		bytes += length;
 	}
 	if (timestamp) {
 		ch = iio_find_channel_from_si(indio_dev,
 					      indio_dev->scan_index_timestamp);
-		length = ch->scan_type.storagebits / 8;
+		if (ch->scan_type.repeat > 1)
+			length = ch->scan_type.storagebits / 8 *
+				ch->scan_type.repeat;
+		else
+			length = ch->scan_type.storagebits / 8;
 		bytes = ALIGN(bytes, length);
 		bytes += length;
 	}
@@ -961,7 +978,11 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 					       indio_dev->masklength,
 					       in_ind + 1);
 			ch = iio_find_channel_from_si(indio_dev, in_ind);
-			length = ch->scan_type.storagebits/8;
+			if (ch->scan_type.repeat > 1)
+				length = ch->scan_type.storagebits / 8 *
+					ch->scan_type.repeat;
+			else
+				length = ch->scan_type.storagebits / 8;
 			/* Make sure we are aligned */
 			in_loc += length;
 			if (in_loc % length)
@@ -973,7 +994,11 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 			goto error_clear_mux_table;
 		}
 		ch = iio_find_channel_from_si(indio_dev, in_ind);
-		length = ch->scan_type.storagebits/8;
+		if (ch->scan_type.repeat > 1)
+			length = ch->scan_type.storagebits / 8 *
+				ch->scan_type.repeat;
+		else
+			length = ch->scan_type.storagebits / 8;
 		if (out_loc % length)
 			out_loc += length - out_loc % length;
 		if (in_loc % length)
@@ -994,7 +1019,11 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 		}
 		ch = iio_find_channel_from_si(indio_dev,
 			indio_dev->scan_index_timestamp);
-		length = ch->scan_type.storagebits/8;
+		if (ch->scan_type.repeat > 1)
+			length = ch->scan_type.storagebits / 8 *
+				ch->scan_type.repeat;
+		else
+			length = ch->scan_type.storagebits / 8;
 		if (out_loc % length)
 			out_loc += length - out_loc % length;
 		if (in_loc % length)
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index ddf9f60..3f1a83c 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -177,6 +177,14 @@ struct iio_event_spec {
  *			shift:		Shift right by this before masking out
  *					realbits.
  *			endianness:	little or big endian
+ *			repeat:		No. of times real/storage bits repeats.
+ *					By default, when repeat is set to 0
+ *					repeat value is treated as 1. When
+ *					repeat value is 0 or 1, then there is
+ *					no change in existing scan element
+ *					type, in sysfs. When set to more than
+ *					1, then the type element in sysfs will
+ *					show repeat value.
  * @info_mask_separate: What information is to be exported that is specific to
  *			this channel.
  * @info_mask_shared_by_type: What information is to be exported that is shared
@@ -219,6 +227,7 @@ struct iio_chan_spec {
 		u8	realbits;
 		u8	storagebits;
 		u8	shift;
+		u8	repeat;
 		enum iio_endian endianness;
 	} scan_type;
 	long			info_mask_separate;
-- 
1.8.3.2

