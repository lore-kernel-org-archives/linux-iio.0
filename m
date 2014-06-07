Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43274 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753062AbaFGPbu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:31:50 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 12/13] iio:adc:ad799x: Return more meaningful event enabled state
Date: Sat,  7 Jun 2014 17:31:36 +0200
Message-Id: <1402155097-435-13-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

only report an event as enabled if it actually is enabled

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad799x.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index b9e02be..8b9c939 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -364,7 +364,15 @@ static int ad799x_read_event_config(struct iio_dev *indio_dev,
 				    enum iio_event_type type,
 				    enum iio_event_direction dir)
 {
-	return 1;
+	struct ad799x_state *st = iio_priv(indio_dev);
+
+	if (!(st->config & AD7998_ALERT_EN))
+		return 0;
+
+	if ((st->config >> AD799X_CHANNEL_SHIFT) & BIT(chan->scan_index))
+		return 1;
+
+	return 0;
 }
 
 static unsigned int ad799x_threshold_reg(const struct iio_chan_spec *chan,
-- 
1.9.1

