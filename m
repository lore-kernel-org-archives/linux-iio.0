Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794986999;
	b=wzHc+dNEC3iIfaxt2c8fm9UcaHBmTl/R/wsf31fbTM0hDYzllexGb89jCA0eJ9P3ZjAP
	 EkD2WfzDo+VxOk+L2l32Bo2PwBp0Q9UCgn2CqrWiPDV+s5C1zo5DGFtaOoaMpGZkXephX
	 VLR/DPbUQKx1/c3zxJ3+wxYrnxES/y6Pc4dI0V47SZpGYmIKfgHnsdFUjAOEvVDDyAfG+
	 iAGLldkg1qU3gQGAuLXpj1dY/6bSeuT69urmjIPv3UQQJ/qhRYat4r9KuCf5MHmd/fTko
	 hnPPdYnUVQsY89+ZEmTBX0evZS8u/fm/P2CCaVaeygyJwfT2GKtgIUKMigQpkbNKtjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986999;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9cJ3Z2ak81fTuu5Dp44bW77EL9XkCB0tjULS+U+kd0o=;
	b=vRXh8+GCbWV2We+rOYIFl4Vc8mbGCkLMMuLZBThdyAktNcfMjh9cOFYhF8GGb1RWfGXK
	 5n5+x40frm7I9dDgomQEmawS9T2wJ1kfWtNpptTWWIh3NASrNSRkemgEX+xIVewWc71EK
	 NxowWEpiEYMNnpkI8N/30d3NKQfUDYaOjspd6IyoHoaLeDrRmNdxESsTXR5GFDhblZxT3
	 Z1rRyLkQGaWdRLdGmORDJxTYE4dOxePyWc/kULxDA+rp73k8AjTv/lEITVfp1CK9DCBRJ
	 Rj/3Xnm7ulvacdYP+z04bvy09CSTS8W4yKqncgJcBVdxt+N0NDBxbGfQITgX0kUanJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hl/7VkGZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85987606A32A;
	Wed, 18 Nov 2026 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hl/7VkGZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794986999;
	b=eiq7p/n5PZQFeLPQeL++FdyB3fLGdAL3tcKy6+jXE+f0TktT7OUtuZxr+5IN2xJVpqI8
	 yrx77/Ga7dFaJi8hWolJ1HGQ9AQhyKxPNiyVj7wyhIlYlsVDvujYe39vMxv1vy4moFCjh
	 O9IiVKOXn3hb5OfWJ1s4ihleGDn7aD5jV/2uTVIzKKL15WehA77gPf8Lzd+klsGOKYG0o
	 c6PRSm+X3ghHEj2C6GCsJvJUouAZnw3/adIP6j+91aBYEoZMpn7YykrlOeG4OY/56iyHP
	 7f65YTqv6Rryeb9t6aTJQYYjPEwhZmeUoYLy2BGzuj3hsdo7v8OtrxoMmhxqRSGVjcg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794986999;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9cJ3Z2ak81fTuu5Dp44bW77EL9XkCB0tjULS+U+kd0o=;
	b=fkADIUL7Dw19xC08Z4tyi/FkyNe0zX/TioWvCx/fTXW/kliRYS2MHM1noWJkZOXc/8j8
	 1KxuNQcggeLXcexYk/aCmAXEPuh/RGmw8mxZ21Cn4oSTqfH97T3KhMDtWCIYZvbRCyf5D
	 8o1xs0HPvlD1eKRNfAc0mjnjHpPb+6CCjO7/MbkUoffqlv2vqj5cllwzAoGjKjqLJ/i+R
	 uKKUjwEE0q8iWU/xriJhjDmRy6599NppFJjmHPzuPvxDMza4RlBF5s+esc4ty4yP9rbLd
	 ygfmmzqONujADzuOpCemSsOGKTBo0c8bTH4wvdoMPNZap4DnrOjnnLZLjgsAkIRnh5A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8D9671F000C6;
	Wed, 18 Nov 2026 07:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794986999;
	bh=9cJ3Z2ak81fTuu5Dp44bW77EL9XkCB0tjULS+U+kd0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hl/7VkGZgTXpQdTDKIKxRZu/lFZqK4d3y5vlmHs3KINvYEzXD0Pd52GocpDZTRyB6
	 gPXxvxHU1rZwo2USvWXd8eeGN5261/ISe8hiczlKNDqaZZzkT8ptA0XLM/QjnzNRDU
	 oVPxZ45RVMj4k4QIeJxYEazYUI8Ht88SStktPSK0XKJjNCcbCGKTJ87rU06aAYzPws
	 +wqviDqCFhC2up63fDGGLiHwUpFQ8IqoMxJCxZGBL67QMbbc4yNST/+ks0fQM1R+DM
	 8nvTXrA0V19sSOJxgwQE0uiaG1ghUR68DoSMERXAowZMKj6Cg1pVfWhfX20P7YfExz
	 bl8ZSSbWAFYew==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1D02C4AC4C;
	Wed, 18 Nov 2026 07:29:58 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Wed, 18 Nov 2026 07:29:55 +0000
Subject: [PATCH v3 2/2] iio: light: adux1020: return early on unsupported
 channel types
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261118-adux1020-guard-v3-2-2c6a18954fc7@gmail.com>
References: <20261118-adux1020-guard-v3-0-2c6a18954fc7@gmail.com>
In-Reply-To: <20261118-adux1020-guard-v3-0-2c6a18954fc7@gmail.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794986997; l=5621;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=MV8Ao7tH+kZOZGFAQwihjZFywcvb8hOVDmLBq0ZEOik=;
 b=y92lfZHFLsmTSDmXGNYuHYjI1hyYfPGoKkTax4EulSt/V6FTf5CFRhD3iKtF9MupJEsgzjB2K
 8c+ihzj5K1cDQuhQ3sfd7lXsJVj0nWyS3gMWiDY0wPrby1uNsR+fpnN
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com
Content-Transfer-Encoding: 7bit

From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

Now that adux1020_read_raw() and adux1020_write_raw() can return
directly, check the channel type with an inverted condition and return
-EINVAL early instead of nesting the work in an inner switch or if
block. This removes one level of indentation and makes the two
functions consistent with each other.

While at it, add a local regmap pointer in adux1020_read_raw() and
adux1020_write_raw() to shorten the regmap calls, check the return
value of regmap_read() with 'if (ret)' since regmap only returns 0 or a
negative error code, and drop the stray semicolon after the closing
brace of adux1020_read_raw().

No functional change intended.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
 drivers/iio/light/adux1020.c | 131 ++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 70 deletions(-)

diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index b595faf4abc5..5ee1994b6e50 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -362,6 +362,7 @@ static int adux1020_read_raw(struct iio_dev *indio_dev,
 			     int *val, int *val2, long mask)
 {
 	struct adux1020_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
 	u16 buf[3];
 	unsigned int regval;
 	int ret;
@@ -370,61 +371,54 @@ static int adux1020_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		switch (chan->type) {
-		case IIO_PROXIMITY:
-			ret = adux1020_set_mode(data, ADUX1020_MODE_PROX_I);
-			if (ret < 0)
-				return ret;
-
-			ret = adux1020_measure(data, ADUX1020_MODE_PROX_I, buf);
-			if (ret < 0)
-				return ret;
-
-			*val = buf[0];
-			return IIO_VAL_INT;
-		default:
+		if (chan->type != IIO_PROXIMITY)
 			return -EINVAL;
-		}
-	case IIO_CHAN_INFO_PROCESSED:
-		switch (chan->type) {
-		case IIO_CURRENT:
-			ret = regmap_read(data->regmap,
-					  ADUX1020_REG_LED_CURRENT, &regval);
-			if (ret < 0)
-				return ret;
 
-			regval = regval & ADUX1020_LED_CURRENT_MASK;
+		ret = adux1020_set_mode(data, ADUX1020_MODE_PROX_I);
+		if (ret < 0)
+			return ret;
 
-			*val = adux1020_led_currents[regval][0];
-			*val2 = adux1020_led_currents[regval][1];
+		ret = adux1020_measure(data, ADUX1020_MODE_PROX_I, buf);
+		if (ret < 0)
+			return ret;
 
-			return IIO_VAL_INT_PLUS_MICRO;
-		default:
+		*val = buf[0];
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PROCESSED:
+		if (chan->type != IIO_CURRENT)
 			return -EINVAL;
-		}
+
+		ret = regmap_read(map, ADUX1020_REG_LED_CURRENT, &regval);
+		if (ret)
+			return ret;
+
+		regval = regval & ADUX1020_LED_CURRENT_MASK;
+
+		*val = adux1020_led_currents[regval][0];
+		*val2 = adux1020_led_currents[regval][1];
+
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		switch (chan->type) {
-		case IIO_PROXIMITY:
-			ret = regmap_read(data->regmap, ADUX1020_REG_FREQUENCY,
-					  &regval);
-			if (ret < 0)
-				return ret;
-
-			regval = FIELD_GET(ADUX1020_PROX_FREQ_MASK, regval);
-			if (regval >= ARRAY_SIZE(adux1020_rates))
-				return -EINVAL;
-
-			*val = adux1020_rates[regval][0];
-			*val2 = adux1020_rates[regval][1];
-
-			return IIO_VAL_INT_PLUS_MICRO;
-		default:
+		if (chan->type != IIO_PROXIMITY)
+			return -EINVAL;
+
+		ret = regmap_read(map, ADUX1020_REG_FREQUENCY, &regval);
+		if (ret)
+			return ret;
+
+		regval = FIELD_GET(ADUX1020_PROX_FREQ_MASK, regval);
+		if (regval >= ARRAY_SIZE(adux1020_rates))
 			return -EINVAL;
-		}
+
+		*val = adux1020_rates[regval][0];
+		*val2 = adux1020_rates[regval][1];
+
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
-};
+}
 
 static inline int adux1020_find_index(const int array[][2], int count, int val,
 				      int val2)
@@ -443,43 +437,40 @@ static int adux1020_write_raw(struct iio_dev *indio_dev,
 			      int val, int val2, long mask)
 {
 	struct adux1020_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
 	int i;
 
 	guard(mutex)(&data->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (chan->type == IIO_PROXIMITY) {
-			i = adux1020_find_index(adux1020_rates,
-						ARRAY_SIZE(adux1020_rates),
-						val, val2);
-			if (i < 0)
-				return i;
-
-			return regmap_update_bits(data->regmap,
-						  ADUX1020_REG_FREQUENCY,
-						  ADUX1020_PROX_FREQ_MASK,
-						  ADUX1020_PROX_FREQ(i));
-		}
-		break;
+		if (chan->type != IIO_PROXIMITY)
+			return -EINVAL;
+
+		i = adux1020_find_index(adux1020_rates,
+					ARRAY_SIZE(adux1020_rates),
+					val, val2);
+		if (i < 0)
+			return i;
+
+		return regmap_update_bits(map, ADUX1020_REG_FREQUENCY,
+					  ADUX1020_PROX_FREQ_MASK,
+					  ADUX1020_PROX_FREQ(i));
 	case IIO_CHAN_INFO_PROCESSED:
-		if (chan->type == IIO_CURRENT) {
-			i = adux1020_find_index(adux1020_led_currents,
+		if (chan->type != IIO_CURRENT)
+			return -EINVAL;
+
+		i = adux1020_find_index(adux1020_led_currents,
 					ARRAY_SIZE(adux1020_led_currents),
 					val, val2);
-			if (i < 0)
-				return i;
+		if (i < 0)
+			return i;
 
-			return regmap_update_bits(data->regmap,
-						  ADUX1020_REG_LED_CURRENT,
-						  ADUX1020_LED_CURRENT_MASK, i);
-		}
-		break;
+		return regmap_update_bits(map, ADUX1020_REG_LED_CURRENT,
+					  ADUX1020_LED_CURRENT_MASK, i);
 	default:
-		break;
+		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 static int adux1020_write_event_config(struct iio_dev *indio_dev,

-- 
2.56.0


