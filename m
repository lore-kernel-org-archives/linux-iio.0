Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: linus.ml.walleij@gmail.com,
	broonie@opensource.wolfsonmicro.com,
	arnd@arndb.de,
	gregkh@suse.de,
	thomas.petazzoni@free-electrons.com,
	Michael.Hennerich@analog.com,
	lars@metafoo.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 6/7] staging:iio: make update buffers available outside iio.
Date: Wed, 26 Oct 2011 16:54:17 +0100
Message-Id: <1319644458-30630-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319644458-30630-1-git-send-email-jic23@cam.ac.uk>
References: <1319644458-30630-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This may well go away depending on exactly what the interfaces
we end up on for this are.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/buffer.h              |    4 ++++
 drivers/staging/iio/industrialio-buffer.c |    7 ++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

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
index ac47eba..7f52f88 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -444,9 +444,9 @@ static unsigned long *iio_scan_mask_match(unsigned long *av_masks,
         return NULL;
 }
 
-static int iio_update_buffers(struct iio_dev *indio_dev,
-                              struct iio_buffer *insert_buffer,
-                              struct iio_buffer *remove_buffer)
+int iio_update_buffers(struct iio_dev *indio_dev,
+		       struct iio_buffer *insert_buffer,
+		       struct iio_buffer *remove_buffer)
 {
         int ret;
         struct iio_buffer *buffer;
@@ -570,6 +570,7 @@ error_free_compound_mask:
 error_ret:
         return ret;
 }
+EXPORT_SYMBOL_GPL(iio_update_buffers);
 
 ssize_t iio_buffer_store_enable(struct device *dev,
 				struct device_attribute *attr,
-- 
1.7.7
