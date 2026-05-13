Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1753806CE
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778667234; cv=none; b=oE0s9LBimid14+rveRawkmJD/dcKMfvY5BdP4DryprOWjcJl9nmyA0UUAcX3DWbfV8w0I/CZO6wuj4nzpjR18/X3hIdX/XuUETsLIw4RTSscJDYNxlrzTzxEN2AG06h+bJ/TXVI0qh9F7GpN4tOETWEEngEKAjzhdN5aS0+tJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778667234; c=relaxed/simple;
	bh=N1D4+ThOR51fuz2bA2bhFDKhujGy63am3i09AJ0bWOw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PpHNA6/QA57L6VwK6R2TwHEK6yRtaFGlb4tC0yckZMLJXK3IJQPAoXW02pViFil/zsuDQPxskXdH/d9vN5NQDdaUqJ3iAv701BRSar1CYmt3SWEkeYoKmXxtjy7IAxYWkkC8JkGPnkQjO6xuDiHkvyH1t/NB+8A8qfaB34Lv+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIfrpCaU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIfrpCaU"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d7670826bso544821f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778667232; x=1779272032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mvKlKrwKM8+snVTmyzpnAxlGtVAs/9zFD/dqGiX2UJg=;
        b=RIfrpCaUOI9wwaMdvDi23Ab+VaaK+z+PhiCDQgo/wYj7vKPlA8sdxFvB2b1RkZWIX0
         AlyGCQ0hMqCoIB2ZPcBr+h4yxGSi8zmxP7amsPQt1XP6FoPHeSO2GuQX3ejosqDbKnUL
         Zof+i4w97AOQV+h7JY4ZPdGS6IrqftokTXy3IdKmYUsbqAfncCxt4VDiUf812gJb5yRX
         ngRXhoRisxj4d5KHvaAFK6ttAiBgqfAYURfm/uBM0oq9/LxGOfWkxLcI95ttqWaxeHY7
         I6OzkVp8JxV8AwGALhZ6P0mS+2sm9pBDGSD1l1MdLsIyZMR26YGnXXf3+jTz+9xaVweQ
         Ygow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778667232; x=1779272032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvKlKrwKM8+snVTmyzpnAxlGtVAs/9zFD/dqGiX2UJg=;
        b=lxJsSlkEH9PrLNvzOBTyyy8Q6k+bdHhYZxjvOpBnbpqvreZ0VZIYignTkM73YIeOsQ
         EQ6boVO9XvmGnRwUBaeRUaq6Gaw3Rzj13wOetIdPZbweavSzIzfP8C01YxmYgxPws4K+
         wMWGIbCtHb2nFWbrOr4k+5llacNt1ZUwS4P9AtQcLlBR1MYXPymRslz50On3ylVhoUAN
         fGWKHpQuoFM/1T+hTW+VD57q2xuIGgNueFu4IJ7OqYpPwBTuzP+psBRHu255hOuSRfzR
         UEQA2AbuCzmhqvBxwYnELQD5QFonE2LUXziDdxO5OcvCbYivnNm/QZJd5DELYVyaTbUu
         ZnPA==
X-Forwarded-Encrypted: i=1; AFNElJ8cxKP8BAAJns2ZDwncZZTMueyDbNGZNWd3FV4lBQq7STAwAdammaqivBElOQCOEqiCdqgdA/QyHUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoE9z+rZPB5RZjTYyLuxiVUR3TCKT7hSzWkk7NDNYageRBHUT3
	KgBnPIrxB39NwPkXiGYQUb5ACR7EmK3uXCFMaF3AJ/v9pSOEPdnFAFbA
X-Gm-Gg: Acq92OHHLh6XCL+lxACZ6y657lOCnoilx+U2m3QCOWjXLg1Bb5sqyxDo2MrIS3YDqR0
	pby9qpMY9PF4ZjKBYbNryny40BNrwyVc7t8268IZGYpa7w5LeKlIWKQCvpBfQgJWz+Fw1w9SYFi
	0fmSHuSjp0NsoR+GE13mKdoCuB3u2IT3oOILIRNgkNokCUvB67UOUwKennbKV8AMdurobE8TNHv
	DooiG/DEcfBg+/HLs6UnZ8d71NEkauETqpWXvCJqDIIE3Xc03vZ0VHcTGbXoqYINQqGt8TfCqVA
	BUZQuEbJcGiI0DEVrXgabY4I35lpZ4aMKx9GUQXJE0Cpwb/cdc/0AUDw70vJZQE/nDaneciTSzz
	H9Ga4BDKxSQUgDXWupsnEwBDJP7w4BkqLIhvqoIEE+AS5ayYbOvv4V6lMhztHdT7rqdxYDV7QXX
	guDKL7QylNVX1JnhuFMZqM9gGZTuN9D8wTTcdNBCxQWkHL
X-Received: by 2002:a05:600c:a08:b0:489:1c1f:35e5 with SMTP id 5b1f17b1804b1-48fc9a44496mr18460915e9.6.1778667231534;
        Wed, 13 May 2026 03:13:51 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fce05f41csm64944635e9.5.2026.05.13.03.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:13:50 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	alisa.roman@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: adc: ad7192: fix GPOCON register access annotation
Date: Wed, 13 May 2026 15:13:32 +0500
Message-Id: <20260513101332.8699-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment next to AD7192_REG_GPOCON marks the register as RO,
but the AD7192 datasheet (Rev. A, page 24, GPOCON REGISTER) says:
"The GPOCON register is an 8-bit register from which data can be
read or to which data can be written."

The driver itself uses ad_sd_write_reg() against this register in
ad7192_show_scale() / write paths to control the bridge power-down
switch and digital outputs, which matches the RW datasheet
description. Update the comment to RW so it does not mislead
future readers.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 8b1664f6b..98c1420a9 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -39,7 +39,7 @@
 #define AD7192_REG_CONF		2 /* Configuration Register  (RW, 24-bit) */
 #define AD7192_REG_DATA		3 /* Data Register	     (RO, 24/32-bit) */
 #define AD7192_REG_ID		4 /* ID Register	     (RO, 8-bit) */
-#define AD7192_REG_GPOCON	5 /* GPOCON Register	     (RO, 8-bit) */
+#define AD7192_REG_GPOCON	5 /* GPOCON Register	     (RW, 8-bit) */
 #define AD7192_REG_OFFSET	6 /* Offset Register	     (RW, 16-bit */
 				  /* (AD7792)/24-bit (AD7192)) */
 #define AD7192_REG_FULLSALE	7 /* Full-Scale Register */
-- 
2.43.0

