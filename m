Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:33337 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571Ab1KARDq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Nov 2011 13:03:46 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: linus.ml.walleij@gmail.com, broonie@opensource.wolfsonmicro.com,
	arnd@arndb.de, gregkh@suse.de, dtor@mail.ru,
	thomas.petazzoni@free-electrons.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/5] staging:iio: make update buffers available outside iio.
Date: Tue,  1 Nov 2011 17:11:51 +0000
Message-Id: <1320167513-587-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1320167513-587-1-git-send-email-jic23@cam.ac.uk>
References: <1320167513-587-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This may well go away depending on exactly what the interfaces
we end up on for this are.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/buffer.h              |    4 ++++
 drivers/staging/iio/industrialio-buffer.c |    8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index cdfc15b..eca2538 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -104,6 +104,10 @@ struct iio_buffer {
 
 bool iio_is_primary_active(struct iio_dev *indio_dev);
 
+int iio_update_buffers(struct iio_dev *indio_dev,
+		       struct iio_buffer *insert_buffer,
+		       struct iio_buffer *remove_buffer);
+
 /**
  * iio_buffer_init() - Initialize the buffer structure
  * @buffer: buffer to be initialized
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index b02a463..d4597f6 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -444,13 +444,14 @@ static unsigned long *iio_scan_mask_match(unsigned long *av_masks,
 	return NULL;
 }
 
-static int iio_update_buffers(struct iio_dev *indio_dev,
-			      struct iio_buffer *insert_buffer,
-			      struct iio_buffer *remove_buffer)
+int iio_update_buffers(struct iio_dev *indio_dev,
+		       struct iio_buffer *insert_buffer,
+		       struct iio_buffer *remove_buffer)
 {
 	int ret;
 	struct iio_buffer *buffer;
 	unsigned long *compound_mask;
+
 /* Wind down existing buffers - iff there are any */
 
 	if (!list_empty(&indio_dev->buffer_list)) {
@@ -572,6 +573,7 @@ error_free_compound_mask:
 error_ret:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iio_update_buffers);
 
 ssize_t iio_buffer_store_enable(struct device *dev,
 				struct device_attribute *attr,
-- 
1.7.7

