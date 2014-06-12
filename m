Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47803 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbaFLEy3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 12 Jun 2014 00:54:29 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v3 11/12] iio:adc:ad799x: Return more meaningful event enabled state
Date: Thu, 12 Jun 2014 06:54:15 +0200
Message-Id: <1402548856-3564-12-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net>
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

only report an event as enabled if it actually is enabled

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad799x.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index abc36c8..08bcada3 100644
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

