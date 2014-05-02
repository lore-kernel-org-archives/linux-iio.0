Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43757 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353AbaEBIJv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 2 May 2014 04:09:51 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/2] iio:magnetometer:mag3110: Fix initialization of ctrl_reg1
Date: Fri,  2 May 2014 10:09:46 +0200
Message-Id: <1399018187-29742-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399018187-29742-1-git-send-email-pmeerw@pmeerw.net>
References: <1399018187-29742-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

DR bits need to be shifted; since MAG3110_CTRL_DR_DEFAULT is
zero, the change has no effect

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/magnetometer/mag3110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 8b77782..1b2df75 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -338,7 +338,7 @@ static int mag3110_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(mag3110_channels);
 	indio_dev->available_scan_masks = mag3110_scan_masks;
 
-	data->ctrl_reg1 = MAG3110_CTRL_DR_DEFAULT;
+	data->ctrl_reg1 = MAG3110_CTRL_DR_DEFAULT << MAG3110_CTRL_DR_SHIFT;
 	ret = i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG1,
 		data->ctrl_reg1);
 	if (ret < 0)
-- 
1.9.1

