Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/3] iio staging: simplify timestamp alignment in iio_simple_dummy
Date: Thu, 21 Jun 2012 23:02:38 +0200
Message-Id: <1340312559-32753-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340312559-32753-1-git-send-email-pmeerw@pmeerw.net>
References: <1340312559-32753-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/iio_simple_dummy_buffer.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index d911960..f4415da 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -85,8 +85,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	}
 	/* Store a timestampe at an 8 byte boundary */
 	if (indio_dev->scan_timestamp)
-		*(s64 *)(((phys_addr_t)data + len
-				+ sizeof(s64) - 1) & ~(sizeof(s64) - 1))
+		*(s64 *)((phys_addr_t)data + ALIGN(len, sizeof(s64)))
 			= iio_get_time_ns();
 	buffer->access->store_to(buffer, (u8 *)data, pf->timestamp);
 
-- 
1.7.9.5
