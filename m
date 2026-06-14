Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43AC32B111
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781426647; cv=none; b=dFJypDo673N02cw4J/u+9Rn9Es82o1E0q0mDPuoP585z3mHPj4JWC6VqyDZvs673GO4YaT/W2l31ssAEKEglchW7B5pRK/u4+/9oWihHxpKQ35UvL7F3phMhb4YMfALfh0p+H/LEllSGMiI9/0VOaC8hKl6AhkbPhoW78ZtyUEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781426647; c=relaxed/simple;
	bh=AQPnKE8kPADZDz9WVMRdmI00gd+dV46unKuHa+JRjqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyldfA89ryyU/hCZRO0S0+33+C0D/jn94PzEZfpJgEl1FUbU5oEhOWcixSwDLfHFkj5rwyip+mqFdx68KvWRoVTRdQImI1UhwAWi8ccJc/qeuEkHjAdGLoGT92GWCgq125gUXDXXcK5au4Y3cC7lZHJ2nxh5HIpugeo9PDyZgYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so1444486a91.3
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 01:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781426645; x=1782031445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nlVBNYFVHKaRBvHkXfDIp1iJezUEhbhP/F3NScqagA4=;
        b=gpwalINzBDOEgndtygtOhWVc89J07U+pPRvHbVHAAv1i6RGy44TNY4eG4F5RO9teHP
         2XHs4RFnJ/OBuXlHF3TrUdnFvUZZJdehMJ/Dt0UjGmj/mTtklYpzz4BT7tcuiF17r7Bs
         QRZTiglD4lPDawhA9UAFC870dTGhsaMdDguRi3Mli32YpGF2Iq0g3L4eAuSfNiWKZ8fu
         tHmkRVyHEXAnJHashZz9e1hHiuv6DSmBzfztOwzzGLOlXQDNM6xDOIhe1Svz6f6CYR6F
         TDL7NMMqmAQsPUQ6tNBf+04huKj061aTFvPa8JaOn/pGp7lL6o9+228HT5DDG7KrHCSj
         p9XQ==
X-Forwarded-Encrypted: i=1; AFNElJ/345q0eRBpZOIVbap7qTTmZN+tiu3lyNpIpoZTF0NU8XYRZHbgtGR3ds7X/bonpQEmYk/RsKTpE9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg0Ezr1VxZ8ZYdfLvpjd/1FKBxW+RuZGajdhotjL+kZpT6vrSZ
	eeQwroczqOMHTX1FNe5wXFiVVA3p1LcBS3sX7YBTZgWp7ZxKyw3l2fXe
X-Gm-Gg: Acq92OEmRJjRSdPCpsXx9m6qZTYKdm6tmTlVlSlVkCwKdleUG/94EwsjtvFmZh5hpoy
	eJl53EmWzAraND947kw640YgOgZLcceEj18rAFKUMq6xDzs7gOAZvAHYGaZgZgnvuqtuSr7ompp
	94NoTKLfkiGbiW81kjLukXbGMJ/2TBc33Qzw2fthGIJQvE8B/UuA9Qi37hvQYnOl5d5UEp4Uh62
	vmIAQcRRhI+WvFWU734wLb8f2Vh8AOY/xMsvCBMMDcneZBLv8Az2WbIKpfNgECZOuWGbWrCsiab
	B4GHd0WlOXiSu430Qv31rnjSpwajXgAmy+HWDndk4f8lyoftOojFy/QTW6a5ITyPNJytCF4p+w+
	QaISl56RG3DdIMS/wMpNa6uv8DZijaAUSK+kL5q0v8B7Kd3V/uwzaZK5s+5DIgep1xEFw93SgCW
	55IyAcxThArIEDxOvl8LCRWfptO9qCGAsIGgTGA1wZKDZTSfd+vD8wKI6x3Ra9NxtJdQA4WzYYg
	50Cs6Oh/mgpNHe/qZ19IOohWvkInC3OKXfMPvvDsHNNmy7eeZg98vxYWwoBPEqB6J+S25xtHNj/
	7QRkqKRlyA==
X-Received: by 2002:a17:90b:2b50:b0:369:223a:cb60 with SMTP id 98e67ed59e1d1-37a01e2fbf7mr9283207a91.8.1781426645002;
        Sun, 14 Jun 2026 01:44:05 -0700 (PDT)
Received: from fedora ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a25ecd5dcsm7209056a91.9.2026.06.14.01.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 01:44:04 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 1/2] iio: proximity: sort the register values for vl53l1x-i2c
Date: Sun, 14 Jun 2026 14:43:39 +0600
Message-ID: <20260614084349.25823-2-email@sirat.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614084349.25823-1-email@sirat.me>
References: <20260614084349.25823-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Sort register defines list

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Siratul Islam <email@sirat.me>
---
 drivers/iio/proximity/vl53l1x-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
index 4d9cb3983dba..8302e0049e7c 100644
--- a/drivers/iio/proximity/vl53l1x-i2c.c
+++ b/drivers/iio/proximity/vl53l1x-i2c.c
@@ -43,6 +43,7 @@
 #define VL53L1X_REG_SOFT_RESET						0x0000
 #define VL53L1X_REG_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BOUND		0x0008
 #define VL53L1X_REG_VHV_CONFIG__INIT					0x000B
+#define VL53L1X_REG_DEFAULT_CONFIG					0x002D
 #define VL53L1X_REG_GPIO_HV_MUX__CTRL					0x0030
 #define VL53L1X_REG_GPIO__TIO_HV_STATUS					0x0031
 #define VL53L1X_REG_SYSTEM__INTERRUPT_CONFIG_GPIO			0x0046
@@ -64,7 +65,6 @@
 #define VL53L1X_REG_RESULT__OSC_CALIBRATE_VAL				0x00DE
 #define VL53L1X_REG_FIRMWARE__SYSTEM_STATUS				0x00E5
 #define VL53L1X_REG_IDENTIFICATION__MODEL_ID				0x010F
-#define VL53L1X_REG_DEFAULT_CONFIG					0x002D
 
 #define VL53L1X_MODEL_ID_VAL		0xEACC
 
-- 
2.54.0

