Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105412;
	b=KzQfDppiX3DwC+1l0VoG+sG6gjYcePHkptwvy5JOxKHEWGFq0l4+93OZARvIh5yakd3x
	 Gox0DsySYEKzHzjKFizx4ZzvdvLdnoZpAh/vMTOZU8d3rpxtwB3vWocWN4GFnhlLScG+R
	 LDBy7bQxhByjH09ITElWvc8MIVXES9XuJJod3GsZI/GSAa83vMN1Dz8juVCX2hNP2XxZv
	 nLgb//WEnKYRBmtdFNfTJ7lOc/yd8+zq5XJ/dwh/tFk82eJDsl9t9PdJoi5gw9BLB3r2c
	 uYcwHyQmL3qZ/MhLMn8YtznWQsrjVhC8sh7XJ5ZLMP65cTiZVR4R9uP7CrA10vadxLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sODvYeqV5gDMhpF3/tE93N3B3mOo+hnfsfgEpH0noQs=;
	b=gfVUunptlxyrjUffcNMm4Q2pngR/61w23IyZQwmtTdt/PrDmN6tf1a4yUD3sScS7s1ET
	 ZZzXAJ1/RLDG1ox0h4ZRjBn6pklGOK01JLhRu4Ok8FPHwojzQfNDtF53BoQ+4ndXP3U/v
	 uj+0HwVkhObYKEBebVZ+suQKNSS5FdHzZJ8/9gLfCAx9+muX228yWoeZdJYsUeyaHsRNo
	 bD7HgmtffZgW4cbQvUA13d+9RDfgEE1V/6WbAQf5YVrJ/SVf0LdGkOjYRzMK7plWhvt4w
	 LWWq3bfvgExp6U1eu1OrSpi7+UApaODl1Gvw15FOX5doBIV1Df9quOCqi1bHS+PYvyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R5tOWkju;
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A060A3817
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 12:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F9A060A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R5tOWkju
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5ba3ac592faso2369574e87.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 05:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793105411; x=1793710211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sODvYeqV5gDMhpF3/tE93N3B3mOo+hnfsfgEpH0noQs=;
        b=R5tOWkju4v00bJxZmvuwB7/pKDsqkBAU/1/eg0Y2mI3+68zI0Mic91igIxblPKDv1G
         ITUYcqzhY/lj7Jsr1hZnifgKAqFARw15N52gxtgWV5Z4lGJVtKLPhp90ADC8Gm6jVEEK
         m7auX7ATnMoHARvtbiA5YgQdCiP6D2li77+Jjj+62l4UY6g5dncYC3HE6dOrlNYK9L/Z
         zF8Bd6Jya6/rQtR+dvCGbiZipSrRIlt4ttb3zUHpSQGM+8ankrnZ0WxqoNSuaIA9Hqkf
         dSbrLbL8x0jXh1KjkboyEe31U+cLqIgHffdPEUIIPx0GRNvxzr/TlbiR3a3NLsUgNl3D
         6Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105411; x=1793710211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sODvYeqV5gDMhpF3/tE93N3B3mOo+hnfsfgEpH0noQs=;
        b=CF5j1C025oLH2vots4pzc4O+3VEeKXqy7VYivo7kOvNQ86ZwpkpAuYrqbeL+YaYxO9
         V/rpelQz91J6uZZE6ZEB4yRz6ggeyMQbCHNQtH5k7VuZ9WXisvfqPREhxMh0uhRm1aID
         uNQA+xbkPdC7slam3wOnDYielHsipLKgWsqFfCySrs1F4BvW2cnsw3QuC1e7PmFl3N8M
         24ZHAb8M6aJymDVVGSni7Wv3RBwshxe8IFaIvR6RKL9dHOKG77n6EgYursORgpL4/xdP
         jezGZDKJ0ZwQgGn67C92CMtyrz1orm2KFXPbp/FUT3eSDzCttSu+tw7HBbk+cRdFqrbp
         ky/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxTqEyQp7aY6J16p/G3WaUNTNI4FllMpJQ9MwQ3oKIpDJk5+2Mpq5sPpyK7K5qI0Fmp8Sfy8ln8+rE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRO/9WOd3Hx+TquqyN7oqr0RxPkp0073+ckowy5xnqpJd+R8Vz
	lmum/IuPTsPwXWPwKME2yV/frVN7cTPFZ7g7TVclhebzqrfMbHaxBfy1
X-Gm-Gg: AYBFou1jGxT/Ji+2gkDG9B9DH7JbYLHNQphkIe96o1yJn38z5rbSP74XGnhcTg5BMXz
	CbWwjlok+PX/Bv6t5/90nDPC1kQQcR+TvoABCHfTQ8b8A3dhWnmsdSn0Rc0iISO2uffyuLurTDC
	OGbUrKMjmn3D5xfmFIPDkeO8M5dGlbfQvGj079q5ee8GX73aYMxK9qaEGZ4EonPYsaAv3ZA4kEA
	NLWJleEjTNP2pn2yk67unkqop9z82d7QHt7aICj2Gu2veNZDOAYEWJ0Hw0tf1yCZ7FvRvM5d/Zy
	eBkNWGDdu96gzfxv/nN9Da/RBaMkcdSZTU03ZQtG/5sMf2Zn0pCEQPSsWKSdL5dOKwORHkY1f8Z
	cUsY/NTgNQgEnB52DQiu7n6nFF7T1rJv89SSjar3xR1Xw/V3tkrSrsrIeVFXAUCv0FcOPAjcn2S
	2NWsf/L4M9N6ulm3QnIPyGq8EsfGy3+bTU2gblTi6+dZHMkRCo3YxrAsCCNS4PUfF18lW4kkFfV
	7vgHUX79DLfH4n1vK+i6mRi6JSlHwuSS0iOyVO04dJHpD+jz2sLkd/nivcKHG/pGtLWSuor56Gw
	n30xyhBYXDpAe0dS4Vo5f+hl91MP+LieKCcjQ7l7II94llufVcCbORsAS3SnDPCk
X-Received: by 2002:a05:6512:3409:b0:5bf:b963:70fa with SMTP id 2adb3069b0e04-5bfb96372f8mr3300311e87.48.1793105410585;
        Tue, 27 Oct 2026 05:50:10 -0700 (PDT)
Received: from yantra.. (nekmmqtcmoboczbkdcs-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:55c8:a52b:6ba2:979c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7e7cb24sm2052803e87.25.2026.10.27.05.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:50:10 -0700 (PDT)
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
Subject: [PATCH v4 8/9] iio: light: veml6031x00: annotate the event enable helpers
Date: Tue, 27 Oct 2026 14:49:53 +0200
Message-ID: <20261027124954.110697-9-zoone.rupert@gmail.com>
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

veml6031x00_event_enable() and veml6031x00_event_disable() call
veml6031x00_set_interrupt(), which needs irq_lock held. Their only
caller holds it, so mark both __must_hold(&data->irq_lock).

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>

 drivers/iio/light/veml6031x00.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
index f6308498e422..476ac3717f8e 100644
--- a/drivers/iio/light/veml6031x00.c
+++ b/drivers/iio/light/veml6031x00.c
@@ -784,6 +784,7 @@ static int veml6031x00_read_event_config(struct iio_dev *iio,
 }
 
 static int veml6031x00_event_enable(struct veml6031x00_data *data)
+	__must_hold(&data->irq_lock)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
@@ -804,6 +805,7 @@ static int veml6031x00_event_enable(struct veml6031x00_data *data)
 }
 
 static int veml6031x00_event_disable(struct veml6031x00_data *data)
+	__must_hold(&data->irq_lock)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-- 
2.43.0

