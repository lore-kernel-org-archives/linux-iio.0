Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:48381 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757689Ab1F0J5E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2011 05:57:04 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 01/54] iio: industrialio-core: introduce IIO_VAL_INT_PLUS_NANO
Date: Mon, 27 Jun 2011 11:04:11 +0100
Message-Id: <1309169104-22139-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    1 +
 drivers/staging/iio/industrialio-core.c |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 38f1425..78a0927 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -202,6 +202,7 @@ static inline s64 iio_get_time_ns(void)
  * call to iio_device_register. */
 #define IIO_VAL_INT 1
 #define IIO_VAL_INT_PLUS_MICRO 2
+#define IIO_VAL_INT_PLUS_NANO 3
 
 /**
  * struct iio_info - constant information about device
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 94d3bfa..e5a7663 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -396,6 +396,11 @@ static ssize_t iio_read_channel_info(struct device *dev,
 			return sprintf(buf, "-%d.%06u\n", val, -val2);
 		else
 			return sprintf(buf, "%d.%06u\n", val, val2);
+	} else if (ret == IIO_VAL_INT_PLUS_NANO) {
+		if (val2 < 0)
+			return sprintf(buf, "-%d.%09u\n", val, -val2);
+		else
+			return sprintf(buf, "%d.%09u\n", val, val2);
 	} else
 		return 0;
 }
-- 
1.7.3.4

