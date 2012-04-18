Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41062 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab2DRNOD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:14:03 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 12/14] staging:iio:impedance-analyser make use of iio_sw_buffer_preenable
Date: Wed, 18 Apr 2012 14:13:52 +0100
Message-Id: <1334754834-13622-13-git-send-email-jic23@kernel.org>
In-Reply-To: <1334754834-13622-1-git-send-email-jic23@kernel.org>
References: <1334754834-13622-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This avoids some code duplication by using the generic form
in a non performance critical place.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 93e5a71..8a0485e 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -569,19 +569,14 @@ static const struct iio_info ad5933_info = {
 static int ad5933_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad5933_state *st = iio_priv(indio_dev);
-	size_t d_size;
 	int ret;
 
 	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
-	d_size = bitmap_weight(indio_dev->active_scan_mask,
-			       indio_dev->masklength) *
-		 ad5933_channels[1].scan_type.storagebits / 8;
-
-	if (indio_dev->buffer->access->set_bytes_per_datum)
-		indio_dev->buffer->access->
-			set_bytes_per_datum(indio_dev->buffer, d_size);
+	ret = iio_sw_buffer_preenable(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	ret = ad5933_reset(st);
 	if (ret < 0)
-- 
1.7.0.4

