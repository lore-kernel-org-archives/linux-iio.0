Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794899465;
	b=AynHTGiqfiDCNYXXzqUbIv6OQATBRZcv5WKSulEV+/Dtr+sm0Tub/icohiIr8TWpdxKy
	 IlrgLgJ1tIu6/EUUc+Rxd2ElvWDB6YrpavGYjHxe3aF2YxySMjYgrSnO1yDqUPFXpWGVn
	 iOc0b2fF+AgtD03she+YwHwGdWvgjnZjmJSdNaIavdJwyEm0OSVqjqP3+xH1TBQgwr0GP
	 93rxZ02LYiAqeGAy+cK99n72isvSBIoZn9aJu63um8SxxyHT2G3BDPxiB735VlON7z/dW
	 sRKkHFboCCj2TImnryNd2LsQ+GrzwtPWIP0XoYaEUEtLyGA5ZqYfL1YTxmfNZomwMJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899465;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fYeKCFr17a4V/OB8ghJ5oXVnr7NbQWC0hZeUiNcoBuo=;
	b=KKfF0EjJRMBbFOonIjNWhQyNVGucK0w28IMGuYXSIsAdSmH4oX4Ys13fqXG8vr+wmdXS
	 SyRjBf3BR+KxuRB9LGMu7Kt0TQqVlBhiiu2PAkol7/E1+pge0AKyqKciHPO6esaNYhDaw
	 2fh1fKDE5tJEa/WK7Q/SI4I6LurKy4JDsnInPpwgcVPLZEEnE1DpbLBJAtp/yDBcm/fkZ
	 V7E6XA5ZakSaTDTAYZ+yelhATWBepJqSlZF/PVByXw0o2m9qRfPaWX3S9I4SJsTTFGKk6
	 NuIqJeF5m6uQqcLsVGdM4DgUDqOLGfw6TOs34ULQ41yJjbmASILchFpTs8SGUlHOzWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkeQpZWj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F3E606A331;
	Tue, 17 Nov 2026 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkeQpZWj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794899465;
	b=o0hgQYerr4XC8xfKaBdOUxXMEZFVlGLimshs4WNqhOdZwZVWICPpKqQys/gpVTATDaYu
	 KySdBm7MIDmfAcy34eoPuuPTC0lJcMmvdeSPu7Eavt96T7/XFRdv6EO3xEzAT6D7HacwM
	 A+1tf5XdF7+S44nEVi33tl+HN3KGjdGAyrJTxQOLMLgDKElwX+ZgmkP7w7i9l2saklxeo
	 GryBzQzO0kCcu3apD2rDova/JuitU4dYEF96EITyBrGJHZTUQ8xJ0eyvLs1FDLUr6Hni9
	 AUsnwrdCCsRnZEE6TqtECt+f39FJf4Ei8YxrhM2LuAktQiTcT8AJB55b+rX/kHLTB+g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794899465;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fYeKCFr17a4V/OB8ghJ5oXVnr7NbQWC0hZeUiNcoBuo=;
	b=1PzIpgxjX+ynhPSVC4mr8S/GtDSfwk03H2xdRIY1ByMD9mBAEbRMhhrZpVY0JyHIABy9
	 3+AoSYwY+QPghuAjG1hoVyBH5GpDeAm+zZib7W91W5nnTnqA8XfFzDKqh0WifDyn+K5Pi
	 MLfdnIQhzoxbSn47qDPxKojJkLfHxPjAqu1GTtrwOqJYPX3O1GVby/bqdW3xSDLsuZ1lr
	 Sl8wwajkUlFNuE7iZ/g0SQXFnSFEHs6yoiJHxg82cY4UVYMjkmAsZeH3ZRgM+CBDMxmZL
	 ZypwcQzhJ59wQBdwnLK1EO8T8cTSKJHvSVVg1EPZRpUgIBNjNUphtnkMKjOF8Dslu5Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3BD7F1F000C7;
	Tue, 17 Nov 2026 07:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794899464;
	bh=fYeKCFr17a4V/OB8ghJ5oXVnr7NbQWC0hZeUiNcoBuo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IkeQpZWjFi4LA8K+w7tZ4KUwhGcpj4v6711Z5mG/o+tZ+XcbcHOOOj1ANS+FVtELz
	 Fotkl4cjuc8uod4LC+pplCIJeAvL9kENee8/jre/j1ekcg06/naMhCL/N/FF5N43lK
	 +lkes2ZUMPUN++7+YcreL2qMLy4UkiFHx0TvGP2tqw/3H9fs9Wlh22s1Gc3aZRT3ge
	 jlsBMK7jxNI5DQ6xcRoZsfnU7M425jwifqc2xgL/gbkHuWWDsr/cvaSHwvaqMK1//9
	 TMB9EivZcKu9Xe+/nV8Fb5RAdma0o+DkSJ3zkOiqee6skvbx4udafZ1PtYG6RhjlsI
	 YlHMC4i14zkXA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B7FDB4A712;
	Tue, 17 Nov 2026 07:11:03 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Tue, 17 Nov 2026 07:11:01 +0000
Subject: [PATCH v2 1/2] iio: light: adux1020: use guard() to simplify lock
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
Message-Id: <20261117-adux1020-guard-v2-1-89707fa070c9@gmail.com>
References: <20261117-adux1020-guard-v2-0-89707fa070c9@gmail.com>
In-Reply-To: <20261117-adux1020-guard-v2-0-89707fa070c9@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794899463; l=6315;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=DMtHrOaeoSbk69l93gv+SBOwCJ/sq3BfFEE9UbzKpVM=;
 b=H8G2eQgqXeJh0DzOySO8+SPstBO/OaWHnTSAFK9hK3Rjp8nP9Axo8xs94rbPOFsaTkd/n92l0
 ICU36QoCfZ2AqvnvsKbcFG1kN8zi8pZ0oXKUlitRVAFfqL7OxobQ8pX
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


