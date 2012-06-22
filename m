Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:52339 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761546Ab2FVHrq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 22 Jun 2012 03:47:46 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/3] iio staging: fix trigger handler of iio_simple_dummy driver
Date: Fri, 22 Jun 2012 09:47:41 +0200
Message-Id: <1340351263-5794-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

accessing first and last channel fails:
fakedata[0] is never accessed, out-of-bound access for last channel

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

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

