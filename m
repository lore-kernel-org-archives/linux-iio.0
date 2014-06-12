Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47800 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbaFLEy3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 12 Jun 2014 00:54:29 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v3 08/12] iio:adc:ad799x: Add helper function to read/write config register
Date: Thu, 12 Jun 2014 06:54:12 +0200
Message-Id: <1402548856-3564-9-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net>
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

16-bit on ad7997/ad7998, 8-bit elsewhere

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad799x.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 92401c9..fe2a9b1 100644
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

