Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670EE9460;
	Wed, 15 Jul 2026 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103840; cv=none; b=ny+Q8yhkymW7nOM67XEBknEYQ5ba+hAP7zdGymgVhJOlMwuxpGtMNCdv+bVFfi9SkgXY4wriRzzl0UOZ6ZINhQBcavn/65ZTw7lYAttB8mxpJqB0UXuQeh2sa8M+Q7ssksObEbt9qSWq5HDkTPcgXN+UOXapGZybwsgBHorfVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103840; c=relaxed/simple;
	bh=VZ/rT6r/lbKkXhS2ooZqBH0gKlX7C3aAwmM1S4fC78s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=haFsE1d/hj24EMwGZVJxMYVnjjcPF+LTE0e1tDN+pLgU92+5+Gp+KKjWc86Aw4C4MtgrUm7N83tJaO2WJzHEhw1O63UMvBa2s5IvbtWlZ7Vzd4XXe/f74AMT6jM7fbrx//7ovAXa1hqWWorEW8zcQEh97YvDpYNkb10U8l3nD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WZmI6P0v; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WZmI6P0v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784103836; x=1784363036;
	bh=Tfqh/xGkyiil1OQKiZ8iknxMpLG97l2M1+3idrkjWAo=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WZmI6P0vTbFD+85YSBygIQUCeuE8VxP4nKao5AXvUNWRvUuVgxLvm25YETT4PldvL
	 WZ33SGJMuJTONmNv4KNP/idkJCpJVp8pWPG/6fECEc6RqWXkf6vUbK/qhcrrt0Gp74
	 l4b5KJpJ1lwm2nzMMTqseCp9mBrn1j5mcWMBB9EXhLhhk2CkImd2dhCxN2VGlCadp8
	 SGfb4Wo5rBuiYs2Hie6/mxapnwc00a5pIsqLj/4Gd3X3SleyIZHMxGX6ypD0BhB2mz
	 yJvJMxeB0x0cqcTqoeXo/u09Q5MCU+UkaiVBb7Rw1Hrt1qlBNaZOBoea4Gt0lVJChl
	 wyL2aXOWILI0w==
X-Pm-Submission-Id: 4h0Tj62y2Hz2Sd33
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 15 Jul 2026 10:23:50 +0200
Subject: [PATCH 3/3] iio: light: ltr501: Add ltr329 driver support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-liteon-ltr329-v1-3-31f027051594@geanix.com>
References: <20260715-liteon-ltr329-v1-0-31f027051594@geanix.com>
In-Reply-To: <20260715-liteon-ltr329-v1-0-31f027051594@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Esben Haabendal <esben@geanix.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784103828; l=3185;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=VZ/rT6r/lbKkXhS2ooZqBH0gKlX7C3aAwmM1S4fC78s=;
 b=rHXq3SFZW0uf49XCE2q9x19rpExrMzDpKiNJQPzk1g8q2GRBD+EPU2Vq0eIkC/OyBOF5E4pMv
 ggQjTpbWAAPCSyvlsgxf9PrbAejrcf4NoCefJQkzZvthJ2lXG8/6eaN
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

This adds support for the LTR-329ALS-01 chip, which is similar to
LTR-303ALS-01, except for interrupt, which LTR-329ALS-01 chip does not
have.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/light/ltr501.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 7d045be78c6d..815b67a10837 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -94,6 +94,7 @@ enum {
 	ltr559,
 	ltr301,
 	ltr303,
+	ltr329,
 };
 
 struct ltr501_gain {
@@ -178,6 +179,11 @@ static const struct ltr501_samp_table ltr501_ps_samp_table[] = {
 			{500000, 2000000}
 };
 
+static bool ltr501_has_irq_support(const struct ltr501_chip_info *chip_info)
+{
+	return chip_info->info != chip_info->info_no_irq;
+}
+
 static int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
 					   int len, int val, int val2)
 {
@@ -428,6 +434,9 @@ static int ltr501_read_intr_prst(const struct ltr501_data *data,
 {
 	int ret, samp_period, prst;
 
+	if (!ltr501_has_irq_support(data->chip_info))
+		return 0;
+
 	switch (type) {
 	case IIO_INTENSITY:
 		ret = regmap_field_read(data->reg_als_prst, &prst);
@@ -466,6 +475,9 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
 	int ret, samp_period, new_val;
 	unsigned long period;
 
+	if (!ltr501_has_irq_support(data->chip_info))
+		return 0;
+
 	if (val < 0 || val2 < 0)
 		return -EINVAL;
 
@@ -1257,6 +1269,18 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
 		.channels = ltr301_channels,
 		.no_channels = ARRAY_SIZE(ltr301_channels),
 	},
+	[ltr329] = {
+		.partid = 0x0A,
+		.als_gain = ltr559_als_gain_tbl,
+		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
+		.als_mode_active = BIT(0),
+		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
+		.als_gain_shift = 2,
+		.info = &ltr301_info_no_irq,
+		.info_no_irq = &ltr301_info_no_irq,
+		.channels = ltr301_channels,
+		.no_channels = ARRAY_SIZE(ltr301_channels),
+	},
 };
 
 static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
@@ -1531,6 +1555,11 @@ static int ltr501_probe(struct i2c_client *client)
 		return ret;
 
 	if (client->irq > 0) {
+		if (!ltr501_has_irq_support(data->chip_info)) {
+			dev_err(&client->dev, "chip does not support irq\n");
+			return -EINVAL;
+		}
+
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, ltr501_interrupt_handler,
 						IRQF_TRIGGER_FALLING |
@@ -1604,6 +1633,7 @@ static const struct i2c_device_id ltr501_id[] = {
 	{ .name = "ltr559", .driver_data = ltr559 },
 	{ .name = "ltr301", .driver_data = ltr301 },
 	{ .name = "ltr303", .driver_data = ltr303 },
+	{ .name = "ltr329", .driver_data = ltr329 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
@@ -1613,6 +1643,7 @@ static const struct of_device_id ltr501_of_match[] = {
 	{ .compatible = "liteon,ltr559", },
 	{ .compatible = "liteon,ltr301", },
 	{ .compatible = "liteon,ltr303", },
+	{ .compatible = "liteon,ltr329", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltr501_of_match);

-- 
2.55.0

