Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39803 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdL2Qxb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Dec 2017 11:53:31 -0500
Received: by mail-pl0-f66.google.com with SMTP id bi12so23232518plb.6
        for <linux-iio@vger.kernel.org>; Fri, 29 Dec 2017 08:53:31 -0800 (PST)
From: venkat.prashanth2498@gmail.com
To: lars@metafoo.de, jic23@kernel.org, Michael.Hennerich@analog.com
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Subject: [PATCH 4/4] Drivers:iio:adc: else is not generally useful after a break or return
Date: Fri, 29 Dec 2017 22:23:09 +0530
Message-Id: <1514566389-3485-1-git-send-email-venkat.prashanth2498@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>

Fixes checkpatch warnings:
WARNING: else is not generally useful after a break or return

Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 7b40925..da18c04 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -939,7 +939,6 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 	/* Check if touchscreen is supported. */
 	if (st->caps->has_ts)
 		return at91_adc_probe_dt_ts(node, st, &idev->dev);
-	else
 		dev_info(&idev->dev, "not support touchscreen in the adc compatible string.\n");

 	return 0;
--
1.9.1

