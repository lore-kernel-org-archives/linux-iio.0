Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-243.synserver.de ([212.40.185.243]:1060 "EHLO
	smtp-out-243.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423570Ab2LFQJi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Dec 2012 11:09:38 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:adf4350: Fix typo
Date: Thu,  6 Dec 2012 17:09:31 +0100
Message-Id: <1354810171-18780-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

There is a typo in the adf4350 driver turning a shift into a compare. This patch
fixes it.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/frequency/adf4350.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index e35bb8f..c7de8b5 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -173,7 +173,7 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 			} while ((st->r1_mod > ADF4350_MAX_MODULUS) && r_cnt);
 		} while (r_cnt == 0);
 
-		tmp = freq * (u64)st->r1_mod + (st->fpfd > 1);
+		tmp = freq * (u64)st->r1_mod + (st->fpfd >> 1);
 		do_div(tmp, st->fpfd); /* Div round closest (n + d/2)/d */
 		st->r0_fract = do_div(tmp, st->r1_mod);
 		st->r0_int = tmp;
-- 
1.8.0

