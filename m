Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58625 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933855AbaFCWmY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Jun 2014 18:42:24 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 03/15] iio:adc:ad799x: Fix ad799x_chip_info kerneldoc
Date: Wed,  4 Jun 2014 00:42:03 +0200
Message-Id: <1401835335-29969-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad799x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 39b4cb4..7e08c60 100644
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

