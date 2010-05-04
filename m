Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 16/20] staging:iio:ring_sw: Fix incorrect test on successful read of last value, causes infinite loop
Date: Tue,  4 May 2010 14:43:11 +0100
Message-Id: <1272980595-11033-17-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1272980595-11033-16-git-send-email-jic23@cam.ac.uk>
References: <1272980595-11033-1-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-2-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-3-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-4-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-5-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-6-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-7-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-8-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-9-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-10-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-11-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-12-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-13-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-14-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-15-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-16-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_sw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index f8de45d..5ee3e45 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -295,7 +295,7 @@ again:
 		return -EAGAIN;
 	memcpy(data, last_written_p_copy, ring->buf.bpd);
 
-	if (unlikely(ring->last_written_p >= last_written_p_copy))
+	if (unlikely(ring->last_written_p != last_written_p_copy))
 		goto again;
 
 	iio_unmark_sw_rb_in_use(&ring->buf);
-- 
1.6.4.4
