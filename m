Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:49448 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956Ab0FYPwS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Jun 2010 11:52:18 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Barry.Song@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/6] staging:iio:lis3l02dq remove unused set_ring_length function
Date: Fri, 25 Jun 2010 16:55:10 +0100
Message-Id: <1277481314-31717-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1277481314-31717-2-git-send-email-jic23@cam.ac.uk>
References: <1277481314-31717-1-git-send-email-jic23@cam.ac.uk>
 <1277481314-31717-2-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 69e2787..a33599d 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -591,12 +591,4 @@ void lis3l02dq_uninitialize_ring(struct iio_ring_buffer *ring)
 	iio_ring_buffer_unregister(ring);
 }
 
-int lis3l02dq_set_ring_length(struct iio_dev *indio_dev, int length)
-{
-	/* Set sensible defaults for the ring buffer */
-	if (indio_dev->ring->access.set_length)
-		return indio_dev->ring->access.set_length(indio_dev->ring, 500);
-	return 0;
-}
-
 
-- 
1.6.4.4

