Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105410;
	b=ljomjCkDwFGWjQVbsEfdpbSKvXUZ9br9pQoWKzAuvjEIK+abaUl+HiR4QklwPawM5lEj
	 czqSD/hYREqbFLdE9i22Ij5itu3Hi0unHlfbM2LYDM8YgmZspODWJsh2RZ7tIrXVQDV+y
	 lihoWTjTLSaScP7PpEd4zwmuh1PKCRU5lYuq6kAVrSRMz8iJSEJ6hQG2DfxAItGh31AGo
	 6E0hWCo/IWQ6hQn0WtXhqARwmxQynu1CWeKJPuLlF/+RAr9sP3xCoFpG2s4QDrKSOpJgM
	 wNcYDQ/epV9NOT3tNgzkDZeBQnL5M4ZD2QFkETGZGc/p6vO+v0NE1jOtAUWXLHZEujQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=w9bm/VqfouJwe/E4PVyOUQraLP3MHwcXiPF4bxf1G7Y=;
	b=3O9G/YZ9txnU6sq92NVDBALecJjaYHEl9gc4PcBP3mg49ryRrneiBWeRycwxBkJeWvvv
	 ulg5i7tpuisAStZuiHJLcCGjiPE5S8wqPxOIVzxeRNQTv3k1xs340thm+YQiyp2zYaF6e
	 t1uN1qftofrvq6dd6M2pGwoy8Ia6YnI+UiRS5divWOmzjuBukMZBXnupHl5A/ApBEbOVP
	 3uoYRaVUYB47/EAGtoYa8r0rDXytPPkcck5WFPruFSjLWs9zp00rUUry/9wcETaqF8EXv
	 06nwPy2c9g9e4TNmFUxsAyyTshULCLqAWOWoTbKH9EaXGH+rjyDqjq+4N/rJWuXf0yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0OUrL+4G;
	arc=none smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2460A262E
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 12:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E2460A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0OUrL+4G
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ab07d956f2so27119231fa.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793105408; x=1793710208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w9bm/VqfouJwe/E4PVyOUQraLP3MHwcXiPF4bxf1G7Y=;
        b=0OUrL+4GZOE8uUTEfdA96OGH/ToNP4d63/vuiTYPji/+otCz4ks/vG1EWxNvbamZSZ
         +iew7Dp+3NkgTOTPVfzlFsDV1vCHubeaxrOkZp5KMum46mDTgymZdVTCbNnu8SoZZl3i
         6pyW2zYTtTwr2gPudthxKg5wJiL5BgvnepW0CNZ9FWk40ur+KMi8bHlPZNQksCFQ3Yq2
         8KK/5HYUGQuRCc1+3YevwzQ3X4HFCj4Xa852iGmqDCFO/9xN1p+bOZQZ/G8pte/2s0U6
         NQUTy7Jr8h/wqSmsEa6Bh1nMIHbIrlQYsAR91RqarU16FI6CvO3DgTBFSM+QaCdQoD1y
         JYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105408; x=1793710208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w9bm/VqfouJwe/E4PVyOUQraLP3MHwcXiPF4bxf1G7Y=;
        b=bnmT1tQGzD5gvuVjzMgMbub5+0fJM7ChZH3MuHFld2CiZFMfsgj4CJL5KNu2L5OYc8
         qNDB5FzoebIpPNQrSjmuvxrG5ysIa62KZVYFx4TIRQMfueAywF+vdZEmFqfuslbvrwVr
         uEEOL6EyrR1c/168pxJzirn18vWy2NB5UVM0UF7uR1ZkMcE5/0ssVmgPKJHUMYmNwd7X
         T7lCU+hAxbxX2yEQEqTqoPr/kXx3QiV1P5fxVUTtVU9yZ6u+WwnuoFLtT/XIZeMTuKE2
         Vp/LEb1sl1Dektj/NZkDUP9kDZAF+4irdrzGGpAkgZCJ03MzkfOeGU8fUFzB08lFsQI1
         k1Bg==
X-Forwarded-Encrypted: i=1; AKwUvBw4JJVaJ9hUYAfnySSuBNI1uFk2scPXkB3pkQVY1lEMtw3L1pQTYjjv6plyTRAseciaFUrK5LHlhDA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK317SeoeIuXbhkJsjeGBuzW5zbFnOSUxIWp8OVTFmkOqEACJAg
	Xk6J1U+XnK9T4BJP2SBptRJFeTDUbbmw29wNNXWRUu+yHFQNJxkzE+HT
X-Gm-Gg: AYBFou3goszImgWFA+5AQfAPJ0905+NjFLeayaWn9lJbVNvQ78LtdGlb3PvXZzZFuP/
	s2556go+a0g9CUjZZJO3tcdj2GAN4bQUx3+DqSW+1ECfjjy+qLVF2yWRTMXjsK+tGFeYarohHG4
	D5AmsCN882tzU49GE7Yw/O4s+nWHN2uBFZnhI7FQJoCg688XgWzlhbJfgdV5vEE8UFHThiV3kxn
	mxyZlo3Qb2R8NMRLGkkEbJWu7snYeryZgvIXFq33Gvyye2/Pesoi5xmhUUEbMYHQbi0ewkvmutO
	bo6BGIPn5rfaHNd6AQxtYqvj2mI5ZNllR+pLVlIN9jH1jWt2Qg1QC5Iz3SgZw29zvPIThmtfwJD
	eqMibR8ND7inYEFZI/1MkJHcj8ib+4hoP8LXHT2xwWY5JVjWYLHpSuYySBaNK0i3bNBSy6xPsXz
	Jn7JnwJTNeDTOsz23FbWiuPrxCNotjLHLmtB+583dPWzxzmkE2Adi8LgkO3h1QXbmtNEuzOnvz2
	kMvjKF6KymxCLgR12f5AbyWOlt1NIzN6xf9xnRHQjWONRjdaZZkuk2XEnodF7dv5t/gY0o9tvI6
	/uvgzUHiNMJK813+21KsVxfeK1vOLV2xbbXx1HTWPK8spNHoPXXBc8TEavwCuJky1daxYC2koQb
	fSdldBek99g==
X-Received: by 2002:a05:651c:a331:b0:3a6:622a:2cad with SMTP id 38308e7fff4ca-3ac6fd0c2efmr24122901fa.10.1793105407711;
        Tue, 27 Oct 2026 05:50:07 -0700 (PDT)
Received: from yantra.. (nekmmqtcmoboczbkdcs-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:55c8:a52b:6ba2:979c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7e7cb24sm2052803e87.25.2026.10.27.05.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:50:07 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Guenter Roeck <groeck@chromium.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Jinseob Kim <kimjinseob88@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Remi Buisson <remi.buisson@tdk.com>
Cc: chrome-platform@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 5/9] iio: adc: meson_saradc: annotate the lock helpers
Date: Tue, 27 Oct 2026 14:49:50 +0200
Message-ID: <20261027124954.110697-6-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027124954.110697-1-zoone.rupert@gmail.com>
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
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

meson_sar_adc_lock() returns 0 with priv->lock held, and
meson_sar_adc_unlock() releases it. Annotate both so context analysis
follows the lock into the callers. Only indio_dev is in scope in the
annotation, so the lock is reached through iio_priv().

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>

 drivers/iio/adc/meson_saradc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 2b003fd5afeb..3c1bc2274129 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -578,6 +578,7 @@ static void meson_sar_adc_stop_sample_engine(struct iio_dev *indio_dev)
 }
 
 static int meson_sar_adc_lock(struct iio_dev *indio_dev)
+	__cond_acquires(0, &((struct meson_sar_adc_priv *)iio_priv(indio_dev))->lock)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	int val, ret;
@@ -608,6 +609,7 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
 }
 
 static void meson_sar_adc_unlock(struct iio_dev *indio_dev)
+	__releases(&((struct meson_sar_adc_priv *)iio_priv(indio_dev))->lock)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 
-- 
2.43.0

