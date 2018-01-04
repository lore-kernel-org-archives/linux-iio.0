Return-Path: <SRS0=B/GZ=D7=gmail.com=aishpant@kernel.org>
Date: Thu, 4 Jan 2018 20:07:14 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, Joe Perches <joe@perches.com>
Subject: [PATCH 1/5] iio: buffer: use permission specific variants of
 DEVICE_ATTR
Message-ID: <e6e4f42f8c311533ee29b02ea6207cfbac6a70b0.1515076155.git.aishpant@gmail.com>
References: <cover.1515076155.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1515076155.git.aishpant@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This is a clean-up patch which replaces DEVICE_ATTR macro with the file
permission specific DEVICE_ATTR_{RO/WO/RW} macros for compaction and
readability. Done using coccinelle.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 drivers/iio/industrialio-buffer.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index d2b465140a6b..ca565fbcff90 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -497,7 +497,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static ssize_t iio_buffer_read_length(struct device *dev,
+static ssize_t length_show(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
@@ -507,7 +507,7 @@ static ssize_t iio_buffer_read_length(struct device *dev,
 	return sprintf(buf, "%d\n", buffer->length);
 }
 
-static ssize_t iio_buffer_write_length(struct device *dev,
+static ssize_t length_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t len)
 {
@@ -540,7 +540,7 @@ static ssize_t iio_buffer_write_length(struct device *dev,
 	return ret ? ret : len;
 }
 
-static ssize_t iio_buffer_show_enable(struct device *dev,
+static ssize_t enable_show(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
@@ -1117,7 +1117,7 @@ void iio_disable_all_buffers(struct iio_dev *indio_dev)
 	iio_buffer_deactivate_all(indio_dev);
 }
 
-static ssize_t iio_buffer_store_enable(struct device *dev,
+static ssize_t enable_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf,
 				       size_t len)
@@ -1153,7 +1153,7 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 
 static const char * const iio_scan_elements_group_name = "scan_elements";
 
-static ssize_t iio_buffer_show_watermark(struct device *dev,
+static ssize_t watermark_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
@@ -1163,7 +1163,7 @@ static ssize_t iio_buffer_show_watermark(struct device *dev,
 	return sprintf(buf, "%u\n", buffer->watermark);
 }
 
-static ssize_t iio_buffer_store_watermark(struct device *dev,
+static ssize_t watermark_store(struct device *dev,
 					  struct device_attribute *attr,
 					  const char *buf,
 					  size_t len)
@@ -1198,16 +1198,13 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
 	return ret ? ret : len;
 }
 
-static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
-		   iio_buffer_write_length);
+static DEVICE_ATTR_RW(length);
 static struct device_attribute dev_attr_length_ro = __ATTR(length,
-	S_IRUGO, iio_buffer_read_length, NULL);
-static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
-		   iio_buffer_show_enable, iio_buffer_store_enable);
-static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
-		   iio_buffer_show_watermark, iio_buffer_store_watermark);
+	S_IRUGO, length_show, NULL);
+static DEVICE_ATTR_RW(enable);
+static DEVICE_ATTR_RW(watermark);
 static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
-	S_IRUGO, iio_buffer_show_watermark, NULL);
+	S_IRUGO, watermark_show, NULL);
 
 static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_length.attr,
-- 
2.15.1
