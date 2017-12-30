Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36583 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdL3JE7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Dec 2017 04:04:59 -0500
Received: by mail-pf0-f194.google.com with SMTP id p84so22953157pfd.3
        for <linux-iio@vger.kernel.org>; Sat, 30 Dec 2017 01:04:59 -0800 (PST)
From: venkat.prashanth2498@gmail.com
To: lars@metafoo.de, jic23@kernel.org, Michael.Hennerich@analog.com
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Subject: [PATCH 7/7] Drivers:iio:adc: Fix space prohibited before that ','
Date: Sat, 30 Dec 2017 14:34:46 +0530
Message-Id: <1514624686-8485-1-git-send-email-venkat.prashanth2498@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>

This is a patch to the ad799x.c file that fixes
ERROR: space prohibited before that ','
found by the checkpatch.pl tool

Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
 drivers/iio/adc/ad799x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 01d7158..a3f5254 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -477,7 +477,7 @@ static int ad799x_read_event_value(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 	*val = (ret >> chan->scan_type.shift) &
-		GENMASK(chan->scan_type.realbits - 1 , 0);
+		GENMASK(chan->scan_type.realbits - 1, 0);

 	return IIO_VAL_INT;
 }
--
1.9.1

