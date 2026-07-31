Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216FE3F4DFC
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497825; cv=none; b=Ff0AC53lUTuGbyy33LcqLGe3m8zFqDcfpAbzrZY6CBncRllC2hVi8jm6q/+yWXT0lJsJnjF4zDRZTExgR61Y1EtdXmk+h4qfaMLIH/IrF6dqkK8XARDJAmVEZA7eF4KORa02DFLxk09dVCPVq9Tv9M73LjcyoqSsye9BfAluhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497825; c=relaxed/simple;
	bh=YR6/oGVbHnlemUZ2JFQ25LTccScQ1moNvQCqFBjDqAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egRzZTPrM0Tyed/ehUg+Ov0Hl9hS382ECgCiSLk5lzaYX9E+8NH9RW6R0wksOSeESTxMY5UZAxkJQ9sYhqRtFyFD2Z/wOVaWsExR2kupA53wB3rq97qPXT+9IQjQHVMd84X07vX2dpP7OSMbS1Idia5r+107jgC4ZjGXG8HlueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IteGXC1X; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IteGXC1X"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47df43bfb07so340471f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497820; x=1786102620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88fGtlotIiUSgMJVrGrIa8cGFo+gZlVN06W7NwNhiU4=;
        b=IteGXC1XwQXgaXvH8ygrFkBREy62eoKbFBOpoelBzO3lRLtBmbcmm9EGK7nGQhLNkK
         Xfm2bjceyZ6ZCeXib9DCBZv+eo7a18kYhD7MHUd4LISjfmrdx1EiQsBRsNVXIbPCjyYh
         X3C765O5qLdu0mSyUgHBjM2xuNuMiPieCLIRpHEO05e5r7KGoOOCsYhnxwXKa0lOwGx7
         UALEo0YRZGe9RGrhGDxmld/ckX9cZNgxoC6NIG1eWtD1TE7VyOKfnz0rgkTZZkAKem3Z
         GB9iiGFC5c6rtrSKMmBQ0w3w+23fL4AjCpl8aN44s/318q/HeTygOMap2CjxeMQj1/rn
         AJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497820; x=1786102620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=88fGtlotIiUSgMJVrGrIa8cGFo+gZlVN06W7NwNhiU4=;
        b=fUNdDM+Kf4za1UujmfCscVb2OgwYMdQuhZ497ymm7QRVPQLO878IS85GZP2+pUmmzu
         BlG9yZgpEGG55atIhcg+HjWo6Q3YwaGA7r5Oxv9vs08oy/dDlfZWnHBsfclHBjM+R3cD
         1VHzSmnhQkcXN9SWuTncy2uOCJRIjjEG7ZC3U+XscH4+h3xJze3Jgx0N4pW/MW0nIr6I
         UJ5IoJvbIZu4pYJZa56nPtp/aJ/ZvwUC7Uy/kSM8wiNOz3IFwq24de19MgmG1iIXYU1x
         0iTn2d8uMumBWAIF9+S81qwA6g0ARgizqH0su3TVSDK9own4bP3Jrk1xzFsoqFASeNEk
         WL/A==
X-Forwarded-Encrypted: i=1; AHgh+Rqj8v6KFYGhLmvVtOhMIigF+qt3/QTBgak7oRFFrMtAZ4b8jG7HhsmQHy+xUb7xjd/3oczzyQqH1c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXtP2uUC6XDF0rEcdvHbhQUB7lq4lXidDQ0BkPtKFaFQCeWUaE
	SpUh/N25UrGX+dcBUk1mSqpahjjdWbDvRkJ3BpqZOPxx0jaem9TxDxZa
X-Gm-Gg: AR+sD13vp5bPDwdcaZpGEk7ikQq2q7AotxZM15tQfAhDyJL6SlayXXLJSQBVrMti7Z9
	5LV/ECasQqufT7EqKbFFSL6QtqYmbXoUk9ohvJb16GOjjFCCBFMOte0/4Kz/DOhf6mqz8zv3W73
	Ov7paa5l3xjtvQUEGkaxxkE1xJTDZOGR++PXppj1V70vcImXGA/ElmHsCnB1cH4hi28wmwvAiOa
	X17AQ3Xxb2+096lbN0rhAcoYtdkzHWhJY/dbU8ATJHNMktX08vLmBvEHqtGRbKLj5ciVfrpkDgS
	YV8cV9FOCl92Anr3nIlbL4rCYGRu/4cDEtdsBkFMHY7HhdEXy0Y9NfyV19FJK8OwRLoiU7+UAZQ
	I8Qc7RnhZEhYklL3NgiaDPJdzvLohzcaMhCh+0SPlW+4YuqKjImIklUUruLoLsaBDcxuwJ6KIdU
	tzTE7tv7UkrJ8rUNSvhWS8isDl6dENy7um2nsVJW3kFuMpGWbAIIRQsbefaLkPMh8G44blBwBBL
	Nwi2crO6g==
X-Received: by 2002:a05:6000:41e6:b0:47f:9171:c59d with SMTP id ffacd0b85a97d-47fd2b30babmr3903817f8f.32.1785497820326;
        Fri, 31 Jul 2026 04:37:00 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:36:59 -0700 (PDT)
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
	mfd@lists.linux.dev,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v6 05/14] iio: light: lm3533-als: Remove redundant pdata helpers
Date: Fri, 31 Jul 2026 14:36:23 +0300
Message-ID: <20260731113632.158440-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lm3533_als_set_input_mode() and lm3533_als_set_resistor() functions
are used only in lm3533_als_setup(). Incorporate their code into
lm3533_als_setup() directly to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/light/lm3533-als.c | 56 ++++++++++------------------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index a9af8e2b965f8..55c35018704c8 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -708,55 +708,31 @@ static const struct attribute_group lm3533_als_attribute_group = {
 	.attrs = lm3533_als_attributes
 };
 
-static int lm3533_als_set_input_mode(struct lm3533_als *als, bool pwm_mode)
+static int lm3533_als_setup(struct lm3533_als *als,
+			    const struct lm3533_als_platform_data *pdata)
 {
+	struct device *dev = &als->pdev->dev;
 	int ret;
 
 	ret = regmap_assign_bits(als->regmap, LM3533_REG_ALS_CONF,
-				 LM3533_ALS_INPUT_MODE_MASK, pwm_mode);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to set input mode %d\n",
-								pwm_mode);
-		return ret;
-	}
-
-	return 0;
-}
+				 LM3533_ALS_INPUT_MODE_MASK, pdata->pwm_mode);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set input mode %d\n",
+				     pdata->pwm_mode);
 
-static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
-{
-	int ret;
+	/* ALS input is always high impedance in PWM-mode. */
+	if (pdata->pwm_mode)
+		return 0;
 
-	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX) {
-		dev_err(&als->pdev->dev, "invalid resistor value\n");
-		return -EINVAL;
-	}
+	if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
+	    pdata->r_select > LM3533_ALS_RESISTOR_MAX)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid resistor value\n");
 
 	ret = regmap_write(als->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
-			   val);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to set resistor\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int lm3533_als_setup(struct lm3533_als *als,
-			    const struct lm3533_als_platform_data *pdata)
-{
-	int ret;
-
-	ret = lm3533_als_set_input_mode(als, pdata->pwm_mode);
+			   pdata->r_select);
 	if (ret)
-		return ret;
-
-	/* ALS input is always high impedance in PWM-mode. */
-	if (!pdata->pwm_mode) {
-		ret = lm3533_als_set_resistor(als, pdata->r_select);
-		if (ret)
-			return ret;
-	}
+		return dev_err_probe(dev, ret, "failed to set resistor\n");
 
 	return 0;
 }
-- 
2.53.0

