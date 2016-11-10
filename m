Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50528 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755086AbcKJJ0X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Nov 2016 04:26:23 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v3 18/28] staging: iio: tsl2583: change tsl2583_als_calibrate() to return 0 on success
Date: Thu, 10 Nov 2016 04:25:54 -0500
Message-Id: <1478769964-7065-19-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

tsl2583_als_calibrate() returns the newly computed gain_trim if the
calibration was successful. This function is only called by
in_illuminance_calibrate_store() and the return value inside that
sysfs attribute is only checked to see if an error was returned.
This patch changes tsl2583_als_calibrate() to return 0 on success.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index bdd395a..ad4ea8a 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -344,7 +344,7 @@ static int tsl2583_als_calibrate(struct iio_dev *indio_dev)
 
 	chip->als_settings.als_gain_trim = (int)gain_trim_val;
 
-	return (int)gain_trim_val;
+	return 0;
 }
 
 static int tsl2583_set_als_time(struct tsl2583_chip *chip)
-- 
2.7.4

