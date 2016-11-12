Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:55942 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966856AbcKLSTy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Nov 2016 13:19:54 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v4 23/26] staging: iio: tsl2583: remove unnecessary memset call
Date: Sat, 12 Nov 2016 13:19:38 -0500
Message-Id: <1478974781-1457-24-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The entries in the lux table (als_device_lux) can be updated via sysfs
through the function in_illuminance_lux_table_store(). The last row in
the table must be terminated with values that are zero. The sysfs code
already ensures that the last row is all zeros. The call to memset to
clear out the table is not needed so this patch removes the unnecessary
call.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 9db191f..712f753 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -591,9 +591,6 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
 		goto done;
 	}
 
-	/* Zero out the table */
-	memset(chip->als_settings.als_device_lux, 0,
-	       sizeof(chip->als_settings.als_device_lux));
 	memcpy(chip->als_settings.als_device_lux, &value[1],
 	       value[0] * sizeof(value[1]));
 
-- 
2.7.4

