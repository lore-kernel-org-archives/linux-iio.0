Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588DD32C33E
	for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2026 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494191; cv=none; b=l5HA12vrqJSaJzrIDzKTmWRkvf8+jEMg7iUqAQ7nIPxx5Vm4pDzTaTRg/doOGQGc5qy5d2T1quJV+m9A3WjJw9RU3Qd0vTAUbN9RTuEUf1YCmivIhh8Rz/6sPiG3eY4LPmLsN0nJPCv56BtDdVdHvSDiNvoWwtYMaeJtuhAvgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494191; c=relaxed/simple;
	bh=xsfl6CjRRGIj+atIrtIembJNz4raXcozsc4Yq786hY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYBa9Ec739Js3pBX3nrtVCnZOb/FHWXarEc07S4UeIx+FDWHsYewbVF/uyqBXKLxcSqIRZ9/3o1TvTcim82lz0+tMWD5Yu3wlGPeMPiNvlPZLUe8/0g4UorqTAOCqUJ+gKj/zwD4SyzdeWEqZ6/WK5Ky7GUUGSLjP/+opMi1WoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGk-0003pc-0E; Tue, 27 Jan 2026 07:09:42 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGj-002hiR-38;
	Tue, 27 Jan 2026 07:09:41 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGj-0000000GQFY-0y0s;
	Tue, 27 Jan 2026 07:09:41 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v2 6/8] iio: dac: ds4424: fix -128 rejection and refactor raw access
Date: Tue, 27 Jan 2026 07:09:37 +0100
Message-ID: <20260127060939.3914006-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127060939.3914006-1-o.rempel@pengutronix.de>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
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

The DS442x DAC uses sign-magnitude encoding, so -128 cannot be represented.
Previously, passing -128 resulted in a truncated value that programmed 0mA.

Fix this by validating the input against the 7-bit magnitude limit.
Additionally, refactor the raw access logic to use symmetrical bitwise
operations, replacing the union structure.

Fixes: d632a2bd8ffc ("iio: dac: ds4422/ds4424 dac driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- Replace S8_MIN/MAX checks with abs() > DS4424_DAC_MASK to enforce the
  correct [-127, 127] physical range.
- Refactor read_raw/write_raw to use symmetrical bitwise operations,
  removing the custom bitfield union.
- Rebase on top of regmap port
---
 drivers/iio/dac/ds4424.c | 50 +++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index f9ab7f4b97ff..8110ca7f062f 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -20,9 +20,10 @@
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
@@ -32,22 +33,6 @@
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
 	ID_DS4402,
 	ID_DS4404,
@@ -127,7 +112,6 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct ds4424_data *data = iio_priv(indio_dev);
-	union ds4424_raw_data raw;
 	unsigned int regval;
 	int ret;
 
@@ -140,10 +124,11 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
 						__func__, ret);
 			return ret;
 		}
-		raw.bits = regval;
-		*val = raw.dx;
-		if (raw.source_bit == DS4424_SINK_I)
+
+		*val = regval & DS4424_DAC_MASK;
+		if (!(regval & DS4424_DAC_SOURCE))
 			*val = -*val;
+
 		return IIO_VAL_INT;
 
 	default:
@@ -156,26 +141,27 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct ds4424_data *data = iio_priv(indio_dev);
-	union ds4424_raw_data raw;
+	unsigned int abs_val;
 
 	if (val2 != 0)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val < S8_MIN || val > S8_MAX)
+		abs_val = abs(val);
+
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
+		 * Currents exiting the IC (Source) are positive.
+		 * Canonicalize 0 to sink; datasheet treats sign as don't-care.
+		 */
+		if (val > 0)
+			abs_val |= DS4424_DAC_SOURCE;
 
 		return regmap_write(data->regmap, DS4424_DAC_ADDR(chan->channel),
-				    raw.bits);
+				    abs_val);
 
 	default:
 		return -EINVAL;
-- 
2.47.3

