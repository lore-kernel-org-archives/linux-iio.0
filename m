Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:52341 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761547Ab2FVHrq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 22 Jun 2012 03:47:46 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/3] iio staging: fix typo, improve timestamp alignment comment
Date: Fri, 22 Jun 2012 09:47:43 +0200
Message-Id: <1340351263-5794-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340351263-5794-1-git-send-email-pmeerw@pmeerw.net>
References: <1340351263-5794-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 drivers/staging/iio/iio_simple_dummy_buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index f4415da..b9e6093 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -83,7 +83,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 			len += 2;
 		}
 	}
-	/* Store a timestampe at an 8 byte boundary */
+	/* Store the timestamp at an 8 byte aligned offset */
 	if (indio_dev->scan_timestamp)
 		*(s64 *)((phys_addr_t)data + ALIGN(len, sizeof(s64)))
 			= iio_get_time_ns();
-- 
1.7.9.5

