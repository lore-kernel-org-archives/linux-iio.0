Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA6F2D7DCF
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778340009; cv=none; b=ateC0JEQLkCPMoC+HdtaOytP44+K3UJiUtahmpcUtD3I/QpdPWjeCi1u6Q+hfFp73KMqeo7gCHCPTbKI2jcbUUF1BXGg9ImYe3AVmPWKMHn0bU+xilGKN1U9GX/eHmXviJAOiEYk1uCLz+mnru/VN6Om7BLq0ng6p6f90IEhGHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778340009; c=relaxed/simple;
	bh=8be50cgUO97dUmyXY8QEaFaIeWcvbyn4FZHCMFnyX9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQJtIHCGOiIaZQgtHspfbwWd4jk/VTcbtp+i7ONrj0ogE05OT1+MAilpLkKNO9nN1D2wEqHc5HZu71Da2KLE8EbU093tXcnfTkidcxPsUQvMpWtGFA3QIisbU4XEaV/gdl6FZlj+Vyx5UXfWpDiS2SZ0I777u2FBtfjqUSa5KaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZURlWW/l; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZURlWW/l"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so2909914e87.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778340006; x=1778944806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iev/RaR7ebPD8/QuDYCOu2PRxG+LdvAV0DZxv0cI94U=;
        b=ZURlWW/lJtg8POJYfBq7LjpIXVzfMdfwB+hbk7WrqXxG/2xAnz63baepHvUq1p3Aed
         sRJTVJDoJUQNPxsp6rVL2VgKCmGuOP4Ny17WgomCytD/o+9vrGvW1JBqCP0aooePb0aZ
         Wf17QFFuPiWU2soLxtm0j0pthAdueE9nLJ7dg6fXylgpE/5hj6eg9Hu1bLNV+Ttx/KxV
         asE+cRjjQdUUKEYkxHy053udQJt+qMab0gwbuCzeeqqZkL4Hvu5MdVnYynVoN7UrBwmN
         qUxTR7hWjJ7txXV1sTVprRMeMpzRDhB12AUzauw0kOsJSgXvuj81POijeUCAQu6RBduR
         IH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778340006; x=1778944806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iev/RaR7ebPD8/QuDYCOu2PRxG+LdvAV0DZxv0cI94U=;
        b=FavH58k6TDBNnU3Q/6FfAMU+ta1CFHNXi1OQoi1hmsonVR6Xg//G73GENuEoNKluvj
         zTmhaP7kQE0mlJeFnlHWD/TDFXGWHBoqPdunIdjXhqAZ2rCj2bru9K3OUApBj9kGSqd0
         K2S98xldHK2bZxVx8aoBb4wNegZlZvEty35s1Fc+K2Zc94yyJbdKoN9/ZqBTQ2R93vRe
         9wlBqyhNmjDvWVqnWbv8COCs1jJf4j0DNoe5jYYIshStUSuXYCD0SxDcPAC9FhM5EcYG
         c/BFImgwTRjZOwkJaPcfqd1tizPAZ9VOIBAJeyNIkOnCYKTrNIW8DmBTVaWZtGVd2MLQ
         wOXg==
X-Gm-Message-State: AOJu0YynGfKLqeZH6PQDTlOZ/cBCsSbOYAm73hs2GZKhQ3eMYUdlaFzO
	4lzxz/TZmL8n2Fduaf5t2vcATABciO672RhwnYlnMCymtM9MAD2mbASxvydSJteJ
X-Gm-Gg: Acq92OG8WrtKiqLqf6xIiu6LJHwKBU+fhQI2nEOz492aQEvU3y6yV59mWWJdp+5C2ov
	d1UgL/ZLuiXWeby4q3CZE3buSoOkfrxx7Mz6H+S2MnlVpynZmTmd2qDB2i4a/BW89/7iY3sK0Ih
	ILZZ7iDYOYI17Y2HJ+kD01D9E0GhsDBwG8VTVpzhJPidetYuA1xZpfuZod0WmIZBeOKHcsQIeeJ
	mk/z9PUvBF/pgaM7ELdH3wJGjZQ0cqN1UxEMyh7Y2twoiK17xHidR4kxUckZm9mL444d9ZnZX5z
	gM/Bbh1LOUI1EDJ+gWo3NS35PPA4j1QIn4IGYCrhb0ql2PT4ysNaVXFZa8eCg996EzyZRzqQ/kZ
	RGRsKZVOaTaBtmZGjTtYmAfHRBR3axxzxjcC7/IRCV8hIF94Z84/Xg2CaYsZAZsezPCOqamAx18
	oam9I8VBD4UCN7J7HlxpbGld/L1W3nIngW+8PeJC8kyNjnqEzhrZKuWuyfjrJpAd4J
X-Received: by 2002:a05:6512:ad3:b0:5a8:9c2f:5712 with SMTP id 2adb3069b0e04-5a8b70926a4mr979997e87.21.1778340005784;
        Sat, 09 May 2026 08:20:05 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a95664easm1301975e87.70.2026.05.09.08.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 08:20:05 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	mike.looijmans@topic.nl,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v4 3/3] iio: adc: ti-ads1298: Remove unnecessary CONFIG2 write during init
Date: Sat,  9 May 2026 18:19:59 +0300
Message-ID: <20260509151959.3475-4-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260509151959.3475-1-shofiqtest@gmail.com>
References: <20260509151959.3475-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver was enabling the internal test signal (INT_TEST), double
amplitude (TEST_AMP), and fast frequency (TEST_FREQ_FAST) bits in
CONFIG2 during initialization. These bits activate an internal square
wave generator intended for device testing and calibration, not normal
ECG operation.

CONFIG2 defaults to having only the RESERVED bit set after reset, which
is the correct value for normal operation. Remove the write entirely
since it would just be writing the reset default value.

Suggested-by: Mike Looijmans <mike.looijmans@topic.nl>
Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index 186bda3087..8957e873e1 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -615,15 +615,6 @@ static int ads1298_init(struct iio_dev *indio_dev)
 	if (!indio_dev->name)
 		return -ENOMEM;
 
-	/* Enable internal test signal, double amplitude, double frequency */
-	ret = regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
-			   ADS1298_MASK_CONFIG2_RESERVED |
-			   ADS1298_MASK_CONFIG2_INT_TEST |
-			   ADS1298_MASK_CONFIG2_TEST_AMP |
-			   ADS1298_MASK_CONFIG2_TEST_FREQ_FAST);
-	if (ret)
-		return ret;
-
 	val = ADS1298_MASK_CONFIG3_RESERVED; /* Must write 1 always */
 	if (!priv->reg_vref) {
 		/* Enable internal reference */
-- 
2.54.0.windows.1

