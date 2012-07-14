Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:45599 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529Ab2GNQXp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jul 2012 12:23:45 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio staging: fix cast warning
Date: Sat, 14 Jul 2012 18:23:43 +0200
Message-Id: <1342283024-15176-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/iio_simple_dummy_buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index c0951f9..bd628de 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -85,7 +85,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	}
 	/* Store the timestamp at an 8 byte aligned offset */
 	if (indio_dev->scan_timestamp)
-		*(s64 *)((phys_addr_t)data + ALIGN(len, sizeof(s64)))
+		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64)))
 			= iio_get_time_ns();
 	buffer->access->store_to(buffer, (u8 *)data, pf->timestamp);
 
-- 
1.7.9.5

