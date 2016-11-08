Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47262 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753096AbcKHK1P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 05:27:15 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 18/23] staging: iio: tsl2583: change tsl2583_als_calibrate() to return 0 on success
Date: Tue,  8 Nov 2016 05:16:43 -0500
Message-Id: <1478600208-21153-19-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
References: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
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
index 5cdfe06..f1c9bb9 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -342,7 +342,7 @@ static int tsl2583_als_calibrate(struct iio_dev *indio_dev)
 
 	chip->als_settings.als_gain_trim = (int)gain_trim_val;
 
-	return (int)gain_trim_val;
+	return 0;
 }
 
 static int tsl2583_set_als_time(struct tsl2583_chip *chip)
-- 
2.7.4

