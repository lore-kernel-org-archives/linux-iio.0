Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, <jic23@cam.ac.uk>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH] iio: industrialio-core: introduce IIO_VAL_INT_PLUS_NANO
Date: Mon, 6 Jun 2011 09:25:14 +0200
Message-ID: <1307345114-2340-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

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
1.7.0.4
