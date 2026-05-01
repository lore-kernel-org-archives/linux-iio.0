Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291713806C3;
	Fri,  1 May 2026 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626922; cv=none; b=g+EBAFnnxEoeDi8ZVXYAollTez94XheFKVSxXWaZj5hH0mU1F8Gk9Nqh7ULldv75Tgl6bhp7d4njCCG7UbFC4J9G4Zon+8MOchZZxLRlaoZIT4hvwQ+Tfgw5OPd6R2WRjiDvYs1nMcic4OQTJLyyuz1R1YSLrZL69sQYAgPQMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626922; c=relaxed/simple;
	bh=fsH1jPF6Bh/zdH62+5u0lhafUJIHMmkjNiDxO+DqKUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BT1oIZnCWS5GR0Tef+KkoBe2x3LpMKDKLnst1u7vM1SFAqJ4jxKV00yebCY6B6BE/fq8pR+gZMPzA/RZPgBdjr/FrFTdlAVAsvog+ckVREqySQ8jeg04OsSVlATIwMgtx8ITVdaBgZH/ZtLwNFCP1QVqiLeNNkSj9V2bhg+gdFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzZhja0Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzZhja0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F029C2BCC6;
	Fri,  1 May 2026 09:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777626922;
	bh=fsH1jPF6Bh/zdH62+5u0lhafUJIHMmkjNiDxO+DqKUw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KzZhja0QJ74GVZPix2avt7C/RkEdsMMAp8Nhc9jLqF3TxsiI9JOWRkraLEKQHKboy
	 3Af7Q9i+Pjby0kW/asy91khWUdMn7Aw95FgR3T8ut0AFL/u6LEeUGt1LBpcLf16/A5
	 9YUJT7p6W+VHoPAEc8NlxE/lmwiBKQoOVWLMB3IJXECabgZJhfA/eM3cAnMUV7dxC2
	 fdNdptDnpvyjO0npOodKP3X4tEZ5tPVf96Ex+VaatL833Gs9FJoUJkt6EYc0pqeL4f
	 ewTYRcGKao2EoOyU2Mg3xROeVgLxDVzsKS3p8ZLTdCQTR2RPJ7wRPKtw3NtJ1buG6C
	 M3ZISoaV75u1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086E0CD3425;
	Fri,  1 May 2026 09:15:22 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 01 May 2026 10:15:02 +0100
Subject: [PATCH v5 09/12] iio: dac: ad5686: add helpers to handle powerdown
 masks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ad5686-fixes-v5-9-0b2f45488418@analog.com>
References: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
In-Reply-To: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777626920; l=4174;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=LfdwOv6cXWsUcCzXJnTuYHrsc0qYNTRQXLs9jOjn8go=;
 b=gNPrM9AripfmxspgYnrMtaO/ZssbPQtrXIE9LUZxPJY+ntbITju2c/wMvHkfu9d1ijs79PZzi
 qWjZCCg5syLCDTcDpsVllaGLBY3YJUCtwhfcdasQmmct7FpL8zSi3GF
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add ad5686_pd_field_set() and ad5686_pd_field_get() helpers to cleanup
powerdown mask control. Define AD5686_PD_* constants, like AD5686_PD_MSK
to hold powerdown mask value for a single channel.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 43 +++++++++++++++++++++++++++----------------
 drivers/iio/dac/ad5686.h |  5 +++++
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 4bcabdbaf1d8..4b279d46948d 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -33,26 +33,39 @@ static inline unsigned int ad5686_pd_mask_shift(const struct iio_chan_spec *chan
 	return __ffs(chan->address) * 2;
 }
 
+static inline void ad5686_pd_field_set(const struct iio_chan_spec *chan,
+				       unsigned int *pd, unsigned int val)
+{
+	unsigned int shift = ad5686_pd_mask_shift(chan);
+
+	*pd &= ~(AD5686_PD_MSK << shift);
+	*pd |= (val & AD5686_PD_MSK) << shift;
+}
+
+static inline unsigned int ad5686_pd_field_get(const struct iio_chan_spec *chan,
+					       unsigned int pd)
+{
+	unsigned int shift = ad5686_pd_mask_shift(chan);
+
+	return (pd >> shift) & AD5686_PD_MSK;
+}
+
 static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan)
 {
-	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	return ((st->pwr_down_mode >> shift) & 0x3) - 1;
+	return ad5686_pd_field_get(chan, st->pwr_down_mode) - 1;
 }
 
 static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     unsigned int mode)
 {
-	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	guard(mutex)(&st->lock);
-
-	st->pwr_down_mode &= ~(0x3 << shift);
-	st->pwr_down_mode |= (mode + 1) << shift;
+	ad5686_pd_field_set(chan, &st->pwr_down_mode, mode + 1);
 
 	return 0;
 }
@@ -67,10 +80,10 @@ static const struct iio_enum ad5686_powerdown_mode_enum = {
 static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
 {
-	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask & (0x3 << shift)));
+	return sysfs_emit(buf, "%d\n",
+			  !!ad5686_pd_field_get(chan, st->pwr_down_mask));
 }
 
 static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
@@ -91,10 +104,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 
 	guard(mutex)(&st->lock);
 
-	if (readin)
-		st->pwr_down_mask |= 0x3 << ad5686_pd_mask_shift(chan);
-	else
-		st->pwr_down_mask &= ~(0x3 << ad5686_pd_mask_shift(chan));
+	ad5686_pd_field_set(chan, &st->pwr_down_mask,
+			    readin ? AD5686_PD_PWR_DOWN : AD5686_PD_PWR_UP);
 
 	switch (st->chip_info->regmap_type) {
 	case AD5310_REGMAP:
@@ -467,10 +478,10 @@ int ad5686_probe(struct device *dev,
 
 	/* Set all the power down mode for all channels to 1K pulldown */
 	for (i = 0; i < st->chip_info->num_channels; i++) {
-		shift = ad5686_pd_mask_shift(&st->chip_info->channels[i]);
-		st->pwr_down_mask &= ~(0x3 << shift); /* powered up state */
-		st->pwr_down_mode &= ~(0x3 << shift);
-		st->pwr_down_mode |= 0x01 << shift;
+		ad5686_pd_field_set(&st->chip_info->channels[i],
+				    &st->pwr_down_mask, AD5686_PD_PWR_UP);
+		ad5686_pd_field_set(&st->chip_info->channels[i],
+				    &st->pwr_down_mode, AD5686_PD_1K_TO_GND);
 	}
 
 	indio_dev->name = name;
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index caadc7403da1..6b7142fbade2 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -47,6 +47,11 @@
 #define AD5683_REF_BIT_MSK			BIT(12)
 #define AD5686_REF_BIT_MSK			BIT(0)
 
+#define AD5686_PD_MSK				GENMASK(1, 0)
+
+#define AD5686_PD_1K_TO_GND			0x1
+#define AD5686_PD_PWR_UP			0x0
+#define AD5686_PD_PWR_DOWN			AD5686_PD_MSK
 
 enum ad5686_regmap_type {
 	AD5310_REGMAP,

-- 
2.43.0


