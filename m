Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:51234 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab1IWLx0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2011 07:53:26 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 04/16] staging:iio:adc:ad799x trivial: use the convenient chan struct.
Date: Fri, 23 Sep 2011 13:01:30 +0100
Message-Id: <1316779302-12357-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is much cleaner than bouncing through the various structures
to get to the same thing.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad799x_core.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 3b5f8be..517cbd9 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -159,12 +159,11 @@ static int ad799x_read_raw(struct iio_dev *dev_info,
 
 		if (ret < 0)
 			return ret;
-		*val = (ret >> st->chip_info->channel[0].scan_type.shift) &
-			RES_MASK(st->chip_info->channel[0].scan_type.realbits);
+		*val = (ret >> chan->scan_type.shift) &
+			RES_MASK(chan->scan_type.realbits);
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
-		scale_uv = (st->int_vref_mv * 1000)
-			>> st->chip_info->channel[0].scan_type.realbits;
+		scale_uv = (st->int_vref_mv * 1000) >> chan->scan_type.realbits;
 		*val =  scale_uv / 1000;
 		*val2 = (scale_uv % 1000) * 1000;
 		return IIO_VAL_INT_PLUS_MICRO;
-- 
1.7.3.4

