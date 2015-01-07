Return-Path: <k.wrona@samsung.com>
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>,
 Karol Wrona <k.wrona@samsung.com>
Subject: [RFC PATCH] iio: Add new operating mode for non triggered sw buffers
Date: Wed, 07 Jan 2015 19:36:11 +0100
Message-id: <1420655771-22465-1-git-send-email-k.wrona@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

There was a need for non triggered software buffer type.  It can be used when
triggered model does not fit and INDIO_BUFFER_HARDWARE causes confusion because
the data stream can be obtained not directly form hardware backend.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Karol Wrona <k.wrona@samsung.com>
---
 drivers/iio/industrialio-buffer.c |    2 ++
 include/linux/iio/iio.h           |    6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index f971f79..15e6de3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -680,6 +680,8 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 		indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
 	} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE) {
 		indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
+	} else if (indio_dev->modes & INDIO_BUFFER_SOFTWARE) {
+		indio_dev->currentmode = INDIO_BUFFER_SOFTWARE;
 	} else { /* Should never be reached */
 		ret = -EINVAL;
 		goto error_run_postdisable;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 3642ce7..55e63fd 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -284,10 +284,11 @@ static inline s64 iio_get_time_ns(void)
 /* Device operating modes */
 #define INDIO_DIRECT_MODE		0x01
 #define INDIO_BUFFER_TRIGGERED		0x02
+#define INDIO_BUFFER_SOFTWARE		0x04
 #define INDIO_BUFFER_HARDWARE		0x08
 
 #define INDIO_ALL_BUFFER_MODES					\
-	(INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE)
+	(INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE | INDIO_BUFFER_SOFTWARE)
 
 #define INDIO_MAX_RAW_ELEMENTS		4
 
@@ -591,7 +592,8 @@ void devm_iio_trigger_free(struct device *dev, struct iio_trigger *iio_trig);
 static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
 {
 	return indio_dev->currentmode
-		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE);
+		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
+		   INDIO_BUFFER_SOFTWARE);
 }
 
 /**
-- 
1.7.9.5
