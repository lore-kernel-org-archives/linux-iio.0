Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:54531 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754425Ab3KBTox (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 2 Nov 2013 15:44:53 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH 2/2] iio: Drop scan_type from viperboard adc driver
Date: Sat,  2 Nov 2013 20:44:48 +0100
Message-Id: <1383421488-5167-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1383421488-5167-1-git-send-email-pmeerw@pmeerw.net>
References: <1383421488-5167-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

the driver does not support buffering, hence scan_type is not needed

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/iio/adc/viperboard_adc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
index 09727a7..94f404d 100644
--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -42,11 +42,6 @@ struct vprbrd_adc {
 	.indexed = 1,					\
 	.channel = _index,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-	.scan_index = _index,				\
-	.scan_type = {					\
-		.sign = 'u',				\
-		.realbits = 8,				\
-		.storagebits = 8,			\
 	},						\
 }
 
@@ -73,7 +68,7 @@ static int vprbrd_iio_read_raw(struct iio_dev *iio_dev,
 		mutex_lock(&vb->lock);
 
 		admsg->cmd = VPRBRD_ADC_CMD_GET;
-		admsg->chan = chan->scan_index;
+		admsg->chan = chan->channel;
 		admsg->val = 0x00;
 
 		ret = usb_control_msg(vb->usb_dev,
-- 
1.8.4.2

