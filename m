Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794986999;
	b=pNFjJS0StA1Ds7QlboPKCDhIN9WfvvbTNJ89CnFeAAD286xRsqp9saZPBJ36RbktvNva
	 tquRHpwjHh3hwAPZ3hMMFq+jt6Dq9RhfGpTxt9YCdMCc/bn2/26suYaFD1LLjz16mPJmk
	 g4BhTzIBSlzPgSyq9px+Ifnc5r06wrfelBm+aHqwkPXE901qGf65sGO1Zetl/Bb/IwWoW
	 pG0T1kOe7ItvOe1I5cif00oAucXCpiUkzkfE74wcG9ds7XVD9gL6IdfW3KNopWRBM8sZB
	 3eYhJlzmurN6xcR/9hrlagQnmJGRuP8Na9UpAaFYhbb/wsQD6nRP2tPguSFo4Hl43dA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986999;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fYeKCFr17a4V/OB8ghJ5oXVnr7NbQWC0hZeUiNcoBuo=;
	b=RPxVAMXTQlAtKMR2DnETo1qCrcoEO7zKhh5ArfP/fvMOamqXhS8/L6kD0qfQmmmFM6w2
	 Z7q/kWyuLCxOGmooMbklBPqdTm0Ng1Ib+dHpcc5pFEaKwYzswkpvGa7LHqTub0tKGih7O
	 PpsgY5lF3m6SYTzM8fPGNKHkktvT7BFnnpTBqWwimCMUfefc/GoNwXgKGXP6IZp5ogccq
	 1jVyd7m5WazHvHND9w4rdZPvXo4Ep5oWTeT03fgFwfwwqzzxmY0ea9uTTxdDHLOMSrIss
	 LzaPrAxq/edP676etTZS3NjVcIzVjYxIgJ/Cz6zs8Gujf6xlKQER7y6vyJy1S85wrZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjwtnMUP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F91606A325;
	Wed, 18 Nov 2026 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjwtnMUP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794986999;
	b=kva0T8LClztZ4oHuED5UVQS+pgUtai19V01hFXz08P019ep7z6bWm+fikQNWiVCXc1J7
	 TeeSQvqs8+Yf4T6fXs6nnFP80yOFMYmyJnxRntNqHg8/vRieYmv6NWBEAp0etiv7lPm9N
	 XeiwWad6l5xm/dxix8iJ4/bI0ZALBaTkNiGdDRXSFCNh1Hu4UKPvkxlM/IuqD/IOGfNWS
	 CMCdL43G4Az6JodH9kE5X1PhqtR8TfYQdJzjuwKRPMx/tLjxhGjg+Ee1VKhRXIWZKkppx
	 ab1eA4ozJif7hJYjwt8O3dVYDdiKJ5JcWNBbk34yJoZ7/ALaqIZXA8by+9m9dXEnIhg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794986999;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fYeKCFr17a4V/OB8ghJ5oXVnr7NbQWC0hZeUiNcoBuo=;
	b=m9nih/JuMyRC14pCNscgm3UwKV96Wrzss0YqI/BFh7ge4x1Pol16O85yunk+iyXRn8IX
	 +il3HfCIUDMWC1P2Zz8Utj1BuL0zObml1xk99kbzIA0mT4PIMmhb7SbQPcbM7rFeZEyHl
	 YX8DaTxHqsJLkMNmZ42AO6103TihVkQVMGJBxcLceg0uGwjYiHvtCgFez60j/z7Or9/44
	 tu3q5HzZ3ijBACY0MyWRB+gyXu687ZzEx2xtoHYfKv8NL34zBbcvFWUwYM7/Hdto5DPEi
	 rrQRBrT+DJW0PhlKpTSQK3VWklPDhRrI/Ffu/10QsSBQdYm4UZfiKjxWQmUGuWuxkwQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 797341F000C5;
	Wed, 18 Nov 2026 07:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794986999;
	bh=fYeKCFr17a4V/OB8ghJ5oXVnr7NbQWC0hZeUiNcoBuo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QjwtnMUPqCtWEVHPdIHOwEqq1WpDUL1UpSG1DThWMmVDeHU/eAEl2wYSMEXP0MAZc
	 Cx4/ntFjKkJcmo7rGUzRPD8gm0Th34gV8o3F5BIaIwld3nmfxaLlTNZ8m4zJKMvvPo
	 7+5mRtUzBQOIDQRm/MwJ8F919oOdKNhYSgKr8EwzH1e1L5S3z9QIoo5OVL8C9oNHJ4
	 /MwCjoM1/yHn59VlogByckXC/+F1+BRX31fs44FaoMDp0I6OOVawx2t5hVfrl+kcG8
	 rTQ2Zpzv7ZxX2XMZuB8Fq8nJZbNZhSqYgqhdMKPLLIJbM1oZKUVA+5JvOCGHhO2Ohw
	 cc6D5EKtjzTBw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 06AD24AC47;
	Wed, 18 Nov 2026 07:29:58 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Wed, 18 Nov 2026 07:29:54 +0000
Subject: [PATCH v3 1/2] iio: light: adux1020: use guard() to simplify lock
 handling
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
Message-Id: <20261118-adux1020-guard-v3-1-2c6a18954fc7@gmail.com>
References: <20261118-adux1020-guard-v3-0-2c6a18954fc7@gmail.com>
In-Reply-To: <20261118-adux1020-guard-v3-0-2c6a18954fc7@gmail.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>, 
 Joshua Crofts <crofts@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794986997; l=6315;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=DMtHrOaeoSbk69l93gv+SBOwCJ/sq3BfFEE9UbzKpVM=;
 b=fEXS8coQDCkDBlpSSLJkLT1MpCdBCZyfdktBYJRrZ1oXuDMfUB6XPy27wYJxxW55Owokn1FPd
 f+pyeGHhXGmDUR6KylinD9g8mTcaNlC1GEkUR438ZfS1LdQwCHxkZbI
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com
Content-Transfer-Encoding: 7bit

From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

Use guard(mutex) in adux1020_read_raw(), adux1020_write_raw() and
adux1020_write_event_config() so the lock is released automatically on
return. This allows returning directly instead of jumping to a common
unlock label, and lets adux1020_write_raw() drop its ret variable.

No functional change intended.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Joshua Crofts <crofts@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
 drivers/iio/light/adux1020.c | 104 ++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 65 deletions(-)

diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index 6b32c5be4753..b595faf4abc5 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -362,10 +363,10 @@ static int adux1020_read_raw(struct iio_dev *indio_dev,
 {
 	struct adux1020_data *data = iio_priv(indio_dev);
 	u16 buf[3];
-	int ret = -EINVAL;
 	unsigned int regval;
+	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -373,69 +374,56 @@ static int adux1020_read_raw(struct iio_dev *indio_dev,
 		case IIO_PROXIMITY:
 			ret = adux1020_set_mode(data, ADUX1020_MODE_PROX_I);
 			if (ret < 0)
-				goto fail;
+				return ret;
 
 			ret = adux1020_measure(data, ADUX1020_MODE_PROX_I, buf);
 			if (ret < 0)
-				goto fail;
+				return ret;
 
 			*val = buf[0];
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		default:
-			break;
+			return -EINVAL;
 		}
-		break;
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_CURRENT:
 			ret = regmap_read(data->regmap,
 					  ADUX1020_REG_LED_CURRENT, &regval);
 			if (ret < 0)
-				goto fail;
+				return ret;
 
 			regval = regval & ADUX1020_LED_CURRENT_MASK;
 
 			*val = adux1020_led_currents[regval][0];
 			*val2 = adux1020_led_currents[regval][1];
 
-			ret = IIO_VAL_INT_PLUS_MICRO;
-			break;
+			return IIO_VAL_INT_PLUS_MICRO;
 		default:
-			break;
+			return -EINVAL;
 		}
-		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan->type) {
 		case IIO_PROXIMITY:
 			ret = regmap_read(data->regmap, ADUX1020_REG_FREQUENCY,
 					  &regval);
 			if (ret < 0)
-				goto fail;
+				return ret;
 
 			regval = FIELD_GET(ADUX1020_PROX_FREQ_MASK, regval);
-			if (regval >= ARRAY_SIZE(adux1020_rates)) {
-				ret = -EINVAL;
-				goto fail;
-			}
+			if (regval >= ARRAY_SIZE(adux1020_rates))
+				return -EINVAL;
 
 			*val = adux1020_rates[regval][0];
 			*val2 = adux1020_rates[regval][1];
 
-			ret = IIO_VAL_INT_PLUS_MICRO;
-			break;
+			return IIO_VAL_INT_PLUS_MICRO;
 		default:
-			break;
+			return -EINVAL;
 		}
-		break;
 	default:
-		break;
+		return -EINVAL;
 	}
-
-fail:
-	mutex_unlock(&data->lock);
-
-	return ret;
 };
 
 static inline int adux1020_find_index(const int array[][2], int count, int val,
@@ -455,9 +443,9 @@ static int adux1020_write_raw(struct iio_dev *indio_dev,
 			      int val, int val2, long mask)
 {
 	struct adux1020_data *data = iio_priv(indio_dev);
-	int i, ret = -EINVAL;
+	int i;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -465,15 +453,13 @@ static int adux1020_write_raw(struct iio_dev *indio_dev,
 			i = adux1020_find_index(adux1020_rates,
 						ARRAY_SIZE(adux1020_rates),
 						val, val2);
-			if (i < 0) {
-				ret = i;
-				goto fail;
-			}
-
-			ret = regmap_update_bits(data->regmap,
-						 ADUX1020_REG_FREQUENCY,
-						 ADUX1020_PROX_FREQ_MASK,
-						 ADUX1020_PROX_FREQ(i));
+			if (i < 0)
+				return i;
+
+			return regmap_update_bits(data->regmap,
+						  ADUX1020_REG_FREQUENCY,
+						  ADUX1020_PROX_FREQ_MASK,
+						  ADUX1020_PROX_FREQ(i));
 		}
 		break;
 	case IIO_CHAN_INFO_PROCESSED:
@@ -481,24 +467,19 @@ static int adux1020_write_raw(struct iio_dev *indio_dev,
 			i = adux1020_find_index(adux1020_led_currents,
 					ARRAY_SIZE(adux1020_led_currents),
 					val, val2);
-			if (i < 0) {
-				ret = i;
-				goto fail;
-			}
-
-			ret = regmap_update_bits(data->regmap,
-						 ADUX1020_REG_LED_CURRENT,
-						 ADUX1020_LED_CURRENT_MASK, i);
+			if (i < 0)
+				return i;
+
+			return regmap_update_bits(data->regmap,
+						  ADUX1020_REG_LED_CURRENT,
+						  ADUX1020_LED_CURRENT_MASK, i);
 		}
 		break;
 	default:
 		break;
 	}
 
-fail:
-	mutex_unlock(&data->lock);
-
-	return ret;
+	return -EINVAL;
 }
 
 static int adux1020_write_event_config(struct iio_dev *indio_dev,
@@ -510,16 +491,16 @@ static int adux1020_write_event_config(struct iio_dev *indio_dev,
 	struct adux1020_data *data = iio_priv(indio_dev);
 	int ret, mask;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ret = regmap_write(data->regmap, ADUX1020_REG_INT_ENABLE,
 			   ADUX1020_INT_ENABLE);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	ret = regmap_write(data->regmap, ADUX1020_REG_INT_POLARITY, 0);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	switch (chan->type) {
 	case IIO_PROXIMITY:
@@ -535,7 +516,7 @@ static int adux1020_write_event_config(struct iio_dev *indio_dev,
 			ret = regmap_set_bits(data->regmap,
 					      ADUX1020_REG_INT_MASK, mask);
 		if (ret < 0)
-			goto fail;
+			return ret;
 
 		/*
 		 * Trigger proximity interrupt when the intensity is above
@@ -544,20 +525,13 @@ static int adux1020_write_event_config(struct iio_dev *indio_dev,
 		ret = regmap_set_bits(data->regmap, ADUX1020_REG_PROX_TYPE,
 				      ADUX1020_PROX_TYPE);
 		if (ret < 0)
-			goto fail;
+			return ret;
 
 		/* Set proximity mode */
-		ret = adux1020_set_mode(data, ADUX1020_MODE_PROX_I);
-		break;
+		return adux1020_set_mode(data, ADUX1020_MODE_PROX_I);
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-fail:
-	mutex_unlock(&data->lock);
-
-	return ret;
 }
 
 static int adux1020_read_event_config(struct iio_dev *indio_dev,

-- 
2.56.0


