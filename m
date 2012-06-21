Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/3] iio staging: fix typo, improve timestamp alignment comment
Date: Thu, 21 Jun 2012 23:02:39 +0200
Message-Id: <1340312559-32753-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340312559-32753-1-git-send-email-pmeerw@pmeerw.net>
References: <1340312559-32753-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
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
