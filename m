Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-219.synserver.de ([212.40.185.219]:1194 "EHLO
	smtp-out-217.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752668Ab2KTNhE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Nov 2012 08:37:04 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/7] iio: Factor out fixed point number parsing into its own function
Date: Tue, 20 Nov 2012 14:36:50 +0100
Message-Id: <1353418611-17614-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1353418611-17614-1-git-send-email-lars@metafoo.de>
References: <1353418611-17614-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Factor out the code for parsing fixed point numbers into its own function and
make this function globally available. This allows us to reuse the code to parse
fixed point numbers in individual IIO drivers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c | 98 ++++++++++++++++++++++++++---------------
 include/linux/iio/iio.h         |  3 ++
 2 files changed, 66 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 3dccd6c..8848f16 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -408,6 +408,64 @@ static ssize_t iio_read_channel_info(struct device *dev,
 	}
 }
 
+/**
+ * iio_str_to_fixpoint() - Parse a fixed-point number from a string
+ * @str: The string to parse
+ * @fract_mult: Multiplier for the first decimal place, should be a power of 10
+ * @integer: The integer part of the number
+ * @fract: The fractional part of the number
+ *
+ * Returns 0 on success, or a negative error code if the string could not be
+ * parsed.
+ */
+int iio_str_to_fixpoint(const char *str, int fract_mult,
+	int *integer, int *fract)
+{
+	int i = 0, f = 0;
+	bool integer_part = true, negative = false;
+
+	if (str[0] == '-') {
+		negative = true;
+		str++;
+	} else if (str[0] == '+') {
+		str++;
+	}
+
+	while (*str) {
+		if ('0' <= *str && *str <= '9') {
+			if (integer_part) {
+				i = i * 10 + *str - '0';
+			} else {
+				f += fract_mult * (*str - '0');
+				fract_mult /= 10;
+			}
+		} else if (*str == '\n') {
+			if (*(str + 1) == '\0')
+				break;
+			else
+				return -EINVAL;
+		} else if (*str == '.' && integer_part) {
+			integer_part = false;
+		} else {
+			return -EINVAL;
+		}
+		str++;
+	}
+
+	if (negative) {
+		if (i)
+			i = -i;
+		else
+			f = -f;
+	}
+
+	*integer = i;
+	*fract = f;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_str_to_fixpoint);
+
 static ssize_t iio_write_channel_info(struct device *dev,
 				      struct device_attribute *attr,
 				      const char *buf,
@@ -415,8 +473,8 @@ static ssize_t iio_write_channel_info(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret, integer = 0, fract = 0, fract_mult = 100000;
-	bool integer_part = true, negative = false;
+	int ret, fract_mult = 100000;
+	int integer, fract;
 
 	/* Assumes decimal - precision based on number of digits */
 	if (!indio_dev->info->write_raw)
@@ -435,39 +493,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
 			return -EINVAL;
 		}
 
-	if (buf[0] == '-') {
-		negative = true;
-		buf++;
-	} else if (buf[0] == '+') {
-		buf++;
-	}
-
-	while (*buf) {
-		if ('0' <= *buf && *buf <= '9') {
-			if (integer_part)
-				integer = integer*10 + *buf - '0';
-			else {
-				fract += fract_mult*(*buf - '0');
-				fract_mult /= 10;
-			}
-		} else if (*buf == '\n') {
-			if (*(buf + 1) == '\0')
-				break;
-			else
-				return -EINVAL;
-		} else if (*buf == '.' && integer_part) {
-			integer_part = false;
-		} else {
-			return -EINVAL;
-		}
-		buf++;
-	}
-	if (negative) {
-		if (integer)
-			integer = -integer;
-		else
-			fract = -fract;
-	}
+	ret = iio_str_to_fixpoint(buf, fract_mult, &integer, &fract);
+	if (ret)
+		return ret;
 
 	ret = indio_dev->info->write_raw(indio_dev, this_attr->c,
 					 integer, fract, this_attr->address);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index adca93a..da8c776 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -620,6 +620,9 @@ static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
 };
 #endif
 
+int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
+	int *fract);
+
 /**
  * IIO_DEGREE_TO_RAD() - Convert degree to rad
  * @deg: A value in degree
-- 
1.8.0

