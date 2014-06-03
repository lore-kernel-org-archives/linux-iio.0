Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58636 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934012AbaFCWm2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Jun 2014 18:42:28 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 11/15] iio:adc:ad799x: Add helper function to read/write config register
Date: Wed,  4 Jun 2014 00:42:11 +0200
Message-Id: <1401835335-29969-12-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

16-bit on ad7997/ad7998, 8-bit elsewhere

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad799x.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index dbc7c2b..0219970 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -136,6 +136,30 @@ struct ad799x_state {
 	unsigned int			transfer_size;
 };
 
+static int ad799x_write_config(struct ad799x_state *st, u16 val)
+{
+	switch (st->id) {
+	case ad7997:
+	case ad7998:
+		return i2c_smbus_write_word_swapped(st->client, AD7998_CONF_REG,
+			val);
+	default:
+		return i2c_smbus_write_byte_data(st->client, AD7998_CONF_REG,
+			val);
+	}
+}
+
+static int ad799x_read_config(struct ad799x_state *st)
+{
+	switch (st->id) {
+	case ad7997:
+	case ad7998:
+		return i2c_smbus_read_word_swapped(st->client, AD7998_CONF_REG);
+	default:
+		return i2c_smbus_read_byte_data(st->client, AD7998_CONF_REG);
+	}
+}
+
 /**
  * ad799x_trigger_handler() bh of trigger launched polling to ring buffer
  *
-- 
1.9.1

