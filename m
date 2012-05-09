Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:19266 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755354Ab2EIKgS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2012 06:36:18 -0400
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/3] iio: core: introduce dB scle: IIO_VAL_INT_PLUS_MICRO_DB
Date: Wed, 9 May 2012 12:36:12 +0200
Message-ID: <1336559774-21136-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/industrialio-core.c |   19 +++++++++++++------
 include/linux/iio/types.h       |    1 +
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 72e33b8..e799d35 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -306,26 +306,33 @@ static ssize_t iio_read_channel_info(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int val, val2;
+	bool scale_db = false;
 	int ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
 					    &val, &val2, this_attr->address);
 
 	if (ret < 0)
 		return ret;
 
-	if (ret == IIO_VAL_INT)
+	switch (ret) {
+	case IIO_VAL_INT:
 		return sprintf(buf, "%d\n", val);
-	else if (ret == IIO_VAL_INT_PLUS_MICRO) {
+	case IIO_VAL_INT_PLUS_MICRO_DB:
+		scale_db = true;
+	case IIO_VAL_INT_PLUS_MICRO:
 		if (val2 < 0)
-			return sprintf(buf, "-%d.%06u\n", val, -val2);
+			return sprintf(buf, "-%d.%06u%s\n", val, -val2,
+				scale_db ? " dB" : "");
 		else
-			return sprintf(buf, "%d.%06u\n", val, val2);
-	} else if (ret == IIO_VAL_INT_PLUS_NANO) {
+			return sprintf(buf, "%d.%06u%s\n", val, val2,
+				scale_db ? " dB" : "");
+	case IIO_VAL_INT_PLUS_NANO:
 		if (val2 < 0)
 			return sprintf(buf, "-%d.%09u\n", val, -val2);
 		else
 			return sprintf(buf, "%d.%09u\n", val, val2);
-	} else
+	default:
 		return 0;
+	}
 }
 
 static ssize_t iio_write_channel_info(struct device *dev,
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index a471fd5..1b073b1 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -50,5 +50,6 @@ enum iio_modifier {
 #define IIO_VAL_INT 1
 #define IIO_VAL_INT_PLUS_MICRO 2
 #define IIO_VAL_INT_PLUS_NANO 3
+#define IIO_VAL_INT_PLUS_MICRO_DB 4
 
 #endif /* _IIO_TYPES_H_ */
-- 
1.7.0.4


