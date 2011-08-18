Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: capfun: fix - mask must be type u64
Date: Thu, 18 Aug 2011 14:01:43 +0200
Message-ID: <1313668903-18115-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

mask must be type u64 otherwise it won't hold a full event code

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/iio_core.h          |    2 +-
 drivers/staging/iio/industrialio-core.c |    9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
index 433952b..85ac5b2 100644
--- a/drivers/staging/iio/iio_core.h
+++ b/drivers/staging/iio/iio_core.h
@@ -33,7 +33,7 @@ int __iio_add_chan_devattr(const char *postfix,
 						struct device_attribute *attr,
 						const char *buf,
 						size_t len),
-			   int mask,
+			   u64 mask,
 			   bool generic,
 			   struct device *dev,
 			   struct list_head *attr_list);
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 4aa538f..35e81f8 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -519,7 +519,7 @@ int __iio_add_chan_devattr(const char *postfix,
 						struct device_attribute *attr,
 						const char *buf,
 						size_t len),
-			   int mask,
+			   u64 mask,
 			   bool generic,
 			   struct device *dev,
 			   struct list_head *attr_list)
@@ -643,7 +643,7 @@ static int iio_device_register_sysfs(struct iio_dev *dev_info)
 	else
 		ret = sysfs_create_group(&dev_info->dev.kobj,
 					 &iio_base_dummy_group);
-	
+
 	if (ret) {
 		dev_err(dev_info->dev.parent,
 			"Failed to register sysfs hooks\n");
@@ -663,7 +663,7 @@ static int iio_device_register_sysfs(struct iio_dev *dev_info)
 			if (ret < 0)
 				goto error_clear_attrs;
 		}
-	if (dev_info->name) { 
+	if (dev_info->name) {
 		ret = sysfs_add_file_to_group(&dev_info->dev.kobj,
 					      &dev_attr_name.attr,
 					      NULL);
@@ -796,7 +796,8 @@ static ssize_t iio_ev_value_store(struct device *dev,
 static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 				      struct iio_chan_spec const *chan)
 {
-	int ret = 0, i, mask = 0;
+	int ret = 0, i;
+	u64 mask = 0;
 	char *postfix;
 	if (!chan->event_mask)
 		return 0;
-- 
1.7.0.4
