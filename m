Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-075.synserver.de ([212.40.185.75]:1024 "EHLO
	smtp-out-048.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751241AbaKDRDV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Nov 2014 12:03:21 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] staging:iio:ade7758: Fix check if channels are enabled in prenable
Date: Tue,  4 Nov 2014 18:03:15 +0100
Message-Id: <1415120596-21704-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1415120596-21704-1-git-send-email-lars@metafoo.de>
References: <1415120596-21704-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We should check if a channel is enabled, not if no channels are enabled.

Fixes: 550268ca1111 ("staging:iio: scrap scan_count and ensure all drivers use active_scan_mask")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/meter/ade7758_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 628e902..6e90064 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -87,7 +87,7 @@ static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 {
 	unsigned channel;
 
-	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
+	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
 	channel = find_first_bit(indio_dev->active_scan_mask,
-- 
1.8.0

