Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:44081 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368AbaLUAoF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 20 Dec 2014 19:44:05 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v2 02/11] iio: buffer: refactor buffer attributes setup
Date: Sun, 21 Dec 2014 02:42:27 +0200
Message-Id: <1419122556-8100-3-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move all core (non-cusotm) buffer attributes to a vector to make it
easier to add more of them in the future.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/iio/industrialio-buffer.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 403b728..bc55434 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -759,6 +759,11 @@ static struct device_attribute dev_attr_length_ro = __ATTR(length,
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
@@ -776,21 +781,23 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
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

