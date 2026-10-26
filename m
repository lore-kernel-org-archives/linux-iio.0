Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984874;
	b=mhvvLEJjfseeMfhdehTWAofhlAUOEDqzjGAjQEu+ts/jmQWmVraR0j+kUbX83jHQt4WR
	 W5K+7ZW+9eXvIKdIauCjBEL9A69qJT7jPXkDNH94WE311MuGXmMW55JnzftLA41/F93e1
	 yUyGhWCzGFNHmS5c5TB4cAQ8dlLRafJJMTXuqAmU0xUqL2gF4ejwNadU+w2JYPIdUcGg8
	 Ky6yR2IZoyaueucgpz9NxyGIsYddjm0kAGtQ3nKFZ0QMqIDI715jbcYXoFryxCctFk+ge
	 Fb7RoZ9y6+wdVHRZYi5mc3nrXq0eXke4GoD/giv0nYS/bmftcTuLqNxfsj7VonRc2uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LbzTcwUzba9B16Ja5I6xe7wiEkfxBaoKDN62I20Byt8=;
	b=RWYNGyewm6x7CH6hZihy4H8c8nzsY5Ti/x2Z8i+ed023ryAtBLo1ChJUujukdtqQ19QG
	 B4fC1wfJcwp2mb3iOvaqpyMwXRuA8fjZkCRlZ7V7c3X1E8frbjsTsHCiyqEoSCxJcxm3G
	 O4reNYvmV80/CNDMuNe+ro8GhGOsTgAXxClB5wgCDXFTmr5tTCrgms7wImEJ1kY6x5FTh
	 JPWkdGqdjQ1GEbFr9iKvLnlcovK2lzbDruEtDof7qkTPNgpKnIqrr1wDTaFV+Br8zlaQ8
	 EARkv9xlNJyn9dgi0GJtLXvj5bzbd7bdExGkHi2o4sAHkK/p2m5I2/t1EC8OlXENcKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4c4D7vx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01540606A320
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 03:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4c4D7vx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9431F01825;
	Mon, 26 Oct 2026 03:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792984873;
	bh=LbzTcwUzba9B16Ja5I6xe7wiEkfxBaoKDN62I20Byt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R4c4D7vxcQ3tqzGXNrah8q8Nc9BqlLQOdNt4oDu1BHqxDvCOMII+h5XmbS7XzO16e
	 ovSKe2zCO6K/uctrOk8aPBzHnZpxLOGNqmgZtRxPzV1KMMhu/tnRg9C7pyBcFpwfTZ
	 uRB4JtT8n/dV8oVaWAeJ67JOs8MXVvToFa5qKunaD1oEZp0wEbQSdndqh93fNj+ZQR
	 1vH2D1blUafkh36rkIUPX+mrhAg6xnXyna7rOJSKJqNT2PTBeBHJFonrTSEO8sGOFB
	 +TKkNA63komCJMxq3FAfNiz/tcBIJSCzHiwKd/hsnSGTRgfxE/0GbNzOfp9C8IZf6i
	 GRPjqxa11m3tg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v3 2/2] iio: gyro: fxs210002c: Use guard(mutex)() for remaining simple cases.
Date: Mon, 26 Oct 2026 03:20:51 +0000
Message-ID: <20261026032051.1004536-3-jic23@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026032051.1004536-1-jic23@kernel.org>
References: <20261026032051.1004536-1-jic23@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

With the exception of the more complex flow in the trigger handler,
all uses of the data->lock are switched to using guard()()
simplifying various error flows.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/gyro/fxas21002c_core.c | 71 ++++++++++--------------------
 1 file changed, 24 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index fe1ac3e841dc..b6e6db4ad94c 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -341,28 +341,21 @@ static int fxas21002c_write(struct fxas21002c_data *data,
 	int actual_mode;
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	actual_mode = fxas21002c_mode_get(data);
-	if (actual_mode < 0) {
-		ret = actual_mode;
-		goto out_unlock;
-	}
+	if (actual_mode < 0)
+		return actual_mode;
 
 	ret = fxas21002c_mode_set(data, FXAS21002C_MODE_READY);
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	ret = regmap_field_write(data->regmap_fields[field], bits);
 	if (ret < 0)
-		goto out_unlock;
-
-	ret = fxas21002c_mode_set(data, data->prev_mode);
-
-out_unlock:
-	mutex_unlock(&data->lock);
+		return ret;
 
-	return ret;
+	return fxas21002c_mode_set(data, data->prev_mode);
 }
 
 static int fxas21002c_temp_get(struct fxas21002c_data *data, int *val)
@@ -420,19 +413,15 @@ static int fxas21002c_odr_get(struct fxas21002c_data *data, int *odr)
 	unsigned int odr_bits;
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	ret = regmap_field_read(data->regmap_fields[F_DR], &odr_bits);
 	if (ret < 0)
-		goto data_unlock;
+		return ret;
 
 	*odr = fxas21002c_odr_hz_from_value(data, odr_bits);
 
-	ret = IIO_VAL_INT;
-
-data_unlock:
-	mutex_unlock(&data->lock);
-
-	return ret;
+	return IIO_VAL_INT;
 }
 
 static int fxas21002c_odr_set(struct fxas21002c_data *data, int odr)
@@ -451,19 +440,15 @@ static int fxas21002c_lpf_get(struct fxas21002c_data *data, int *val2)
 	unsigned int bw_bits;
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	ret = regmap_field_read(data->regmap_fields[F_BW], &bw_bits);
 	if (ret < 0)
-		goto data_unlock;
+		return ret;
 
 	*val2 = fxas21002c_lpf_bw_from_value(data, bw_bits) * 10000;
 
-	ret = IIO_VAL_INT_PLUS_MICRO;
-
-data_unlock:
-	mutex_unlock(&data->lock);
-
-	return ret;
+	return IIO_VAL_INT_PLUS_MICRO;
 }
 
 static int fxas21002c_lpf_set(struct fxas21002c_data *data, int bw)
@@ -495,19 +480,15 @@ static int fxas21002c_hpf_get(struct fxas21002c_data *data, int *val2)
 	unsigned int sel_bits;
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	ret = regmap_field_read(data->regmap_fields[F_SEL], &sel_bits);
 	if (ret < 0)
-		goto data_unlock;
+		return ret;
 
 	*val2 = fxas21002c_hpf_sel_from_value(data, sel_bits);
 
-	ret = IIO_VAL_INT_PLUS_MICRO;
-
-data_unlock:
-	mutex_unlock(&data->lock);
-
-	return ret;
+	return IIO_VAL_INT_PLUS_MICRO;
 }
 
 static int fxas21002c_hpf_set(struct fxas21002c_data *data, int sel)
@@ -527,23 +508,19 @@ static int fxas21002c_scale_get(struct fxas21002c_data *data, int *val)
 	int scale;
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	ret = regmap_field_read(data->regmap_fields[F_FS], &fs_bits);
 	if (ret < 0)
-		goto data_unlock;
+		return ret;
 
 	scale = fxas21002c_range_fs_from_value(data, fs_bits);
-	if (scale < 0) {
-		ret = scale;
-		goto data_unlock;
-	}
+	if (scale < 0)
+		return scale;
 
 	*val = scale;
 
-data_unlock:
-	mutex_unlock(&data->lock);
-
-	return ret;
+	return 0;
 }
 
 static int fxas21002c_scale_set(struct fxas21002c_data *data, int range)
-- 
2.56.0

