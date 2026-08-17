Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B38466AF4;
	Mon, 17 Aug 2026 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986574; cv=none; b=Pbv632nLLuY6VxwPfzzN4EMuRK8uQXtJWUeZU5C+Y7xkVBsfoomD4wGn82Yda1edHxEWtq6uLQdmxV+D0/S5Y8G1BT4RES5uFB083stIkcsV/SSYAU/JQtK7Na4cHUUVel5ow09A3duXJwG9ivwhiJ5MJacDIAweZs7kFVBXAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986574; c=relaxed/simple;
	bh=05r0E2UencTylpGUfWAVrIUppX13gbc8uqKtxoN9aco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gb26/o/v1jrObtZlphYTRAXAhRpDDjdCTe7L0unTPw93A6hqLvWa4WUd7ZO9TVkOqum0QyM18Mj0adiaPl2+T5UAPhLqO/Usiiz3fUzhmDFF4VRccslb2Xfq69fy4wxw5c4L+Q3IhujsaEA2FRc6JRwlTfmZS7btaijeTvJCacY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=AOMmIFic; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="AOMmIFic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786986563; x=1787245763;
	bh=zTG0glKZ4EdPd7ZawStj89BtMUj3NqUD1Toxdlh3S/Q=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AOMmIFicuO+ptaCoKtJeTuZGAK5zWA+ooO87Jcerdvlyy6q4bTMvTjeJAR6QP5zqB
	 LNTYq5dfFVarjJ/syr0FJ9yJJfdYcX/55GJbePSSGVG969wBlAcxfghBxRuolvFhTb
	 9gpgJlKWeQz/92uO/WcG7eckNVGLGz0u3o7xiWabimbXuvgUJzft2eiQdS+aI4Xkil
	 FIMlXT+n7HJHm2w3eS9Hb9C7aMZ37DoFa327iSvBdTM8wWhCYQwPVrICH8JrcWUOdh
	 J1YQ2DrV757r41a31N39tJXanNb+hEGRtpoB8kmTlbFSTr7Do5F4Cc+JveWiM5wA5k
	 Fca238DhYlAeA==
X-Pm-Submission-Id: 4hNzp70s60z2SchQ
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 17 Aug 2026 19:08:55 +0200
Subject: [PATCH v5 6/8] iio: light: ltr501: Add ltr329 driver support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-liteon-ltr329-v5-6-6f71ab2b0588@geanix.com>
References: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
In-Reply-To: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, 
 Yangtao Li <frank.li@vivo.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786986543; l=4503;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=05r0E2UencTylpGUfWAVrIUppX13gbc8uqKtxoN9aco=;
 b=4cVgkjuPOeoFmgU9Ge7BR4U2YkxM+DhxsDlJBz3Aa2buQ9oViAGXewBfURQqvfFyVrUyKZpkC
 YYRS4nf+VLRB6A8gtrTlwNJgPx9RSJSvZxZprfILnLkWszM3ssU2s6M
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

This adds support for the LTR-329ALS-01 chip, which is similar to
LTR-303ALS-01, except for interrupt, which LTR-329ALS-01 chip does not
have.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/light/ltr501.c | 47 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index b36bd10a0262..51ab387f24a3 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -9,6 +9,7 @@
  * TODO: IR LED characteristics
  */
 
+#include <linux/array_size.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
@@ -94,6 +95,7 @@ enum {
 	ltr559,
 	ltr301,
 	ltr303,
+	ltr329,
 };
 
 struct ltr501_gain {
@@ -140,6 +142,7 @@ struct ltr501_chip_info {
 	u8 als_mode_active;
 	u8 als_gain_mask;
 	u8 als_gain_shift;
+	bool no_irq_support;
 	struct iio_chan_spec const *channels;
 	const int no_channels;
 	const struct iio_info *info;
@@ -178,6 +181,11 @@ static const struct ltr501_samp_table ltr501_ps_samp_table[] = {
 			{500000, 2000000}
 };
 
+static bool ltr501_has_irq_support(const struct ltr501_chip_info *info)
+{
+	return !info->no_irq_support;
+}
+
 static int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
 					   int len, int val, int val2)
 {
@@ -821,6 +829,9 @@ static int __ltr501_write_raw(struct iio_dev *indio_dev,
 			if (ret < 0)
 				return ret;
 
+			if (!ltr501_has_irq_support(info))
+				return ret;
+
 			/* update persistence count when changing frequency */
 			ret = ltr501_write_intr_prst(data, chan->type,
 						     0, data->als_period);
@@ -840,6 +851,9 @@ static int __ltr501_write_raw(struct iio_dev *indio_dev,
 			if (ret < 0)
 				return ret;
 
+			if (!ltr501_has_irq_support(info))
+				return ret;
+
 			/* update persistence count when changing frequency */
 			ret = ltr501_write_intr_prst(data, chan->type,
 						     0, data->ps_period);
@@ -1257,6 +1271,18 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
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
+		.no_irq_support = true,
+		.info_no_irq = &ltr301_info_no_irq,
+		.channels = ltr301_channels,
+		.no_channels = ARRAY_SIZE(ltr301_channels),
+	},
 };
 
 static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
@@ -1369,13 +1395,15 @@ static int ltr501_init(struct ltr501_data *data)
 
 	data->ps_contr = status | LTR501_CONTR_ACTIVE;
 
-	ret = ltr501_read_intr_prst(data, IIO_INTENSITY, &data->als_period);
-	if (ret < 0)
-		return ret;
+	if (ltr501_has_irq_support(data->chip_info)) {
+		ret = ltr501_read_intr_prst(data, IIO_INTENSITY, &data->als_period);
+		if (ret < 0)
+			return ret;
 
-	ret = ltr501_read_intr_prst(data, IIO_PROXIMITY, &data->ps_period);
-	if (ret < 0)
-		return ret;
+		ret = ltr501_read_intr_prst(data, IIO_PROXIMITY, &data->ps_period);
+		if (ret < 0)
+			return ret;
+	}
 
 	return ltr501_write_contr(data, data->als_contr, data->ps_contr);
 }
@@ -1530,6 +1558,11 @@ static int ltr501_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	if (!ltr501_has_irq_support(data->chip_info) && client->irq > 0) {
+		client->irq = 0;
+		dev_warn(&client->dev, "chip doesn't support IRQ");
+	}
+
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, ltr501_interrupt_handler,
@@ -1601,6 +1634,7 @@ static const struct i2c_device_id ltr501_id[] = {
 	{ .name = "ltr559", .driver_data = ltr559 },
 	{ .name = "ltr301", .driver_data = ltr301 },
 	{ .name = "ltr303", .driver_data = ltr303 },
+	{ .name = "ltr329", .driver_data = ltr329 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
@@ -1610,6 +1644,7 @@ static const struct of_device_id ltr501_of_match[] = {
 	{ .compatible = "liteon,ltr559", },
 	{ .compatible = "liteon,ltr301", },
 	{ .compatible = "liteon,ltr303", },
+	{ .compatible = "liteon,ltr329", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltr501_of_match);

-- 
2.55.0

