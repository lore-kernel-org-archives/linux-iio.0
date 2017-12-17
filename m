Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40849 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757305AbdLQOIa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Dec 2017 09:08:30 -0500
Received: by mail-pf0-f193.google.com with SMTP id v26so8616626pfl.7
        for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2017 06:08:29 -0800 (PST)
From: venkat.prashanth2498@gmail.com
To: lars@metafoo.de, Michael.Hennerich@analog.com
Cc: jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org,
        Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Subject: [PATCH 2/2] Drivers:iio:adc : fix quoted string split across lines issue in at91_adc.c
Date: Sun, 17 Dec 2017 19:38:21 +0530
Message-Id: <1513519701-3421-1-git-send-email-venkat.prashanth2498@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>

This is a patch to the at91_adc.c file that fixes up a quoted string split
across lines warning found by the checkpatch.pl tool

Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index a4767d6..c3729f8 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -737,8 +737,8 @@ static int at91_adc_of_get_resolution(struct at91_adc_state *st,

 count = of_property_count_strings(np, "atmel,adc-res-names");
 if (count < 2) {
-dev_err(&idev->dev, "You must specified at least two resolution names for "
-	"adc-res-names property in the DT\n");
+dev_err(&idev->dev, "You must specified at least two resolution names for
+	adc-res-names property in the DT\n");
 	return count;
 }

--
1.9.1

