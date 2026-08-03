Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE5B392C27
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759368; cv=none; b=e2UiNBlvxulrHc2sAKKsVp7RjeccR2SnF7189Vv/X5F4Sk0Qg+93yrBltT+UhPN6nE6539atB3Vvw2pM2GCZzYRUXHwYAX10Hoib4S4kt86TSN+KvESEPAOpb7CTIP/yJhVxu2yVghw2u93ebqV5uvZvcBLeirj66CgtwMmf2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759368; c=relaxed/simple;
	bh=KbuAVltrdpgoTAsog3bNgHW9HPKgi7jzMUcqoyvahh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGxRbRna+6HaDl+XmYsjSulHBhuSYbK1Uxmb7QtL2PSapgdtkRH7gUcnzuFHKG9kLouaszIOMnJeWKp2fhbJbV7wiJiXSPJzTBtDu1iv91GXNdOn9N/d48cGi1iEZmC+tOsEL3st9Iz9cWwNHtgNyObDkwsOBXyDHLMnqmXmWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+b1GaYn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+b1GaYn"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso3601624a12.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785759363; x=1786364163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0KbS3mbw078LtlagODYtZipKV9fmkHUKkmrW3T3OnxI=;
        b=W+b1GaYnznQL0V4rTJ0bA/FzRSVg8igJ3RLXAZElUC9TQm/anFo69jlGTdr4KIuQKb
         hSe7WlTEiiF6Ri0S//SabXU+1toDP7e1GyMrwV4f+xAbs1JTLfOGfPgKTRNSpJkasaAQ
         oseEg4TyXk911WclY6KPAobx5cBtMA9Xrmrns0/5xITern74ItG23HYffRJXkhF3XJuk
         yX3gbVxI2PWjZ7eFbwfhoVs3H615xGrKafOne2/IHtFQcssfC4MkQQCEVaGSX1m3N6SE
         +mvjcwYjoFHJBeqDz3dR54cmk4wTW10K3ldUMeAFu5xeSfwxbGBfgEY0WKOWSNozgMTR
         m9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759363; x=1786364163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0KbS3mbw078LtlagODYtZipKV9fmkHUKkmrW3T3OnxI=;
        b=DaQTESbOiwub5DLcbeuRXnX+X3pOcdzSEmEkb08/qsrVgfJWCdp4YkPMFAP+614V81
         cBqP2eCEXWRXBfyyI1lWKttNt0Ivg1USYeJ1QrnhCAR4RGiJrFAMMtob5o7YNW7I3G3U
         9iHUfMmIEtfqZMJzTfcb6S80BTYWK8hOc3zsa0Zgqe0/zZVkfw9rubWctUjSbGso10K9
         JPoULvawJ9sLUUwdOzAZh7WMAkGoN7ISpIzJ1Sp3LwJfDxfhl85YCImV7xcgoeO9Pw24
         +Zlj3IUaTqLKmtlTGUkOsGyWhe1kYtdCTNQBUUORGPbRiOEHm7hoV7XE2s2tXnFq/vMG
         6TYA==
X-Forwarded-Encrypted: i=1; AHgh+RqoX6SYP4lM3LT7yh6FKPu0zDk2ZGreR8OOETFMBbDfwxBcl3Ik+v+w0QIb96PbKwV8Msb9KgKxnw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4pfhO4YNSo0Qf/Dv8bAKeMh6VE5WNA4ulsbnBtMhEcq4eSFI
	gOaiagKk/B6H5oOl99X0HpbYJx548QvhXxHCmbYeAl1KJ2ZMloycO9n/pIP5fw==
X-Gm-Gg: AR+sD123m0SZq2x0S6+24FuTGDEP5k+r87hN+s7dr4GXwy/OhkbpifcGm7cnaqVeAcv
	v8LsUD0BsAhqOYP35Q98xXOI9YvWIcUepIiQqDnGnMNi5NEjOcr3XswwN9pvWsTwVpwdl/L8NDy
	WVA2g28PNR13WCt08GdBSLFbOD32uEqFo+G1WWiRV0dfGAqDcPgvkE5sSRfVwR9pehsB8ws6RqN
	qPzNAQwkCmBc4zRaueEWe3m2OettcPuQDqPDtAc5FoXm2bNmoMZfEXkeuFXYvwXAer6ARRviNFv
	pzvkv8OBmW34a9EoXa46+quIwjytM+/yoQrYOMLHLCf+A80VpFX+X5z5ajsiVf8FYYes9gkYq3w
	HaZur5PH9KK0E/LT4cagX4w7JBp1DkQzSep19W76b6n+RDJybkjNxzRKi7GNv7IdHDvkMeWyeEr
	xrQGNANSrv9toKJYj6KOdFC7Xt7eJYbssnEupKMz1wU4Ur62TBwAIUPCOvuIskHb/QVyEDhx5HI
	pz/zkLIN7ndbF0VRlTG
X-Received: by 2002:a05:6402:378a:b0:69a:928:9405 with SMTP id 4fb4d7f45d1cf-6a0a7c60e9bmr7134857a12.1.1785759363194;
        Mon, 03 Aug 2026 05:16:03 -0700 (PDT)
Received: from fedora ([154.182.126.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c655626sm6175963a12.22.2026.08.03.05.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:16:02 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-staging@linux.dev,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v2 2/2] staging: iio: ad7816: avoid DMA from stack in spi_read
Date: Mon,  3 Aug 2026 15:15:20 +0300
Message-ID: <20260803121520.6274-3-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803121520.6274-1-abdelnasserhussein11@gmail.com>
References: <0bde2343-8a70-44d4-9b27-8ce42c099309@baylibre.com>
 <20260803121520.6274-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPI transfer buffer is allocated on the stack, which is unsafe when
the SPI core performs DMA transfers. With VMAP_STACK enabled, this can
lead to DMA mapping failures because the stack is not guaranteed to be
DMA-accessible.

Move the buffer into struct ad7816_chip_info to provide storage with an
appropriate lifetime for DMA, align it with
__aligned(IIO_DMA_MINALIGN), and update the spi_read() sizeof() argument
to reference the relocated buffer.

Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index b5a0c2871e00..c58a6bf77020 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -51,6 +51,7 @@ struct ad7816_chip_info {
 	u8  channel_id;	/* 0 always be temperature */
 	u8  mode;
 	struct mutex lock; /* protect device state during SPI transfers */
+	__be16 rx_buf __aligned(IIO_DMA_MINALIGN);
 };
 
 enum ad7816_type {
@@ -66,7 +67,6 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 {
 	struct spi_device *spi_dev = chip->spi_dev;
 	int ret;
-	__be16 buf;
 
 	mutex_lock(&chip->lock);
 
@@ -95,7 +95,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 
 	gpiod_set_value(chip->rdwr_pin, 0);
 	gpiod_set_value(chip->rdwr_pin, 1);
-	ret = spi_read(spi_dev, &buf, sizeof(*data));
+	ret = spi_read(spi_dev, &chip->rx_buf, sizeof(chip->rx_buf));
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI data read error\n");
 		mutex_unlock(&chip->lock);
@@ -103,7 +103,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 		return ret;
 	}
 
-	*data = be16_to_cpu(buf);
+	*data = be16_to_cpu(chip->rx_buf);
 	mutex_unlock(&chip->lock);
 	return ret;
 }
-- 
2.54.0

