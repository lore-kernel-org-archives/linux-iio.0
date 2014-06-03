Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58639 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932485AbaFCWm3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Jun 2014 18:42:29 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 13/15] iio:adc:ad799x: Rename ad7997_8_update_scan_mode() to ad799x_update_scan_mode()
Date: Wed,  4 Jun 2014 00:42:13 +0200
Message-Id: <1401835335-29969-14-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

function is used by all chips with ALERT pin

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad799x.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index f8e029d..5c9445e 100644
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
@@ -483,7 +487,7 @@ static const struct iio_info ad7991_info = {
 static const struct iio_info ad7993_4_7_8_noirq_info = {
 	.read_raw = &ad799x_read_raw,
 	.driver_module = THIS_MODULE,
-	.update_scan_mode = ad7997_8_update_scan_mode,
+	.update_scan_mode = ad799x_update_scan_mode,
 };
 
 static const struct iio_info ad7993_4_7_8_irq_info = {
@@ -493,7 +497,7 @@ static const struct iio_info ad7993_4_7_8_irq_info = {
 	.read_event_value = &ad799x_read_event_value,
 	.write_event_value = &ad799x_write_event_value,
 	.driver_module = THIS_MODULE,
-	.update_scan_mode = ad7997_8_update_scan_mode,
+	.update_scan_mode = ad799x_update_scan_mode,
 };
 
 static const struct iio_event_spec ad799x_events[] = {
-- 
1.9.1

