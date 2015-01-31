Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60030 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753926AbbAaAA2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 30 Jan 2015 19:00:28 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v3 1/9] iio: buffer: refactor buffer attributes setup
Date: Sat, 31 Jan 2015 02:00:00 +0200
Message-Id: <1422662408-8149-2-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com>
References: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move all core (non-custom) buffer attributes to a vector to make it
easier to add more of them in the future.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/iio/industrialio-buffer.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 7133314..c2d5440 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -761,6 +761,11 @@ static struct device_attribute dev_attr_length_ro = __ATTR(length,
 static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
 		   iio_buffer_show_enable, iio_buffer_store_enable);
 
+static struct attribute *iio_buffer_attrs[] = {
+	&dev_attr_length.attr,
+	&dev_attr_enable.attr,
+};
+
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
 	struct iio_dev_attr *p;
@@ -778,21 +783,23 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 			attrcount++;
 	}
 
-	buffer->buffer_group.name = "buffer";
-	buffer->buffer_group.attrs = kcalloc(attrcount + 3,
-			sizeof(*buffer->buffer_group.attrs), GFP_KERNEL);
-	if (!buffer->buffer_group.attrs)
+	attr = kcalloc(attrcount + ARRAY_SIZE(iio_buffer_attrs) + 1,
+		       sizeof(struct attribute *), GFP_KERNEL);
+	if (!attr)
 		return -ENOMEM;
 
-	if (buffer->access->set_length)
-		buffer->buffer_group.attrs[0] = &dev_attr_length.attr;
-	else
-		buffer->buffer_group.attrs[0] = &dev_attr_length_ro.attr;
-	buffer->buffer_group.attrs[1] = &dev_attr_enable.attr;
+	memcpy(attr, iio_buffer_attrs, sizeof(iio_buffer_attrs));
+	if (!buffer->access->set_length)
+		attr[0] = &dev_attr_length_ro.attr;
+
 	if (buffer->attrs)
-		memcpy(&buffer->buffer_group.attrs[2], buffer->attrs,
-			sizeof(*&buffer->buffer_group.attrs) * attrcount);
-	buffer->buffer_group.attrs[attrcount+2] = NULL;
+		memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
+		       sizeof(struct attribute *) * attrcount);
+
+	attr[attrcount + ARRAY_SIZE(iio_buffer_attrs)] = NULL;
+
+	buffer->buffer_group.name = "buffer";
+	buffer->buffer_group.attrs = attr;
 
 	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
 
-- 
1.9.1

