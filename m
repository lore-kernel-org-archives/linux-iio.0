Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33393 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754099AbdCaPJC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2017 11:09:02 -0400
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: iio: frequency: Remove useless type conversion
Date: Fri, 31 Mar 2017 20:38:49 +0530
Message-Id: <1490972930-15476-3-git-send-email-singhalsimran0@gmail.com>
In-Reply-To: <1490972930-15476-1-git-send-email-singhalsimran0@gmail.com>
References: <1490972930-15476-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some type conversions like casting a pointer to a pointer of same type,
casting to the original type using addressof(&) operator etc. are not
needed. Therefore, remove them. Done using coccinelle:

@@
type t;
t *p;
t a;
@@
(
- (t)(a)
+ a
|
- (t *)(p)
+ p
|
- (t *)(&a)
+ &a
)

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 425b8ab..01bdf8e 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -119,7 +119,7 @@ struct ad9832_state {
 static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout *
-				     (u64)((u64)1L << AD9832_FREQ_BITS);
+				     (u64)1L << AD9832_FREQ_BITS;
 	do_div(freqreg, mclk);
 	return freqreg;
 }
-- 
2.7.4

