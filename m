Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449BB22127A
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213652; cv=none; b=IoTd0/Z2badoS/4InHF4itobByML6yWE0F7Kv78FGRSzqnLUoEtAQeP/8VYwHcYK1cU0PCsQtvEHkBka31zXG+LkxBSWWwHcxQICNUBYtB4hrDQ0gx381cK9jxwvtZQ94bz6/+NoxlC51RiGxUO9KMXXG7C+QIDXDVAAgDq/TzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213652; c=relaxed/simple;
	bh=rPfE4515n+KZG273IiE6bLfVi2PtNGJOTQBPCKEkJ/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r83VtAjdlIFoEC9Qq+4BMckhe2ng+BYARz35lwO94Nc+SjMrgZiVvpuBliL72cFIqohA6faauV9XR9rNm8X6hKyp5C2FMtf8+DRf8lKNyXjSpYAI0b9DwYoE3PPDq1hSD7s8wnGRLwhueZpaCFfHgdR69nsCKgaecbgqd8qpwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR1-0001Qi-HP; Wed, 04 Feb 2026 15:00:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR1-0045FF-1E;
	Wed, 04 Feb 2026 15:00:46 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR0-00000001dfe-2de9;
	Wed, 04 Feb 2026 15:00:46 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v5 02/13] iio: dac: ds4424: refactor raw access to use bitwise operations
Date: Wed,  4 Feb 2026 15:00:34 +0100
Message-ID: <20260204140045.390677-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260204140045.390677-1-o.rempel@pengutronix.de>
References: <20260204140045.390677-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Refactor the raw access logic to use standard GENMASK() and BIT()
macros. Use abs() for magnitude calculation to simplify the logic and
make the data flow clearer.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
changes v5:
- no changes
changes v4:
- Split patch: The functional fix for -128 was moved to the previous
  patch (1/9) for stable backporting.
- This patch now contains only the refactoring (GENMASK/BIT/abs) on top
  of the fix.
changes v3:
- Remove "Rebase on top of regmap" note as this is now patch 1/8.
- Add #include <linux/bits.h>
- Clarify 0mA sink/source behavior in comments
- Remove redundant blank line in write_raw
changes v2:
- Replace S8_MIN/MAX checks with abs() > DS4424_DAC_MASK to enforce the
  correct [-127, 127] physical range.
- Refactor read_raw/write_raw to use symmetrical bitwise operations,
  removing the custom bitfield union.
- Rebase on top of regmap port
---
 drivers/iio/dac/ds4424.c | 55 +++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 059acca45f64..596ff5999271 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2017 Maxim Integrated
  */
 
+#include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
@@ -19,9 +20,10 @@
 #define DS4422_MAX_DAC_CHANNELS		2
 #define DS4424_MAX_DAC_CHANNELS		4
 
+#define DS4424_DAC_MASK			GENMASK(6, 0)
+#define DS4424_DAC_SOURCE		BIT(7)
+
 #define DS4424_DAC_ADDR(chan)   ((chan) + 0xf8)
-#define DS4424_SOURCE_I		1
-#define DS4424_SINK_I		0
 
 #define DS4424_CHANNEL(chan) { \
 	.type = IIO_CURRENT, \
@@ -31,22 +33,6 @@
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 }
 
-/*
- * DS4424 DAC control register 8 bits
- * [7]		0: to sink; 1: to source
- * [6:0]	steps to sink/source
- * bit[7] looks like a sign bit, but the value of the register is
- * not a two's complement code considering the bit[6:0] is a absolute
- * distance from the zero point.
- */
-union ds4424_raw_data {
-	struct {
-		u8 dx:7;
-		u8 source_bit:1;
-	};
-	u8 bits;
-};
-
 enum ds4424_device_ids {
 	ID_DS4422,
 	ID_DS4424,
@@ -108,21 +94,21 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
 {
-	union ds4424_raw_data raw;
-	int ret;
+	int ret, regval;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = ds4424_get_value(indio_dev, val, chan->channel);
+		ret = ds4424_get_value(indio_dev, &regval, chan->channel);
 		if (ret < 0) {
 			pr_err("%s : ds4424_get_value returned %d\n",
 							__func__, ret);
 			return ret;
 		}
-		raw.bits = *val;
-		*val = raw.dx;
-		if (raw.source_bit == DS4424_SINK_I)
+
+		*val = regval & DS4424_DAC_MASK;
+		if (!(regval & DS4424_DAC_SOURCE))
 			*val = -*val;
+
 		return IIO_VAL_INT;
 
 	default:
@@ -134,25 +120,26 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
-	union ds4424_raw_data raw;
+	unsigned int abs_val;
 
 	if (val2 != 0)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val <= S8_MIN || val > S8_MAX)
+		abs_val = abs(val);
+		if (abs_val > DS4424_DAC_MASK)
 			return -EINVAL;
 
-		if (val > 0) {
-			raw.source_bit = DS4424_SOURCE_I;
-			raw.dx = val;
-		} else {
-			raw.source_bit = DS4424_SINK_I;
-			raw.dx = -val;
-		}
+		/*
+		 * Currents exiting the IC (Source) are positive. 0 is a valid
+		 * value for no current flow; the direction bit (Source vs Sink)
+		 * is treated as don't-care by the hardware at 0.
+		 */
+		if (val > 0)
+			abs_val |= DS4424_DAC_SOURCE;
 
-		return ds4424_set_value(indio_dev, raw.bits, chan);
+		return ds4424_set_value(indio_dev, abs_val, chan);
 
 	default:
 		return -EINVAL;
-- 
2.47.3

