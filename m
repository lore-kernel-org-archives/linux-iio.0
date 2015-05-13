Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-163.synserver.de ([212.40.185.163]:1112 "EHLO
	smtp-out-163.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933470AbbEMOE6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2015 10:04:58 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/8] iio: __iio_update_buffers: Perform request_update() only for new buffers
Date: Wed, 13 May 2015 16:04:46 +0200
Message-Id: <1431525891-19285-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1431525891-19285-1-git-send-email-lars@metafoo.de>
References: <1431525891-19285-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We only have to call the request_update() callback for a newly inserted
buffer. The configuration of the already previously active buffers will not
have changed.

This also allows us to move the request_update() call to the beginning of
__iio_update_buffers(), before any currently active buffers are stopped.
This makes the error handling a lot easier since no changes were made to
the buffer list and no rollback needs to be performed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 2afe3db..21ed316 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -575,6 +575,25 @@ static void iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
 	buffer->access->set_bytes_per_datum(buffer, bytes);
 }
 
+static int iio_buffer_request_update(struct iio_dev *indio_dev,
+	struct iio_buffer *buffer)
+{
+	int ret;
+
+	iio_buffer_update_bytes_per_datum(indio_dev, buffer);
+	if (buffer->access->request_update) {
+		ret = buffer->access->request_update(buffer);
+		if (ret) {
+			dev_dbg(&indio_dev->dev,
+			       "Buffer not started: buffer parameter update failed (%d)\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static void iio_free_scan_mask(struct iio_dev *indio_dev,
 	const unsigned long *mask)
 {
@@ -593,6 +612,12 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 	unsigned long *compound_mask;
 	const unsigned long *old_mask;
 
+	if (insert_buffer) {
+		ret = iio_buffer_request_update(indio_dev, insert_buffer);
+		if (ret)
+			return ret;
+	}
+
 	/* Wind down existing buffers - iff there are any */
 	if (!list_empty(&indio_dev->buffer_list)) {
 		if (indio_dev->setup_ops->predisable) {
@@ -678,17 +703,6 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 		iio_compute_scan_bytes(indio_dev,
 				       indio_dev->active_scan_mask,
 				       indio_dev->scan_timestamp);
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
-		iio_buffer_update_bytes_per_datum(indio_dev, buffer);
-		if (buffer->access->request_update) {
-			ret = buffer->access->request_update(buffer);
-			if (ret) {
-				dev_dbg(&indio_dev->dev,
-				       "Buffer not started: buffer parameter update failed (%d)\n", ret);
-				goto error_run_postdisable;
-			}
-		}
-	}
 	if (indio_dev->info->update_scan_mode) {
 		ret = indio_dev->info
 			->update_scan_mode(indio_dev,
-- 
1.8.0

