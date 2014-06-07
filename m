Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43274 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954AbaFGPbt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:31:49 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 07/13] iio:adc:ad799x: Make chan_spec const in ad799x_chip_config struct
Date: Sat,  7 Jun 2014 17:31:31 +0200
Message-Id: <1402155097-435-8-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad799x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index e880d17..ae32ea1 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -107,7 +107,7 @@ enum {
  * @info:		pointer to iio_info struct
  */
 struct ad799x_chip_config {
-	struct iio_chan_spec		channel[9];
+	const struct iio_chan_spec	channel[9];
 	u16				default_config;
 	const struct iio_info		*info;
 };
-- 
1.9.1

