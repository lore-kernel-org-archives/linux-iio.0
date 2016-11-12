Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:55918 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966819AbcKLSTv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Nov 2016 13:19:51 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v4 17/26] staging: iio: tsl2583: remove unnecessary parentheses
Date: Sat, 12 Nov 2016 13:19:32 -0500
Message-Id: <1478974781-1457-18-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

in_illuminance_lux_table_store() contains some unnecessary parentheses.
This patch removes them since they provide no value.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index fc58074..fe9d777 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -574,7 +574,7 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
 			__func__, TSL2583_MAX_LUX_INTS);
 		goto done;
 	}
-	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0) {
+	if ((value[n - 2] | value[n - 1] | value[n]) != 0) {
 		dev_err(dev, "%s: The last 3 entries in the lux table must be zeros.\n",
 			__func__);
 		goto done;
@@ -582,7 +582,7 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
 
 	/* Zero out the table */
 	memset(tsl2583_device_lux, 0, sizeof(tsl2583_device_lux));
-	memcpy(tsl2583_device_lux, &value[1], (value[0] * 4));
+	memcpy(tsl2583_device_lux, &value[1], value[0] * 4);
 
 	ret = len;
 
-- 
2.7.4

