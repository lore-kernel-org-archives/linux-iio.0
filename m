Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A203302753
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 04:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721892; cv=none; b=R7/TsbgLf/FIDWVgQaebca4VF7FPjtSeQZu4T1AxFPUbwQHfO6DyCoEwe1OVVa8K7/lHPqOWYx81k40LQDyHSw6h7NqJIbrC5l0r7lvXidaIjmEB8NPn5h2s36qR2vHkKvWX55DEDAYoLzjlr9r5QLX1KaATptjkiX7xKac1Jjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721892; c=relaxed/simple;
	bh=9fUrOXJ0ZI+0f52eTa/9AqkmecF4y8G0qJn/YY7pPMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yp69BmRuMMs94sG4V0g7aqqpvodm5zdPA0nV9O1QPwJwFmOlfY4i6WMvRm3V50xmTHx8+++gjGQpS2ihyb7wtA0h9nucczr84jbiiyQ+srTiWcz6IjMiM8XQfyf76D/a0fA8HOna6NUPaQrTBddeOLQS2o46Ljllv1se3ajoF8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWXT37Aa; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWXT37Aa"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bec2ddee9bbso530607366b.3
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 21:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721889; x=1781326689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WZGMz9a8XsNsuHgB7vubDPNzI+zMoyCyaCQ9SgGtB4=;
        b=eWXT37AaVImZiPeT2Y+DJpWVc+BFRpmCvZLnDyEK6CtEIFBjEkV3rQYiV2sbtPs08m
         epZWTGd1SPB8NeMAA/OcfGhru1gXLjY9MfhfcS/cdbs9Vfqfu4vYMzQXEVXpUGV/iq8N
         zu4Cnfl5HSviA7WVUW1w7Fu12T6glymx5S7KRnFlbCpljdGTtPdQdKckbFP+oSSZXc/z
         7jQeFg7ZpM1y31kDU1bQbrSAZfyvXx7JvL4Jrq2dNJs+2nd6wt6cBYKhM13/peU4Wvfj
         1sLeeT0Rdi3ewK8gpiGJACvo5VnELgHouqoUTPmne8XsjUJig4cwWG+u6+WAL84k+prz
         DiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721889; x=1781326689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6WZGMz9a8XsNsuHgB7vubDPNzI+zMoyCyaCQ9SgGtB4=;
        b=VtFHoWKvAavne4JKhTf9gvocxcJuMrQ2AQB8rpqjfEobMqn/PPJCjixtMGWNHG818I
         hpcbXITSqvawzouDXYWq60pcLTAb5qTNYvfjgOQu90GN34NKhO5zjGUAGtWIYoISpCjU
         ecPR6aW2dtaibS49fWwYsg2j49QosamH4lFCcpr5FMWgy+Y/EaeH3boOV4E5jou3b7ia
         pfBCu3oqLHKDUgGqAYHedAl3PcTelqhBjH0+VF+V5wHHcjQfoDhTi4VyaU0pQ7gPatNT
         NllB1oyLzimljWVXxZmJHRcFK1Y1AcPljKD3DgafoPuvF+YB36fcF/UT+3dN7D55kDAV
         1Rmg==
X-Forwarded-Encrypted: i=1; AFNElJ/xkle7M7HGNyGHjLrstHwN8dSfVQ2bfSq7rAfN5f4kj1pV0R7xAZMbIyFUVfv8hpl46ZnvQcaiWU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJtGCq9HUFneVsWW8wER6+qSKCijpkzSNpFyRajD1YiwJFijT
	t437nJ2/cTG2lF+7u1mkzTE4dIZkFSVHJ85bW6v84xGyO4SNp+AvGv7t
X-Gm-Gg: Acq92OGoHBo1mOYBMwAR7nKurxBi9vkTiWrU91SRKO5gE2lTLgEDxC5qtWc+MOSpy8c
	jGpFsGxxgm6eP4eGh9EkmO5UNAzr7yrWmXl42C6t0seUFyzeHOtVyfYrcf22KfH8Wi8qrXanmN7
	Sr5tdzwCAOcRCvLavSlnLoRTlwAk1iVcnD+JzIoxzAIQaLEI9e3hsPM8Izo6ya8bW/tyzXpEJES
	9GDevXNVtfybgXKRcmLWG50Ar8RKPKdPZt0/EUZWdxQCB586AAUviAKzeGi2+bw8iCuMlNCiXwY
	x1wEw3FJh174K4i1v+1v3Zofe4doWWBtPPcml9yG5O8HSwFanwe7G2sdz9khJU+gtwUIG4Q0xBM
	gA78rtk8A/pp//bGNB2mKmgyKV5PrlKbT0+888OGOoZdT7tdha7VZklosZrebdI/ybX+VyyzObq
	yU3GoKmyMES4syhkWCaKFIUGY=
X-Received: by 2002:a17:907:a44:b0:bd3:cb24:ae61 with SMTP id a640c23a62f3a-bf37037d2eemr377837966b.6.1780721888728;
        Fri, 05 Jun 2026 21:58:08 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:08 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v4 02/14] mfd: lm3533: Remove driver specific regmap wrappers
Date: Sat,  6 Jun 2026 07:57:26 +0300
Message-ID: <20260606045738.21050-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606045738.21050-1-clamor95@gmail.com>
References: <20260606045738.21050-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove driver-specific regmap wrappers in favor of using regmap helpers
directly.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/lm3533-als.c      | 79 +++++++++++++----------------
 drivers/leds/leds-lm3533.c          | 58 ++++++++-------------
 drivers/mfd/lm3533-core.c           | 73 ++++----------------------
 drivers/mfd/lm3533-ctrlbank.c       | 22 ++++----
 drivers/video/backlight/lm3533_bl.c | 33 ++++--------
 include/linux/mfd/lm3533.h          |  8 +--
 6 files changed, 90 insertions(+), 183 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 99f0b903018c..44b104c2d77f 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -17,6 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/mfd/core.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
@@ -64,7 +65,7 @@ static int lm3533_als_get_adc(struct iio_dev *indio_dev, bool average,
 {
 	struct lm3533_als *als = iio_priv(indio_dev);
 	u8 reg;
-	u8 val;
+	u32 val;
 	int ret;
 
 	if (average)
@@ -72,7 +73,7 @@ static int lm3533_als_get_adc(struct iio_dev *indio_dev, bool average,
 	else
 		reg = LM3533_REG_ALS_READ_ADC_RAW;
 
-	ret = lm3533_read(als->lm3533, reg, &val);
+	ret = regmap_read(als->lm3533->regmap, reg, &val);
 	if (ret) {
 		dev_err(&indio_dev->dev, "failed to read adc\n");
 		return ret;
@@ -86,10 +87,10 @@ static int lm3533_als_get_adc(struct iio_dev *indio_dev, bool average,
 static int _lm3533_als_get_zone(struct iio_dev *indio_dev, u8 *zone)
 {
 	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 val;
+	u32 val;
 	int ret;
 
-	ret = lm3533_read(als->lm3533, LM3533_REG_ALS_ZONE_INFO, &val);
+	ret = regmap_read(als->lm3533->regmap, LM3533_REG_ALS_ZONE_INFO, &val);
 	if (ret) {
 		dev_err(&indio_dev->dev, "failed to read zone\n");
 		return ret;
@@ -127,7 +128,7 @@ static inline u8 lm3533_als_get_target_reg(unsigned channel, unsigned zone)
 }
 
 static int lm3533_als_get_target(struct iio_dev *indio_dev, unsigned channel,
-							unsigned zone, u8 *val)
+				 unsigned zone, u32 *val)
 {
 	struct lm3533_als *als = iio_priv(indio_dev);
 	u8 reg;
@@ -140,7 +141,7 @@ static int lm3533_als_get_target(struct iio_dev *indio_dev, unsigned channel,
 		return -EINVAL;
 
 	reg = lm3533_als_get_target_reg(channel, zone);
-	ret = lm3533_read(als->lm3533, reg, val);
+	ret = regmap_read(als->lm3533->regmap, reg, val);
 	if (ret)
 		dev_err(&indio_dev->dev, "failed to get target current\n");
 
@@ -161,7 +162,7 @@ static int lm3533_als_set_target(struct iio_dev *indio_dev, unsigned channel,
 		return -EINVAL;
 
 	reg = lm3533_als_get_target_reg(channel, zone);
-	ret = lm3533_write(als->lm3533, reg, val);
+	ret = regmap_write(als->lm3533->regmap, reg, val);
 	if (ret)
 		dev_err(&indio_dev->dev, "failed to set target current\n");
 
@@ -171,8 +172,8 @@ static int lm3533_als_set_target(struct iio_dev *indio_dev, unsigned channel,
 static int lm3533_als_get_current(struct iio_dev *indio_dev, unsigned channel,
 								int *val)
 {
+	u32 target;
 	u8 zone;
-	u8 target;
 	int ret;
 
 	ret = lm3533_als_get_zone(indio_dev, &zone);
@@ -271,16 +272,10 @@ static irqreturn_t lm3533_als_isr(int irq, void *dev_id)
 static int lm3533_als_set_int_mode(struct iio_dev *indio_dev, int enable)
 {
 	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 mask = LM3533_ALS_INT_ENABLE_MASK;
-	u8 val;
 	int ret;
 
-	if (enable)
-		val = mask;
-	else
-		val = 0;
-
-	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_ZONE_INFO, val, mask);
+	ret = regmap_assign_bits(als->lm3533->regmap, LM3533_REG_ALS_ZONE_INFO,
+				 LM3533_ALS_INT_ENABLE_MASK, enable);
 	if (ret) {
 		dev_err(&indio_dev->dev, "failed to set int mode %d\n",
 								enable);
@@ -293,17 +288,16 @@ static int lm3533_als_set_int_mode(struct iio_dev *indio_dev, int enable)
 static int lm3533_als_get_int_mode(struct iio_dev *indio_dev, int *enable)
 {
 	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 mask = LM3533_ALS_INT_ENABLE_MASK;
-	u8 val;
 	int ret;
 
-	ret = lm3533_read(als->lm3533, LM3533_REG_ALS_ZONE_INFO, &val);
-	if (ret) {
+	ret = regmap_test_bits(als->lm3533->regmap, LM3533_REG_ALS_ZONE_INFO,
+			       LM3533_ALS_INT_ENABLE_MASK);
+	if (ret < 0) {
 		dev_err(&indio_dev->dev, "failed to get int mode\n");
 		return ret;
 	}
 
-	*enable = !!(val & mask);
+	*enable = ret;
 
 	return 0;
 }
@@ -316,7 +310,7 @@ static inline u8 lm3533_als_get_threshold_reg(unsigned nr, bool raising)
 }
 
 static int lm3533_als_get_threshold(struct iio_dev *indio_dev, unsigned nr,
-							bool raising, u8 *val)
+				    bool raising, u32 *val)
 {
 	struct lm3533_als *als = iio_priv(indio_dev);
 	u8 reg;
@@ -326,7 +320,7 @@ static int lm3533_als_get_threshold(struct iio_dev *indio_dev, unsigned nr,
 		return -EINVAL;
 
 	reg = lm3533_als_get_threshold_reg(nr, raising);
-	ret = lm3533_read(als->lm3533, reg, val);
+	ret = regmap_read(als->lm3533->regmap, reg, val);
 	if (ret)
 		dev_err(&indio_dev->dev, "failed to get threshold\n");
 
@@ -337,8 +331,8 @@ static int lm3533_als_set_threshold(struct iio_dev *indio_dev, unsigned nr,
 							bool raising, u8 val)
 {
 	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 val2;
 	u8 reg, reg2;
+	u32 val2;
 	int ret;
 
 	if (nr > LM3533_ALS_THRESH_MAX)
@@ -348,7 +342,7 @@ static int lm3533_als_set_threshold(struct iio_dev *indio_dev, unsigned nr,
 	reg2 = lm3533_als_get_threshold_reg(nr, !raising);
 
 	mutex_lock(&als->thresh_mutex);
-	ret = lm3533_read(als->lm3533, reg2, &val2);
+	ret = regmap_read(als->lm3533->regmap, reg2, &val2);
 	if (ret) {
 		dev_err(&indio_dev->dev, "failed to get threshold\n");
 		goto out;
@@ -363,7 +357,7 @@ static int lm3533_als_set_threshold(struct iio_dev *indio_dev, unsigned nr,
 		goto out;
 	}
 
-	ret = lm3533_write(als->lm3533, reg, val);
+	ret = regmap_write(als->lm3533->regmap, reg, val);
 	if (ret) {
 		dev_err(&indio_dev->dev, "failed to set threshold\n");
 		goto out;
@@ -375,11 +369,11 @@ static int lm3533_als_set_threshold(struct iio_dev *indio_dev, unsigned nr,
 }
 
 static int lm3533_als_get_hysteresis(struct iio_dev *indio_dev, unsigned nr,
-								u8 *val)
+				     u32 *val)
 {
 	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 falling;
-	u8 raising;
+	u32 falling;
+	u32 raising;
 	int ret;
 
 	if (nr > LM3533_ALS_THRESH_MAX)
@@ -503,7 +497,7 @@ static ssize_t show_als_attr(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct lm3533_als_attribute *als_attr = to_lm3533_als_attr(attr);
-	u8 val;
+	u32 val;
 	int ret;
 
 	switch (als_attr->type) {
@@ -716,16 +710,10 @@ static const struct attribute_group lm3533_als_attribute_group = {
 
 static int lm3533_als_set_input_mode(struct lm3533_als *als, bool pwm_mode)
 {
-	u8 mask = LM3533_ALS_INPUT_MODE_MASK;
-	u8 val;
 	int ret;
 
-	if (pwm_mode)
-		val = mask;	/* pwm input */
-	else
-		val = 0;	/* analog input */
-
-	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, val, mask);
+	ret = regmap_assign_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
+				 LM3533_ALS_INPUT_MODE_MASK, pwm_mode);
 	if (ret) {
 		dev_err(&als->pdev->dev, "failed to set input mode %d\n",
 								pwm_mode);
@@ -744,7 +732,8 @@ static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
 		return -EINVAL;
 	}
 
-	ret = lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR_SELECT, val);
+	ret = regmap_write(als->lm3533->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
+			   val);
 	if (ret) {
 		dev_err(&als->pdev->dev, "failed to set resistor\n");
 		return ret;
@@ -774,11 +763,11 @@ static int lm3533_als_setup(struct lm3533_als *als,
 
 static int lm3533_als_setup_irq(struct lm3533_als *als, void *dev)
 {
-	u8 mask = LM3533_ALS_INT_ENABLE_MASK;
 	int ret;
 
 	/* Make sure interrupts are disabled. */
-	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_ZONE_INFO, 0, mask);
+	ret = regmap_clear_bits(als->lm3533->regmap, LM3533_REG_ALS_ZONE_INFO,
+				LM3533_ALS_INT_ENABLE_MASK);
 	if (ret) {
 		dev_err(&als->pdev->dev, "failed to disable interrupts\n");
 		return ret;
@@ -798,10 +787,10 @@ static int lm3533_als_setup_irq(struct lm3533_als *als, void *dev)
 
 static int lm3533_als_enable(struct lm3533_als *als)
 {
-	u8 mask = LM3533_ALS_ENABLE_MASK;
 	int ret;
 
-	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, mask, mask);
+	ret = regmap_set_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
+			      LM3533_ALS_ENABLE_MASK);
 	if (ret)
 		dev_err(&als->pdev->dev, "failed to enable ALS\n");
 
@@ -810,10 +799,10 @@ static int lm3533_als_enable(struct lm3533_als *als)
 
 static int lm3533_als_disable(struct lm3533_als *als)
 {
-	u8 mask = LM3533_ALS_ENABLE_MASK;
 	int ret;
 
-	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, 0, mask);
+	ret = regmap_clear_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
+				LM3533_ALS_ENABLE_MASK);
 	if (ret)
 		dev_err(&als->pdev->dev, "failed to disable ALS\n");
 
diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index 45795f2a1042..a48991958eae 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -12,6 +12,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include <linux/mfd/lm3533.h>
@@ -80,7 +81,6 @@ static inline u8 lm3533_led_get_pattern_reg(struct lm3533_led *led,
 static int lm3533_led_pattern_enable(struct lm3533_led *led, int enable)
 {
 	u8 mask;
-	u8 val;
 	int pattern;
 	int state;
 	int ret = 0;
@@ -96,12 +96,8 @@ static int lm3533_led_pattern_enable(struct lm3533_led *led, int enable)
 	pattern = lm3533_led_get_pattern(led);
 	mask = 1 << (2 * pattern);
 
-	if (enable)
-		val = mask;
-	else
-		val = 0;
-
-	ret = lm3533_update(led->lm3533, LM3533_REG_PATTERN_ENABLE, val, mask);
+	ret = regmap_assign_bits(led->lm3533->regmap,
+				 LM3533_REG_PATTERN_ENABLE, mask, enable);
 	if (ret) {
 		dev_err(led->cdev.dev, "failed to enable pattern %d (%d)\n",
 							pattern, enable);
@@ -131,7 +127,7 @@ static int lm3533_led_set(struct led_classdev *cdev,
 static enum led_brightness lm3533_led_get(struct led_classdev *cdev)
 {
 	struct lm3533_led *led = to_lm3533_led(cdev);
-	u8 val;
+	u32 val;
 	int ret;
 
 	ret = lm3533_ctrlbank_get_brightness(&led->cb, &val);
@@ -259,7 +255,7 @@ static u8 lm3533_led_delay_set(struct lm3533_led *led, u8 base,
 	dev_dbg(led->cdev.dev, "%s - %lu: %u (0x%02x)\n", __func__,
 							*delay, t, val);
 	reg = lm3533_led_get_pattern_reg(led, base);
-	ret = lm3533_write(led->lm3533, reg, val);
+	ret = regmap_write(led->lm3533->regmap, reg, val);
 	if (ret)
 		dev_err(led->cdev.dev, "failed to set delay (%02x)\n", reg);
 
@@ -337,10 +333,10 @@ static ssize_t show_risefalltime(struct device *dev,
 	struct lm3533_led *led = to_lm3533_led(led_cdev);
 	ssize_t ret;
 	u8 reg;
-	u8 val;
+	u32 val;
 
 	reg = lm3533_led_get_pattern_reg(led, base);
-	ret = lm3533_read(led->lm3533, reg, &val);
+	ret = regmap_read(led->lm3533->regmap, reg, &val);
 	if (ret)
 		return ret;
 
@@ -375,7 +371,7 @@ static ssize_t store_risefalltime(struct device *dev,
 		return -EINVAL;
 
 	reg = lm3533_led_get_pattern_reg(led, base);
-	ret = lm3533_write(led->lm3533, reg, val);
+	ret = regmap_write(led->lm3533->regmap, reg, val);
 	if (ret)
 		return ret;
 
@@ -405,11 +401,11 @@ static ssize_t show_als_channel(struct device *dev,
 	struct lm3533_led *led = to_lm3533_led(led_cdev);
 	unsigned channel;
 	u8 reg;
-	u8 val;
+	u32 val;
 	int ret;
 
 	reg = lm3533_led_get_lv_reg(led, LM3533_REG_CTRLBANK_BCONF_BASE);
-	ret = lm3533_read(led->lm3533, reg, &val);
+	ret = regmap_read(led->lm3533->regmap, reg, &val);
 	if (ret)
 		return ret;
 
@@ -441,7 +437,7 @@ static ssize_t store_als_channel(struct device *dev,
 	mask = LM3533_REG_CTRLBANK_BCONF_ALS_CHANNEL_MASK;
 	val = channel - 1;
 
-	ret = lm3533_update(led->lm3533, reg, val, mask);
+	ret = regmap_update_bits(led->lm3533->regmap, reg, mask, val);
 	if (ret)
 		return ret;
 
@@ -455,11 +451,11 @@ static ssize_t show_als_en(struct device *dev,
 	struct lm3533_led *led = to_lm3533_led(led_cdev);
 	bool enable;
 	u8 reg;
-	u8 val;
+	u32 val;
 	int ret;
 
 	reg = lm3533_led_get_lv_reg(led, LM3533_REG_CTRLBANK_BCONF_BASE);
-	ret = lm3533_read(led->lm3533, reg, &val);
+	ret = regmap_read(led->lm3533->regmap, reg, &val);
 	if (ret)
 		return ret;
 
@@ -476,22 +472,15 @@ static ssize_t store_als_en(struct device *dev,
 	struct lm3533_led *led = to_lm3533_led(led_cdev);
 	unsigned enable;
 	u8 reg;
-	u8 mask;
-	u8 val;
 	int ret;
 
 	if (kstrtouint(buf, 0, &enable))
 		return -EINVAL;
 
 	reg = lm3533_led_get_lv_reg(led, LM3533_REG_CTRLBANK_BCONF_BASE);
-	mask = LM3533_REG_CTRLBANK_BCONF_ALS_EN_MASK;
 
-	if (enable)
-		val = mask;
-	else
-		val = 0;
-
-	ret = lm3533_update(led->lm3533, reg, val, mask);
+	ret = regmap_assign_bits(led->lm3533->regmap, reg,
+				 LM3533_REG_CTRLBANK_BCONF_ALS_EN_MASK, enable);
 	if (ret)
 		return ret;
 
@@ -504,12 +493,12 @@ static ssize_t show_linear(struct device *dev,
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 	struct lm3533_led *led = to_lm3533_led(led_cdev);
 	u8 reg;
-	u8 val;
+	u32 val;
 	int linear;
 	int ret;
 
 	reg = lm3533_led_get_lv_reg(led, LM3533_REG_CTRLBANK_BCONF_BASE);
-	ret = lm3533_read(led->lm3533, reg, &val);
+	ret = regmap_read(led->lm3533->regmap, reg, &val);
 	if (ret)
 		return ret;
 
@@ -529,22 +518,15 @@ static ssize_t store_linear(struct device *dev,
 	struct lm3533_led *led = to_lm3533_led(led_cdev);
 	unsigned long linear;
 	u8 reg;
-	u8 mask;
-	u8 val;
 	int ret;
 
 	if (kstrtoul(buf, 0, &linear))
 		return -EINVAL;
 
 	reg = lm3533_led_get_lv_reg(led, LM3533_REG_CTRLBANK_BCONF_BASE);
-	mask = LM3533_REG_CTRLBANK_BCONF_MAPPING_MASK;
-
-	if (linear)
-		val = mask;
-	else
-		val = 0;
 
-	ret = lm3533_update(led->lm3533, reg, val, mask);
+	ret = regmap_assign_bits(led->lm3533->regmap, reg,
+				 LM3533_REG_CTRLBANK_BCONF_MAPPING_MASK, linear);
 	if (ret)
 		return ret;
 
@@ -557,7 +539,7 @@ static ssize_t show_pwm(struct device *dev,
 {
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 	struct lm3533_led *led = to_lm3533_led(led_cdev);
-	u8 val;
+	u32 val;
 	int ret;
 
 	ret = lm3533_ctrlbank_get_pwm(&led->cb, &val);
diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 0a2409d00b2e..f9bdc0a1d9be 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -80,66 +80,14 @@ static struct mfd_cell lm3533_led_devs[] = {
 	},
 };
 
-int lm3533_read(struct lm3533 *lm3533, u8 reg, u8 *val)
-{
-	int tmp;
-	int ret;
-
-	ret = regmap_read(lm3533->regmap, reg, &tmp);
-	if (ret < 0) {
-		dev_err(lm3533->dev, "failed to read register %02x: %d\n",
-								reg, ret);
-		return ret;
-	}
-
-	*val = tmp;
-
-	dev_dbg(lm3533->dev, "read [%02x]: %02x\n", reg, *val);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(lm3533_read);
-
-int lm3533_write(struct lm3533 *lm3533, u8 reg, u8 val)
-{
-	int ret;
-
-	dev_dbg(lm3533->dev, "write [%02x]: %02x\n", reg, val);
-
-	ret = regmap_write(lm3533->regmap, reg, val);
-	if (ret < 0) {
-		dev_err(lm3533->dev, "failed to write register %02x: %d\n",
-								reg, ret);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(lm3533_write);
-
-int lm3533_update(struct lm3533 *lm3533, u8 reg, u8 val, u8 mask)
-{
-	int ret;
-
-	dev_dbg(lm3533->dev, "update [%02x]: %02x/%02x\n", reg, val, mask);
-
-	ret = regmap_update_bits(lm3533->regmap, reg, mask, val);
-	if (ret < 0) {
-		dev_err(lm3533->dev, "failed to update register %02x: %d\n",
-								reg, ret);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(lm3533_update);
-
 static int lm3533_set_boost_freq(struct lm3533 *lm3533,
 						enum lm3533_boost_freq freq)
 {
 	int ret;
 
-	ret = lm3533_update(lm3533, LM3533_REG_BOOST_PWM,
-					freq << LM3533_BOOST_FREQ_SHIFT,
-					LM3533_BOOST_FREQ_MASK);
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
+				 LM3533_BOOST_FREQ_MASK,
+				 freq << LM3533_BOOST_FREQ_SHIFT);
 	if (ret)
 		dev_err(lm3533->dev, "failed to set boost frequency\n");
 
@@ -152,9 +100,9 @@ static int lm3533_set_boost_ovp(struct lm3533 *lm3533,
 {
 	int ret;
 
-	ret = lm3533_update(lm3533, LM3533_REG_BOOST_PWM,
-					ovp << LM3533_BOOST_OVP_SHIFT,
-					LM3533_BOOST_OVP_MASK);
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
+				 LM3533_BOOST_OVP_MASK,
+				 ovp << LM3533_BOOST_OVP_SHIFT);
 	if (ret)
 		dev_err(lm3533->dev, "failed to set boost ovp\n");
 
@@ -181,7 +129,8 @@ static int lm3533_set_hvled_config(struct lm3533 *lm3533, u8 hvled, u8 bl)
 	mask = LM3533_BL_ID_MASK << shift;
 	val = bl << shift;
 
-	ret = lm3533_update(lm3533, LM3533_REG_OUTPUT_CONF1, val, mask);
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_OUTPUT_CONF1,
+				 mask, val);
 	if (ret)
 		dev_err(lm3533->dev, "failed to set hvled config\n");
 
@@ -216,7 +165,7 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
 	mask = LM3533_LED_ID_MASK << shift;
 	val = led << shift;
 
-	ret = lm3533_update(lm3533, reg, val, mask);
+	ret = regmap_update_bits(lm3533->regmap, reg, mask, val);
 	if (ret)
 		dev_err(lm3533->dev, "failed to set lvled config\n");
 
@@ -258,7 +207,7 @@ static ssize_t show_output(struct device *dev,
 	struct lm3533_device_attribute *lattr = to_lm3533_dev_attr(attr);
 	int id = lattr->u.output.id;
 	u8 reg;
-	u8 val;
+	u32 val;
 	u8 mask;
 	int shift;
 	int ret;
@@ -278,7 +227,7 @@ static ssize_t show_output(struct device *dev,
 		mask = LM3533_LED_ID_MASK << shift;
 	}
 
-	ret = lm3533_read(lm3533, reg, &val);
+	ret = regmap_read(lm3533->regmap, reg, &val);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mfd/lm3533-ctrlbank.c b/drivers/mfd/lm3533-ctrlbank.c
index 2537dfade51c..b78c130d7712 100644
--- a/drivers/mfd/lm3533-ctrlbank.c
+++ b/drivers/mfd/lm3533-ctrlbank.c
@@ -9,6 +9,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 
 #include <linux/mfd/lm3533.h>
 
@@ -38,8 +39,8 @@ int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb)
 	dev_dbg(cb->dev, "%s - %d\n", __func__, cb->id);
 
 	mask = 1 << cb->id;
-	ret = lm3533_update(cb->lm3533, LM3533_REG_CTRLBANK_ENABLE,
-								mask, mask);
+	ret = regmap_set_bits(cb->lm3533->regmap, LM3533_REG_CTRLBANK_ENABLE,
+			      mask);
 	if (ret)
 		dev_err(cb->dev, "failed to enable ctrlbank %d\n", cb->id);
 
@@ -55,7 +56,8 @@ int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb)
 	dev_dbg(cb->dev, "%s - %d\n", __func__, cb->id);
 
 	mask = 1 << cb->id;
-	ret = lm3533_update(cb->lm3533, LM3533_REG_CTRLBANK_ENABLE, 0, mask);
+	ret = regmap_clear_bits(cb->lm3533->regmap, LM3533_REG_CTRLBANK_ENABLE,
+				mask);
 	if (ret)
 		dev_err(cb->dev, "failed to disable ctrlbank %d\n", cb->id);
 
@@ -80,7 +82,7 @@ int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u16 imax)
 	val = (imax - LM3533_MAX_CURRENT_MIN) / LM3533_MAX_CURRENT_STEP;
 
 	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_MAX_CURRENT_BASE);
-	ret = lm3533_write(cb->lm3533, reg, val);
+	ret = regmap_write(cb->lm3533->regmap, reg, val);
 	if (ret)
 		dev_err(cb->dev, "failed to set max current\n");
 
@@ -94,7 +96,7 @@ int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u8 val)
 	int ret;
 
 	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_BRIGHTNESS_BASE);
-	ret = lm3533_write(cb->lm3533, reg, val);
+	ret = regmap_write(cb->lm3533->regmap, reg, val);
 	if (ret)
 		dev_err(cb->dev, "failed to set brightness\n");
 
@@ -102,13 +104,13 @@ int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u8 val)
 }
 EXPORT_SYMBOL_GPL(lm3533_ctrlbank_set_brightness);
 
-int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u8 *val)
+int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val)
 {
 	u8 reg;
 	int ret;
 
 	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_BRIGHTNESS_BASE);
-	ret = lm3533_read(cb->lm3533, reg, val);
+	ret = regmap_read(cb->lm3533->regmap, reg, val);
 	if (ret)
 		dev_err(cb->dev, "failed to get brightness\n");
 
@@ -135,7 +137,7 @@ int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u8 val)
 		return -EINVAL;
 
 	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_PWM_BASE);
-	ret = lm3533_write(cb->lm3533, reg, val);
+	ret = regmap_write(cb->lm3533->regmap, reg, val);
 	if (ret)
 		dev_err(cb->dev, "failed to set PWM mask\n");
 
@@ -143,13 +145,13 @@ int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u8 val)
 }
 EXPORT_SYMBOL_GPL(lm3533_ctrlbank_set_pwm);
 
-int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u8 *val)
+int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val)
 {
 	u8 reg;
 	int ret;
 
 	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_PWM_BASE);
-	ret = lm3533_read(cb->lm3533, reg, val);
+	ret = regmap_read(cb->lm3533->regmap, reg, val);
 	if (ret)
 		dev_err(cb->dev, "failed to get PWM mask\n");
 
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index babfd3ceec86..03cce6aeb014 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/backlight.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include <linux/mfd/lm3533.h>
@@ -45,7 +46,7 @@ static int lm3533_bl_update_status(struct backlight_device *bd)
 static int lm3533_bl_get_brightness(struct backlight_device *bd)
 {
 	struct lm3533_bl *bl = bl_get_data(bd);
-	u8 val;
+	u32 val;
 	int ret;
 
 	ret = lm3533_ctrlbank_get_brightness(&bl->cb, &val);
@@ -82,12 +83,12 @@ static ssize_t show_als_en(struct device *dev,
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
-	u8 val;
+	u32 val;
 	u8 mask;
 	bool enable;
 	int ret;
 
-	ret = lm3533_read(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF, &val);
+	ret = regmap_read(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
 	if (ret)
 		return ret;
 
@@ -104,7 +105,6 @@ static ssize_t store_als_en(struct device *dev,
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int enable;
-	u8 val;
 	u8 mask;
 	int ret;
 
@@ -113,13 +113,8 @@ static ssize_t store_als_en(struct device *dev,
 
 	mask = 1 << (2 * ctrlbank);
 
-	if (enable)
-		val = mask;
-	else
-		val = 0;
-
-	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF, val,
-									mask);
+	ret = regmap_assign_bits(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+				 mask, enable);
 	if (ret)
 		return ret;
 
@@ -130,12 +125,12 @@ static ssize_t show_linear(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	u8 val;
+	u32 val;
 	u8 mask;
 	int linear;
 	int ret;
 
-	ret = lm3533_read(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF, &val);
+	ret = regmap_read(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
 	if (ret)
 		return ret;
 
@@ -156,7 +151,6 @@ static ssize_t store_linear(struct device *dev,
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	unsigned long linear;
 	u8 mask;
-	u8 val;
 	int ret;
 
 	if (kstrtoul(buf, 0, &linear))
@@ -164,13 +158,8 @@ static ssize_t store_linear(struct device *dev,
 
 	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
 
-	if (linear)
-		val = mask;
-	else
-		val = 0;
-
-	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF, val,
-									mask);
+	ret = regmap_assign_bits(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+				 mask, linear);
 	if (ret)
 		return ret;
 
@@ -182,7 +171,7 @@ static ssize_t show_pwm(struct device *dev,
 					char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	u8 val;
+	u32 val;
 	int ret;
 
 	ret = lm3533_ctrlbank_get_pwm(&bl->cb, &val);
diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index 69059a7a2ce5..db0a5e5c9e39 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -86,14 +86,10 @@ extern int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
 extern int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
 
 extern int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u8 val);
-extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u8 *val);
+extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
 extern int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb,
 								u16 imax);
 extern int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u8 val);
-extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u8 *val);
-
-extern int lm3533_read(struct lm3533 *lm3533, u8 reg, u8 *val);
-extern int lm3533_write(struct lm3533 *lm3533, u8 reg, u8 val);
-extern int lm3533_update(struct lm3533 *lm3533, u8 reg, u8 val, u8 mask);
+extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
 
 #endif	/* __LINUX_MFD_LM3533_H */
-- 
2.53.0

