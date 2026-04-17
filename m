Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091C83563CD
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430178; cv=none; b=BcqjT9Ll3uEcEkIMNtxvDIerw2u6Y7GoJTBApIbgu3t08vOnJWm/icSoMzKVAuDCNX6gEBmKZuq2bUYmQMCY+YgdEKKEOhxz68OHwTtHr0ir28y5gypTubkN88EIk5EXkQvh/d9TYRcHko9wSJqc8XB5f02O9q9Tg9wFs4iEJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430178; c=relaxed/simple;
	bh=/sbeCvYRJV2J6VSn1qTNL4TuFMe1xKvjzwFVqfDvwPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T5rvz+UgRCVIpAcUzauxoGuEWX+4YFBDJxuIkm9P0TZDKYEYl/kGPL4D0jewPPserASDmhrqf5CG1wU1YPx0ClD8KmFK6dKPWwh3afUf9ZncAy3AQEqyqbFZIXAVxvlu3VaWxnDi0OgNs2ijwUoRK2IIfOhb9PYX7r5r7P4KoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIFWWqXi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIFWWqXi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad4d639db3so3490855ad.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 05:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776430176; x=1777034976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilm5rEXfs+j3rDOpp9ULtRLO1fYzOj9RLqCJ/xDcEbU=;
        b=EIFWWqXiM56yMuGV/XJHTufT3602zkmf3plRdHdQJajvRwSPzK4XrwRuI0/Dt7cNGP
         h/syBcISVEyJhq1DiVI54NzuUurUH5bWHUl/qFDqNL9xRPBBg3GDriWyQH2+RvLAdv8y
         a+6FMF+PqE1OfsaFC1mvC8XA7rnwAzU0aVnBNcDOPZjy2WAo/62T0bsT+WgkK1eERrrq
         uBAF8EstKbxGijqz9crp4AwjsxTuDoDCJHZ+b14R9gytWjJpp5jfY3H4P6no6n+VoPP8
         6pHzAx/BAzAPNOl8sCOcZVzYe10/soxIIeQZAYde3bCfSfCK/pZgIfX9pFKhDQY2OhGu
         /FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776430176; x=1777034976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ilm5rEXfs+j3rDOpp9ULtRLO1fYzOj9RLqCJ/xDcEbU=;
        b=jk7aHIMUqDJHy0LlrdWKiceu2oMQFFaDGoFN+PjDdTLn8a/Lyfx00okTleIz4X9hAr
         EDEE96crpvHisAvpmDSxnzw/n/qCpa7Djb0dWweFTgiwPdpuGLP6UFTle3PADG6XyvyN
         e1RsarnOlzbq2urfEGEyhAW5NiNKo5ZoPeb4bQd7u0SWRJKSW3FdrkFQwYVkkguOF6E8
         ELe/IsSRT8YotOo7GGJo0tMOe9AFjv2ElHXwWqEhllTcLbUvbBr32+hp92nNJNQSAu/J
         KHGGLnggJ7Qa4Rznhqoq3JQbrNfZLbm2EUnPWzowI1gkPBOSWzYbzUw1V97bM5CJ8D97
         ONLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9RSU9AC7/8O7HeE+xNcHYZSEXGpg6rBb5qrHLAvHjqxiRds4l9W/B85QAuesLHwJAkRdUL7dVmRdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOELqGvoikdI3ucaXYq1q+H/mujoc8lo3a7cZrY3TUjSTjanuM
	eTJdnf5zCYXCbGnop6irV90Yx7HBaSyj66bncqtUMrbXOoPKcpBcZ9uo
X-Gm-Gg: AeBDievNnO0By263fbT5hIcm7F05sMCYGsZQrev3uSdO3mAWb959KEMlxvDiKKT9pju
	yzTydS7J1KUmbpcacTwUxkjVuQyLd+hdhkuS8OG5CeOwl3XS8z8YKpgq8/sivOkUMYyBCjgz9v4
	Zs5BMjaTeZvAlOR74fhjOqxlGp6XQN2fn8/2DzcF7KJLKXh53hy21p8GyM/rCvL0dbysQgmz1oT
	7Wmte4XtjuxfAs+Uv4bbqFg2NBCSKGW5CcjebArfTtxZTEPuIYs8aOh1RaCtRIEcjMJ0OeCWCrn
	1v9XV/Cu4Z8MNO196bFpfGzJ7YJQSQkq3lYaP4MzvqmvuNaxN+vTJorxZ4Av803BVV7lOyxqqm/
	+WIt4fqukUlYuSqqjTOjsg8yU+NQOoPmomEG9sOEtmLSdW3lqaMH2XXZnsyj4PjM29FHYE6n8M7
	TPLjsfX8EyrqJiHIrLdNVdrivaSCQJp8lI06Bc9tgSRr+9p9szxbO6JjvYOoIoPUG+jk0jzw==
X-Received: by 2002:a17:903:98b:b0:2b0:7026:24bf with SMTP id d9443c01a7336-2b5f9eff280mr28816875ad.14.1776430176409;
        Fri, 17 Apr 2026 05:49:36 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cb92sm19428855ad.50.2026.04.17.05.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:49:35 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	puranjay@kernel.org,
	cosmin.tanislav@analog.com,
	marcelo.schmitt@analog.com,
	antoniu.miclaus@analog.com,
	ramona.gradinariu@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] iio: accel: adxl313_core: Use devm-managed mutex initialization
Date: Fri, 17 Apr 2026 18:19:17 +0530
Message-Id: <20260417124924.353189-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417124924.353189-1-sanjayembedded@gmail.com>
References: <20260417124924.353189-1-sanjayembedded@gmail.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/accel/adxl313_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index bcc11dabdf22..1fc96b7b0f1f 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -1240,7 +1240,9 @@ int adxl313_core_probe(struct device *dev,
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

