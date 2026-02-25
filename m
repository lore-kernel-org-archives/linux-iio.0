Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA9E3502BA
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019115; cv=none; b=Op0YcbVi7QejaXTW/RP/KgLAOWDl5pZIsYLFaHKVC8M7vvZhCFjE/IlmE4Pfb0CCjQpzaz2F12zVl9z3zdBcy6yvOKhBOo3Kpj2C2FM7Nwjo2juOK7WLA34T4AeoCZ2WDoNgt/vHMQYxNJzdGxOcFfocOXAqM4TcDRSgZowT6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019115; c=relaxed/simple;
	bh=tyP0nDNjBIEMVKo4YhOLZyC/BQFAGdwA9TSDuFF6Dp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s3mGYHNoqzS60wORD5cC+2QSmIw5OpGDD26/6vm/oGac4UwpOUHiqtgZBaVBjkcbxAQcBWbQGcti7MOmP37qWDL1uy54692TmC5VjkvDjliPGVC4jzGePY06XHGpLaR9cJva0bBaM2FjxD1qhlmM/eu05AF8SUnmL/DGUclbo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0yYwmge; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0yYwmge"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836fc075d2so7609565e9.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 03:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772019111; x=1772623911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CBdnPip5pL49c6+gEunsZLiIHbCIze9L65pv92ooJx4=;
        b=N0yYwmgecqz4T3IyphiGxbs98zldqGTTUWJo/UQiYLmfjTSTBsUwEKMM04x9Jh+7tS
         GJHjYbJYuUV4eZN9W4bLR7olijWMr312HYUa367vp1P1BcaqkbJlyryJncyVLVrTK1oN
         y5I2RtZFpIbEtEn/FDekwJ8YUsSS6NTgd1GcxdrRzNAo694x2dqKhdXohH6hBENpTP67
         C+2e/7pshxIhPC2CLNrQ7Z/PHz00MeNubzYCUQ+2olN2I8jlhf1hBU/Iqjj2lUG3N3zZ
         wHafPhgLirnhLVtMuhxhlcB1FGLlufuSqfWv2sf8gUaNo+Nj4/74bJUSFErpvpYwWCKh
         celw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772019111; x=1772623911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBdnPip5pL49c6+gEunsZLiIHbCIze9L65pv92ooJx4=;
        b=ueV4wLvVtuUPdaOEq2Hg3KySkPB54wGPbiI16wRTUrjav8efX2wvjEvRQYSad7LHXE
         PQDFp1pVsHRHph5egVFFXE6TcShOyKLzcSKpybB2InweLlDcUHlfP+00eKSbjuZ66sY5
         mqDe/LighqpgvhtruJ1IcFjuAJQI4h/rRLmqzpQh9f+0dvt66vBAqvwAI8jIhWghw0FX
         uJo+j3znr9/gkGK2WoF2cS55wBuU9kOygwAV5S1MLi5oarhj1v5HSoGsHNLZ0OuZEW+A
         mTT1ej4QixIcJlFMCe4FsJ/4/CJi/H5vKV1DWj+/9aDU/KdOOkSoiciH6fc0lSiyHdbo
         M+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjE9+TlnIvauUc2g2VMbZ4zTo5OHG+TQE+d1u7J+8tEPZFVgn6Y+7kvddQrHWm4Wo4EV+Da6skexg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfLjcG05FXfv0Zhrq0h/fQcIL6f693MNbFL+ShxLA45WxRQThS
	3bMaiz4Vk53DPzro73EfgOYK3F1wr4+zDg1ZH1mnuXGCrgmB9lDJ3nCr
X-Gm-Gg: ATEYQzy7qvY9hzSf+ddEtb6ueuTPlwacCx6D6YlNACV27oPwg9k9Y6jEk/AtjQm6fAC
	fMjxNnqoTjDYn4bMWpBrBOjarWNC9zF429ej9Fv4VRwJPWYKAz+dF/a+E/bxJHJ0mCI4vI3og/g
	a8lATK0/4VUZvyMGEB6MlZ7viWG6GQOqTZPLHk5+w+bG9Qzz6kmsbRrrhUREN5IfPBpHXt8CEGD
	+cVwf2yiAMrGol7TipRDNiCo/AZSosicKiBr3I0pVfKGsg1cmxcfIwow7kdLed6hD8wTjqYv37Z
	GS0YotfRa0CcC5r6P/PGEYE2BLZlx5LV+uGTrznTl0HfDrautTykkhwCNQRHAqxDIMgYgH0JVJs
	Fn7iLtWaqq2kiHDhWFGit2a0UTHMYxfENrZFRJ1mnk2tCvtFoe4d6NmapBJrKauUeGztNGpkevw
	AktyottPGl8ec+btageA7OOkuEzCu240tIyjYtaWjAaLU1e6V1vRM/fR9EUUJpROgIz7YrZttM3
	8zyUX1F53VnSmLolt4MxTaljAs5IqTBGYaCvkE+mQq71FuplXfC
X-Received: by 2002:a05:600c:8183:b0:477:5b01:7d42 with SMTP id 5b1f17b1804b1-483a95e42admr140167735e9.5.1772019110306;
        Wed, 25 Feb 2026 03:31:50 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bffc17dasm17006135e9.2.2026.02.25.03.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 03:31:49 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH RFC] iio: adc: ad4030: fix calibscale read/write unit mismatch
Date: Wed, 25 Feb 2026 15:30:39 +0400
Message-ID: <20260225113102.84568-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The read path returns calibscale in IIO_VAL_INT_PLUS_NANO but the write
path treats it as MICRO. Since no write_raw_get_fmt is provided, the
IIO core defaults to MICRO when parsing userspace input.

This means reading calibscale and writing it back results in a ~1000x
gain error.

Change the read path and available range to use MICRO to match the
write path.

Fixes: 0cb8b324852f ("iio: adc: ad4030: add driver for ad4030-24")
Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ad4030.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index def3e1d01ceb..3d823648371d 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -423,10 +423,10 @@ static int ad4030_get_chan_calibscale(struct iio_dev *indio_dev,
 
 	/* From datasheet: multiplied output = input × gain word/0x8000 */
 	*val = gain / AD4030_GAIN_MIDLE_POINT;
-	*val2 = mul_u64_u32_div(gain % AD4030_GAIN_MIDLE_POINT, NANO,
+	*val2 = mul_u64_u32_div(gain % AD4030_GAIN_MIDLE_POINT, MICRO,
 				AD4030_GAIN_MIDLE_POINT);
 
-	return IIO_VAL_INT_PLUS_NANO;
+	return IIO_VAL_INT_PLUS_MICRO;
 }
 
 /* Returns the offset where 1 LSB = (VREF/2^precision_bits - 1)/gain */
@@ -720,8 +720,8 @@ static irqreturn_t ad4030_trigger_handler(int irq, void *p)
 
 static const int ad4030_gain_avail[3][2] = {
 	{ 0, 0 },
-	{ 0, 30518 },
-	{ 1, 999969482 },
+	{ 0, 30 },
+	{ 1, 999969 },
 };
 
 static int ad4030_read_avail(struct iio_dev *indio_dev,
@@ -739,7 +739,7 @@ static int ad4030_read_avail(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_CALIBSCALE:
 		*vals = (void *)ad4030_gain_avail;
-		*type = IIO_VAL_INT_PLUS_NANO;
+		*type = IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_RANGE;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-- 
2.52.0

