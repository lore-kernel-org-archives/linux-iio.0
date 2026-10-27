Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105406;
	b=GenJFDLirCjDXEEzWZBp3j9m2/pIw//DtHoJjYDQAZKQK/3wIjE5hA49s9qNjQAm48Pr
	 8bMhyyEV3kky0Ei7vYa32pIvk/Aja0UUdafh1y/Nrwh/BEWv7a34GKW5ueG+i+6GnTsVx
	 PDM2jp97ft8MTivCjAuOn6mCW/1DVhoLUmizJKogzEWrSBI/i6HcoB7l1oiwa8R7B9YhK
	 2pVHBvNoO71z3kH7z28Kjk7M9qfZ/EiSotoV7LmDLxRbz/XCmy4LIJ8sh8LWDsLb6sots
	 mJZEc6XjKFCcd8YnGKPYFCq3aflHuHMAKLN47MKDOLmgsklhfp/uv9ESBVfaX45Nt3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pkcAkMdCRwIuT9szM2gCVVjCSXFflqIHrQQCvrEeeZg=;
	b=CvK+QTI+Zs+OwI/vMEFsyeqc34t8hJOz6Bt/FAUdaPJsN6NrG0B+Kc2Iw7DFRouDz1nH
	 f9Q+HyzvgskSrZ7MDfU8qwPJEihR3j0Qz+mku7E/N6FsAVdICJri1DzZniVE/IV4FeXQR
	 1UySnTA41D0YVDZlHKN+WhBAlU/H0KS3MebcmcO3So/LAPAnANGb0I2ywMOfPZLZChcbN
	 p6+Xztv7GIYbKCK5mDS2eiyg21fCuiOL/MYk8P/OHAfLI8yXMhIIVq7jnGsOaoZ5Tk0+L
	 eiplvO2tsRbzIakZ2gJCvio4vtMDrH/1DRtUCiiX1SvDQo34xgxaVk/70DrLnuieDbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HisGQ0qh;
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C837E606A32A
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 12:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C837E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HisGQ0qh
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso3426114e87.3
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 05:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793105404; x=1793710204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pkcAkMdCRwIuT9szM2gCVVjCSXFflqIHrQQCvrEeeZg=;
        b=HisGQ0qht2PJXTGw5WAvL5jvm2y81pQfxwwDQ4pzxV7qEjKiv/cqetdgchEhFLiQLm
         ROP5GV/aiLKdwUS5yrc42cRdpfbWE6g6/AZoVTpM3DOxB1HL5tKE2Yt5IkGDO4waVpbk
         awtdsgY7FcZ3vowE/ptcyBfXU2C336wcXkxZ7EMY2GPg1Bl/VWuYLNep3txus1W61/Ks
         uCY26n0GZGaAgOEGI1fvCI8j1vekzG/24grSoR7ldsnRPwon7x2Xrfe2Dm+IuyclK8B1
         i0l7aoi1lkIR4OxsL5LDbEJ9nIrCcBli6PE0+oWTTTNIXk3EFHKTG0yEoxJwFwqMR14s
         puDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105404; x=1793710204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pkcAkMdCRwIuT9szM2gCVVjCSXFflqIHrQQCvrEeeZg=;
        b=zggJX1U61AcGNouiGV7OLYWt5blotavgbHoLKjO+Uo1e05FyO9PqrLj+Y7uDPpUvaZ
         eXLObfaYXsH9+iVz1pb3kxbMdRrvSXwebExevi0mBcwrsnZL+aSi7pQJvv6jkaW6s/ag
         RiWD341L/L0yKYbXPiMwnIUY6lC+lUpfqF//nXV1ST5YTzS0KB3iUysTO+0q7bJ9Sv0y
         z3KoORaVYXWD7SMsfQzxNWuVRxPYBXKLd/hvXdj1k4oaM95pv3W6t82/lAaamhLc70bG
         Oc8uwLBL5ZL49sCPPvAZitHtmBsKQbFcf4DeLEUmConQSBUVwCs6WN0CyOFXYyzGtSOP
         wXng==
X-Forwarded-Encrypted: i=1; AKwUvBwROWOsh4wRjZnnkAqBrFIL5cROfgKNukKzdFymwbpEmUO8G9yMnhyJ1PZXTcU12um2mykUjLIL9hs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRzztRdNUvadxxFJjary08CG5lMNwAQslM7H17JAIQVjNS/9pc
	uKlJEuWof1yonVn1F8Fd5k434QTdiQQdjlRvxi20WU8fxQWqAII+nJqA
X-Gm-Gg: AYBFou2sLRzrg9m4Xp9ndOEg5AL8DDc4HZgGyI5hNe7Lb4g6tCkqT9+qHV7xxqPlNDx
	BSGcm7EQ6FzJRpaRHS1XVDFbSfyFBdPcgPtA08lHcwTn5qIaKeRkggWHIokdYspay0GFxzn5m3C
	TXqUpHDws4gbAk62HBuHxATrRZj5yq05x1AEr63Q+wSTcyNi4OZbovJVLncwy9bwDU1jukpAsUd
	s7VpMPxuu1sYXj0y6puvJMNFe9rYCFd9xi8X4dyI+PDKQnVnM08G0MNRELb+0DoWxFNmOdHQ+Hg
	C1MTpLJSvbMovqY8ZMABsjsmly08pId89OKhvT//2nehGLDgqlM2F3fFfIGnPpx44AjBWH+k7/M
	Zdx59y7WlkMEmQia6rSR+BCDasAmSCBZ4DaBVG9Q/ycP1yuIXoUd7cY/CTYl8JmpslfX/go7n68
	aE4lczcABEWg3/t1246qGuDaQgOPMxTwHoD2sFf5MuB06dZpZz3YzHwjW6h7gojOgQiq63hopvT
	3E1l7IVWWOtBzd3GmUsNuxqoXCKSQRDHXwy+PfqZ5pMPFLSXrQp93e1LrlJKJLpqKSLPZRoZY3P
	XhA9KE7YIRitcuJtza3xcHuGcVBELwizfcgttjC6Ubo6l7mkB0bCRPWo0ch3pQfgjAYtLUdfVO3
	sWrAFBQerpg==
X-Received: by 2002:a05:6512:1047:b0:5bc:d9de:d75c with SMTP id 2adb3069b0e04-5bfb71e3343mr3417911e87.47.1793105403789;
        Tue, 27 Oct 2026 05:50:03 -0700 (PDT)
Received: from yantra.. (nekmmqtcmoboczbkdcs-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:55c8:a52b:6ba2:979c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7e7cb24sm2052803e87.25.2026.10.27.05.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:50:03 -0700 (PDT)
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
	Bart Van Assche <bvanassche@acm.org>,
	Marco Elver <elver@google.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: [PATCH v4 1/9] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations on mutex helpers
Date: Tue, 27 Oct 2026 14:49:46 +0200
Message-ID: <20261027124954.110697-2-zoone.rupert@gmail.com>
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

Since commit 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse
support"), __acquires() and __releases() only feed context analysis.
Their argument is parsed before the function body, where only dev is in
scope, so with analysis enabled for this file the build fails:

  error: use of undeclared identifier 'adc'

Name the lock through dev, the same way the bodies find it. The analysis
then also checks that the helpers really take and drop it.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

v4: name the lock through dev instead of __context_unsafe() (Bart),
    now the first patch of the series that enables the analysis (Jonathan)
v3: drop Fixes tag (Jonathan), trailer cleanup (Andy)
    https://lore.kernel.org/linux-iio/20261025191510.22261-1-zoone.rupert@gmail.com/
v2: __context_unsafe() explained in commit message (Andy)
    https://lore.kernel.org/linux-iio/20261021052435.112686-1-zoone.rupert@gmail.com/
v1: https://lore.kernel.org/linux-iio/20261003214516.128573-1-zoone.rupert@gmail.com/

 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index c68c6c5f6aca..09013c6e44a0 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -663,7 +663,7 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
 }
 
 void adc5_gen3_mutex_lock(struct device *dev)
-	__acquires(&adc->lock)
+	__acquires(&((struct adc5_chip *)iio_priv(dev_get_drvdata(dev->parent)))->lock)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
 	struct adc5_chip *adc = iio_priv(indio_dev);
@@ -673,7 +673,7 @@ void adc5_gen3_mutex_lock(struct device *dev)
 EXPORT_SYMBOL_NS_GPL(adc5_gen3_mutex_lock, "QCOM_SPMI_ADC5_GEN3");
 
 void adc5_gen3_mutex_unlock(struct device *dev)
-	__releases(&adc->lock)
+	__releases(&((struct adc5_chip *)iio_priv(dev_get_drvdata(dev->parent)))->lock)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
 	struct adc5_chip *adc = iio_priv(indio_dev);
-- 
2.43.0

