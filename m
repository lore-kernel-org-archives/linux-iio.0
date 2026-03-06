Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C10376BC4
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772781472; cv=none; b=HBW8aWBHSqQoU0IZPf4tfyuE20mRYm3gpCDkmQBzhRjNYSJY+6U0HQ+9OYswZ+Y2tucppjHTwOgVS3NjwDrT5WlReUoGI4JeBeSa9xEvvMy4jOuoICXV0NuJ9mIdzMXE37DkxQIytuiVcky64Y75+7q33B0WA+IPSAXpJns1sSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772781472; c=relaxed/simple;
	bh=0rAB9MBGoOdOMIG3fhy02OT6Cyxc/u79BMxz/VaekZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tAgi1IRZ90s/TQbZc1F/trfyZxTJFRek7Un43bwavaYlwexpRb0wVOUhbdVQmJTFZcBXWDFx4YJ08j5pZl6lyRKwVpYKn9KO2Gqgg1Lao98GCTsNGqJDigQGLoRirgvCy3upkB4thZP37+K8s/Ff/RZevwfAw2LaNVxXG3Itfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVq4BVai; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVq4BVai"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2be1ab1fa7dso6613444eec.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 23:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772781470; x=1773386270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMYOEONlQSsPyZ3EdoCsxjFpvIJZ2m37u2LdjlQwwyY=;
        b=GVq4BVaixbl48rrPtZ3uq3EMGxfMz8ZGWU9HtlKme87w/OuSjpKVVKAxbgc7XaAzfq
         DCDSw7w/wPccyrV5bSvzh+XzQi+KUb1AmNP3RYvQcVCI7UNEW82Jpb+sbEHArmt98hSR
         Uxqy6V18Lbis1MinjCmaUKhNB9QaN4qd3oFbSVYsRSGvrTpTUFQLk2nQID0JNI9WRMdi
         aYt+E8cNVSB78424HERrlrBvr851DNJ7MvLQ2OZhrwGreoWFB6aSjtOYV+dO11VLjtKq
         N1ROiJF1s1LBLy1AVZGBe6b2P0WInsN2ju6MBndCtoIhwMCtP57S5D1A3SBadM/fBqk4
         G5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772781470; x=1773386270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aMYOEONlQSsPyZ3EdoCsxjFpvIJZ2m37u2LdjlQwwyY=;
        b=n35dCcNBAP202mIQEYuZsQ7DbsIQnN3j8e0h4TiQs/kL2BgskePPswypQEPQzha2Bu
         OZgS1ZlT01fRKR3BvBkNgSMSh0EhM/oVzz9Q3owO8KrQzyCw3m5yDTT9Z1otNe+qJQ6p
         D27RSeEmwViHy0qIkyHvSFmblTyTBl7ssbweV95gB7UvqVkDyPUuCStRi65Ocnj3+kMu
         LuqI8h7427m11hHftNglw2N96e2LaPkFf2wmSHHgH0Bo57Ed0Kz7uoR8cYRuUi0sLDb7
         gkqHbEcX0K4lNTPHSo7uxZcL1Fi9dEHGzBF/CcBNKh7ZppFXnsRCe9x5JlDiOgIS2TUP
         roiw==
X-Forwarded-Encrypted: i=1; AJvYcCWOM7QugbHFUfb1BC1fPNmXl9ZeGDTm60HmR0iH9RqIb1qY+KeCpZu+B1ND5OBuUgeJFY75sxb6B48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcA1AzBYN50Ykh+2Lcdi8fF2lmJE1pbaTNu0INKXcam7nBj//E
	oNBaWpbmZYKwWCXY4ZSvZOcN/tz2sJjPGDrtdJYeJGe+khhJHidpmFrsLiTsrCeS
X-Gm-Gg: ATEYQzzkL3q819GNWoPMulMTzAB+vIBQgsd3s+hXFb5fF8gW4YPeaZF0bNMQCu61vPx
	cDtUsFo1sXo9LIE4oXeWNA8vtGN7la34g48pJRtw+km+cBKzBu9/HJQ+RPOn4VsickU9CZsC3xk
	hMRaXyMZXAiJDFfUoLXNfwqw0iGiYRcX9IohQrsEgWHY4Qa6ZkBpXXZ85pS20j7Iw29oecE2BIX
	4kTr7hzKI72IQvEndeKVhgziCDaYopjcm7VmIAbYSXtXkc2ushD1ohDuQDOgkhdf0LQAf2WlLbq
	ZYsaMmEG4zXBgfaMErn1LHLvX3VFPNPqH0x4vj0tRHyxCoj9xnKozyhawX5MLCkGz6Ryv41PSuZ
	l+8acNFtVuIeHRbdJzEdeQg34fMh5ZE49TZGKifGLjR4aT/RLs4vPQSgj8m4/MCREvj7gAcMNAE
	6UtRNInYB50H7CjRpxg+xZRYuAFDPOfydDQWFHpg==
X-Received: by 2002:a05:7301:1291:b0:2bd:f432:d545 with SMTP id 5a478bee46e88-2be4deb8b8cmr460852eec.17.1772781470331;
        Thu, 05 Mar 2026 23:17:50 -0800 (PST)
Received: from [192.168.1.187] ([76.50.196.152])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f96f25bsm545713eec.28.2026.03.05.23.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 23:17:49 -0800 (PST)
From: Michael Harris <michaelharriscode@gmail.com>
Date: Thu, 05 Mar 2026 23:17:01 -0800
Subject: [PATCH v2 4/4] staging: iio: adt7316: convert magic numbers to
 BIT_U32() or GENMASK_U32()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-adt7316-correct-macros-v2-4-3702e3841c42@gmail.com>
References: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
In-Reply-To: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michael Harris <michaelharriscode@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772781459; l=5562;
 i=michaelharriscode@gmail.com; s=20260130; h=from:subject:message-id;
 bh=0rAB9MBGoOdOMIG3fhy02OT6Cyxc/u79BMxz/VaekZ4=;
 b=5MBgmK5XwbhRJgOsfvxYxLgjH4BN49GWnBZYl3dSOPGCax98N3pasMXF75qbVcJkAPUcEob+N
 1onOStR7tCWBqV0kO2gxF8uoRwU2+SgrM3tkVlKUBpLfbGQNyJvH96w
X-Developer-Key: i=michaelharriscode@gmail.com; a=ed25519;
 pk=td/zQD3XANAhdG3Kf3mSetXiynk1Ql0eM4s0+eks5DU=

Improve readability by converting raw hex macros to use BIT_U32() or
GENMASK_U32() instead.

Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 72 ++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index ea7d97bb0f378f3a3ce1225d8d13af2c5955ca56..824801c022475c35b8dfd4626820a533fbb68a17 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -30,8 +30,8 @@
 #define ADT7316_INT_STAT1		0x0
 #define ADT7316_INT_STAT2		0x1
 #define ADT7316_LSB_IN_TEMP_VDD		0x3
-#define ADT7316_LSB_IN_TEMP_MASK	0x3
-#define ADT7316_LSB_VDD_MASK		0xC
+#define ADT7316_LSB_IN_TEMP_MASK	GENMASK_U32(1, 0)
+#define ADT7316_LSB_VDD_MASK		GENMASK_U32(3, 2)
 #define ADT7316_LSB_EX_TEMP_AIN		0x4
 #define ADT7316_LSB_EX_TEMP_AIN1_MASK	GENMASK_U32(1, 0)
 #define ADT7516_LSB_AIN2_MASK		GENMASK_U32(3, 2)
@@ -90,19 +90,19 @@
 /*
  * ADT7316 config1
  */
-#define ADT7316_CONFIG1_MONITOR_EN		0x1
-#define ADT7516_CONFIG1_SEL_AIN1_2_EX_TEMP_MASK	0x6
-#define ADT7516_CONFIG1_SEL_EX_TEMP		0x4
-#define ADT7516_CONFIG1_SEL_AIN3		0x8
-#define ADT7316_CONFIG1_INT_EN			0x20
-#define ADT7316_CONFIG1_INT_POLARITY		0x40
-#define ADT7316_CONFIG1_PD			0x80
+#define ADT7316_CONFIG1_MONITOR_EN		BIT_U32(0)
+#define ADT7516_CONFIG1_SEL_AIN1_2_EX_TEMP_MASK	GENMASK_U32(2, 1)
+#define ADT7516_CONFIG1_SEL_EX_TEMP		BIT_U32(2)
+#define ADT7516_CONFIG1_SEL_AIN3		BIT_U32(3)
+#define ADT7316_CONFIG1_INT_EN			BIT_U32(5)
+#define ADT7316_CONFIG1_INT_POLARITY		BIT_U32(6)
+#define ADT7316_CONFIG1_PD			BIT_U32(7)
 
 /*
  * ADT7316 config2
  */
-#define ADT7316_CONFIG2_AD_SINGLE_CH_MASK	0x3
-#define ADT7516_CONFIG2_AD_SINGLE_CH_MASK	0x7
+#define ADT7316_CONFIG2_AD_SINGLE_CH_MASK	GENMASK_U32(1, 0)
+#define ADT7516_CONFIG2_AD_SINGLE_CH_MASK	GENMASK_U32(2, 0)
 #define ADT7316_CONFIG2_AD_SINGLE_CH_VDD	0
 #define ADT7316_CONFIG2_AD_SINGLE_CH_IN		1
 #define ADT7316_CONFIG2_AD_SINGLE_CH_EX		2
@@ -110,51 +110,51 @@
 #define ADT7516_CONFIG2_AD_SINGLE_CH_AIN2	3
 #define ADT7516_CONFIG2_AD_SINGLE_CH_AIN3	4
 #define ADT7516_CONFIG2_AD_SINGLE_CH_AIN4	5
-#define ADT7316_CONFIG2_AD_SINGLE_CH_MODE	0x10
-#define ADT7316_CONFIG2_DISABLE_AVERAGING	0x20
-#define ADT7316_CONFIG2_EN_SMBUS_TIMEOUT	0x40
-#define ADT7316_CONFIG2_RESET			0x80
+#define ADT7316_CONFIG2_AD_SINGLE_CH_MODE	BIT_U32(4)
+#define ADT7316_CONFIG2_DISABLE_AVERAGING	BIT_U32(5)
+#define ADT7316_CONFIG2_EN_SMBUS_TIMEOUT	BIT_U32(6)
+#define ADT7316_CONFIG2_RESET			BIT_U32(7)
 
 /*
  * ADT7316 config3
  */
-#define ADT7316_CONFIG3_ADCLK_22_5		0x1
-#define ADT7316_CONFIG3_DA_HIGH_RESOLUTION	0x2
-#define ADT7316_CONFIG3_DA_EN_VIA_DAC_LDAC	0x8
-#define ADT7516_CONFIG3_AIN_IN_VREF		0x10
-#define ADT7316_CONFIG3_EN_IN_TEMP_PROP_DACA	0x20
-#define ADT7316_CONFIG3_EN_EX_TEMP_PROP_DACB	0x40
+#define ADT7316_CONFIG3_ADCLK_22_5		BIT_U32(0)
+#define ADT7316_CONFIG3_DA_HIGH_RESOLUTION	BIT_U32(1)
+#define ADT7316_CONFIG3_DA_EN_VIA_DAC_LDAC	BIT_U32(3)
+#define ADT7516_CONFIG3_AIN_IN_VREF		BIT_U32(4)
+#define ADT7316_CONFIG3_EN_IN_TEMP_PROP_DACA	BIT_U32(5)
+#define ADT7316_CONFIG3_EN_EX_TEMP_PROP_DACB	BIT_U32(6)
 
 /*
  * ADT7316 DAC config
  */
-#define ADT7316_DAC_CONFIG_2VREF_CH_MASK	0xF
-#define ADT7316_DAC_CONFIG_EN_MODE_MASK		0x30
+#define ADT7316_DAC_CONFIG_2VREF_CH_MASK	GENMASK_U32(3, 0)
+#define ADT7316_DAC_CONFIG_EN_MODE_MASK		GENMASK_U32(5, 4)
 #define ADT7316_DAC_CONFIG_EN_MODE_SINGLE	0x00
 #define ADT7316_DAC_CONFIG_EN_MODE_AB_CD	0x10
 #define ADT7316_DAC_CONFIG_EN_MODE_ABCD		0x20
 #define ADT7316_DAC_CONFIG_EN_MODE_LDAC		0x30
-#define ADT7316_DAC_CONFIG_VREF_BYPASS_AB	0x40
-#define ADT7316_DAC_CONFIG_VREF_BYPASS_CD	0x80
+#define ADT7316_DAC_CONFIG_VREF_BYPASS_AB	BIT_U32(6)
+#define ADT7316_DAC_CONFIG_VREF_BYPASS_CD	BIT_U32(7)
 
 /*
  * ADT7316 LDAC config
  */
-#define ADT7316_LDAC_CONFIG_EN_DA_MASK		0xF
-#define ADT7316_LDAC_CONFIG_DAC_IN_VREF		0x10
-#define ADT7516_LDAC_CONFIG_DAC_AB_IN_VREF	0x10
-#define ADT7516_LDAC_CONFIG_DAC_CD_IN_VREF	0x20
-#define ADT7516_LDAC_CONFIG_DAC_IN_VREF_MASK	0x30
+#define ADT7316_LDAC_CONFIG_EN_DA_MASK		GENMASK_U32(3, 0)
+#define ADT7316_LDAC_CONFIG_DAC_IN_VREF		BIT_U32(4)
+#define ADT7516_LDAC_CONFIG_DAC_AB_IN_VREF	BIT_U32(4)
+#define ADT7516_LDAC_CONFIG_DAC_CD_IN_VREF	BIT_U32(5)
+#define ADT7516_LDAC_CONFIG_DAC_IN_VREF_MASK	GENMASK_U32(5, 4)
 
 /*
  * ADT7316 INT_MASK2
  */
-#define ADT7316_INT_MASK2_VDD		0x10
+#define ADT7316_INT_MASK2_VDD		BIT_U32(4)
 
 /*
  * ADT7316 value masks
  */
-#define ADT7316_VALUE_MASK		0xfff
+#define ADT7316_VALUE_MASK		GENMASK_U32(11, 0)
 #define ADT7316_AD_MSB_MASK		GENMASK_U32(9, 2)
 
 /*
@@ -172,7 +172,7 @@
 #define ID_ADT7517		0x12
 #define ID_ADT7519		0x14
 
-#define ID_FAMILY_MASK		0xF0
+#define ID_FAMILY_MASK		GENMASK_U32(7, 4)
 #define ID_ADT73XX		0x0
 #define ID_ADT75XX		0x10
 
@@ -206,9 +206,9 @@ struct adt7316_chip_info {
 #define ADT7516_AIN2_INT_MASK		0x20
 #define ADT7516_AIN3_INT_MASK		0x40
 #define ADT7516_AIN4_INT_MASK		0x80
-#define ADT7316_VDD_INT_MASK		0x100
-#define ADT7316_TEMP_INT_MASK		0x1F
-#define ADT7516_AIN_INT_MASK		0xE0
+#define ADT7316_VDD_INT_MASK		BIT_U32(8)
+#define ADT7316_TEMP_INT_MASK		GENMASK_U32(4, 0)
+#define ADT7516_AIN_INT_MASK		GENMASK_U32(7, 5)
 #define ADT7316_TEMP_AIN_INT_MASK	\
 	(ADT7316_TEMP_INT_MASK)
 

-- 
2.53.0

