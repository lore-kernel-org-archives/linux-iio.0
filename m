Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32883 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753688AbdCTLfH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 07:35:07 -0400
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, abhiram@cs.utah.edu,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH] staging: iio: tsl2x7x_core: Fix standard deviation calculation
Date: Mon, 20 Mar 2017 19:27:05 +0800
Message-Id: <1490009225-10268-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Standard deviation is calculated as the square root of the variance
where variance is the mean of sample_sum and length. Correct the
computation of statP->stddev in accordance to the proper calculation.

Fixes: 3c97c08b5735 ("staging: iio: add TAOS tsl2x7x driver")
Reported-by: Abhiram Balasubramanian <abhiram@cs.utah.edu>
Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 drivers/staging/iio/light/tsl2x7x_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index ea15bc1..197201a 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -854,7 +854,7 @@ void tsl2x7x_prox_calculate(int *data, int length,
 		tmp = data[i] - statP->mean;
 		sample_sum += tmp * tmp;
 	}
-	statP->stddev = int_sqrt((long)sample_sum) / length;
+	statP->stddev = int_sqrt((long)sample_sum / length);
 }
 
 /**
-- 
2.7.4

