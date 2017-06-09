Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:60958 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbdFIMIu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Jun 2017 08:08:50 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1] iio: core: Use __sysfs_match_string() helper
Date: Fri,  9 Jun 2017 15:08:16 +0300
Message-Id: <20170609120816.22106-1-andriy.shevchenko@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use __sysfs_match_string() helper instead of open coded variant.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4a1de59d153a..15c86a8cd704 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -478,21 +478,16 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 	size_t len)
 {
 	const struct iio_enum *e = (const struct iio_enum *)priv;
-	unsigned int i;
 	int ret;
 
 	if (!e->set)
 		return -EINVAL;
 
-	for (i = 0; i < e->num_items; i++) {
-		if (sysfs_streq(buf, e->items[i]))
-			break;
-	}
-
-	if (i == e->num_items)
-		return -EINVAL;
+	ret = __sysfs_match_string(e->items, e->num_items, buf);
+	if (ret < 0)
+		return ret;
 
-	ret = e->set(indio_dev, chan, i);
+	ret = e->set(indio_dev, chan, ret);
 	return ret ? ret : len;
 }
 EXPORT_SYMBOL_GPL(iio_enum_write);
-- 
2.11.0

