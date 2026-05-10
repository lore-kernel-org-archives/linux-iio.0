Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ACC31F9BB
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778442760; cv=none; b=KwYdnpvz3v5SGtt2dd466/CJXXdoiGwh+8eoh0iP+bXQmSO5IVEUFuCFNwhpxjdZgZMQq3vwC9QBz61+EggFAF6MJrMW3b/5cqWqciOop1zugCSzyx7fIGzhj9Ie5K1pKJpGRZHR0/aO1YVuvP0bSJnTu+FoxrtygjhHeKDLLio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778442760; c=relaxed/simple;
	bh=szr91X0aX1oiL+z0YDbJm/jeuKLCyV7ri0mqBGA+Vhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rr9Y81m/HZjMsUvFZzqWzyDi4/u9IaQBWkfvgRLeVp3jOuSuP8XEFFxwVMg/G/sEcetPJfR2zWZ0ZimODbHeGnGb8yvxA6iPOiwpW9tarlPIphZHcGqiEDh+xYAHXA+i5zTTTDANRgAURnxYvmcdnxcHIUUYFM3c3if5BOrQ/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMPq664W; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMPq664W"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso35492515ad.2
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778442759; x=1779047559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGdRP8DOxTfqMmP41Ln6pwyIdScELpEFLbXpkvVWa9M=;
        b=TMPq664WKsVO/G/14s8GWChSpnzzOKbMOHOu37CRGeB7md9y426b4SAymPhqS0Ef1T
         kGoCbD/AnCvAyD3K10C1emkoVphf8QKUuqhAPL8noMKx4MXGUrpBI8xNRtEtPr8TvWf1
         9FmqU4PkkP84CLmfhP+dL1sBnRovY4zQGyvyUj12SkT7h7HxYZE9zGVwL+iFe9E0EnHT
         E9fQle75+h4axZ9pHZrbusIHCa7rTuRHz2V5EFhJyojgTEQJPsQW9QqIXE5pTnH7Hwlq
         oo56xmPno7gIdo8HJVe8emx5rVQ9M4PALDODN+RaBxIsqMVqa8ohnTuYmKctWg355SiZ
         zr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778442759; x=1779047559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qGdRP8DOxTfqMmP41Ln6pwyIdScELpEFLbXpkvVWa9M=;
        b=Q1tegctkg4BLW/6kfWnGqHxYIDZ6xStUlkASa3fR6k0QU0/OXWZ9iS+qkeAfOEwz5H
         0uwLBG/5kOnQBf0USAoxumgGCg5a64brcm81hmZNekq+H+yyW9NvyssOwsHkv/3+nfb7
         ogL4pGM5h4nZjC+zKGBtN/MC9MwBYfT2ycllyqvWZ618I+r1ytIO1aT6X4Oqr9QgDipA
         2wep3uXhDSoe94u+uRaGt3AWbe1mj2gneKElxVdAFTZ8dDh2n5Ak5PNljyFHOlI6MQaS
         XbtNzTTG9UVv7fmc4JrvH3uilByumXBpNdi5vTqkMhCLvoCnF6Ch8gLhmoz7goQPoJfN
         xE9w==
X-Forwarded-Encrypted: i=1; AFNElJ/ojFrffFXMJ7dOIUtH1iuvVdW2a/eOzJIYViNpavshFekCSba73Ifl9HHH4gD/ZXaQUW/FGinUR4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBrTVSp7mw65VFny2UsXTCXC9EKK+CGd5Yq0dsaZtmvqoY13Dg
	OB/9Lh2u7ma1mYZUf81SPzYFPi3Xi6mb+CFNDh+Mn+N8hJhle7Xdnibh
X-Gm-Gg: Acq92OE7oMqU2+yh3Qnx0/x3qBCAO0uUh9YaEluIE2L1BD5MSNUvMWggBB3P+hmDemv
	8b00GXsTWW0AJn6nHMSfDHxxkRMKxoHvAHe8ylf0V8o2g5UG384F6Oe4MQfODR0fecwdt67Js6f
	J7/LJx7q//mBO8SZuiNBA83NR/mwhE5wM/6cy57kyldLlN2yenfjQnkEVlPLzVvy1axN4V+Dd4M
	mff8K/Ny04dZYSPGB7fNQuZ8uYDccYBt7kdcDBkCVgfbcFfQpajrJ/qqLgKFun15qXlyctcVmBO
	3X2v5wq1erJ9eZkTudwllyoMsi+Oux9kUmZdYAS7ZKGSf5U13wHksH0B5dAxjfBM4kRzfC98QiV
	XC9ecje4U3bFkZJTVXBEFSN98NghuZOhj3MpPallQmNm4cGYtRS26Nqd+BGdLQvKLc23bqgIype
	BkxEPYCMBulI1vbxsYVFA0o3MVUOn+KjYZ3ChBekmAg2Ht+ISHdVBOxFyFZh81U+IARL9xrWBYN
	V427N6CgVSQUHlnc0w6pKWu3GUsVUbo0zSOWIpLnDeG9xDZVk9x1UBwx/DBNZ3rBGCcbQI=
X-Received: by 2002:a17:902:e74a:b0:2b2:9d60:5eaf with SMTP id d9443c01a7336-2bc7a97bd76mr75042445ad.6.1778442758645;
        Sun, 10 May 2026 12:52:38 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e358b2sm77065095ad.54.2026.05.10.12.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:52:38 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/11] iio: adc: hx711: localize loop iterators in hx711_read
Date: Mon, 11 May 2026 01:19:31 +0530
Message-ID: <20260510194947.31997-10-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510194947.31997-1-piyushpatle228@gmail.com>
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tighten the scope of the loop variables in hx711_read() now that
trailing-pulse selection is already handled by the callers.

Also replace the 24-bit loop bound with a named constant while touching
the same code.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/adc/hx711.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 8da39d2801cd..9f17cbc6c2e5 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -23,6 +23,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 
+#define HX711_DATA_BITS		24
+
 /* gain to pulse and scale conversion */
 #define HX711_GAIN_MAX		3
 #define HX711_RESET_GAIN	128
@@ -157,16 +159,16 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 
 static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
-	int i, ret;
 	int value = 0;
 	int val;
+	int ret;
 
 	/* we double check if it's really down */
 	val = gpiod_get_value(hx711_data->gpiod_dout);
 	if (val)
 		return -EIO;
 
-	for (i = 0; i < 24; i++) {
+	for (int i = 0; i < HX711_DATA_BITS; i++) {
 		value <<= 1;
 		ret = hx711_cycle(hx711_data);
 		if (ret)
@@ -175,7 +177,7 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 
 	value ^= 0x800000;
 
-	for (i = 0; i < trailing_pulses; i++)
+	for (int i = 0; i < trailing_pulses; i++)
 		hx711_cycle(hx711_data);
 
 	return value;
-- 
2.43.0

