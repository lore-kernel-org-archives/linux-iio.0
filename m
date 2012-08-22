Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42908 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634Ab2HVThX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 22 Aug 2012 15:37:23 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] staging iio: fix potential memory leak in lis3l02dq_ring.c
Date: Wed, 22 Aug 2012 21:37:18 +0200
Message-Id: <1345664238-5446-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 18d108f..f3da590 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -121,8 +121,10 @@ static int lis3l02dq_get_buffer_element(struct iio_dev *indio_dev,
 	if (rx_array == NULL)
 		return -ENOMEM;
 	ret = lis3l02dq_read_all(indio_dev, rx_array);
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(rx_array);
 		return ret;
+	}
 	for (i = 0; i < scan_count; i++)
 		data[i] = combine_8_to_16(rx_array[i*4+1],
 					rx_array[i*4+3]);
-- 
1.7.9.5

