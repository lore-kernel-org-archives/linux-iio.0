Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-150.synserver.de ([212.40.185.150]:1047 "EHLO
	smtp-out-150.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197Ab3JNQrg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2013 12:47:36 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/17] iio:ad7887: Remove redundant call to iio_sw_buffer_preenable().
Date: Mon, 14 Oct 2013 18:49:17 +0200
Message-Id: <1381769370-17100-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-1-git-send-email-lars@metafoo.de>
References: <1381769370-17100-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
so there is no need to do this from the driver anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7887.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index faedd0e..acb7f90 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -78,11 +78,6 @@ enum ad7887_supported_device_ids {
 static int ad7887_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7887_state *st = iio_priv(indio_dev);
-	int ret;
-
-	ret = iio_sw_buffer_preenable(indio_dev);
-	if (ret < 0)
-		return ret;
 
 	/* We know this is a single long so can 'cheat' */
 	switch (*indio_dev->active_scan_mask) {
-- 
1.8.0

