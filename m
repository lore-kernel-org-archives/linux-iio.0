Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214333A9DA
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548353; cv=none; b=GcFWoJ1ufT7kbL7mCPzBMIzW0Y2yGHoXHxDXy/Br/sXlHV7hcoSkzGg70y6a0xIP+vbzLuwk/jIf39AeeKY2Yvg+4HGAPKOwJCCBWFLsQoQOSMbKAlvBpOLK/6VGNomKn/A3BR9C9KmD0/jNTglEVcABDZ4AqKFaGeYhGA+D8U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548353; c=relaxed/simple;
	bh=YeA5NTit+vRgO6O7UM7usIAyOEi9ktUs3te+RyJJPCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fPG+5KewlOOz1oh1/KofdsamS81hyNr9qy8pb6gw/ZUMhnyRc3nxNrb+Yhvozzcl4+iNofXrQidDGYMtT83aunGuIUVkyqQXGhc5c0HImiyWhrbW9jkH9ai2v1vNqJMYRPXdSyjVCGuJHWT2cJ+LFz2jUBq28i/liW5nzfrg2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUtIZ72c; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUtIZ72c"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ab46931cf1so18128525ad.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774548349; x=1775153149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7lW8LFGu1hdwVKAacX1pBoH1829SaNw1Lo72wdjeU4=;
        b=gUtIZ72chmMyqjTbKYpcVGZ6skdr4B2igol8sK977Ov5Gqj0qrD7KqCBK6LIuzAbj/
         4DzOUeu9tyCnS6ubxCrRnRYHRa1kx1UbG2jlu1QBilvJxxm0AYCuZbL9yegLOSm6htxn
         yS0PDMB6yUrx6MyNNq/gPHclb3ACtCyRNnR4IY0MeVpvSR3ox9ZB20J98lzyfyDosYGk
         P7s/ht0TOAs2W6EOl2fHNaKYbHAGY1eNVkffPfpiUoOBkAFrSS59uDOIuLhIJVCxH+iH
         Rt57kGHiKb+rYNFRjRW1kbsQl5e7Dc9gGSqxsWGIRySaXUPZ4epxIpXSa5sGjT4kDDJy
         514Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774548349; x=1775153149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V7lW8LFGu1hdwVKAacX1pBoH1829SaNw1Lo72wdjeU4=;
        b=FXTaUIjdfd8u0zg4dT3eW/wlbV7G0wLVp6JHYqRmPIwh2K02l34UJQp2CgjQ2aa6j4
         jOBggCH/lrS1opE2mYNX3XkNv36KMeY4zfFy5ICD7TIDNFDv8rwn7Xk6+QoumS/t2B0e
         f8Rbsj+RUi8nrbAqKM8TIMLSchcdC8R/PcMVZS+oJ/MXvFD5AxTU1QeiOr0bpVVPO4J/
         3gEV1gDK/kYi6wQ/JZJwDx5RygRW4LC+GYRYqAU46iZrMhHaYPIa3EkBmvtxgfCGdOBL
         8Q3wZSN95uMYSmBBpKBNNGjkeHxqHPnB7aSTP7iN6kiKUfDi5H+utEDNk1YF9PSybGM9
         49hw==
X-Forwarded-Encrypted: i=1; AJvYcCXOaK3sc2m5VmcJTToAkLtI1ONKk6pSwrmDfOANtpoQWLISWVzOdacy3ddtYee7dQCwiFe3zeIO1S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJsWJwi8Xp4H68M8fce6r9Tr+bkYRxxaHzyaoGAenY3jXmZzY
	1OWudK2ompxqgmsLgFJXugLlZ3399R7AescLNgXsTDgNqRRY60dOUU9mFT/3eZeGAwU=
X-Gm-Gg: ATEYQzwTCJw2S8RNY8T7c1dlu/g1Fgss+8+tALZm2eTC6oRmkmBkcLWqFc7tWVs87/9
	qWPLXrO5v7Konw+BFz60/4J+LaOjq06hyHT+vqDk7b5XaI1MzTV4R/TflKjzOkKbu2kgI25tNDA
	zkJFLZonA788KtUTdWzkOEP/oC8nYbIW10ULd8L6BOeDcsUH62nxUSMUnkiNNBwFVil1sz5/VEn
	8FyLen44CuXW2+qASE8LaS4RsBOp6hMpN71PPQBlwlE5zhEL3/QuI1EZUG3uowLpj6E6cPiy2ZH
	/k5YH+pACQ5p1Ar1LcGSYx5E3QN9DToZYE6RtzzTh6FH3ni7X1Kuke7bMRTc3cdrkpqUnf45rwu
	OmKmcMvHkc6UliUMD1mhQpNycu9/8Xjil01UuOODZdkzFrkTio2LU0uvNIZCf/prkkChhbbayrV
	bZSLfDUPks3sO23EGiD79oSni9KMT7ET0ayLpG63kzOTLUMX8LjkpRf4p7AvtG6zSV71TUgc60m
	lk=
X-Received: by 2002:a17:902:c950:b0:2ae:5ab4:f4c0 with SMTP id d9443c01a7336-2b0c488e16cmr25741765ad.13.1774548348811;
        Thu, 26 Mar 2026 11:05:48 -0700 (PDT)
Received: from debian.ari ([47.30.237.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7a17c5sm43823545ad.26.2026.03.26.11.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:05:48 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v6 2/4] iio: adc: ad799x: use a static buffer for scan data
Date: Thu, 26 Mar 2026 23:35:27 +0530
Message-Id: <20260326180529.19154-3-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260326180529.19154-1-architanant5@gmail.com>
References: <20260326180529.19154-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, rx_buf is dynamically allocated using kmalloc() every time
ad799x_update_scan_mode() is called. This can lead to memory leaks if
the scan mask is updated multiple times.

Drop the dynamic allocation and replace it with a static buffer at the
end of the state structure using IIO_DECLARE_BUFFER_WITH_TS().
This eliminates the allocation overhead, prevents leaks, and removes
the need for manual kfree() on driver removal.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 9825abc9285d..7504bcf627da 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -39,6 +39,7 @@
 #include <linux/iio/triggered_buffer.h>
 
 #define AD799X_CHANNEL_SHIFT			4
+#define AD799X_MAX_CHANNELS			8
 
 /*
  * AD7991, AD7995 and AD7999 defines
@@ -133,8 +134,8 @@ struct ad799x_state {
 	unsigned int			id;
 	u16				config;
 
-	u8				*rx_buf;
 	unsigned int			transfer_size;
+	IIO_DECLARE_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
 };
 
 static int ad799x_write_config(struct ad799x_state *st, u16 val)
@@ -217,7 +218,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	}
 
 	b_sent = i2c_smbus_read_i2c_block_data(st->client,
-			cmd, st->transfer_size, st->rx_buf);
+			cmd, st->transfer_size, (u8 *)st->rx_buf);
 	if (b_sent < 0)
 		goto out;
 
@@ -234,11 +235,6 @@ static int ad799x_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct ad799x_state *st = iio_priv(indio_dev);
 
-	kfree(st->rx_buf);
-	st->rx_buf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (!st->rx_buf)
-		return -ENOMEM;
-
 	st->transfer_size = bitmap_weight(scan_mask,
 					  iio_get_masklength(indio_dev)) * 2;
 
@@ -896,7 +892,6 @@ static void ad799x_remove(struct i2c_client *client)
 	if (st->vref)
 		regulator_disable(st->vref);
 	regulator_disable(st->reg);
-	kfree(st->rx_buf);
 }
 
 static int ad799x_suspend(struct device *dev)
-- 
2.39.5

