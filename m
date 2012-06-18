Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47284 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064Ab2FRSdK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 Jun 2012 14:33:10 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 4/4] iio staging: another typo in iio_simple_dummy_buffer
Date: Mon, 18 Jun 2012 20:33:04 +0200
Message-Id: <1340044387-2725-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net>
References: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

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

