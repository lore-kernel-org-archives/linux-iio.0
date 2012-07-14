Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:45600 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792Ab2GNQXq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jul 2012 12:23:46 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio staging: fix cast warning and cleanup alignment code
Date: Sat, 14 Jul 2012 18:23:44 +0200
Message-Id: <1342283024-15176-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1342283024-15176-1-git-send-email-pmeerw@pmeerw.net>
References: <1342283024-15176-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index d7f8af7..18d108f 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -151,8 +151,7 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 
 	  /* Guaranteed to be aligned with 8 byte boundary */
 	if (indio_dev->scan_timestamp)
-		*(s64 *)(((phys_addr_t)data + len
-				+ sizeof(s64) - 1) & ~(sizeof(s64) - 1))
+		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64)))
 			= pf->timestamp;
 	buffer->access->store_to(buffer, (u8 *)data, pf->timestamp);
 
-- 
1.7.9.5

