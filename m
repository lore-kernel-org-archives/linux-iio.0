Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A3440DFD5
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764667; cv=none; b=CuR0ex8AwlRKSCpb0VfcAJVKys9nyihPTQS9FqsFuOEYSA4TUZmDIqQERUpzDx1ePAHuAVbD6EdHXlB4++Y7N7whxWh9kfWvD2XYpzxgXN2ynGOXEM3SRY3KjM7Z3WGkaiipUmIP6lJKJETP0j5DdOh3JLvVsx7qLJNuaWUotRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764667; c=relaxed/simple;
	bh=KbuAVltrdpgoTAsog3bNgHW9HPKgi7jzMUcqoyvahh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAirMntNeXH9bL5jMyPz4Vh8s4pbQuWrKNDTVpvRMPwuadKesOyaBpEVDuhj9/3by14SKhKi4NIp9PPFy607IR/OnYC/iTWa97z+Jaf4SvEV+MdrZXG0Ervw1CkkSEAnctoA2abA/gXDSmFGvtWIkkIK5UGTSa5FwaQVRBuh4OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2TvBU9N; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2TvBU9N"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49548e01d02so12052315e9.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785764664; x=1786369464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0KbS3mbw078LtlagODYtZipKV9fmkHUKkmrW3T3OnxI=;
        b=B2TvBU9N5dqvJ+vEFjS9UOQeMrzU0vmvTsM7u/WVrW1gkDakdfuFHmHxE7aWF+OMXl
         kLeCcrDPrfnnUbb1knjd6d4u77DN7mpQTWjC11aniV48YngO/mh/AdlnlpZPn3+oj+VR
         FeZdtKOW06POiAQDIzeGHNbQ5lcasEUK2aJGEiDt61va+SSIN+ZSNPLpNejpEb0pQKQ1
         i9OQjZ+arAMrqwyh1gBEtMyDK54w/jwBZrfhwdugrV68n9ylWYq9YqulOkdhQ9NhZ8qI
         kDCLQIScSdgU4JSBndK/iL2rQijf3hCWrPYSrdGH8YTi75x8A9+jFtEEPQ0iC7LqicGx
         v2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764664; x=1786369464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0KbS3mbw078LtlagODYtZipKV9fmkHUKkmrW3T3OnxI=;
        b=VzxCIdf5/h5PLAeAR5ekGLmQ8ij17/7ZoJ8HsXeBavNl3Wh1veI2/aThPgtEferR/n
         Zz1F3LJJOpSOPh4YrB+oYtI+0iePhLOtUIwBvzhowPCAjiOiAfmXMwXJegI9w00IRuiD
         yiS5BRaQ7iNVEHOdARp8TCce3cHa3upMh4nRDmF1i+GYUGTIZYkuqlpp7K/xb4YfR2oy
         JBbXWfHVhKFTXB2XAVutszrAMPkByYUoy7mgIFB9cby8nQaZFVZHjOeJEpj2VcJCMONw
         4Hd5G3d3SRR40eoTvjPbDlT+jID8/YJq6GZDwgSkgOSyRM9PFGY+MUe7ZQuWCcIWk26l
         qBMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVoKlXl9EkSeDqh7pjkNJnpU0asLoOHOTeAxEcmZ2fa4DBt6DlpaUxeQ/YGF8JScr6abg/8z2o74o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKr81ZTZcspvKKC0jS8+npUZHF+kM6AF74B7W826nfof1sruZW
	cGYIiYFdNvjrDyttlmUR4oBaxV8Uh01Rr9HmivHJQEbk4bFrVE8EOlAY
X-Gm-Gg: AR+sD11MdPf2K5cYjxHVnj1EY5Dzlz17vVPrvitPDXzl0UVVtVcmUNGpL4LZCSpCmZk
	6uAVjS/K2RfQtaYFI+lQnwoaA12/SJ5MF+/QQFWlcg+b90dQM3PNklBjwOU4ggDPTZoiXXTar4T
	+3EU4ZJXkKu8w5lfeqWWNOaKQBxTtUUiGp678f4Jvpgix/d3mkYiHkkp48XZZ9oagbNMKKoiMt8
	87sy6a7Xth9VZ/kGBpT/sIx/WYEKDKrJslDnfG9w7UW+MT6TiyfTuSH4+EiVys/i9/dyZXvEdcY
	4uKkbryGhdZlMQ3G5++aelfcKRSSSWp/ea5+dsBBNc5gk6NyOx/S6XdbtA3dVlFBYhnkdAd/7zt
	1YaaxIg0Zk4cGOvduB3vUc7vm8uKdyucCRP8vCsnh4t2giSOuUVu09j9LKDdhEED0rF0whSfhof
	UFQDM2l3e2P1a16LERHk+i+oyXJPXbzYeEUR2iakGJhVOZq1RzI9tI51E7Dlzpp/9eTwZITNP/4
	XsW3fDYzw==
X-Received: by 2002:a05:600c:3550:b0:495:607e:5ee7 with SMTP id 5b1f17b1804b1-4980c679513mr223092645e9.17.1785764663678;
        Mon, 03 Aug 2026 06:44:23 -0700 (PDT)
Received: from fedora ([154.182.126.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4068fb7sm34328908f8f.0.2026.08.03.06.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 06:44:23 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v3 2/2] staging: iio: ad7816: avoid DMA from stack in spi_read
Date: Mon,  3 Aug 2026 16:43:46 +0300
Message-ID: <20260803134346.6733-5-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803134346.6733-1-abdelnasserhussein11@gmail.com>
References: <20260803134346.6733-1-abdelnasserhussein11@gmail.com>
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

