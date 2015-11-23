Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36771 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbbKWRtQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2015 12:49:16 -0500
From: Nizam Haider <nizamhaider786@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	hamohammed.sa@gmail.com, shivanib134@gmail.com,
	asaf.vertz@tandemg.com, cristina.moraru09@gmail.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Nizam Haider <nizamhaider786@gmail.com>,
	Nizam Haider <nijamh@cdac.in>
Subject: [PATCH] Staging: iio: light: tsl2x7x_core: use dev_get_platdata()
Date: Mon, 23 Nov 2015 23:18:50 +0530
Message-Id: <1448300930-10789-1-git-send-email-nizamhaider786@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly.

Signed-off-by: Nizam Haider <nijamh@cdac.in>
---
 drivers/staging/iio/light/tsl2x7x_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 9dfd048..5b1c165 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -1898,7 +1898,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 	mutex_init(&chip->prox_mutex);
 
 	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_UNKNOWN;
-	chip->pdata = clientp->dev.platform_data;
+	chip->pdata = dev_get_platdata(&clientp->dev);
 	chip->id = id->driver_data;
 	chip->chip_info =
 		&tsl2x7x_chip_info_tbl[device_channel_config[id->driver_data]];
-- 
1.8.1.4

