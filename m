Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47284 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753454AbcKHK1S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 05:27:18 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 20/23] staging: iio: tsl2583: don't assume an unsigned int is 32 bits
Date: Tue,  8 Nov 2016 05:16:45 -0500
Message-Id: <1478600208-21153-21-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
References: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

in_illuminance_lux_table_store assumes that an unsigned int is 32 bits.
Replace this with sizeof(unsigned int).

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 29153fa..6644374 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -574,7 +574,7 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
 
 	/* Zero out the table */
 	memset(tsl2583_device_lux, 0, sizeof(tsl2583_device_lux));
-	memcpy(tsl2583_device_lux, &value[1], value[0] * 4);
+	memcpy(tsl2583_device_lux, &value[1], value[0] * sizeof(unsigned int));
 
 	ret = len;
 
-- 
2.7.4

