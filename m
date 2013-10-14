Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-150.synserver.de ([212.40.185.150]:1043 "EHLO
	smtp-out-150.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756507Ab3JNQrf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2013 12:47:35 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Denis Ciocca <denis.ciocca@st.com>,
	Marek Vasut <marex@denx.de>,
	Zubair Lutfullah <zubair.lutfullah@gmail.com>,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH 01/17] iio: Update buffer's bytes per datum after updating the scan mask
Date: Mon, 14 Oct 2013 18:49:14 +0200
Message-Id: <1381769370-17100-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently a IIO device driver needs to make sure to update the buffer's bytes
per datum after the scan mask has changed. This is usually done in the preenable
callback by invoking iio_sw_buffer_preenable(). This is something that needs to
be done and is done for virtually all devices which support buffers (we
currently have only one exception). Also this a bit of a layering violation
since we have to call the buffer setup ops from the device setup ops. This
requires the device driver to know about the internal requirements of the buffer
(e.g. whether we need to call the set_bytes_per_datum) callback. And especially
with in-kernel buffer consumers, which allows to attach arbitrary buffers to a
device, this is something that the driver can't know.

Moving this to the core allows us to drop the individual calls to
iio_sw_buffer_preenable() from drivers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
---
 drivers/iio/industrialio-buffer.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 796376a..186f501 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -492,6 +492,20 @@ void iio_disable_all_buffers(struct iio_dev *indio_dev)
 		indio_dev->setup_ops->postdisable(indio_dev);
 }
 
+static void iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
+	struct iio_buffer *buffer)
+{
+	unsigned int bytes;
+
+	if (!buffer->access->set_bytes_per_datum)
+		return;
+
+	bytes = iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
+		buffer->scan_timestamp);
+
+	buffer->access->set_bytes_per_datum(buffer, bytes);
+}
+
 static int __iio_update_buffers(struct iio_dev *indio_dev,
 		       struct iio_buffer *insert_buffer,
 		       struct iio_buffer *remove_buffer)
@@ -589,7 +603,8 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 		iio_compute_scan_bytes(indio_dev,
 				       indio_dev->active_scan_mask,
 				       indio_dev->scan_timestamp);
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list)
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		iio_buffer_update_bytes_per_datum(indio_dev, buffer);
 		if (buffer->access->request_update) {
 			ret = buffer->access->request_update(buffer);
 			if (ret) {
@@ -598,6 +613,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 				goto error_run_postdisable;
 			}
 		}
+	}
 	if (indio_dev->info->update_scan_mode) {
 		ret = indio_dev->info
 			->update_scan_mode(indio_dev,
-- 
1.8.0

