Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48264 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121Ab3GGUYV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 7 Jul 2013 16:24:21 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/5] iio: staging: fix typo in ade758_ring.c
Date: Sun,  7 Jul 2013 22:24:04 +0200
Message-Id: <1373228646-5356-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net>
References: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/meter/ade7758_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index b29e2d5..7d5db71 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -54,7 +54,7 @@ out:
 	return ret;
 }
 
-/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
+/* Whilst this makes a lot of calls to iio_sw_ring functions - it is too device
  * specific to be rolled into the core.
  */
 static irqreturn_t ade7758_trigger_handler(int irq, void *p)
-- 
1.8.3.2

