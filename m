Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1033A9DD
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304179; cv=none; b=j7RgpttZhrsBKciJHAYc7loNLK0GMA6Qj1r/SBOHJaS1D18sNTi35/d4THbqeaP+09u+reyX58SXKwHbw2/YvaDkqITDgzhMKUEpzVTMLv7QIURHfxF26MHGbYaTREGhV5lFwkCYHmRoa1FbaUmm8i4VeVpJdYxBM2knHRcgypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304179; c=relaxed/simple;
	bh=WI5d2sIhzon5iSv9LESgJJisHe0kjNQeDryiAHg2gpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nc4F3U88OY5mxT/d9de0KN0XvxgRaqN95SLSnP16ez7zSRkNu1V8kycbnQuXLvzYz5cLEmT6peLxdRV/mVk3KM/uxqAg3MZVrI9xrRXPVsWIMkxF4uOiNj0eFKgK1VrK/shY0T6hvwTgGv8vp5DY1gsEcwoeRFmfla16G0OG8vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzL08Eln; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzL08Eln"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48d10c981e4so6853535e9.0
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 12:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779304176; x=1779908976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FttOyObDZY6c8IeXvp79f4b56sRCEoRuLMX9sSkdMYA=;
        b=mzL08ElnMuBgBBS57pyjj//LiUbQ7I8dnYeZN12AmEajVPVMNkw/n4RALMRjwIY16P
         PFqeWMVgpK8jptbSIdiZbixFG9C5KeBHfWtiocx5fSXQ1mMSTz2kacWvQj76dldfZ/xL
         PhkgOqwXVbTtA5x2pJXV2jkm2L/FzTgJvN2VPxjoadRmMNjGe8AorO0J3tGAwrsNk1CG
         DZj0JI9cBQXj7APFRLkZRVvNRZFft9n9JC4UBKJUgWUUUJSvQmEW05H8orIF8Ui/oDMu
         Q5zOPcaAty+fCiQJ92scviYEdi4Sqw/tgMMsACzD02X9KvsjDFukNzQQpyA6J+ujCSot
         FfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779304176; x=1779908976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FttOyObDZY6c8IeXvp79f4b56sRCEoRuLMX9sSkdMYA=;
        b=C9CpsWXx1csG1+TzxygJlmh6maUhiOewfjPbA+s5DUmiu/Je4gnTONbjuUWqu8lmSu
         9sHATw1P/nnslN29uv45IDextHss637nTFVgAI0f4nIZ8W+dYVqzzsOYsrW6PGDBPTMZ
         CG34h8eaO1Sm4D2wavhP4Sl4JGdSdvaofAXCIdMOhK45rmdKtLsw3CEwhNQ5J+AiFhbS
         J3Qs3w4VzdLFZUbsjfJnZWn+oqziObl2GtNI/yEDxY43eBX23MUuY+Eq82OVUCFb+gfz
         VEucpO+YHeWq14cupDOKYGYjuq7veqOoBm90lHMOme77f0mYAiIDVR4i4nmB0Dma5yW8
         z3dQ==
X-Forwarded-Encrypted: i=1; AFNElJ8HtyNH912c22BvO7LcGPhaEuTzxTQHDMKRFEZXTQHLZNDZKuCBgwQAZGahx79PIlwB088HYyHKAW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFnWua6tKTz5NsRtsR+cZRKe/b4YjhnZIuEElMsnqJFEFgsC80
	S4bGh4yViHp9Z6+wXcZg7+zgc4qfmgiGAnZyY/qZTdqnF+6ndh0Nu3lq
X-Gm-Gg: Acq92OGdVqvElewfCj03dBKWkbphqvBt6IOvZbNspNhZiuGtnkVzIGyqIEWQ+QJ1ymI
	1WD1ESQYe4bkHZK6jIxcRUO6kW7/Ik8JU5y0lc5d3ejPzz14P1hLAa+rVGbMDTXxwRLqf492mDo
	3kGgwr/RkVKcvBVfdbZY+fIqiUsz27Hy2j90dsKgwjUC2reJt6rl7QXN/qLl4NuGax8fxk2CzFL
	YlSG9CeAfxrBAQUacWQ5Pdl4LoxGMHYufE2g21ev/ddrm98Jqr+nKeZYJSEj9DzIDeqy7gndfWI
	41u2L9FAHELv3v5Mcb1ElsEi+X8Rl5i2gUu0YwGxn1GnpFipOda62A1YfxeYqPzgwXpIlKl5+sI
	H9I0ASUxBixYB5fmHhWU3Cr4cDotK0buPvsKeioRJ9xH66T1iuvscqiKvGmVsOP4O8l5EpI52jn
	Ydu1wNTR5U2CUfGYm0mpvgm9+b3E4XHqDo8MmqV8myzEpt
X-Received: by 2002:a05:600c:c177:b0:48a:56d4:7274 with SMTP id 5b1f17b1804b1-48fe66423ecmr187206125e9.3.1779304176451;
        Wed, 20 May 2026 12:09:36 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d8e25bsm11344115e9.11.2026.05.20.12.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:09:36 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: adc: qcom-spmi-iadc: balance enable_irq_wake() on driver unbind
Date: Thu, 21 May 2026 00:09:24 +0500
Message-Id: <20260520190924.12774-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iadc_probe() calls enable_irq_wake() after a successful
devm_request_irq(), but the driver has no remove callback or
matching disable_irq_wake(), so the wake reference count on the
IRQ is leaked on module unload or driver unbind.

Check the IRQ request error first, then register a devm action
that calls disable_irq_wake() so the wake reference is released
in the same scope as the enable. While here, drop the inverted
"if (!ret) ... else return ret" in favour of the standard
"if (ret) return ret;" pattern.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/adc/qcom-spmi-iadc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
index b64a8a407..0ec3a0c4b 100644
--- a/drivers/iio/adc/qcom-spmi-iadc.c
+++ b/drivers/iio/adc/qcom-spmi-iadc.c
@@ -481,6 +481,11 @@ static const struct iio_chan_spec iadc_channels[] = {
 	},
 };
 
+static void iadc_disable_irq_wake(void *data)
+{
+	disable_irq_wake((unsigned long)data);
+}
+
 static int iadc_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -538,9 +543,16 @@ static int iadc_probe(struct platform_device *pdev)
 	if (!iadc->poll_eoc) {
 		ret = devm_request_irq(dev, irq_eoc, iadc_isr, 0,
 					"spmi-iadc", iadc);
-		if (!ret)
-			enable_irq_wake(irq_eoc);
-		else
+		if (ret)
+			return ret;
+
+		ret = enable_irq_wake(irq_eoc);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, iadc_disable_irq_wake,
+					       (void *)(unsigned long)irq_eoc);
+		if (ret)
 			return ret;
 	} else {
 		ret = devm_device_init_wakeup(iadc->dev);
-- 
2.43.0

