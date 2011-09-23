Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:51241 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423Ab1IWLx0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2011 07:53:26 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 06/16] staging:iio:adc:ad799x avoid bouncing back and forth from iio_priv space.
Date: Fri, 23 Sep 2011 13:01:32 +0100
Message-Id: <1316779302-12357-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad799x.h      |    4 ++--
 drivers/staging/iio/adc/ad799x_core.c |    2 +-
 drivers/staging/iio/adc/ad799x_ring.c |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 98f06f6..eda01d5 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -124,11 +124,11 @@ struct ad799x_platform_data {
 int ad7997_8_set_scan_mode(struct ad799x_state *st, unsigned mask);
 
 #ifdef CONFIG_AD799X_RING_BUFFER
-int ad799x_single_channel_from_ring(struct ad799x_state *st, int channum);
+int ad799x_single_channel_from_ring(struct iio_dev *indio_dev, int channum);
 int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad799x_ring_cleanup(struct iio_dev *indio_dev);
 #else /* CONFIG_AD799X_RING_BUFFER */
-int ad799x_single_channel_from_ring(struct ad799x_state *st, int channum)
+int ad799x_single_channel_from_ring(struct iio_dev *indio_dev, int channum)
 {
 	return -EINVAL;
 }
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index c615188..a24d695 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -151,7 +151,7 @@ static int ad799x_read_raw(struct iio_dev *dev_info,
 	case 0:
 		mutex_lock(&dev_info->mlock);
 		if (iio_buffer_enabled(dev_info))
-			ret = ad799x_single_channel_from_ring(st,
+			ret = ad799x_single_channel_from_ring(dev_info,
 							      chan->scan_index);
 		else
 			ret = ad799x_scan_direct(st, chan->address);
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 1bcc168..e3f4698 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -23,9 +23,9 @@
 
 #include "ad799x.h"
 
-int ad799x_single_channel_from_ring(struct ad799x_state *st, int channum)
+int ad799x_single_channel_from_ring(struct iio_dev *indio_dev, int channum)
 {
-	struct iio_buffer *ring = iio_priv_to_dev(st)->buffer;
+	struct iio_buffer *ring = indio_dev->buffer;
 	int count = 0, ret;
 	u16 *ring_data;
 
-- 
1.7.3.4

