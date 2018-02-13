Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway20.websitewelcome.com ([192.185.60.19]:30091 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964987AbeBMRPD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Feb 2018 12:15:03 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 7524140102344
        for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2018 10:53:03 -0600 (CST)
Date: Tue, 13 Feb 2018 10:52:58 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] iio: adc: ina2xx: Use 64-bit arithmetic instead of 32-bit
Message-ID: <20180213165258.GA12967@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add suffix ULL to constant 1000 in order to give the compiler complete
information about the proper arithmetic to use. Notice that this
constant is used in a context that expects an expression of type
u64 (64 bits, unsigned).

The expression 1000 * sampling_us is currently being evaluated
using 32-bit arithmetic.

Addresses-Coverity-ID: 1463793
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/iio/adc/ina2xx-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 0635a79..8649700 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -810,7 +810,7 @@ static int ina2xx_capture_thread(void *data)
 		 * multiple times, i.e. samples are dropped.
 		 */
 		do {
-			timespec64_add_ns(&next, 1000 * sampling_us);
+			timespec64_add_ns(&next, 1000ULL * sampling_us);
 			delta = timespec64_sub(next, now);
 			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
 		} while (delay_us <= 0);
-- 
2.7.4

