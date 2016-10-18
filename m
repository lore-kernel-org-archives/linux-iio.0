Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35947 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933242AbcJRTae (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Oct 2016 15:30:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so864045wma.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Oct 2016 12:30:34 -0700 (PDT)
Date: Tue, 18 Oct 2016 21:31:47 +0200
From: =?utf-8?B?UGF3ZcWC?= Jarosz <paweljarosz3691@gmail.com>
To: paweljarosz3691@gmail.com
Cc: linux-iio@vger.kernel.org, ldewangan@nvidia.com,
        rui.zhang@intel.com, edubezval@gmail.com
Subject: [PATCH] thermal: generic-adc: Fix linear temperature approximation
Message-ID: <20161018193147.GA14745@vaio-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In current version of the driver there is error in temperature
calculation.

So lets fix it using proper linear function.

Signed-off-by: Paweł Jarosz <paweljarosz3691@gmail.com>
---
 drivers/thermal/thermal-generic-adc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 73f55d6..1190aee 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -26,7 +26,7 @@ struct gadc_thermal_info {
 
 static int gadc_thermal_adc_to_temp(struct gadc_thermal_info *gti, int val)
 {
-	int temp, adc_hi, adc_lo;
+	int temp, adc1, adc2, temp1, temp2;
 	int i;
 
 	for (i = 0; i < gti->nlookup_table; i++) {
@@ -39,10 +39,13 @@ static int gadc_thermal_adc_to_temp(struct gadc_thermal_info *gti, int val)
 	} else if (i >= (gti->nlookup_table - 1)) {
 		temp = gti->lookup_table[2 * (gti->nlookup_table - 1)];
 	} else {
-		adc_hi = gti->lookup_table[2 * i - 1];
-		adc_lo = gti->lookup_table[2 * i + 1];
-		temp = gti->lookup_table[2 * i];
-		temp -= ((val - adc_lo) * 1000) / (adc_hi - adc_lo);
+		adc1 = gti->lookup_table[2 * i - 1];
+		adc2 = gti->lookup_table[2 * i + 1];
+
+		temp1 = gti->lookup_table[2 * i - 2];
+		temp2 = gti->lookup_table[2 * i];
+
+		temp = (val - adc1) * (temp2 - temp1) / (adc2 - adc1) + temp1;
 	}
 
 	return temp;
-- 
2.7.4

