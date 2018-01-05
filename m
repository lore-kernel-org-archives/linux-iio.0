Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43996 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbeAEDoH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Jan 2018 22:44:07 -0500
Received: by mail-pf0-f193.google.com with SMTP id e3so1696663pfi.10
        for <linux-iio@vger.kernel.org>; Thu, 04 Jan 2018 19:44:07 -0800 (PST)
From: venkat.prashanth2498@gmail.com
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Subject: [PATCH 2/2] Drivers:iio:adc: remove comparison to bool
Date: Fri,  5 Jan 2018 09:13:57 +0530
Message-Id: <1515123837-32473-1-git-send-email-venkat.prashanth2498@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>

This is the patch to the file ti_am335x_adc.c
which fixes the following coccinelle warning:

WARNING: Comparison to bool

Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index b3e573c..80df5a3 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -523,7 +523,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 	}
 	am335x_tsc_se_adc_done(adc_dev->mfd_tscadc);
 
-	if (found == false)
+	if (!found)
 		ret =  -EBUSY;
 
 err_unlock:
-- 
1.9.1

