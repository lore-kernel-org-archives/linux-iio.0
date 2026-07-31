Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA83FADF6
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497828; cv=none; b=Bt5U2t/lQE4pfWuIkHfXUOpZ8VTq9DzQNLIeARrCFQ6aqWbPETFk13LWnKjhWMARwKom6EAvx/MTQz22wSpzVlbylyKI/OCzPWjlMjBkZAZcIimQ5jl2T+RbxDfoBJrLMeyOILPWDZVUJeRjDamDH5Bga/aq+JDF/Cdqi5dnUn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497828; c=relaxed/simple;
	bh=utgrkcrPEexnwKubYxzeT83rM8IkZKoDxi9jYmOHcaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIOZLYxatYC+KYvTPIrfs+pt6Y+bnPJr2gPjvq7bU3QhWzTyrrfHv387jx0oifzs5Ctbjym9RNcQbRMthavVbZIHVcV4tWYhPwwAPsTlXTPG38mVC5xWMY+ZTDlm8GtKNhts8jwc1vz7wNKlvJMjpaH4x9Zu4tNMZKqQJpd1Ho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVsyJL0i; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVsyJL0i"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so191043f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 04:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497822; x=1786102622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbqFKXAPXCgqFlzsfbnx5DNlo8ULOW4jbUhFKit/7gU=;
        b=bVsyJL0iA1ILDrQepRgEpqQNOPuwkNzhvXYcEx5ESXDi44zEYYSGlwME8ecqFNVOn+
         LMoHcPanl7RD/WZOh+zci0B7M+w7KuS4UDhiAj/Nx33nM9TWb6gizZneGDH1mWs6UL0g
         FGuy5AuoWbUdLAMpaITzdx/obza62VLz7reFi/BRy98xqZ558/n7c3euCCqjbhHlCV/3
         VBSf1lUJSXxP1aC9U8Nt//L2WPoBq1KaYlWzpTho8Mi9j8XT4GJ1c361IpzoCgSylCzi
         EcIwsi6JEKKW/MoJzc9V+isAXWy7meSh+qSCLfEHIXbP+eD1TFIfRPH2EzB8vA5b/4iu
         oFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497822; x=1786102622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NbqFKXAPXCgqFlzsfbnx5DNlo8ULOW4jbUhFKit/7gU=;
        b=F5zMOJk37mbUiOJ4ChGXfE9BW/lVtOTycSIzGafsjBCVl4XJ8TJcicc7o7egMuJscC
         iXQTANHBz78DQ5t3LeZL/ZdjHGJVkoAjsh7xC1TTcxljye6MaHr7qDW6g9iYm7cgEubV
         d9cAVpT5Cl8Pa6fFbCJfM7NNkhbxyeE46lDFb0yaVZtqlsRPLd5uomYOvtb1C6lDRaPD
         ckbcXtDcRTwestivjsO5t/5lpC2jAx6JLoxRFyL78vwSejSn4Gx44wu4AfOftkW7D9Ni
         E1Pgh3hCHKpYVf7fRp2hlOjnewlIyegn86owYsHbzFx8vV4EIrpj1Uem4Y/Ecexe/cOI
         dKJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2VN/aPQOF+4g7ScWponSTUkEOZrlkNlzcdoY3OY+dy0Y9iBkKm3xZKi3XBZfZ6dgeE5z0JtnMz9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zmbxl+uzB0l1UlM+a+HvdasKHXL0jOy60W+xcpj7svE8X2Um
	8oigFscYgwMK0uHYYp6gOxqiYVD0cfQMti2TJmflDFNcbclMoz0bXpW4
X-Gm-Gg: AR+sD13U2DTikMz+GJ0aowkguhY05Pf/vxvebtjBK4gMNh3p+PA9teX7vpdlbtejK/2
	qu1sBNeaDx5lRaWce0WT70zK6mwmlkgxoK/qphJoTK24hEQK65TkaYDhES3Li8jlnXNr8x6MfIn
	BROce/YbLBOJySMMaaUzJ2udxWqLzzuh2aTg0K8eG7TkMoQMCmdm8lpMIEQ/pTgZM3z06mpdrGn
	e1GsV8MFKho+jDxw2lo66Y5EPLr/OEwsgNZH943aCpQOzNexc0WTNwvE70sCBJGnh7ubYuIFktD
	9xwDzLwu9gKzx/rINTmDP3o+V34yQ/jfMI/1tFVNWLX6b9ocllpobZsGLVVIE9vNCcvqk/FmWPs
	GqOTFwNhvN2AJNRu/UFUlzVKoYzieJ8zrfnJw4abxtewaqouGfuYv2lSQuea4PkFuyio1F6qfxn
	9zhyuMigad6XMxCoyzz4P2NzGqp11Y9Z+E+jm+ezDZZJi12G2svGACla75Z3usmDfAnmFkEiZ3y
	JVuuKYJIQ==
X-Received: by 2002:a05:6000:2997:20b0:47f:9661:6766 with SMTP id ffacd0b85a97d-47fd2b9824emr2824366f8f.61.1785497822299;
        Fri, 31 Jul 2026 04:37:02 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:37:01 -0700 (PDT)
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
Subject: [PATCH v6 06/14] mfd: lm3533-core: Remove redundant pdata helpers
Date: Fri, 31 Jul 2026 14:36:24 +0300
Message-ID: <20260731113632.158440-7-clamor95@gmail.com>
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

The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are used
only in lm3533_device_setup(), which in turn is only called by
lm3533_device_init(). Incorporate their code directly into
lm3533_device_init() to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 61 ++++++++++-----------------------------
 1 file changed, 15 insertions(+), 46 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index f9bdc0a1d9bec..5baf934fac825 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -7,6 +7,7 @@
  * Author: Johan Hovold <jhovold@gmail.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -23,10 +24,7 @@
 
 
 #define LM3533_BOOST_OVP_MASK		0x06
-#define LM3533_BOOST_OVP_SHIFT		1
-
 #define LM3533_BOOST_FREQ_MASK		0x01
-#define LM3533_BOOST_FREQ_SHIFT		0
 
 #define LM3533_BL_ID_MASK		1
 #define LM3533_LED_ID_MASK		3
@@ -80,35 +78,6 @@ static struct mfd_cell lm3533_led_devs[] = {
 	},
 };
 
-static int lm3533_set_boost_freq(struct lm3533 *lm3533,
-						enum lm3533_boost_freq freq)
-{
-	int ret;
-
-	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
-				 LM3533_BOOST_FREQ_MASK,
-				 freq << LM3533_BOOST_FREQ_SHIFT);
-	if (ret)
-		dev_err(lm3533->dev, "failed to set boost frequency\n");
-
-	return ret;
-}
-
-
-static int lm3533_set_boost_ovp(struct lm3533 *lm3533,
-						enum lm3533_boost_ovp ovp)
-{
-	int ret;
-
-	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
-				 LM3533_BOOST_OVP_MASK,
-				 ovp << LM3533_BOOST_OVP_SHIFT);
-	if (ret)
-		dev_err(lm3533->dev, "failed to set boost ovp\n");
-
-	return ret;
-}
-
 /*
  * HVLED output config -- output hvled controlled by backlight bl
  */
@@ -406,18 +375,6 @@ static int lm3533_device_led_init(struct lm3533 *lm3533)
 	return 0;
 }
 
-static int lm3533_device_setup(struct lm3533 *lm3533,
-					struct lm3533_platform_data *pdata)
-{
-	int ret;
-
-	ret = lm3533_set_boost_freq(lm3533, pdata->boost_freq);
-	if (ret)
-		return ret;
-
-	return lm3533_set_boost_ovp(lm3533, pdata->boost_ovp);
-}
-
 static int lm3533_device_init(struct lm3533 *lm3533)
 {
 	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
@@ -437,9 +394,21 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 
 	lm3533_enable(lm3533);
 
-	ret = lm3533_device_setup(lm3533, pdata);
-	if (ret)
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
+				 LM3533_BOOST_FREQ_MASK,
+				 FIELD_PREP(LM3533_BOOST_FREQ_MASK, pdata->boost_freq));
+	if (ret) {
+		dev_err(lm3533->dev, "failed to set boost frequency\n");
 		goto err_disable;
+	}
+
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
+				 LM3533_BOOST_OVP_MASK,
+				 FIELD_PREP(LM3533_BOOST_OVP_MASK, pdata->boost_ovp));
+	if (ret) {
+		dev_err(lm3533->dev, "failed to set boost ovp\n");
+		goto err_disable;
+	}
 
 	lm3533_device_als_init(lm3533);
 	lm3533_device_bl_init(lm3533);
-- 
2.53.0

