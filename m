Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/3] iio staging: fix trigger handler of iio_simple_dummy driver
Date: Thu, 21 Jun 2012 23:02:37 +0200
Message-Id: <1340312559-32753-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

accessing first and last channel fails:
fakedata[0] is never accessed, out-of-bound access for last channel

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/iio_simple_dummy_buffer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index fa4939c..d911960 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -75,9 +75,9 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 		for (i = 0, j = 0;
 		     i < bitmap_weight(indio_dev->active_scan_mask,
 				       indio_dev->masklength);
-		     i++) {
+		     i++, j++) {
 			j = find_next_bit(buffer->scan_mask,
-					  indio_dev->masklength, j + 1);
+					  indio_dev->masklength, j);
 			/* random access read from the 'device' */
 			data[i] = fakedata[j];
 			len += 2;
-- 
1.7.9.5
