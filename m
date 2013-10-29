Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:35478 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825Ab3J2BAD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 28 Oct 2013 21:00:03 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/4] iio: Fix mag3110 scan_type
Date: Tue, 29 Oct 2013 01:59:54 +0100
Message-Id: <1383008397-8721-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

last argument of IIO_ST is shift, not endianness

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/magnetometer/mag3110.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 783c5b4..becf544 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -250,7 +250,12 @@ done:
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
 		BIT(IIO_CHAN_INFO_SCALE), \
 	.scan_index = idx, \
-	.scan_type = IIO_ST('s', 16, 16, IIO_BE), \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = 16, \
+		.storagebits = 16, \
+		.endianness = IIO_BE, \
+	}, \
 }
 
 static const struct iio_chan_spec mag3110_channels[] = {
-- 
1.8.4.1

