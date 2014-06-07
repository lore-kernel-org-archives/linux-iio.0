Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43283 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753059AbaFGPbu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:31:50 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 11/13] iio:adc:ad799x: Set conversion channels and rename ad7997_8_update_scan_mode()
Date: Sat,  7 Jun 2014 17:31:35 +0200
Message-Id: <1402155097-435-12-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

rename since function is used by all chips with ALERT pin, not just ad7997/8

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad799x.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index a5d1a0a..b9e02be 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -208,7 +208,7 @@ out:
 	return IRQ_HANDLED;
 }
 
-static int ad7997_8_update_scan_mode(struct iio_dev *indio_dev,
+static int ad799x_update_scan_mode(struct iio_dev *indio_dev,
 	const unsigned long *scan_mask)
 {
 	struct ad799x_state *st = iio_priv(indio_dev);
@@ -221,10 +221,14 @@ static int ad7997_8_update_scan_mode(struct iio_dev *indio_dev,
 	st->transfer_size = bitmap_weight(scan_mask, indio_dev->masklength) * 2;
 
 	switch (st->id) {
+	case ad7992:
+	case ad7993:
+	case ad7994:
 	case ad7997:
 	case ad7998:
-		return i2c_smbus_write_word_swapped(st->client, AD7998_CONF_REG,
-			st->config | (*scan_mask << AD799X_CHANNEL_SHIFT));
+		st->config &= ~(GENMASK(7, 0) << AD799X_CHANNEL_SHIFT);
+		st->config |= (*scan_mask << AD799X_CHANNEL_SHIFT);
+		return ad799x_write_config(st, st->config);
 	default:
 		return 0;
 	}
@@ -484,7 +488,7 @@ static const struct iio_info ad7991_info = {
 static const struct iio_info ad7993_4_7_8_noirq_info = {
 	.read_raw = &ad799x_read_raw,
 	.driver_module = THIS_MODULE,
-	.update_scan_mode = ad7997_8_update_scan_mode,
+	.update_scan_mode = ad799x_update_scan_mode,
 };
 
 static const struct iio_info ad7993_4_7_8_irq_info = {
@@ -494,7 +498,7 @@ static const struct iio_info ad7993_4_7_8_irq_info = {
 	.read_event_value = &ad799x_read_event_value,
 	.write_event_value = &ad799x_write_event_value,
 	.driver_module = THIS_MODULE,
-	.update_scan_mode = ad7997_8_update_scan_mode,
+	.update_scan_mode = ad799x_update_scan_mode,
 };
 
 static const struct iio_event_spec ad799x_events[] = {
-- 
1.9.1

