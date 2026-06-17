Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E733CFF5C
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683261; cv=none; b=iyPye/QTmePY04M6FfNrRIeavaeKFKcYD/szFOgHLuOzYjP89ZNHSmVBi40gdylIZcPmJr5kXsjugNQ7m51DWiFeQxIGpZ9AZrkBXSHanFgNhvcjA7K3FiU/3oieL1zXbKHSNih+aErIySYJV14v4vCzR5lt5I5wQ2LCVSJ1lqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683261; c=relaxed/simple;
	bh=EErEa+xTvRrMlTfCICTBeucwWtahnLN9Dg/ExT+D1y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITFJ73jSEP3xNuPVHr+ZrNatWI3JEkllqPBkSm7IQOWRzeZSvUfuiM/HeQg4vztyZ1dWQWunPb/GAhv1aLI6uIrokSTsnmC3RCEze0clFF+h5YQnpvvWdOY8ZhpuTDBRbTCU1bui4/6B99pQDm3q+r8aTks9/YtiWk/lNUguZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQK9yjFt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQK9yjFt"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so8859886a12.3
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 01:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683251; x=1782288051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zcYkBqsgtm7crDvyj+FVJGVI8rwwbt6ayEuo6Ql52s=;
        b=UQK9yjFt9W/l/gnodv7PROtIDTvHGJKgOXovy2Cy15yiDA6YO2lmeVtIL5lGz2h26j
         YkGPTwFA9NeYqU5TWWS/8iTmZ4WbCSWWTeEvYBAYRG2OPh7yuvtEJ7A7vLobt+LoDttI
         6MQbCmriupTGKgkRvOkvCz2DF0K/SKHRCmaL1WjkKUj1kklGXeS6SQUys5S0/ZUS0Nou
         kbFpIHQsdMiV6qfUitY9/cBvIVLVRKnNWLr6mCjYa4sTDcjT7f8Rk8G+zhb1P0YlqbSD
         peIct/+llBU1722YeW+RecV7siZ25vV0kaV3nRWXrg8NQGC7wom+cow1IYLOhAPNNQ9V
         frLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683251; x=1782288051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0zcYkBqsgtm7crDvyj+FVJGVI8rwwbt6ayEuo6Ql52s=;
        b=Tz9a+To2XPWRw2FqoD9RmScc64OUmSquR29R+9pt4f+6QCg4aAq7vQkEaCfjNx2J05
         oN0R1UzMsDEH2nXHlwmneHM0vy5bTzxP28JpiYgU8TNJbZCq4Vehu4vMeK2073V1jm5e
         myiXa/4m9qua1xrTAj8U0fQ5kyY9ZHHtj435rFCadUmWipnymd2YcDs8up1RvcQ7PsLw
         47EoA5gFjfWEUsXDxSClJ0IxlSBbwkktPCUdc/NmJr2wLjAXtoV3P2HCByFyEPCuyCfv
         +53mNj/hcW5P4GnmAMrMJSoOI1ZQW+OfcPEYpvAtxHurmV+N2NLRuLlShEXznHAMhXor
         VPSA==
X-Forwarded-Encrypted: i=1; AFNElJ9ou1G2NkLUmGcy3WFwDMYLZ6nKABV8lvM4qhvHoDHgiXbCgJNTU0MFyWkb3QZskry7oIyPsVstM7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqSyJQTAroYlaImE0oYHNajaFCqI+AOUvDS667cwwT1Bsy66Lz
	ey5s3baSLPFkLh//EJNV46J9aVLIxQhIY28L5S1bEgMltgEiTnZKuZrN
X-Gm-Gg: Acq92OGe+YP9DmdKMh59XGzBYTIChQCW1o1hXgSjXfNsP6nUqUbiuMKsMCcnqAni5S9
	BlE9DOLiqlyOl2QIN32q95UzUU35aVfwUGvrfjqgEOtvhEButh4ghGEa8a19PYQVkJZ0iF5p4by
	qHIzmW2BfN1iCFjnH72NvaGO2e86IRXLHPehlC0NtTHR0WLbxEIHweSo2M+kMpko6C7z58tzcYJ
	q820UrBvM0RnfRlS5dF29iEJ2LAPetfpX/PpoGIVZ4dMziGdq28dWFqGA96c35T9AZq1/3rlprn
	3J437nIX66yDH53cZBKOW92RBg9vuxVvuxvF8coWTtWIjtQwL3QFyqT8CR2kaAxyu7IxEGocxxK
	m+E20FhEYuDM1bUmWn9PQgkIXcHUkaZVFtPrxaoYiWttlnn97MqFiYM11dI7KynJAQUKLT1Qcwp
	6w9Q==
X-Received: by 2002:a17:906:9fca:b0:c03:b8c6:cc27 with SMTP id a640c23a62f3a-c05a6bded8bmr163827566b.24.1781683249238;
        Wed, 17 Jun 2026 01:00:49 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:00:48 -0700 (PDT)
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
Subject: [PATCH v5 05/14] iio: light: lm3533-als: Remove redundant pdata helpers
Date: Wed, 17 Jun 2026 11:00:22 +0300
Message-ID: <20260617080031.99156-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617080031.99156-1-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
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
---
 drivers/iio/light/lm3533-als.c | 56 ++++++++++------------------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index a9af8e2b965f..69bac1b202f1 100644
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
+	/* Bail out when in PWM-mode */
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

