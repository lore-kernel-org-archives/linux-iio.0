Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 17/19] staging:iio:ring_sw: Fix incorrect test on successful read of last value, causes infinite loop
Date: Mon, 26 Apr 2010 21:08:08 +0100
Message-Id: <1272312490-9791-18-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1272312490-9791-17-git-send-email-jic23@cam.ac.uk>
References: <1272312490-9791-1-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-2-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-3-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-4-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-5-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-6-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-7-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-8-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-9-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-10-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-11-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-12-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-13-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-14-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-15-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-16-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-17-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_sw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 4e5134c..8d2f7cd 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -297,7 +297,7 @@ again:
 		return -EAGAIN;
 	memcpy(data, last_written_p_copy, ring->buf.bpd);
 
-	if (unlikely(ring->last_written_p >= last_written_p_copy))
+	if (unlikely(ring->last_written_p != last_written_p_copy))
 		goto again;
 
 	iio_unmark_sw_rb_in_use(&ring->buf);
-- 
1.6.4.4
