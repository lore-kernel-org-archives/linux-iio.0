Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:max1363 Fix two bugs in single_channel_from_ring
Date: Sun, 16 May 2010 21:29:25 +0100
Message-Id: <1274041765-6512-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Reported-by: Michael Hennerich <Michael.Hennerich@analog.com>
---

This patch contains fixes for the two bugs Michael pointed
out last week.  As the other suggestion Michael made is
not a bug fix (just a much more sensible way of handling
things), I'll do that as a separate patch soon.

The bugs were introduced with the abi changes.

 drivers/staging/iio/adc/max1363_ring.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index c8aa011..56688dc 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -51,15 +51,15 @@ int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
 	/* Need a count of channels prior to this one */
 	mask >>= 1;
 	while (mask) {
-		if (mask && st->current_mode->modemask)
+		if (mask & st->current_mode->modemask)
 			count++;
 		mask >>= 1;
 	}
 	if (st->chip_info->bits != 8)
-		return ((int)(ring_data[count*2 + 0] & 0x0F) << 8)
+		ret = ((int)(ring_data[count*2 + 0] & 0x0F) << 8)
 			+ (int)(ring_data[count*2 + 1]);
 	else
-		return ring_data[count];
+		ret = ring_data[count];
 
 error_free_ring_data:
 	kfree(ring_data);
-- 
1.7.0.4
