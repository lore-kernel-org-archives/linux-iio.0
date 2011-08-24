Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/8] staging:iio:kfifo buffer - push structure definition down into implementation.
Date: Wed, 24 Aug 2011 17:34:07 +0100
Message-Id: <1314203654-22377-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314203654-22377-1-git-send-email-jic23@cam.ac.uk>
References: <1314203654-22377-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Nothing other than the implementation needs to know about this.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/kfifo_buf.c |    8 ++++++++
 drivers/staging/iio/kfifo_buf.h |    8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index 6002368..3c9516b 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -8,6 +8,14 @@
 
 #include "kfifo_buf.h"
 
+struct iio_kfifo {
+	struct iio_ring_buffer ring;
+	struct kfifo kf;
+	int use_count;
+	int update_needed;
+	struct mutex use_lock;
+};
+
 #define iio_to_kfifo(r) container_of(r, struct iio_kfifo, ring)
 
 static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
diff --git a/drivers/staging/iio/kfifo_buf.h b/drivers/staging/iio/kfifo_buf.h
index aac3053..fb48523 100644
--- a/drivers/staging/iio/kfifo_buf.h
+++ b/drivers/staging/iio/kfifo_buf.h
@@ -3,14 +3,6 @@
 #include "iio.h"
 #include "ring_generic.h"
 
-struct iio_kfifo {
-	struct iio_ring_buffer ring;
-	struct kfifo kf;
-	int use_count;
-	int update_needed;
-	struct mutex use_lock;
-};
-
 extern const struct iio_ring_access_funcs kfifo_access_funcs;
 
 struct iio_ring_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev);
-- 
1.7.3.4
