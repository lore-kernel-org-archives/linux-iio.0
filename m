Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 4/4] iio staging: another typo in iio_simple_dummy_buffer
Date: Sun, 17 Jun 2012 19:03:19 +0200
Message-Id: <1339952599-22105-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net>
References: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/iio_simple_dummy_buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index 3e43025..fa4939c 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -78,7 +78,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 		     i++) {
 			j = find_next_bit(buffer->scan_mask,
 					  indio_dev->masklength, j + 1);
-			/* random access read form the 'device' */
+			/* random access read from the 'device' */
 			data[i] = fakedata[j];
 			len += 2;
 		}
-- 
1.7.9.5
