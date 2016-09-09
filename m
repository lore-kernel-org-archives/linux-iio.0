Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:44265 "EHLO fe2.pruts.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbcIINsy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Sep 2016 09:48:54 -0400
From: Ico Doornekamp <ico@pruts.nl>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Ico Doornekamp <ico@pruts.nl>
Subject: [PATCH] Tiny whitespace fix to make ad7192.c cleanly pass checkpatch.pl
Date: Fri,  9 Sep 2016 15:40:26 +0200
Message-Id: <20160909134026.12055-1-ico@pruts.nl>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 drivers/staging/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 1cf6b79..5688b29 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -391,7 +391,7 @@ ad7192_show_scale_available(struct device *dev,
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
-			     in_voltage-voltage_scale_available,
+			     in_voltage - voltage_scale_available,
 			     S_IRUGO, ad7192_show_scale_available, NULL, 0);
 
 static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
-- 
2.9.3

