Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/16] staging:iio: remove userspace access to bytes per datum.
Date: Sun, 27 Nov 2011 13:33:31 +0000
Message-Id: <1322400825-29400-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1322400825-29400-1-git-send-email-jic23@kernel.org>
References: <1322400825-29400-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

There are no known reasons why userspace should want this value.
It can be established from the buffer description anyway.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/buffer.h              |    9 ---------
 drivers/staging/iio/industrialio-buffer.c |   15 ---------------
 drivers/staging/iio/kfifo_buf.c           |    2 --
 drivers/staging/iio/ring_sw.c             |    2 --
 4 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 97d59d9..9171735 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -193,12 +193,6 @@ ssize_t iio_buffer_write_length(struct device *dev,
 			      const char *buf,
 			      size_t len);
 /**
- * iio_buffer_read_bytes_per_datum() - attr for number of bytes in whole datum
- **/
-ssize_t iio_buffer_read_bytes_per_datum(struct device *dev,
-					struct device_attribute *attr,
-					char *buf);
-/**
  * iio_buffer_store_enable() - attr to turn the buffer on
  **/
 ssize_t iio_buffer_store_enable(struct device *dev,
@@ -214,9 +208,6 @@ ssize_t iio_buffer_show_enable(struct device *dev,
 #define IIO_BUFFER_LENGTH_ATTR DEVICE_ATTR(length, S_IRUGO | S_IWUSR,	\
 					   iio_buffer_read_length,	\
 					   iio_buffer_write_length)
-#define IIO_BUFFER_BYTES_PER_DATUM_ATTR					\
-	DEVICE_ATTR(bytes_per_datum, S_IRUGO | S_IWUSR,			\
-		    iio_buffer_read_bytes_per_datum, NULL)
 
 #define IIO_BUFFER_ENABLE_ATTR DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,	\
 					   iio_buffer_show_enable,	\
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 352f9f1..4af7f94 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -410,21 +410,6 @@ ssize_t iio_buffer_write_length(struct device *dev,
 }
 EXPORT_SYMBOL(iio_buffer_write_length);
 
-ssize_t iio_buffer_read_bytes_per_datum(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
-
-	if (buffer->access->get_bytes_per_datum)
-		return sprintf(buf, "%d\n",
-			       buffer->access->get_bytes_per_datum(buffer));
-
-	return 0;
-}
-EXPORT_SYMBOL(iio_buffer_read_bytes_per_datum);
-
 ssize_t iio_buffer_store_enable(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf,
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index fd98a0e..fb3b7ae 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -75,12 +75,10 @@ static inline void __iio_init_kfifo(struct iio_kfifo *kf)
 }
 
 static IIO_BUFFER_ENABLE_ATTR;
-static IIO_BUFFER_BYTES_PER_DATUM_ATTR;
 static IIO_BUFFER_LENGTH_ATTR;
 
 static struct attribute *iio_kfifo_attributes[] = {
 	&dev_attr_length.attr,
-	&dev_attr_bytes_per_datum.attr,
 	&dev_attr_enable.attr,
 	NULL,
 };
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 66a34ad..98fe819 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -393,13 +393,11 @@ static int iio_mark_update_needed_sw_rb(struct iio_buffer *r)
 }
 
 static IIO_BUFFER_ENABLE_ATTR;
-static IIO_BUFFER_BYTES_PER_DATUM_ATTR;
 static IIO_BUFFER_LENGTH_ATTR;
 
 /* Standard set of ring buffer attributes */
 static struct attribute *iio_ring_attributes[] = {
 	&dev_attr_length.attr,
-	&dev_attr_bytes_per_datum.attr,
 	&dev_attr_enable.attr,
 	NULL,
 };
-- 
1.7.7.3
