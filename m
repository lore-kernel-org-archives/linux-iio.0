Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:47927 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab1GRNuF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2011 09:50:05 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, manuel.stahl@iis.fraunhofer.de,
	device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/7] staging:iio:kfifo buffer - push structure definition down into implementation.
Date: Mon, 18 Jul 2011 14:49:59 +0100
Message-Id: <1310997004-22728-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310997004-22728-1-git-send-email-jic23@cam.ac.uk>
References: <1310997004-22728-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

