Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DC428505E
	for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770920427; cv=none; b=N+WnndACsnvo7Fxg3D/axYtk4XiSF+MzxqzUWZ44QY23wS2VOpwO2AFUJ4PqDF5yuBAeL/UzNhubVVzVy4kUgd5z6ziuduCs/ZbCLyRa0QqkYU9+W6Sjc2I6ubEdEOn6Aj4AAs7948YJMM1PFuZ8ZJbpeEF0RUKd69/pUJIwBrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770920427; c=relaxed/simple;
	bh=j7w5W5n+1tnAj9tyIzUZDSwh/ga/Vo6JWcfZq1R2EOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3n+dct81hy6AhetdxE9uG5Xk8JblV8Yv7EF0gKNl6KlPYvgc7b3/HdZImZtGaIx4oM1JWkfjPSh9PUsksK7GaBQHQnv5lW05Hi++3l9f+RdYkK6hfyCIcA5Skr27FVc1Ee36fZ6tKPqR6KPBUtf3TY6UIm6wzLUw4knQT9v+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP37YKbL; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP37YKbL"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43591b55727so155575f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770920425; x=1771525225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJKm78yJdUZ0qsK3Qh4mVjVC+cGTgJke+yjUKqEIW6U=;
        b=eP37YKbLcXwbqsBS55aAyL5g40PkfHB5KgNca2CmAW9OweLh9uD2D8TH14n4NKSovb
         3mCb5SN/rT0gtUSoz69WXYtQ8snZMjx6Qjttk6MZnhydxYKBDw+vKKP/z/sthfK0S7Ot
         T1Tsp22Rjwg+0pm/F1PgVRps0Z2Ujrug5Gq+wg4knZJhyRQ/U+hnDgc1eJYEd8lfGrz2
         nQD1FuVyuoIoRcJJDyaWh0FF9AA3RJXPnEMzoc0f8OaLPhmVAS4WbBDFM8nqSsaZpDP6
         CgWFAqXzIMt8znVZeEqUFSqI3WVIFN4oZvwFMq4SRju0ZLUWdF/US8s5x722JmSmMr7x
         jEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770920425; x=1771525225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YJKm78yJdUZ0qsK3Qh4mVjVC+cGTgJke+yjUKqEIW6U=;
        b=D6v2TcaSjiBxa1hY2Ag/8Xznsm5ay6WOF5lF3gPmsdeH+XTxejdyDG6B+ELzzk0TMY
         cCaPj+QBzreXR/U0QodbYOVqfg0RmocDN9wzLUzkjthGqup2+zVU3Jw0izg2OKVkc/Sx
         q/8w5krWtsw3P7mQfMOp3BFdvjBeMjNL6nrvKdO6vivP0t5Ih6Il29URAQAASTdq1Nd9
         uNt7jtTHdDcmD0Z5Biqjch8JDxLtlqsc3mNkTT5VnwQG6AmrMI9hYCNRC5E9tiuGCjRU
         ylPNQODggN2EA4ZbC+bdm3QAEcM9g4fopWTouokIos9CurA4m29I0wLMylW2fWf+HX2s
         QXKg==
X-Forwarded-Encrypted: i=1; AJvYcCUtWivHHnJRNFXH+Ay+x/PoEGMeRz2UqOwbj6j1BXTezAQmVsw7AZOm3FBzLDdy+xnFz+0MrvDED4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZ+XqNpA8RMTWhtZR1Pq2GHEKHIC4vxzVn73qurzvgedYgEef
	P+NSscp3a/DkhHD3TH6zPFqLb3IiXi2Cl48vkdEvw7MsFF7vdheXIYo4
X-Gm-Gg: AZuq6aIY6lSh+65Pod2oDz4szNEG7DhOdYCEIvgW5kX3cuIy+2olwENl8HeeyhCpEnn
	pV0a6uC2ERUsTCrPcHc3UfQfH0/H4itimwn/9qENfTmD/WvyEJAfMay72G3BtoqQKx1mynqqWmQ
	2zoG3i659Ob+12/HUch93998CKCYsXZ+j6jEwoRn9DB8S0s+0cPH4dVLYqMyDuQJnonOuNnESG4
	4dCZ/OoYDc4D4+Lid//nMyzl2ToxDwKf3A0C/C0BSfDRHJ2fa4L7JYacQK/LfW4Bh9RA2JTTO+t
	Dah6cf+8cVpKadIEGUOQunGN3+cuPLq6ODih9S0akqDEu2Hgpiy6/9pxwVJBwGYYA6tEot6JWy7
	aysAs24yjMykvPnM+kijJpsZHU7qCD78NQBv6skasRPCxDbmZLbiNBJgAIQ0fdf8uwnTwvVdO0F
	rgDn9cFw4D6cV7UJKd2jHaQHS5GtXgMKPSvzFyvWB5BlaJGsUVVjkt47bWJCi1gD+K
X-Received: by 2002:a05:6000:178f:b0:431:656:c73a with SMTP id ffacd0b85a97d-4378ac7e289mr6007987f8f.31.1770920424821;
        Thu, 12 Feb 2026 10:20:24 -0800 (PST)
Received: from db07.UM6P.local ([196.200.180.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc2b0sm13239933f8f.21.2026.02.12.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 10:20:24 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mentees@lists.linuxfoundation.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v1 2/2] iio: dac: ad5504: use adi,output-range-volts for scale calculation
Date: Thu, 12 Feb 2026 19:19:55 +0100
Message-ID: <20260212181955.42724-3-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212181955.42724-1-0rayn.dev@gmail.com>
References: <20260212181955.42724-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver previously used VCC to calculate the scale, but the datasheet
states the output range is fixed by the R_SEL pin (0-30V or 0-60V).

Update probe to read `adi,output-range-volts` for the scale. Default
to the 60V range if the property is missing, while keeping the VCC
regulator enable for power.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 355bcb6a8ba0..1796a9b1e750 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -15,6 +15,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
 #include <linux/bitops.h>
+#include <linux/property.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -274,6 +275,7 @@ static int ad5504_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct ad5504_state *st;
 	int ret;
+	u32 val;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -281,17 +283,21 @@ static int ad5504_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
-	if (ret < 0 && ret != -ENODEV)
+	ret = devm_regulator_get_enable(&spi->dev, "vcc");
+	if (ret)
 		return ret;
-	if (ret == -ENODEV) {
-		if (pdata->vref_mv)
-			st->vref_mv = pdata->vref_mv;
-		else
-			dev_warn(&spi->dev, "reference voltage unspecified\n");
-	} else {
-		st->vref_mv = ret / 1000;
-	}
+
+	ret = device_property_read_u32(&spi->dev, "adi,output-range-volts", &val);
+	if (ret)
+		val = 60;
+
+	if (val == 60)
+		st->vref_mv = 60000;
+	else
+		st->vref_mv = 30000;
+
+	if (pdata && pdata->vref_mv)
+		st->vref_mv = pdata->vref_mv;
 
 	st->spi = spi;
 	indio_dev->name = spi_get_device_id(st->spi)->name;
-- 
2.47.3

