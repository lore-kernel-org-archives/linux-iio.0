Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-175.synserver.de ([212.40.185.175]:1092 "EHLO
	smtp-out-171.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934649AbaGQP7t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Jul 2014 11:59:49 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] iio: buffer: Coalesce adjacent demux table entries
Date: Thu, 17 Jul 2014 17:59:49 +0200
Message-Id: <1405612789-27964-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1405612789-27964-1-git-send-email-lars@metafoo.de>
References: <1405612789-27964-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When copying multiple multiple samples that are adjacent in both the source as
well as the destination buffer, instead of creating a new demux table entry for
each sample just increase the length of the previous entry by the size of the
new sample. This makes the demuxing process slightly more efficient.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 47 +++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 5063703..779e5b3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -942,13 +942,34 @@ int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
 }
 EXPORT_SYMBOL_GPL(iio_push_to_buffers);
 
+static int iio_buffer_add_demux(struct iio_buffer *buffer,
+	struct iio_demux_table **p, unsigned int in_loc, unsigned int out_loc,
+	unsigned int length)
+{
+
+	if (*p && (*p)->from + (*p)->length == in_loc &&
+		(*p)->to + (*p)->length == out_loc) {
+		(*p)->length += length;
+	} else {
+		*p = kmalloc(sizeof(*p), GFP_KERNEL);
+		if (*p == NULL)
+			return -ENOMEM;
+		(*p)->from = in_loc;
+		(*p)->to = out_loc;
+		(*p)->length = length;
+		list_add_tail(&(*p)->l, &buffer->demux_list);
+	}
+
+	return 0;
+}
+
 static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 				   struct iio_buffer *buffer)
 {
 	const struct iio_chan_spec *ch;
 	int ret, in_ind = -1, out_ind, length;
 	unsigned in_loc = 0, out_loc = 0;
-	struct iio_demux_table *p;
+	struct iio_demux_table *p = NULL;
 
 	/* Clear out any old demux */
 	iio_buffer_demux_free(buffer);
@@ -981,11 +1002,6 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 			/* Make sure we are aligned */
 			in_loc = roundup(in_loc, length) + length;
 		}
-		p = kmalloc(sizeof(*p), GFP_KERNEL);
-		if (p == NULL) {
-			ret = -ENOMEM;
-			goto error_clear_mux_table;
-		}
 		ch = iio_find_channel_from_si(indio_dev, in_ind);
 		if (ch->scan_type.repeat > 1)
 			length = ch->scan_type.storagebits / 8 *
@@ -994,20 +1010,14 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 			length = ch->scan_type.storagebits / 8;
 		out_loc = roundup(out_loc, length);
 		in_loc = roundup(in_loc, length);
-		p->from = in_loc;
-		p->to = out_loc;
-		p->length = length;
-		list_add_tail(&p->l, &buffer->demux_list);
+		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
+		if (ret)
+			goto error_clear_mux_table;
 		out_loc += length;
 		in_loc += length;
 	}
 	/* Relies on scan_timestamp being last */
 	if (buffer->scan_timestamp) {
-		p = kmalloc(sizeof(*p), GFP_KERNEL);
-		if (p == NULL) {
-			ret = -ENOMEM;
-			goto error_clear_mux_table;
-		}
 		ch = iio_find_channel_from_si(indio_dev,
 			indio_dev->scan_index_timestamp);
 		if (ch->scan_type.repeat > 1)
@@ -1017,10 +1027,9 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 			length = ch->scan_type.storagebits / 8;
 		out_loc = roundup(out_loc, length);
 		in_loc = roundup(in_loc, length);
-		p->from = in_loc;
-		p->to = out_loc;
-		p->length = length;
-		list_add_tail(&p->l, &buffer->demux_list);
+		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
+		if (ret)
+			goto error_clear_mux_table;
 		out_loc += length;
 		in_loc += length;
 	}
-- 
1.8.0

