Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04F533EB0E
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316603; cv=none; b=NL5XgeuLJw5hIuZiVRsmRp0i0OSqTycuHE3yofHMU0Y04nj+wRwuoH8XRV4mFtE4Gd9F2cbdF3JALGCNpX+JZA31I1l/AcfepmasWUlcNN1/yClVVuBr1iuheLgIuDISRbGQE1OE3EOGU7ajlmaLwiFh6LnV6+5nlN89JgDPz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316603; c=relaxed/simple;
	bh=94cZR+Dl9Y1xK9/i5NSZuXmbQP4B52YhFHGXev9PItQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EqQ5Mz+88udspH4sLKBH6me3oqlJp3xt/djcesoqDmz405gGwu8BHNk6XnK1avM6Xaf6OBAUrfjUi0k16Xd83zXz+vFXUvceCdTwuyDuVN8UNGzneIm2xKC+IuRze4is6MQSSyX7GGdVHykikKA4Z9Ju6B0WwldIQ0d6WBSYH2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sLMt2K7O; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLMt2K7O"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f2766905fso2168522b3a.3
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 22:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776316601; x=1776921401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNAH9fN9Mb66NpyeBtWR1vJkRM7PGuhU3j0WVdjK+ro=;
        b=sLMt2K7O8dSS2fhIN88NGDGdGhXjlK7jjZUWEwLCbhBhp94mEoH3f6jeGahvrQ5l1R
         O+UwZdeGlfseKGcEerTJwOTmf4naiqQ97g8uDv5T+xUDkmdn0YJhJ6Z3gSy62gbLmA4K
         y7xVUy79Vfpk/VwM6SpKf3l4r70zWIHFx2DVSC7Z0rg2MbAU5cMSJEYxTwsZwDgT4tDx
         q5QLrZzu4vrc7+6oPfuT8dXWBXd7YaJVcJeh0nV7D+nKvrbGUdCg0qN5m3gDoaFf4bla
         WSjJ+4AcFLRJJVpu2H8Vn6IZ0VbuIDVIXTyEZ+XcUv3p4JxJPg0WXvY9P7YwK9x376xW
         lYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776316601; x=1776921401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FNAH9fN9Mb66NpyeBtWR1vJkRM7PGuhU3j0WVdjK+ro=;
        b=iufzaQbkYfsmu8sLwKsaGz+AY8SaR5oVGh6/gP7R6eJ3y2DUuK7PTl9sobP0Ps6Nor
         fueO3vhsidigElojdR4KpmnFNLsuK86renhiOw2aILRPhdrkITnRZ0OPCyN7QMcjwYUh
         n34RmhzXTkxhvVj7OKjykT4SuAfuGMIl8JJLPlafjXTAWLMF1QH0obn0CxxeLW8wTwIC
         KtnnMwashYSo8U5UI7B9unfSdFhwHdSx9ZhZ2qXYZOBT53XvRH+/z3x77zKLmkoR/TqH
         WGlSZvRMHA4GCGykLjoL7PKEXBViDAbO6ehNhhiqENBNbGgvlodk7E1oGxdOCoUrCFKf
         gqQA==
X-Forwarded-Encrypted: i=1; AFNElJ8j9idHae37JX0JC455utrWhNpd56dn6O5SMWoMA+KK8tzLR0qrKutZp9BqXbKBWvFv3GBFOpAfWuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1LPCJrKYehytRdR8DQ9pOMd4PerAzluVDEBgZ/+X2CZyWgpr
	z7pfJ9INxiwIc+bncHeq0Kfsbk5waza+NDieOEompGnSf/R26lSqQ15B
X-Gm-Gg: AeBDietB73g+Exdtrwl7c4/chplHJTNn514kDH2vOsS/hFQJv5hdyo9y2oNkOMyIuQF
	atJe1Y1hK/YTMoXoC4EHkDeFcxsqTg7QJGdma04+FqywLefZJ7PrDeDNg+hAgPWIJILU9S+pk/C
	TznT9+4+YXEeEFOc1woC2v1OpNTXeSsBwTE93RJPapHDQjXL0/Ef7GdzdZ/5UcuU/p2YARGCcYT
	EzLywhRbhyimBM3gWfxouW5VdEHgGPsyu4R2KVe/o8Eb6iXsTxzpfvwf/PyjpkoCGjgvSmz8pW0
	NU6OWAEX3V/8tC13njVzqgs/pDDYJOgJKCkVElKeML3D+5Nv152bzFIZ6VAwUv3IQfv3cxIvhXL
	wdnIFC/+0uawHBVJwuni62+ekntkyyZNPCDPQiRE5JabEnjP5kXfKS//hIJTq1WU4OXWzoSIEJr
	/aGrPwDgSwePZA+LCzl7C85OX82pm0lebrvS35MRlmVWrDzQtDkh5zElD3+/BUTI8nehw3nA==
X-Received: by 2002:a05:6a00:2394:b0:82f:75d6:aa78 with SMTP id d2e1a72fcca58-82f75d6cca7mr2404899b3a.0.1776316600836;
        Wed, 15 Apr 2026 22:16:40 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67476a5fsm3948364b3a.60.2026.04.15.22.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 22:16:40 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: accel: adxl313_core: Use devm-managed mutex initialization
Date: Thu, 16 Apr 2026 10:46:29 +0530
Message-Id: <20260416051631.551250-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416051631.551250-1-sanjayembedded@gmail.com>
References: <20260416051631.551250-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use devm_mutex_init() to tie the mutex lifetime to the device and
improve debugging when CONFIG_DEBUG_MUTEXES is enabled.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 83dcac17a042..2ca4ce90cd86 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -1243,7 +1243,9 @@ int adxl313_core_probe(struct device *dev,
 	data->regmap = regmap;
 	data->chip_info = chip_info;
 
-	mutex_init(&data->lock);
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->name = chip_info->name;
 	indio_dev->info = &adxl313_info;
-- 
2.34.1

