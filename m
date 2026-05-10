Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF130F927
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778418512; cv=none; b=VCUcX9n0p5GXWgVRsU5Gd0X+dp+7daM/OYvFUst5JqZEz2sJ0bdOjnCvIrqh9OOuv5UAbA7AT81Xclrxh2gyHMipLX9Y/Cuatfi1pYSNLTm/XLgE9rhatLXo3Rp7GD/vBnj9pYiumdKilRQ/idCsSGlPZQlRujY99V9Ho5U2tFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778418512; c=relaxed/simple;
	bh=/DOUNSvaEtfzaQTm7+qIQBIrmUenp2MbzW42H0OC6qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aRvPYA+LrxsTdvG6dkUX+vZrJS3fEDvXYXKcIE/BO267dLn+BqP0K46oOQ9UZJtrlUXqkHKHDCbyCw1fY/bPQk2BlC+6WQO+BERf5IFACtr/Lm3zCKihyZ++wFMgEmJRKwI4XYQV0jj/bI+j1IUZlhnG8JmODmWJaf9i7KOQOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4vPIgqD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4vPIgqD"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4836d9d54f6so4153995e9.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 06:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778418510; x=1779023310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IakIyz4uwcJHUWjsUXZVog5qj4L77ZfSWeluiup+7EM=;
        b=H4vPIgqDTX9vkVn3CS9RZzSFl93EaOyiDcwka3G8RFPvdNR8UYezZyCXi8A6/Kq7uW
         PO0BQOaRAm2KiNF7vQjVkBAtXnVOr3ncubK5i9GFsXsPFpXMhJH9kPI0RUzm6+4Ca27z
         7oO5pUpKJ3YGXVEWEsBYGc6d22hrkONEd8+8NazOtVd6UKW4dNk/0TrkkRuB/Hk2NhpV
         aL/dXiT24OcBgYkWeCAtjVEY7O/ymAGW96Jbztss3CFYu00r8p8YBOJ1Ukjmk+BsXZnq
         Mq2TY2O3dDW4gutTX/1F8Zm8rc0+yyAR5iFm9njupoQhbwUf/wK/oNqfepL88zSlKOOe
         vV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778418510; x=1779023310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IakIyz4uwcJHUWjsUXZVog5qj4L77ZfSWeluiup+7EM=;
        b=YEuaWiGG8QCxYsbpTPyNZIXj3m/O+Kogx/N+AUVk8Qi+FVjQggUMwIwAg/R96nRY6X
         s6/m22RjYqeAZDEF+CW9T0+sha7tH3W8W8xieB011zeglUqQPs1f0YiriXouRXV6GfLC
         cVdxm0ZdZaOmIEfmV/Do6f/6r60Z4gxpqD7TxP0pa18TIIN9z/JDx+SFunOFmgrDTZ92
         ObvZhsKZqXTKogaKI2wzy2a8rJzDT5nuk/hjVoVSnXipTXUrPd1WLlaATnE5KIQrwDRP
         xXqYnx75MdQ5DRhBy8BWa0E9LV/ltRgOfslPAq0ipB0y3lUYdynDa8InIuTkgcEOcfeL
         a9Yw==
X-Forwarded-Encrypted: i=1; AFNElJ/yFl/evcrkged4cHCPLEyjjuTU1hOiWblwikOwzQL07VdQSB3Em7AvwqLI1zebR8BpGmjmIxM6Smk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbazTcR1HvHE67yl293wckBTPGwfEzKUtExAm0HznNGGAcj4q6
	uMLhlB3YXweXySzzefQl6Fy22HrKbqIVHJy+CvV9GhBbKf1gD0Kv6xlS
X-Gm-Gg: Acq92OGuHkD3p0M107caYDW5GGiVKNdPoUxVnGd95Q4GxbQCzjvVR7kA/pFn9k6kzr3
	V9DspbojJm+hKo2P3zgV8qMXNtNBw1Nf25U/NPOtdkFaci9P+9/Cgg8MKAA30mgBJeylZumFcYC
	dMKLHTjzrCF9jx9DucLejnnC3XH+wtCKm/fJ5cp7CLluucJIpO9LlLMGAqNTC8ftYTC0xaCu64L
	tkwHLfUAkGX4+WHHpQAKY3TvM/ncnuTpvOEBixpDfcJF8UNPSQEMWRymqj/JVrDc0zC+UTyhkdy
	EcpoSe2DkzKDZbOMHT+LEWRqcF2EMGwRCHNziynfkP7oCkJxrHeGd6HTZYt3eL4b28/cNCZ09zI
	rmXtwh06zzSxFCazX+Y3HD8sNN9nIIHfPPFN/epacxii95WxpZ+rxoHQe7p5811vPVZc9S/Mgif
	BrI203H+lGWy+53GUYkpIjN5kLee0acsYpr+2UiZiHmy+x
X-Received: by 2002:a05:600c:198c:b0:48a:58e1:6cf7 with SMTP id 5b1f17b1804b1-48e530bf915mr143017005e9.4.1778418509516;
        Sun, 10 May 2026 06:08:29 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e6d41sm142327625e9.7.2026.05.10.06.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 06:08:29 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	puranjay@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] iio: accel: adxl355: replace usleep_range() with fsleep()
Date: Sun, 10 May 2026 10:53:03 +0500
Message-Id: <20260510055303.37221-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260510050820.27748-1-sozdayvek@gmail.com>
References: <20260510050820.27748-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "at least 5ms" wait after software reset has no specific upper
bound. Use fsleep() with 5 * USEC_PER_MSEC to make the unit
explicit at the call site.

No functional change.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/accel/adxl355_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 8f90c58f4..9d4421653 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -351,7 +351,7 @@ static int adxl355_setup(struct adxl355_data *data)
 			return ret;
 
 		/* Wait at least 5ms after software reset */
-		usleep_range(5000, 10000);
+		fsleep(5 * USEC_PER_MSEC);
 
 		/* Read shadow registers for comparison */
 		ret = regmap_bulk_read(data->regmap,
-- 
2.43.0

