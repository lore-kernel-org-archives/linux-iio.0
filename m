Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C431335090
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769845131; cv=none; b=o7rk3KHMN1PqcQq5RWQDFHOVoFrNM9MT5+gUrPd7a4kau8XEV2wrwviYZLy4YL2F4yvcq+xfK2bl5HwPUMPibki5St1EmZ+0a7DcxmLGQBpy8jhmh/PPMfGdB/LMD3JkpZp3q9T3+eN/fJddwAk+95zVoRxSrzq1zvgGVnmRl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769845131; c=relaxed/simple;
	bh=2hehsSc95k8OiROw8SZieahI+zCiELEJXRh0+GjuEuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmx1Y6EjxfGpV2YWJne/poB78ZQpsX9o08t5eAjhiFvE9Y3/pT84WrkcQqnsimuLS9Nm/1Tx4ZBrxRn9hT/TBSfuji49IgldXe0lSU0j+NwNPQquQTGRsAsCqYJElN9FgVX5lPJRs7NbsMGfKjEeYtNWzpdU2CTXKQExeexyNIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5afbkXH; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5afbkXH"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b7070acfdcso3441612eec.0
        for <linux-iio@vger.kernel.org>; Fri, 30 Jan 2026 23:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769845129; x=1770449929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgmpbHGAysGvtiudNoXzc7HtntppszTMpEWpHobWzc0=;
        b=L5afbkXHC/xqyfwP6Jeu2ylsv1fgKmeghWqfKja/JyjGhtFeu5R8XY6by1IO/SA5vr
         bo3Noac4frKkBSIL7LTZezTud8OuQEsh6a+eAKKn3kCxxZMmqya2mHnMztQQKOuxfdBy
         X9NlbaAiEE5Kh0zpfqbdF7pfXiL7BqNDm7QDqzRKUCQSVcJ3spqFVMrN1Z7/uMllDdZg
         ESPpDpZ2eQe2pjBoNVub+GsFrvMAOdh8ge2v5GWawo1Ex51hsmPHwM7DZR6RAVpt3xhd
         Ko6XKxXllYZMlesiwHVZhdVRcg1HIC/yfp2gq9CxyZ7XUiuGUw6lDK4hFcnIKWaCjf+w
         f4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769845129; x=1770449929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WgmpbHGAysGvtiudNoXzc7HtntppszTMpEWpHobWzc0=;
        b=Dr4YJYVT/BmyrHXHikPKKB1Q/snkVRK0nOlrJ9HGJ5KanDYUWH0sj948g9zjxa0vh8
         lC9CDV9nAYc67skPy0RR7YdScjvMqFCEVUn7S2K6XXby9L1Ae8j5z6EzshzWmmgUHjgI
         hem290LFangObdF4koi2TwHq+JMYo2u8m0XSv7smx1y007XLp6J69Ho7LXLCEvUzFvwd
         YkUmCFqyxi8hXNnrHMy4nsCnXtvDER52Pj3mt4lpdWRu0YVKA/i0eTN6NOFemzTHLE1C
         ZiL//Z9cbe78iwxZQ2IZU8/Q1ttSCS1a8LA73XxcrbDIgYCuMWdKwdWkSikyWktSaMCv
         CzTw==
X-Forwarded-Encrypted: i=1; AJvYcCU6uGr/cV5Yqqk4JSN24zeOfT+aPC+/0D+uiZemo35KXOocsmxTtKc/IGrJyT7ovHD6hQVaU+eVfr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOZ0zJB+8VOo4Ahs8MBKJIU/q3BHr6KU7XLBiP7zq6hrsWmFnR
	jlZRb5MKxp+SPCPjMIg9pxRrzeBgNI/zDvXEWTPzOBzlMZGtmXrI1JaH
X-Gm-Gg: AZuq6aJVfpBH23y3lpIb2E5FgLYH0pb0cJni5ITIvmQOwXcLToA3LcH8lfgKvp4Xi9S
	hqy0AioiaRTGtM5dw3Opm/UsyopvqaGdQiuvW/ubd/0yX7UYWzYmXvmzrC/x8lUHF8PkZ57u5OW
	wGPoKTz8aiR9dLggJqmmPlK4nv0PK15bCOS6F4XDTK8U38X6SEWPRMyA4y1CoMGdozVF5M9kPfp
	ABGmGBJStP80d3CSpo7Y/GBUWQYpt9kvheN8G9t72HYLDrmMGR7VSuqPxgighoBE7HrBa5X1DLb
	0w3zkO9Z/Vm/AiaiVz+wrT0CnWiGIox2US9wp1cqA1igYT1u79sqmxJpbT2pMB9htGc3qIae47P
	73n8M7j2XCtoa3hURU9F2lm0AXwXjPRze/YYWfZ/AHB8ZDvWBNatm+RUqfSeAm94iIqBdWyuJ0l
	0gpJdYQ8xKtctzipNbH2l/E8rHTw==
X-Received: by 2002:a05:7300:ad08:b0:2b0:4c5f:c05c with SMTP id 5a478bee46e88-2b7c862d9b9mr2495071eec.4.1769845129285;
        Fri, 30 Jan 2026 23:38:49 -0800 (PST)
Received: from [192.168.0.61] ([76.174.137.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8d6sm14337027eec.3.2026.01.30.23.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 23:38:47 -0800 (PST)
From: Michael Harris <michaelharriscode@gmail.com>
Date: Fri, 30 Jan 2026 23:38:28 -0800
Subject: [PATCH 2/2] staging: iio: adt7316: convert magic numbers to BIT()
 and GENMASK()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-adt7316-correct-macros-v1-2-8a71df1e42f1@gmail.com>
References: <20260130-adt7316-correct-macros-v1-0-8a71df1e42f1@gmail.com>
In-Reply-To: <20260130-adt7316-correct-macros-v1-0-8a71df1e42f1@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769845124; l=6212;
 i=michaelharriscode@gmail.com; s=20260130; h=from:subject:message-id;
 bh=2hehsSc95k8OiROw8SZieahI+zCiELEJXRh0+GjuEuo=;
 b=OXpV7JxGwGsE9bqpWBETLPpcYUVx5Klh2SzCVu+PC7ktEzLDrBXJT3SFAllV06VWTLUP6Fmyj
 spe/NgY2DG5CZBTsV0BDxg336Dj2Y/hjBv+yVGpmBsUHXHkuHpOW+fo
X-Developer-Key: i=michaelharriscode@gmail.com; a=ed25519;
 pk=td/zQD3XANAhdG3Kf3mSetXiynk1Ql0eM4s0+eks5DU=

Improve readability by converting raw hex macros to use BIT() or GENMASK()
instead.

Update a few sysfs_emit() string formats to expect the unsigned long type
given by BIT() and GENMASK() and prevent compiler errors.

Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 80 ++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 4173c8822fff495e8c69d9cf6c11be9e9227a8c1..0af7e18ff9684993622a268110f0a17c0bff3616 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -29,11 +29,11 @@
 #define ADT7316_INT_STAT1		0x0
 #define ADT7316_INT_STAT2		0x1
 #define ADT7316_LSB_IN_TEMP_VDD		0x3
-#define ADT7316_LSB_IN_TEMP_MASK	0x3
-#define ADT7316_LSB_VDD_MASK		0xC
+#define ADT7316_LSB_IN_TEMP_MASK	GENMASK(1, 0)
+#define ADT7316_LSB_VDD_MASK		GENMASK(3, 2)
 #define ADT7316_LSB_VDD_OFFSET		2
 #define ADT7316_LSB_EX_TEMP_AIN		0x4
-#define ADT7316_LSB_EX_TEMP_MASK	0x3
+#define ADT7316_LSB_EX_TEMP_MASK	GENMASK(1, 0)
 #define ADT7516_LSB_AIN_SHIFT		2
 #define ADT7316_AD_MSB_DATA_BASE        0x6
 #define ADT7316_AD_MSB_DATA_REGS        3
@@ -88,19 +88,19 @@
 /*
  * ADT7316 config1
  */
-#define ADT7316_EN			0x1
-#define ADT7516_SEL_EX_TEMP		0x4
-#define ADT7516_SEL_AIN1_2_EX_TEMP_MASK	0x6
-#define ADT7516_SEL_AIN3		0x8
-#define ADT7316_INT_EN			0x20
-#define ADT7316_INT_POLARITY		0x40
-#define ADT7316_PD			0x80
+#define ADT7316_EN			BIT(0)
+#define ADT7516_SEL_EX_TEMP		BIT(2)
+#define ADT7516_SEL_AIN1_2_EX_TEMP_MASK	GENMASK(2, 1)
+#define ADT7516_SEL_AIN3		BIT(3)
+#define ADT7316_INT_EN			BIT(5)
+#define ADT7316_INT_POLARITY		BIT(6)
+#define ADT7316_PD			BIT(7)
 
 /*
  * ADT7316 config2
  */
-#define ADT7316_AD_SINGLE_CH_MASK	0x3
-#define ADT7516_AD_SINGLE_CH_MASK	0x7
+#define ADT7316_AD_SINGLE_CH_MASK	GENMASK(1, 0)
+#define ADT7516_AD_SINGLE_CH_MASK	GENMASK(2, 0)
 #define ADT7316_AD_SINGLE_CH_VDD	0
 #define ADT7316_AD_SINGLE_CH_IN		1
 #define ADT7316_AD_SINGLE_CH_EX		2
@@ -108,54 +108,54 @@
 #define ADT7516_AD_SINGLE_CH_AIN2	3
 #define ADT7516_AD_SINGLE_CH_AIN3	4
 #define ADT7516_AD_SINGLE_CH_AIN4	5
-#define ADT7316_AD_SINGLE_CH_MODE	0x10
-#define ADT7316_DISABLE_AVERAGING	0x20
-#define ADT7316_EN_SMBUS_TIMEOUT	0x40
+#define ADT7316_AD_SINGLE_CH_MODE	BIT(4)
+#define ADT7316_DISABLE_AVERAGING	BIT(5)
+#define ADT7316_EN_SMBUS_TIMEOUT	BIT(6)
 
 /*
  * ADT7316 config3
  */
-#define ADT7316_ADCLK_22_5		0x1
-#define ADT7316_DA_HIGH_RESOLUTION	0x2
-#define ADT7316_DA_EN_VIA_DAC_LDAC	0x8
-#define ADT7516_AIN_IN_VREF		0x10
-#define ADT7316_EN_IN_TEMP_PROP_DACA	0x20
-#define ADT7316_EN_EX_TEMP_PROP_DACB	0x40
+#define ADT7316_ADCLK_22_5		BIT(0)
+#define ADT7316_DA_HIGH_RESOLUTION	BIT(1)
+#define ADT7316_DA_EN_VIA_DAC_LDAC	BIT(3)
+#define ADT7516_AIN_IN_VREF		BIT(4)
+#define ADT7316_EN_IN_TEMP_PROP_DACA	BIT(5)
+#define ADT7316_EN_EX_TEMP_PROP_DACB	BIT(6)
 
 /*
  * ADT7316 DAC config
  */
-#define ADT7316_DA_2VREF_CH_MASK	0xF
-#define ADT7316_DA_EN_MODE_MASK		0x30
+#define ADT7316_DA_2VREF_CH_MASK	GENMASK(3, 0)
+#define ADT7316_DA_EN_MODE_MASK		GENMASK(5, 4)
 #define ADT7316_DA_EN_MODE_SHIFT	4
 #define ADT7316_DA_EN_MODE_SINGLE	0x00
 #define ADT7316_DA_EN_MODE_AB_CD	0x10
 #define ADT7316_DA_EN_MODE_ABCD		0x20
 #define ADT7316_DA_EN_MODE_LDAC		0x30
-#define ADT7316_VREF_BYPASS_DAC_AB	0x40
-#define ADT7316_VREF_BYPASS_DAC_CD	0x80
+#define ADT7316_VREF_BYPASS_DAC_AB	BIT(6)
+#define ADT7316_VREF_BYPASS_DAC_CD	BIT(7)
 
 /*
  * ADT7316 LDAC config
  */
-#define ADT7316_LDAC_EN_DA_MASK		0xF
-#define ADT7316_DAC_IN_VREF		0x10
-#define ADT7516_DAC_AB_IN_VREF		0x10
-#define ADT7516_DAC_CD_IN_VREF		0x20
+#define ADT7316_LDAC_EN_DA_MASK		GENMASK(3, 0)
+#define ADT7316_DAC_IN_VREF		BIT(4)
+#define ADT7516_DAC_AB_IN_VREF		BIT(4)
+#define ADT7516_DAC_CD_IN_VREF		BIT(5)
 #define ADT7516_DAC_IN_VREF_OFFSET	4
-#define ADT7516_DAC_IN_VREF_MASK	0x30
+#define ADT7516_DAC_IN_VREF_MASK	GENMASK(5, 4)
 
 /*
  * ADT7316 INT_MASK2
  */
-#define ADT7316_INT_MASK2_VDD		0x10
+#define ADT7316_INT_MASK2_VDD		BIT(4)
 
 /*
  * ADT7316 value masks
  */
-#define ADT7316_T_VALUE_SIGN		0x400
+#define ADT7316_T_VALUE_SIGN		BIT(10)
 #define ADT7316_T_VALUE_FLOAT_OFFSET	2
-#define ADT7316_T_VALUE_FLOAT_MASK	0x2
+#define ADT7316_T_VALUE_FLOAT_MASK	BIT(1)
 
 /*
  * Chip ID
@@ -167,7 +167,7 @@
 #define ID_ADT7517		0x12
 #define ID_ADT7519		0x14
 
-#define ID_FAMILY_MASK		0xF0
+#define ID_FAMILY_MASK		GENMASK(7, 4)
 #define ID_ADT73XX		0x0
 #define ID_ADT75XX		0x10
 
@@ -192,9 +192,9 @@ struct adt7316_chip_info {
  * Logic interrupt mask for user application to enable
  * interrupts.
  */
-#define ADT7316_VDD_INT_MASK		0x100
-#define ADT7316_TEMP_INT_MASK		0x1F
-#define ADT7516_AIN_INT_MASK		0xE0
+#define ADT7316_VDD_INT_MASK		BIT(8)
+#define ADT7316_TEMP_INT_MASK		GENMASK(4, 0)
+#define ADT7516_AIN_INT_MASK		GENMASK(7, 5)
 #define ADT7316_TEMP_AIN_INT_MASK	\
 	(ADT7316_TEMP_INT_MASK)
 
@@ -783,7 +783,7 @@ static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return sysfs_emit(buf, "0x%x\n",
+	return sysfs_emit(buf, "0x%lx\n",
 		chip->dac_config & ADT7316_DA_2VREF_CH_MASK);
 }
 
@@ -1023,7 +1023,7 @@ static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
-		return sysfs_emit(buf, "0x%x\n",
+		return sysfs_emit(buf, "0x%lx\n",
 			(chip->ldac_config & ADT7516_DAC_IN_VREF_MASK) >>
 			ADT7516_DAC_IN_VREF_OFFSET);
 	return sysfs_emit(buf, "%d\n",
@@ -1146,7 +1146,7 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 		sign = '-';
 	}
 
-	return sysfs_emit(buf, "%c%d.%.2d\n", sign,
+	return sysfs_emit(buf, "%c%d.%.2ld\n", sign,
 		(data >> ADT7316_T_VALUE_FLOAT_OFFSET),
 		(data & ADT7316_T_VALUE_FLOAT_MASK) * 25);
 }

-- 
2.52.0

