Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 01/20] iio: Factor IIO value formating into its own function
Date: Mon,  7 Oct 2013 16:11:15 +0200
Message-Id: <1381155094-20166-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/iio_core.h          |  2 ++
 drivers/iio/industrialio-core.c | 38 ++++++++++++++++++++++++++------------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 9209f47..0157686 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -34,6 +34,8 @@ int __iio_add_chan_devattr(const char *postfix,
 			   struct device *dev,
 			   struct list_head *attr_list);
 
+ssize_t iio_format_value(char *buf, unsigned int type, int val, int val2);
+
 /* Event interface flags */
 #define IIO_BUSY_BIT_POS 1
 
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 863aa01..af69723 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -362,22 +362,20 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(iio_enum_write);
 
-static ssize_t iio_read_channel_info(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
+/**
+ * iio_format_value() - Formats a IIO value into its string representation
+ * @buf: The buffer to which the formated value gets written
+ * @type: One of the IIO_VAL_... constants. This decides how the val and val2
+ *        parameters are formatted.
+ * @val: First part of the value, exact meaning depends on the type parameter.
+ * @val2: Second part of the value, exact meaning depends on the type parameter.
+ */
+ssize_t iio_format_value(char *buf, unsigned int type, int val, int val2)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	unsigned long long tmp;
-	int val, val2;
 	bool scale_db = false;
-	int ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
-					    &val, &val2, this_attr->address);
 
-	if (ret < 0)
-		return ret;
-
-	switch (ret) {
+	switch (type) {
 	case IIO_VAL_INT:
 		return sprintf(buf, "%d\n", val);
 	case IIO_VAL_INT_PLUS_MICRO_DB:
@@ -409,6 +407,22 @@ static ssize_t iio_read_channel_info(struct device *dev,
 	}
 }
 
+static ssize_t iio_read_channel_info(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int val, val2;
+	int ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
+					    &val, &val2, this_attr->address);
+
+	if (ret < 0)
+		return ret;
+
+	return iio_format_value(buf, ret, val, val2);
+}
+
 /**
  * iio_str_to_fixpoint() - Parse a fixed-point number from a string
  * @str: The string to parse
-- 
1.8.0
