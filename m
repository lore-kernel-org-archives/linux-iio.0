Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:36383 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146Ab3IRVLA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Sep 2013 17:11:00 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/2] iio: Pass scan mask as unsigned long
Date: Wed, 18 Sep 2013 23:10:48 +0200
Message-Id: <1379538649-9675-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/industrialio-buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 58180ec..2361fbc 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -429,8 +429,8 @@ static const unsigned long *iio_scan_mask_match(const unsigned long *av_masks,
 	return NULL;
 }
 
-static int iio_compute_scan_bytes(struct iio_dev *indio_dev, const long *mask,
-				  bool timestamp)
+static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
+				const unsigned long *mask, bool timestamp)
 {
 	const struct iio_chan_spec *ch;
 	unsigned bytes = 0;
-- 
1.8.4

