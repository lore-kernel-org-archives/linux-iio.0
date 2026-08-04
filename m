Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C8485504
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862999; cv=none; b=SC3EBoE+rjFjiXsrOakLxKrELae2Ds12Vgjfh4Pph0t1b5Plw4cXalHVpqsfKCZ2cgNCjEKid4kqlB66uZga8D/RySV9zcICGnuQn42DUhCeSljJmghz07Ykj73iF5ytNcIPp5eRfwncZDlQQUrlSvlZB9w4zv86wqNjxa4ZhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862999; c=relaxed/simple;
	bh=uhh+05uz8LcoPPQbMVpi/sd93nGPonQ4lc8EQ8qC7Es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DvDe0USLW/+EfvgoXcBDeD9kX6h2ZUbAkZgeTJLcVQ7u5eP2KibCt/Y1j6C7mGD/sAwBFx0bU4u+125nJ9Kg3Mo2qvlpJPgCUEuO7BaKz59WFQJvqVN14ZeQgpoS7y4Q5wk2OPQYReUF9I8mn/es/zNyKoxqW5lWnk5r14v51Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=iycGRAjN; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="iycGRAjN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785862963; x=1786122163;
	bh=wYuTCzJgQQQN8D13XXNxpJjZiLh5lRfz2NNmdAZMVBE=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iycGRAjND7a6It6bq4wIOWhaqexYTB/AS+tULb+nRlPhST/BrN3GmZ/0eQGGby0V9
	 tHRt2EPLBl6ZjN5n+ZF0jtFZvpPsvchmHH4+7paN6YPAt2p/hWNdEtU6ukCn+PteKv
	 n8wv2Axglaqdwj4T4jXd4zUHd7PYZ/CD0MU8GJ0oIF810WCR/g3L3IDw5bCP7MjHtY
	 3ZQGtHtUYs/CcXfizWmYrCrEHyLF4T1pEkQuGr1/fb9Op/fZkvbl2mcVJevXEz127O
	 +y2Yy4v7nVLDgWr9VXrLBWXYUqNVGIlZYpyhN8JsjVZczPECkjHhBZRYg02n0jq12B
	 NKFwkCVHzRIlw==
X-Pm-Submission-Id: 4hF0GT3YNfz2Scd7
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 04 Aug 2026 19:02:16 +0200
Subject: [PATCH v3 5/6] iio: light: ltr501: Add ltr329 driver support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-liteon-ltr329-v3-5-c6b768c7c745@geanix.com>
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
In-Reply-To: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785862947; l=4450;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=uhh+05uz8LcoPPQbMVpi/sd93nGPonQ4lc8EQ8qC7Es=;
 b=gnztkhtQA9ggR2JXcLNPbxfWbfiP7Y3EPgEmibxTkzKzR0mJHVvVlf4H4JR1Gm+38Ae/nNTmZ
 owibJy6JFEIBCTFed1PouPMkVTitVecxTAIducHKnN4KFxuygEYCPOZ
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

This adds support for the LTR-329ALS-01 chip, which is similar to
LTR-303ALS-01, except for interrupt, which LTR-329ALS-01 chip does not
have.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/light/ltr501.c | 48 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index b36bd10a0262..9d37872ceec5 100644
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
@@ -1531,6 +1559,12 @@ static int ltr501_probe(struct i2c_client *client)
 		return ret;
 
 	if (client->irq > 0) {
+		if (!ltr501_has_irq_support(data->chip_info)) {
+			dev_err(&client->dev, "chip does not support irq\n");
+			ret = -EINVAL;
+			goto powerdown_on_error;
+		}
+
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, ltr501_interrupt_handler,
 						IRQF_TRIGGER_FALLING |
@@ -1601,6 +1635,7 @@ static const struct i2c_device_id ltr501_id[] = {
 	{ .name = "ltr559", .driver_data = ltr559 },
 	{ .name = "ltr301", .driver_data = ltr301 },
 	{ .name = "ltr303", .driver_data = ltr303 },
+	{ .name = "ltr329", .driver_data = ltr329 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
@@ -1610,6 +1645,7 @@ static const struct of_device_id ltr501_of_match[] = {
 	{ .compatible = "liteon,ltr559", },
 	{ .compatible = "liteon,ltr301", },
 	{ .compatible = "liteon,ltr303", },
+	{ .compatible = "liteon,ltr329", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltr501_of_match);

-- 
2.55.0

