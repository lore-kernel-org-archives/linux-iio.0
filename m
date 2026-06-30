Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55454441030
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833756; cv=none; b=gftyiAhMfjC3KvzMNWsFj7zTnH7IuQyeCyxkaP8XLDFbOTwGGFZPdqOgH/4x96jHz+8HLX65eggiGbmIVtz0JFof8YriJEB0h7FLsre4dmpBJxbAQTl4gliHQ1qCq1iFfDa0/wXoipBDJBi1NJFFzFWkIj8BWD/QSbLwK4uT08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833756; c=relaxed/simple;
	bh=a61AZulhD4aGnomWMt4dzz2q6pYz9bKZ+bGF6oQ8vX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbN8aWz6xHVLw83FFtdbq0pC/MbfJMz0Mr4Qld/qRHJWvlgF2USuQJDlW+WFu6gxCaW1to/WV/gP12oLG5D8pijzpKCbW1PTZDK6gVDNcV8jPI7rX3QWeCULPYEsnpk1+2BUlzFcxYUEqXWOE26OuippexsjZiFlminJun7F2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fxZlR7FB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fxZlR7FB"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-472a14c9965so2307848f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782833754; x=1783438554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hOld1uAwErTcWyZoIkaiGh1bIGshmemJEz0PAecMfw=;
        b=fxZlR7FB77uzqIYz1n7ZARrS6Js55fqXL9/TsKDmDX2H3/rS3waES0qCmNgLFuwQQl
         xmIaBVfmjt+FZMPgvsbRUTrULqzZtK+VqjwUA8eqd3jo+tLG2cwfWA9cEO5yLJXeS3i3
         MytnhAPvLS70G6mqdOKhVhKeigzjgsDMNCnjvMFmDkY5aA+rj0WLOr5SzRK95YG+epPi
         lSov9Fc5NT2nHEm9nv09rJS0f6MzjOKrsGUhvu81EbKHQEveavso5kJjDUQCzD9wNl4e
         3NYmQMm2Ytt7XoL/EviETqVcJdw83BEfK0bdBkY9YDxx2KQVnrnQsLAWTeBW7Fc8HVtz
         xsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833754; x=1783438554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4hOld1uAwErTcWyZoIkaiGh1bIGshmemJEz0PAecMfw=;
        b=O9c4t7BszylZNAjEixGqOH2S1MU+QLrM6k/a29qPKoQWdZbEJ0wR0aNTWNikAaLDtD
         9x0IJVwHBM1u6RFSjUBTN9zNrYCs75LMC5ybhRn8ZEeobgnKD0S1Yiw9+cKX4R5hLqKi
         YZb4PQgSlQEcXHrfb/M7pUtvJ7kcNFZXcZMMtDjfwZ3g55RFzMv9BF7PIf79Z4dUe57s
         Q13fJN4D72TTBQVI8ElBgR53+grt6I5StY/74gWtw66Jj3vDklJa2U6smg/IH42jx4IR
         rQZlcYMEzy8FW0pnrZEv2ybEMdmthXlCNxyIQxNFyCHiT/P+R1OYp1WQbE++zt2TymK7
         j8Pw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+sL3kFOlMoOJv0Ga+Hgm2IBwXc8/+S6Qpr7c9mnDPHQnWBK9JS6+TIU0hGhDgUG8n00JfNzLdBa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwr0vFkLqF5jGE/vvqd396DgoikcBxGQn/KbHLKpDxf8uqbFa6
	Ao7VpmeBeP0TOzy0lDyd6F8w/qOHq36FDhiNIoGhRYEl7VKluI++ZprknEcWeModp5M=
X-Gm-Gg: AfdE7ckNZA6hb3NZsE4046hQrTZ7C/S300gHdW3y1CzxHt/RXeNLdTERKdPl7w9YdBl
	PzbI9hlACr+V+p0DVKel3m/1Kk6Oi9zD/5x+wSSUKf7BdPr0APRsTNPBWbwlJ1cK7jmS9Z1OfTo
	G1zBlN6lgfBLLwPDRsj66dLVDjYznfr32mjh29bV7oTUwax2IlmR6VrKdIKPUNTnKlhHd4O6JFV
	nJrPYjxlF3FVAvDk5elfpRZDB3d+GC24n7kYV/GRO1IU86US0+8zUMMPKxUU12/+zHDnlK1qbdg
	UQr+cacsUpaHIsexI6lGLPh5y89FRoW3tTKufbt0XZtvtsVr4LyhtTGG0QPe49Nu+N28BZEhfFK
	DTGv+U8cIiQUtkxfdOuKjC9n9vAa4jX9sVIkf13kmMIHK3wBXrl51uy7YnuHhUGtnOMfzpXH+9m
	RhwrjAJImCtb4X2sx63PI0Xsn6cfunH13rccTidFv3DMo8UTAHMKkOa90j0MQ43YrD4Y55JiU5g
	w6a
X-Received: by 2002:a05:6000:2c07:b0:473:a74d:34d7 with SMTP id ffacd0b85a97d-475505f2c6fmr5814809f8f.2.1782833753701;
        Tue, 30 Jun 2026 08:35:53 -0700 (PDT)
Received: from localhost (p200300f65f47db042a9b551def0a6b94.dip0.t-ipconnect.de. [2003:f6:5f47:db04:2a9b:551d:ef0a:6b94])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4756797a8besm9297248f8f.35.2026.06.30.08.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:35:53 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: kernel@pengutronix.de,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iio: adc: ti-tsc2046: Simplify device handling
Date: Tue, 30 Jun 2026 17:35:34 +0200
Message-ID:  <a3329201c27a1f2439f4b6c1c89cd1949dcab23c.1782833415.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782833415.git.u.kleine-koenig@baylibre.com>
References: <cover.1782833415.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3251; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=a61AZulhD4aGnomWMt4dzz2q6pYz9bKZ+bGF6oQ8vX0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqQ+JJKc19sVsvqj5vYGofB3c2NT3/xyEjqkIKS WImqp5I41KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakPiSQAKCRCPgPtYfRL+ TlosB/9uvybiHUHH2GYS4aNmGqGrzsCTFImokCyA0T+h+GnFfQKmG7ctjfZL/QSNdLAeMZJgOBZ no7EQVX3yoIEl+Hd8cPZRMXcFWrnyLGDSBt1Ij1kLvfCo4DF5tkxlp+JQWuKrU89ikTgmQRObDB vXF3u/Tb32fKKXnlT0foJV6+tX337hQBI/f3OeVWmcrGYybZWjeK8+aew+twDzSWNoyeOKnDXUS BmLyPIICDB8Hd8ZDUufd5I1kxXncT2OlmEvS/rv5LwFlEHZ1OJfxPSvaC4Nv5C2VCU7IjsPXFAA FsvCj5zIZ3HBUlOf1NgW2jm+xHsf3bNXsxfmKo10o0Cxll9p
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver was introduced in 2021 and since then only supports a single
chip variant. Simplify the driver by hard-coding the device properties
instead of using the id_table's abstraction for a single chip type.

Also drop the write-only struct member dcfg and the then unused struct
definition.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ti-tsc2046.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index aba4b10a17ac..125f6d7e2d84 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -121,11 +121,6 @@ struct tsc2046_adc_group_layout {
 	unsigned int skip;
 };
 
-struct tsc2046_adc_dcfg {
-	const struct iio_chan_spec *channels;
-	unsigned int num_channels;
-};
-
 struct tsc2046_adc_ch_cfg {
 	unsigned int settling_time_us;
 	unsigned int oversampling_ratio;
@@ -141,7 +136,6 @@ enum tsc2046_state {
 
 struct tsc2046_adc_priv {
 	struct spi_device *spi;
-	const struct tsc2046_adc_dcfg *dcfg;
 	bool internal_vref;
 
 	struct iio_trigger *trig;
@@ -214,11 +208,6 @@ const struct iio_chan_spec name ## _channels[] = { \
 
 static DECLARE_TI_TSC2046_8_CHANNELS(tsc2046_adc, 12);
 
-static const struct tsc2046_adc_dcfg tsc2046_adc_dcfg_tsc2046e = {
-	.channels = tsc2046_adc_channels,
-	.num_channels = ARRAY_SIZE(tsc2046_adc_channels),
-};
-
 /*
  * Convert time to a number of samples which can be transferred within this
  * time.
@@ -739,7 +728,6 @@ static void tsc2046_adc_parse_fwnode(struct tsc2046_adc_priv *priv)
 
 static int tsc2046_adc_probe(struct spi_device *spi)
 {
-	const struct tsc2046_adc_dcfg *dcfg;
 	struct device *dev = &spi->dev;
 	struct tsc2046_adc_priv *priv;
 	struct iio_dev *indio_dev;
@@ -752,10 +740,6 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	dcfg = spi_get_device_match_data(spi);
-	if (!dcfg)
-		return -EINVAL;
-
 	spi->mode &= ~SPI_MODE_X_MASK;
 	spi->mode |= SPI_MODE_0;
 	ret = spi_setup(spi);
@@ -767,14 +751,13 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	priv = iio_priv(indio_dev);
-	priv->dcfg = dcfg;
 
 	priv->spi = spi;
 
 	indio_dev->name = TI_TSC2046_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = dcfg->channels;
-	indio_dev->num_channels = dcfg->num_channels;
+	indio_dev->channels = tsc2046_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(tsc2046_adc_channels);
 	indio_dev->info = &tsc2046_adc_info;
 
 	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
@@ -829,13 +812,13 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ads7950_of_table[] = {
-	{ .compatible = "ti,tsc2046e-adc", .data = &tsc2046_adc_dcfg_tsc2046e },
+	{ .compatible = "ti,tsc2046e-adc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ads7950_of_table);
 
 static const struct spi_device_id tsc2046_adc_spi_ids[] = {
-	{ "tsc2046e-adc", (unsigned long)&tsc2046_adc_dcfg_tsc2046e },
+	{ .name = "tsc2046e-adc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, tsc2046_adc_spi_ids);
-- 
2.47.3

