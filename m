Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43261 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752996AbaFGPbr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:31:47 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 02/13] iio:adc:ad799x: Fix ad799x_chip_info kerneldoc
Date: Sat,  7 Jun 2014 17:31:26 +0200
Message-Id: <1402155097-435-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad799x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 099b830..b250651 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -105,9 +105,8 @@ enum {
  * struct ad799x_chip_info - chip specific information
  * @channel:		channel specification
  * @num_channels:	number of channels
- * @monitor_mode:	whether the chip supports monitor interrupts
  * @default_config:	device default configuration
- * @event_attrs:	pointer to the monitor event attribute group
+ * @info:		pointer to iio_info struct
  */
 struct ad799x_chip_info {
 	struct iio_chan_spec		channel[9];
-- 
1.9.1

