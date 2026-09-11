Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3BE443C13
	for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125057; cv=none; b=MY5KyStPYRui1BqAXLkYS1AWcCvHbIdW+tgm9sy8kGnZilq7CQzNnQiEc7NqCy4K1nvPPtfDTUTgDGky2Wm39gT3VIcT7fe7muyfpMpsm3vgel6Co3oop/jEx3WctHkll/YKBG0706l52+dtFj8Np9schihODgwcu4WifGSBybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125057; c=relaxed/simple;
	bh=pJ4vj8BCmfF1V31tX/wZS7//jdxk6ExCWx5LYoQItFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mk/Q1y+/02PmsxjNN7D8ialFQgN9T04NmjTw7znQadvMcNeQKfZWJ+I/F0RYVA/TK+aKj5URPbK61+aGeBuu5m7J2GAuMw0aDI84gZL5QvXZ7IwfyTZ0lwuSaznNBvrTxbly3kXpmOCfpvLzvOCyxUJeq+Qe25mkmIyPwoEIAo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caRQwJYU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caRQwJYU"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso7192805e9.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 04:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789125049; x=1789729849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xWttpW5LjqZG6rptcoUTqVDa/t+6fdXdX2MvAK+JxuA=;
        b=caRQwJYU8TP/h0sqp5TVcK8EWyqETVDBiR+DJYpnFf9pHNpFpg1V3c4TY8IbMfE8IM
         zeVKPCHP3/jZEKnH2icgkHNqTmeKFv7UWMbrlpHlFaa/iQ28XM9lJZTEYjjw0bjQ7jXS
         hS9F1LQW1kV/ocjhUdwMbHfkTYyY/fyunl3GvmxIdjcYoi6JPoH/FwaW5Ddp3/iqmIqs
         dGG6qvHrEaQGOrrlffTE1Te41+9oDY/ePcGnAYuPt/3ikBiFzXE3JP2qaWNcy3vvrM05
         32hHOV9RJUqvozSnwxIGsIQgzFYq9gBzrpl7u7U16RUj7/i2T3yTWUevkf/zZoZSnnUa
         dyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789125049; x=1789729849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xWttpW5LjqZG6rptcoUTqVDa/t+6fdXdX2MvAK+JxuA=;
        b=ME6mnFITIKAqeTGwiwDV4T4oUG+GXVTfq5MZeUa25zljOTrbu5Xvz9yT61N3c6Rf4c
         bUALMrV1/RWjVmPlrSsRsQIOktDidauQDKA75xdYIqcvN87Xm40dkwsNL64fYrzW3ZGi
         EcD3taueekp9mTx7/YBpxAWUIJFdIvJQuvhNRmx1Cz5cqvPVLH6tZG6IM8w31Kubx0Mm
         6mk1ITQ2M4DRTl4pP8c1fRRMFTlwYh19pW+yVuKPtqrYNLR47i6ezJ/i+OgTFvi7AxoI
         buGDs6fDYPnwV8cWmR5BF3azrrpKp/jamswtuPumzDEafTFX6vmXHf7S9h9Ow8UnlZhE
         oqkg==
X-Forwarded-Encrypted: i=1; AKwUvBzwHP/7Ly8PlV8pbd6pyc+vrwvV4puMxyicUKFlrw/yM8wpbIwLSXve1u1dNE119QpKfL4A99bcr9Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mhefwu/hpjKkGEhE6czItxu4z1hyT6HnWtOlYl8NpZ3Whq2m/a
	nblTpOuTtMNOm1nBInrNP3+Zqg3r6A3b5DUfhJOXsMKpClcDRD/7xX8C
X-Gm-Gg: AYBFou1PadzdBX4HGr270ofTksOlvpBXYQUd7r3xSGJgzKb4du42V53j0C9YHIWRVD7
	NuHxZjGc/UZjt6j1begnIMUTfmPct1rjtG/LtuKFxXMX3TUvrA2FSahvDh+RyhKM3B1SeqX1jdw
	abRetcf3sUjDMfB6HWsHbv/7AFlJHJ7SpoGK2k6Owe34fsPFrWr0Nv23KUgKCSta0t0p5KEIBpm
	WbQYd0gX9xyosW3eW1BbTPd4uNw0MrZKMKhsuW5kXbpdcamwx0mVK+ij+Fhyz+5PzSLlBk8BKKe
	NAVPMK9LalB+rQzHDgwZ3AtL6H9gnHW2NMMrKjLJEG+W95qMPgwkTFqv0wwEZvC1dHU9etil0sA
	su+DXEeLMyQv4HqXbauvAnFLVmILBP6t/LV5jMNjPMQuLKlhmzPEASLXySuegel1dD48YUhkCgL
	7/Z2KCvXOGlXLWmBk3Ck60+ZeEWz1LldvetqBX7I+mGxcFLQgq9rpK3BBSTukZyjyNyECqgTVSp
	y6Bz5pclaPnQ36QYX0=
X-Received: by 2002:a05:600c:3b07:b0:49c:fa20:cbff with SMTP id 5b1f17b1804b1-49e619c18a3mr42351175e9.22.1789125048251;
        Fri, 11 Sep 2026 04:10:48 -0700 (PDT)
Received: from fedora ([154.182.82.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ac411asm66109065e9.8.2026.09.11.04.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:10:47 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v5 2/2] staging: iio: adc: ad7816: Use DMA-safe buffer for SPI read
Date: Fri, 11 Sep 2026 14:04:56 +0300
Message-ID: <20260911110456.24873-3-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260911110456.24873-1-abdelnasserhussein11@gmail.com>
References: <20260911110456.24873-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stack buffers are unsafe for DMA with VMAP_STACK enabled because
they are not physically contiguous and can share cache lines. This
causes data corruption.

Fix this by using a dedicated rx_buf aligned with IIO_DMA_MINALIGN
in the device state structure to ensure cache coherency.

Fixes: 7024425db64a ("staging: iio: adc: new driver for AD7816 devices")
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index d0355763aa8f..19da164945c7 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -53,6 +53,7 @@ struct ad7816_chip_info {
 	u8  channel_id;	/* 0 always be temperature */
 	u8  mode;
 	struct mutex lock; /* protect device state during SPI transfers */
+	__be16 rx_buf __aligned(IIO_DMA_MINALIGN);
 };
 
 enum ad7816_type {
@@ -68,7 +69,6 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 {
 	struct spi_device *spi_dev = chip->spi_dev;
 	int ret;
-	__be16 buf;
 
 	guard(mutex)(&chip->lock);
 
@@ -96,13 +96,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 
 	gpiod_set_value(chip->rdwr_pin, 0);
 	gpiod_set_value(chip->rdwr_pin, 1);
-	ret = spi_read(spi_dev, &buf, sizeof(buf));
+	ret = spi_read(spi_dev, &chip->rx_buf, sizeof(chip->rx_buf));
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI data read error\n");
 		return ret;
 	}
 
-	*data = be16_to_cpu(buf);
+	*data = be16_to_cpu(chip->rx_buf);
 
 	return ret;
 }
-- 
2.54.0

