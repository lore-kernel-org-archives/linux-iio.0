Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:37916 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934543AbaDJC1K (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Apr 2014 22:27:10 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so3332729ier.41
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2014 19:27:10 -0700 (PDT)
From: Michael Welling <mwelling@ieee.org>
To: linux-iio@vger.kernel.org, jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: Michael Welling <mwelling@ieee.org>
Subject: [PATCH 3/3] Staging: iio: Switch from msleep to usleep range per timers-howto.txt
Date: Wed,  9 Apr 2014 21:26:45 -0500
Message-Id: <1397096805-25168-4-git-send-email-mwelling@ieee.org>
In-Reply-To: <1397096805-25168-1-git-send-email-mwelling@ieee.org>
References: <1397096805-25168-1-git-send-email-mwelling@ieee.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/staging/iio/light/tsl2583.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index f015fb4..fa96498 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -451,7 +451,7 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 		}
 	}
 
-	msleep(3);
+	usleep_range(3000, 3500);
 	/* NOW enable the ADC
 	 * initialize the desired mode of operation */
 	utmp = TSL258X_CNTL_PWR_ON | TSL258X_CNTL_ADC_ENBL;
-- 
1.7.9.5

