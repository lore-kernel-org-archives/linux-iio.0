Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41001 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab2DRNOC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:14:02 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 02/14] staging:iio:buffer: pull computation of scan length into a utility function.
Date: Wed, 18 Apr 2012 14:13:42 +0100
Message-Id: <1334754834-13622-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1334754834-13622-1-git-send-email-jic23@kernel.org>
References: <1334754834-13622-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Principal reason is to make later patches more coherent and easier to review
but this set in itself separates a logical entity out nicely wihin the code.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/industrialio-buffer.c |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 59b0caf..639b41a 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -508,30 +508,41 @@ static const unsigned long *iio_scan_mask_match(const unsigned long *av_masks,
 	return NULL;
 }
 
-int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
+static int iio_compute_scan_bytes(struct iio_dev *indio_dev, const long *mask,
+				  bool timestamp)
 {
-	struct iio_buffer *buffer = indio_dev->buffer;
 	const struct iio_chan_spec *ch;
 	unsigned bytes = 0;
 	int length, i;
-	dev_dbg(&indio_dev->dev, "%s\n", __func__);
 
 	/* How much space will the demuxed element take? */
-	for_each_set_bit(i, buffer->scan_mask,
+	for_each_set_bit(i, mask,
 			 indio_dev->masklength) {
 		ch = iio_find_channel_from_si(indio_dev, i);
-		length = ch->scan_type.storagebits/8;
+		length = ch->scan_type.storagebits / 8;
 		bytes = ALIGN(bytes, length);
 		bytes += length;
 	}
-	if (buffer->scan_timestamp) {
+	if (timestamp) {
 		ch = iio_find_channel_from_si(indio_dev,
-					      buffer->scan_index_timestamp);
-		length = ch->scan_type.storagebits/8;
+					      indio_dev
+					      ->buffer->scan_index_timestamp);
+		length = ch->scan_type.storagebits / 8;
 		bytes = ALIGN(bytes, length);
 		bytes += length;
 	}
+	return bytes;
+}
+
+int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer = indio_dev->buffer;
+	unsigned bytes;
+	dev_dbg(&indio_dev->dev, "%s\n", __func__);
+
+	/* How much space will the demuxed element take? */
+	bytes = iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
+				       buffer->scan_timestamp);
 	buffer->access->set_bytes_per_datum(buffer, bytes);
 
 	/* What scan mask do we actually have ?*/
-- 
1.7.0.4

