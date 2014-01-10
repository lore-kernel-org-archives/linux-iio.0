Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58104 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722AbaAJV70 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 10 Jan 2014 16:59:26 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 4/5] iio:magnetometer:mag3110: Fix initialization of ctrl_reg1
Date: Fri, 10 Jan 2014 22:59:22 +0100
Message-Id: <1389391163-9622-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389391163-9622-1-git-send-email-pmeerw@pmeerw.net>
References: <1389391163-9622-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

DR bits need to be shifted; since MAG3110_CTRL_DR_DEFAULT is
zero, the change has no effect

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/magnetometer/mag3110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 02e4f97..9e774de 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -339,7 +339,7 @@ static int mag3110_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(mag3110_channels);
 	indio_dev->available_scan_masks = mag3110_scan_masks;
 
-	data->ctrl_reg1 = MAG3110_CTRL_DR_DEFAULT;
+	data->ctrl_reg1 = MAG3110_CTRL_DR_DEFAULT << MAG3110_CTRL_DR_SHIFT;
 	ret = i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG1,
 		data->ctrl_reg1);
 	if (ret < 0)
-- 
1.8.3.2

