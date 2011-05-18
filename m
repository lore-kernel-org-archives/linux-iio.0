Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53941 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933195Ab1ERNkE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:04 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 030/111] staging:iio:ring_sw add function needed for threaded irq.
Date: Wed, 18 May 2011 14:41:20 +0100
Message-Id: <1305726161-5606-31-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_sw.c |   14 ++++++++++----
 drivers/staging/iio/ring_sw.h |    1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 40beadd..d55757b 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -455,11 +455,8 @@ int iio_sw_ring_preenable(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL(iio_sw_ring_preenable);
 
-void iio_sw_trigger_bh_to_ring(struct work_struct *work_s)
+void iio_sw_trigger_to_ring(struct iio_sw_ring_helper_state *st)
 {
-	struct iio_sw_ring_helper_state *st
-		= container_of(work_s, struct iio_sw_ring_helper_state,
-			work_trigger_to_ring);
 	struct iio_ring_buffer *ring = st->indio_dev->ring;
 	int len = 0;
 	size_t datasize = ring->access.get_bytes_per_datum(ring);
@@ -488,6 +485,15 @@ void iio_sw_trigger_bh_to_ring(struct work_struct *work_s)
 
 	return;
 }
+EXPORT_SYMBOL(iio_sw_trigger_to_ring);
+
+void iio_sw_trigger_bh_to_ring(struct work_struct *work_s)
+{
+	struct iio_sw_ring_helper_state *st
+		= container_of(work_s, struct iio_sw_ring_helper_state,
+			work_trigger_to_ring);
+	iio_sw_trigger_to_ring(st);
+}
 EXPORT_SYMBOL(iio_sw_trigger_bh_to_ring);
 
 void iio_sw_poll_func_th(struct iio_dev *indio_dev, s64 time)
diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index 7d56524..84b7c5a 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -216,6 +216,7 @@ struct iio_sw_ring_helper_state {
 
 void iio_sw_poll_func_th(struct iio_dev *indio_dev, s64 time);
 void iio_sw_trigger_bh_to_ring(struct work_struct *work_s);
+void iio_sw_trigger_to_ring(struct iio_sw_ring_helper_state *st);
 
 #else /* CONFIG_IIO_RING_BUFFER*/
 struct iio_sw_ring_helper_state {
-- 
1.7.3.4

