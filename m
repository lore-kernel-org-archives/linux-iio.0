Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794899465;
	b=CHmHV0eJH4Ox7dPzFK1iMy0aHJU02+HvdxHT0+PlPNYYpl6MoXQazNUpHE6EHpuTT9B9
	 vclBb+CiOFs/pTWicAftd6dIxD5SP7oaMqDHD7I7nAYhO6JrOdNDR9fjJOVqWQ+wI0MbW
	 ZfKwF+iFVn3bNHe5nM7KYQTCbWQr+j7PdMZbVU/yi27Pq+FCcPSLeEc9Wpav5OqVGq9Df
	 aCSrH9QQxSShw1hAHDCvoMg/FfA007K4X/mknmoOsQGZuSuJ2jTWdaLZFJ3oasJDKTQNB
	 mmi+e6Fh/5SUOG1OE7G2GlOJc2LNv9qo2cnAr0b+gZYlQJ53wu9raI7qPXcVfHFi1Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899465;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5TXKbTb1nF7F0trHANUV8CeqsCneXL5g0PCAbz5kO+o=;
	b=4kXSS9NBhqZDKUHqS739wmL5qT70yX3JafiEmzzA9F1TzLwWkqYnKkL+5BHwHtfNoNAZ
	 pD5OvnBOtKkvO8wlElQk6PW20O3ux/kvTeVtVl8HsTbgouSXF4ENyCGFb6gpWdqwX4Eb3
	 6ABHWVFqX6OS5gPVIq1xZJufZAxdUIXkOcvaVzdp+Qg8VSGQ+mh4rv34u4zdgFkunmcGi
	 E1cwwPVzDB7X4G0VicczRHH8UHpOWM8zOnvnNklJEf+RwyxxJsAJvSS73qJcJ8vIvrYVs
	 K7j487uXjpktTfLanqy5dSHnaoKLazBJDsLI3frUWg/QowA+nJCyXD8sAhkk4WpK/pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLUNlrZM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7AC606A334;
	Tue, 17 Nov 2026 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLUNlrZM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794899465;
	b=h5/+Un4pZEdDOMmcjHQejXQyoRc/UYHBWAiZW6MCkX9qijq/sZBEEjnbTbOr+I+Ee0PW
	 R2L4LgYLqI55onJshUCMixoAvpUsA06VNtYulHnTl2v3v6ihl2lwMcbc9hYqFlToIlsX6
	 Hk5gjGhNIQV7dCGXF6oi0lg4FP97fm0I1lNXonY8A2LxXGwSgg8Tk1rm2LsiX62qOM93f
	 2NNxP4/uL7Yp9A2KOEieP3fsvnyN0/Kg82/oGi4N8mDv9BwpQrYMF+M/SBozNXXL/w9f4
	 pYAWc1D80W7UmcUWAIVoDmLTSnLfLFaZ/hGgrB8iTTi7owYt9vAQrPLwN/Dj63/8tbA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794899465;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5TXKbTb1nF7F0trHANUV8CeqsCneXL5g0PCAbz5kO+o=;
	b=fHRdT+BrDq+54sNlo8xL7Y/fI8jk+yLO6n1xo0LaNvPngig0pV/T2rC80pfTDrGtj2LK
	 hV/GfyrB2TEQzeg/zw8TDVesnqsNGVsn1sO/b3UCdYvOo2r0F73EupY6bUK6jVt/rT8D4
	 ZzC7gA4xkyxSDhCvglm1Uual7L9x3L1SXJzeeQMeZbhZUcvkT4JoggRHos5fqrBAq0NE9
	 3ECXBk5+e6QuC8gKFfpfj82e8ujFm8YHmqdyubzDf/zb1Fg4z1RQpSNt+boCVHFoOC7Jn
	 WBEkcunyWN0siwRNGbJaVYK9Phghj0VpTLKztIerrQstwDQvgw3PEzzqVppv2VaQJ8w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4E60E1F000C8;
	Tue, 17 Nov 2026 07:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794899465;
	bh=5TXKbTb1nF7F0trHANUV8CeqsCneXL5g0PCAbz5kO+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=RLUNlrZMtgX4QwF/eZ8sizzrpSNZQBAIppKEbLVEQ1EOfwi1dzmZ/JbWLydabUp3a
	 rLQxe9cf0olBzVT42F1z1cOmqUTnAAszap8PTOc+lzYbhJQxxmocue+jvIL8rKcYZ2
	 mNvWzqsKixZkH5N2RbCxBv+05xC6PGCWAOXgffk/b2kDaJKdOb3gk043qBrLK9Qy8A
	 CsriQ5Negbu1RoybriQMOxUE5AIegqGF0QqecmI2daFX75y2zILFka/gNRS2P560C6
	 wxzqKxNSob3LSIZGIgOkLFkOvyBVgEw0qJkUPk4aeLPupAtaCIEq33qnKm7Ba02nV9
	 8H8K+AutMQOTg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CDA2C4A715;
	Tue, 17 Nov 2026 07:11:03 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Tue, 17 Nov 2026 07:11:02 +0000
Subject: [PATCH v2 2/2] iio: light: adux1020: return early on unsupported
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
Message-Id: <20261117-adux1020-guard-v2-2-89707fa070c9@gmail.com>
References: <20261117-adux1020-guard-v2-0-89707fa070c9@gmail.com>
In-Reply-To: <20261117-adux1020-guard-v2-0-89707fa070c9@gmail.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794899463; l=5018;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=Mb4JTj/5n+0Q7IBjaPH3v6RUZj2Y9BygVBPXXhkxAvI=;
 b=i2c0tLU/q3Y07UFEJ8eWf41SejLcLc4ifsRfevxra1gfuR6YGpRNnaBcOEhu7k6ZnC3NLGlXt
 RKZ/+hHeQDbCpUbwf9E2s8oN8uV7ycxQ/Hzh0kLejopOZ+wQkWB9t97
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

While at it, drop the stray semicolon after the closing brace of
adux1020_read_raw().

No functional change intended.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
 drivers/iio/light/adux1020.c | 131 ++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 70 deletions(-)

diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index b595faf4abc5..afb0798a2894 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -370,61 +370,56 @@ static int adux1020_read_raw(struct iio_dev *indio_dev,
 
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
+
+		ret = adux1020_measure(data, ADUX1020_MODE_PROX_I, buf);
+		if (ret < 0)
+			return ret;
 
-			*val = adux1020_led_currents[regval][0];
-			*val2 = adux1020_led_currents[regval][1];
+		*val = buf[0];
 
-			return IIO_VAL_INT_PLUS_MICRO;
-		default:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PROCESSED:
+		if (chan->type != IIO_CURRENT)
 			return -EINVAL;
-		}
+
+		ret = regmap_read(data->regmap, ADUX1020_REG_LED_CURRENT,
+				  &regval);
+		if (ret < 0)
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
 			return -EINVAL;
-		}
+
+		ret = regmap_read(data->regmap, ADUX1020_REG_FREQUENCY,
+				  &regval);
+		if (ret < 0)
+			return ret;
+
+		regval = FIELD_GET(ADUX1020_PROX_FREQ_MASK, regval);
+		if (regval >= ARRAY_SIZE(adux1020_rates))
+			return -EINVAL;
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
@@ -449,37 +444,33 @@ static int adux1020_write_raw(struct iio_dev *indio_dev,
 
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
+					ARRAY_SIZE(adux1020_rates), val, val2);
+		if (i < 0)
+			return i;
+
+		return regmap_update_bits(data->regmap, ADUX1020_REG_FREQUENCY,
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
+		return regmap_update_bits(data->regmap,
+					  ADUX1020_REG_LED_CURRENT,
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


