Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58636 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934038AbaFCWma (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Jun 2014 18:42:30 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 15/15] iio:adc:ad799x: Allow to write event config
Date: Wed,  4 Jun 2014 00:42:15 +0200
Message-Id: <1401835335-29969-16-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

allow to enable events

previously, events were always reported as enabled, but actually only
implicitly enabled when updating the buffer scan mode

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad799x.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index b8191f1..f8bfbcb 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -375,6 +375,39 @@ static int ad799x_read_event_config(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static int ad799x_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     int state)
+{
+	struct ad799x_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&indio_dev->mlock);
+	if (iio_buffer_enabled(indio_dev)) {
+		ret = -EBUSY;
+		goto done;
+	}
+
+	if (state)
+		st->config |= BIT(chan->scan_index) << AD799X_CHANNEL_SHIFT;
+	else
+		st->config &= ~(BIT(chan->scan_index) << AD799X_CHANNEL_SHIFT);
+
+	if (st->config >> AD799X_CHANNEL_SHIFT)
+		st->config |= AD7998_ALERT_EN;
+	else
+		st->config &= ~AD7998_ALERT_EN;
+
+	ret = ad799x_write_config(st, st->config);
+
+done:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
 static unsigned int ad799x_threshold_reg(const struct iio_chan_spec *chan,
 					 enum iio_event_direction dir,
 					 enum iio_event_info info)
@@ -502,6 +535,7 @@ static const struct iio_info ad7993_4_7_8_irq_info = {
 	.read_raw = &ad799x_read_raw,
 	.event_attrs = &ad799x_event_attrs_group,
 	.read_event_config = &ad799x_read_event_config,
+	.write_event_config = &ad799x_write_event_config,
 	.read_event_value = &ad799x_read_event_value,
 	.write_event_value = &ad799x_write_event_value,
 	.driver_module = THIS_MODULE,
-- 
1.9.1

