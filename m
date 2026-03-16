Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94745383C6E
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651673; cv=none; b=CxQhRI8tq9B6WAFaojXhU3FulYmnkIOCuoJjKNGATFjOpc/R+JJGAKuzdmv5fljYG2UJn7uHv+ljGVvxKpyTl9F88fKQiJGyj0ZSIo7+ai0K5pPETKFKDFNeOPnKrxGaEbWwlh+aCaPJWYUbvJPBbC+PsZJYLr8JYsv+le77uJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651673; c=relaxed/simple;
	bh=Vo0wYVd8yog3Mr6zHSsNOrJfQRHnePM7ExtTX1p6rdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T37paqgJLyxvY93wTDhcA6wOaUq+wLVSEzk0VoigdJzMbdJYokyfUYT1YD8vmFadYt65447xBhDjrqz5RjLpF10ssGXWgaK14FcDx3ExyaGkFTF9P8f0T65tSbBXw4zDW5mZVcLi0Yfkmx1hNZmHTC5oLAinGUVRPVLYEo0o0HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gy0DD4da; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy0DD4da"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b04075d1e5so8132015ad.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651672; x=1774256472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX24UaNXEZhEFp3UePPgAeTnSXp9Fs24gQB3bdIvq5k=;
        b=gy0DD4dakJKCxOSeUiUVwaZwepsH9suX2mSv6mEZuJhSQblvbO4icH5tl/SeBA8aWa
         2bjCvnyBzeJguU+QDHnleyirK6t4H9HWXmWTeF2gpYDDC3e8YHY0pJD8NL1BLSDH1ZUH
         NKUQAAen0K+AG8KS6ArtRzhWyDSnfKuWaegcmID6DX2BGRBsT7yqpyah0iHR/WU4URVs
         PfZuMVHqXfHifOlYEYaWLv2I2344JEwxQFLclRTFbi39GYMqtB9TPfiJUuuS8VVoNfeF
         YhQnFaiv9xVT8ry4IkMp79WGG+FLtua9NBpL68gDNVHQHm+pdkuH1x2pZ/cuJbfQujSu
         vbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651672; x=1774256472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uX24UaNXEZhEFp3UePPgAeTnSXp9Fs24gQB3bdIvq5k=;
        b=TyIZMbNs4qhiC6eWfkieou7J9dfCV8iE2KvH79NhQ7biOYX6KlThOgDr8wMruBxpzw
         Mnis8GG0he7P9mnypPQEUQSSOvGBHjOPmfe1+ZpMEj+pG5drlJcNBn+1PCgWmVLVyh3Y
         /tXDTr21eWUX+MLy8P9wALENeIz1UEk5w04Cwrm9C6GPOMKYOZde5qZwfnefddXkR03C
         GUFYnv9dtMc3QAEnF6O+4zbEic8MkkBmVjk4mRZD4SkQtrsTuwaqR8vWlPSQJ7zwD0aA
         iMz+oj/9NgXxskqmN9HH/4w6F1i3PROURPjS/qx4qP9XohU7SvboqQPoRbKPxFq06xkm
         uVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNUyGhZdThq+Tjpjs2H/fgPcBZaI/DVEAxtooWDcy6Q/GQ4FOGA7Yk4/ihCmoh5CSAdzFDV8ZOUyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXzkZSU+3kyA2MsdB2WPWx12nY9O/rvjmCcFjKbIZI0t9QttmY
	+Fwk5y/BlXgwCOOFMBi5Y8zelZ70vRz4FIfERFzsc0Tw0Sw8ED3Lbu8G
X-Gm-Gg: ATEYQzySe02atT6+RpeSCDOJAlivdaS2j5P3wyscCvLg3nn6SeXqg7qyke562oxM0td
	3tsdyC6OSTVr29LaMqka+MEztCFcOJHiin2+dcgIo8vvzfPzDHdAQSGZex4XpYPEzuZ3AxH/AwD
	v5CLlY/Mnu3Dxy7vLg+CdLC3Uma6ZJvCF7oAmBZpNoHccrgKgOPDs8nN2yd+Sqdfl06+jtYt3zc
	Rl6OWpe5p7awEx9+S9fkjIfk50m/bm17t4FwU/UyFU1ElnU7hwebBYaufiXVt1ARPz/k1Motqs+
	6RT/oAguM5jwxM9D9MMVXgjpJ5z9suElOiJ+WOfp97RlXvz7Rj0iEkum5bOEDovfJsmEjiDGPxd
	N+CfnP3EUo46T3yQjjoVIfM6yxuZn2GG/FR20hJOViCOSsLGHmarI/vSP2NHjpdw1EdH7zyFA92
	iLWjaKarGZlWzijxJRQFL9zekAFVBBZEw/s8I=
X-Received: by 2002:a17:902:ea06:b0:2b0:5c3f:c0d8 with SMTP id d9443c01a7336-2b05c3fc4damr15989505ad.47.1773651671811;
        Mon, 16 Mar 2026 02:01:11 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:01:11 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v5 06/14] iio: pressure: fix spelling mistakes in comments
Date: Mon, 16 Mar 2026 14:30:14 +0530
Message-ID: <20260316090023.14691-7-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316090023.14691-1-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several spelling mistakes in comments.

- opertion -> operations
- transfered -> transferred
- usng -> using
- externaly -> externally

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/pressure/bmp280-spi.c  | 2 +-
 drivers/iio/pressure/hsc030pa.c    | 2 +-
 drivers/iio/pressure/rohm-bm1390.c | 2 +-
 drivers/iio/pressure/zpa2326.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 3b90384f17d7..04bf2f5be5b1 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -47,7 +47,7 @@ static int bmp380_regmap_spi_read(void *context, const void *reg,
		return -EINVAL;

	/*
-	 * According to the BMP3xx datasheets, for a basic SPI read opertion,
+	 * According to the BMP3xx datasheets, for a basic SPI read operation,
	 * the first byte needs to be dropped and the rest are the requested
	 * data.
	 */
diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030pa.c
index 2d00c0656259..d6b18a84f0ab 100644
--- a/drivers/iio/pressure/hsc030pa.c
+++ b/drivers/iio/pressure/hsc030pa.c
@@ -273,7 +273,7 @@ static const struct hsc_range_config hsc_range_config[HSC_VARIANTS_MAX] = {
  * @data: structure containing instantiated sensor data
  * Return: true only if both status bits are zero
  *
- * the two MSB from the first transfered byte contain a status code
+ * The two MSB from the first transferred byte contain a status code
  *   00 - normal operation, valid data
  *   01 - device in factory programming mode
  *   10 - stale data
diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index dac27fd359ad..08146ca0f91d 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -440,7 +440,7 @@ static int bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples)
	 * the timestamps. If we are ran from IRQ, then the
	 * IRQF_ONESHOT has us covered - but if we are ran by the
	 * user-space read we need to disable the IRQ to be on a safe
-	 * side. We do this usng synchronous disable so that if the
+	 * side. We do this using synchronous disable so that if the
	 * IRQ thread is being ran on other CPU we wait for it to be
	 * finished.
	 */
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 4923a558a26a..2c68fdf2744e 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -840,7 +840,7 @@ static irqreturn_t zpa2326_handle_threaded_irq(int irq, void *data)

 complete:
	/*
-	 * Wake up direct or externaly triggered buffer mode waiters: see
+	 * Wake up direct or externally triggered buffer mode waiters: see
	 * zpa2326_sample_oneshot() and zpa2326_trigger_handler().
	 */
	complete(&priv->data_ready);
--
2.53.0
