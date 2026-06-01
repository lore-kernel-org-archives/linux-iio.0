Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543AE3DCD8C
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327151; cv=none; b=THVjtBrCeX/tbBp+5m1QCdIy6JU80G5PZufy8IWp5oj30pX1cUXP+vC2Vv3DMZ0P6gHABwtntaAN1DnTICnRmoolwyQiSaKUuHdvCZItJNE3LTiijulwnFU/huMYnbGzAUYRbPApb5lVokfiPVbnJhLTp4fqrF1iNE0uhiKsOag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327151; c=relaxed/simple;
	bh=UtPscoMn7/+u3hgCsxGsK5x29OOmOoQ7cGtI5AS2sAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QG/hFpgrqQouvI84oolRT8Zr4E+n2nk3TglXx5z9EDEnOGj+XmbwaIVI9diUC4CB34Si0H9aaZDGkiOuPow/tmC/d2evHmkkByu5MMIJM77kuUdWI3q7a+aPN/loQeIA4B+PvrS8WUCvXjonduSdxyA7r6XcOoaUeL+q6uI7Xis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiszMNeP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiszMNeP"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-460166910e6so340377f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 08:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327142; x=1780931942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y382WZZPSXgqkJt8F6mrSdOVSYmocK83eFeJ1TSWQE4=;
        b=XiszMNeP4wUTqUxFlUnFLah3PuhRurrdvgYAUaNSfjnBlvvHl4pqWSxVXYji1IkvFB
         d/yKXKPKYdhAClOQR2tK7rd6MK0PKTeG97Uq4lP711I9N9hCNI2BFP6N7qWzvyjHc9In
         al2CzUtKFUSIaZNGOZIpI8FLH0E4BJUb5YmBDgLKILvJBa+bbu4E4IvcnkuvDSFQnaHg
         nYFpMdRKzuUytJchtXBfPXAil8EeAdG9FtyAHUiXh6o0PV5OWMnFdXvXhATbuPKKfPtG
         Z1EuUnHfzPSCc6uQzKa9H7DvHB5/7IdKsHlpFTWKT1lXdCDdKXCd043ftoa/GPZL4lGk
         G50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327142; x=1780931942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y382WZZPSXgqkJt8F6mrSdOVSYmocK83eFeJ1TSWQE4=;
        b=QsMNogf+SjsemBCFzOV20u+/9HNDqHFimzJs91/iCmXNNKb5ZmzDUbRf4kVg+953pT
         gFYirg1yiyZ5VPoF/CotSX6u0QcTojTdQxWKfKlg3t8iJaYVByYBHQJsFd70qLMBPXdl
         AXxzzGE+dCx3ldT5w/bclUkR7gMt9lsseGubNQc+nojBGtSOQzFfPIubzsUxYMoGdOZV
         vDBjx8v4gX3eJP2ZV1sD/O8hgHAr1axPA5uHggLdf8Du9iC96rEwuyu742TKSjdrnGYy
         MrnLivLqrhdhHHuwBCscmFwlkJeJtb0973KyS2AjHRLRPxf8HIZlltCrCJqlpqaj/dOL
         FirQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wFDJFtTaVSxlYqa/U8JZuTYqBO7776Huw745KQzpn0Pw8WAVmzMDMkeVkqhK2aRQ22LE+CgAtEV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG64qbfDCu5NZLQ/zsHUAzz66TqD2RhKEvbH3A78dMjZGDX1V6
	GQNfjqyJNKuWaV33yHPr2p19W6btcjJdGIRAyrRMw5eZsDNL5FvcfHj2
X-Gm-Gg: Acq92OF418jt3JIyY3PEU1Kle+6OK4Nls7r0igVm57kSbIlm9l8FXZlij+GtokEsFbb
	uVc8Tw6Qmu5BT6t4h1HcaFeGr8sxMXc3BgC1A98BdXZNk2zqXEJd4l7ShzDvtjazNs7eyV411vT
	5BF5drP3RPqsAtQN5+lWJ/BqrjmhYlTvz44JXRtpZ6b3OTOh7JDwre3O3hGvaDSxMZwjWF4Gb1t
	sDuPUM7J/bEkkNTAM8d7J/teFhHPBqu+SCAJNQu3AF5NJmVduz5XwC05yR9Pgj5c/0QTgyL/g5W
	AveXHLujlxO0XKd88OWQDMmCOxtGWbgWdXtA9LMk5pNjtVGM+ZoUw/KwtjbEgRVnEbq7VvdlsLC
	BB8lre2cOInmgYGULfkcm0wYFznFtLRw3giKpRDWqaDhrUSn5SPR5NKoTIVII8gqbRVaTwNSfr6
	vB3DiWi75HnpgQ4+eLMZFA714=
X-Received: by 2002:a05:6000:4c8:b0:45e:ea3a:47d6 with SMTP id ffacd0b85a97d-45ef6b93b94mr15555475f8f.32.1780327142357;
        Mon, 01 Jun 2026 08:19:02 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:19:01 -0700 (PDT)
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
Subject: [PATCH v3 03/11] iio: light: lm3533-als: Remove redundant pdata helpers
Date: Mon,  1 Jun 2026 18:18:23 +0300
Message-ID: <20260601151831.76350-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601151831.76350-1-clamor95@gmail.com>
References: <20260601151831.76350-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lm3533_als_set_input_mode and lm3533_als_set_resistor functions are
used only in lm3533_als_setup. Incorporate their code into
lm3533_als_setup directly to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/lm3533-als.c | 61 +++++++++-------------------------
 1 file changed, 16 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index fb61904f110f..52136ca1abc9 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -716,61 +716,32 @@ static const struct attribute_group lm3533_als_attribute_group = {
 	.attrs = lm3533_als_attributes
 };
 
-static int lm3533_als_set_input_mode(struct lm3533_als *als, bool pwm_mode)
-{
-	u8 mask = LM3533_ALS_INPUT_MODE_MASK;
-	u8 val;
-	int ret;
-
-	if (pwm_mode)
-		val = mask;	/* pwm input */
-	else
-		val = 0;	/* analog input */
-
-	ret = regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
-				 mask, val);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to set input mode %d\n",
-								pwm_mode);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
-{
-	int ret;
-
-	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX) {
-		dev_err(&als->pdev->dev, "invalid resistor value\n");
-		return -EINVAL;
-	}
-
-	ret = regmap_write(als->lm3533->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
-			   val);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to set resistor\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static int lm3533_als_setup(struct lm3533_als *als,
 			    const struct lm3533_als_platform_data *pdata)
 {
+	struct device *dev = &als->pdev->dev;
 	int ret;
 
-	ret = lm3533_als_set_input_mode(als, pdata->pwm_mode);
+	ret = regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
+				 LM3533_ALS_INPUT_MODE_MASK,
+				 pdata->pwm_mode ? LM3533_ALS_INPUT_MODE_MASK : 0);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to set input mode %d\n",
+				     pdata->pwm_mode);
+
 
 	/* ALS input is always high impedance in PWM-mode. */
 	if (!pdata->pwm_mode) {
-		ret = lm3533_als_set_resistor(als, pdata->r_select);
+		if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
+		    pdata->r_select > LM3533_ALS_RESISTOR_MAX) {
+			dev_err(&als->pdev->dev, "invalid resistor value\n");
+			return -EINVAL;
+		}
+
+		ret = regmap_write(als->lm3533->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
+				   pdata->r_select);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret, "failed to set resistor\n");
 	}
 
 	return 0;
-- 
2.51.0

