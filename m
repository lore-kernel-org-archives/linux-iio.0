Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAF81C6FF5
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787209998; cv=none; b=eMt61uFb6qMRVIh25aNSgmJmzbH9oV/D9rRtLwJOElWLmjNmvE5qHIsS93f6mJGWE4jo+VoeHNZADwQja9SBFbIAq7Z5xqk9WcZR+gYGuOlofGnG1mZIc86K59iCR0pavouNshO197QclbP7aIdC3H922S7cBEvVJYauq9AtjC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787209998; c=relaxed/simple;
	bh=r4qlQ8BhGFT/tD2kQwy2cYNpAnMxt7qvdY2YRg/5ALo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KdOqKTTGBXOn55qsJCLtVu+ZXCtX2CvjEmR/juqdyURMSXdlTEvQqv6A6nevX/T4W/rG0+/0JtZ6zdhQvU6UiuGvPNelggQp3vSsJM9DVZOGtHVZz1yBjM79P87KSpMuQ8F68mLOmSCuGIq4hysRYeS7m+pYoxchIhjmTMDS5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYDumqhG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYDumqhG"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d5655cc850so22235965ad.3
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 00:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787209997; x=1787814797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5pJ0L04+0LvJLaoDNBbLvvB34SBygdnNvNCFLvcb6N4=;
        b=TYDumqhGoTs+oeMKQBRxrTjh2q6My5GuEbZ27HZJocTZ2DeS/8fzmWcpwqWE3SO50d
         CDTAKrDfAcCCSmUw1zP5MXqy3Ef5LT89uyRzFKbjSHhl06mR61QjDUYpCqbJd9d5QgcM
         ygTtBMpI7BPHAXKkeLkjH8ilpvEiaxu2RUwfUeS+efwmP4JF6T6YaTDAb8iBrH8PoXuR
         zoq1S2XofCR3NPkYoaPH+FmrOFohC+6oGHwdAK4YgKI20Z4nMIJQcEKGANTtRf6ikWHs
         416u93T0LporsdhJ1xHb5qDmp6/DG5APfO5HFf4LRrBEKY+x9ZyVEcyOSR8O6QR4Cmli
         C9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787209997; x=1787814797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5pJ0L04+0LvJLaoDNBbLvvB34SBygdnNvNCFLvcb6N4=;
        b=OgVuyz2aWaRVxM+8UcL1Hj6DC4McnaMGMzgj1OeSllBeqANBtRMyniaEhGXXyFOZui
         mjjffSZNIM4QlDtoc6NkON4ZVXCAkFwnTNGso4xVKEFYNDocWHXp8H3un5ccnmDyxl4a
         bEw638W0jp2KoZUWJZJL8roRAIYLZC5eH2QufucmJS2KXAV6HNf5K4NAP1/PRTZXMs5x
         i5oQXnWRWqQgOc/PULTiMQ20x6YH3Cb65UuJRWLTuF+/GZI9irzMr6pNuEPLdPe9Bxvt
         g3k4ULeksRvcl1/VDmfKiBq6PUPIjGdtS/RP+He3/fDViFrwt4xUWu4ZD3rGHrH3znmI
         IxvA==
X-Forwarded-Encrypted: i=1; AHgh+RqGPluPcIpzglKNLBgpA6wzIljgrMMvUeoKLTpud3w9WpL6IOmTAc6Yat0+5wSp6J5m2xwHQlPt1E4=@vger.kernel.org
X-Gm-Message-State: AFuF++kU2S7mc9MPz+p/ijCkTJU8on6Vd8K2LMBm+nvCblxJqyxlbX+Q
	BVIIh8JSXEUcC9KNU6nPJu0/JEW//1vdjiUwZsWijIAviV7PxFtq5bAVEE7YEVs=
X-Gm-Gg: AR+sD10mQ17a1StRM7p0m0gA63OgOQYgAg/6tEWg7dN+4QxFHiyPzQP3qIbboOp1TO0
	q0hUDSbZZd5hmLXL2Bazj7oJlwOjtGQTw7eVLgfa9KunmZyJd1EAkMduqeT4NQT/rmkjZuV6fYw
	92Fr9uvzn6aYYMe+wQcqKDsslpS6YEeUY8cT4T4/LVjwjWB+id1FhXA8kp0cJpNJQoKrf4eoIxi
	vG/Jd2HCBHgsc8ML+iIDjiyl3X6aQabhDJubMFNeZQWYizmYL2DYGxpRcW5YxwZEFxjJu/w1MgM
	ixJfvN+tUvCKU6W7tQJNEJDDjL4hEzmp13dQcI7zAd0kWA1d1d9SDcGb4I94ExZhoi/EmSn+Rja
	okl+aPhCcikSqwA24hlQ7g7mAi1BpRu0w71cn1CEY/2QrmTdk373GFdj9Odh3M8W99zgxbDBvI5
	dl8eHnaqOi7FNv7OmwKohLVBgf0BAFvSujTdGGMxju4c0oSrTi0UgOWeywKct+XlxyXC2EFeie4
	Q==
X-Received: by 2002:a17:903:b4e:b0:2c8:4c29:afeb with SMTP id d9443c01a7336-2d5fd674a51mr207729235ad.8.1787209996909;
        Thu, 20 Aug 2026 00:13:16 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d5b687bsm3207175ad.37.2026.08.20.00.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 00:13:16 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: fabrice.gasnier@foss.st.com
Cc: wbg@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] counter: stm32-timer-cnt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Thu, 20 Aug 2026 14:13:08 +0700
Message-ID: <20260820071308.2041128-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from its suspend and
resume callbacks, and reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/counter/stm32-timer-cnt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index a3d8f7a5874e..3024ec002cc6 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -794,7 +794,7 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __maybe_unused stm32_timer_cnt_suspend(struct device *dev)
+static int stm32_timer_cnt_suspend(struct device *dev)
 {
 	struct stm32_timer_cnt *priv = dev_get_drvdata(dev);
 
@@ -814,7 +814,7 @@ static int __maybe_unused stm32_timer_cnt_suspend(struct device *dev)
 	return pinctrl_pm_select_sleep_state(dev);
 }
 
-static int __maybe_unused stm32_timer_cnt_resume(struct device *dev)
+static int stm32_timer_cnt_resume(struct device *dev)
 {
 	struct stm32_timer_cnt *priv = dev_get_drvdata(dev);
 	int ret;
@@ -842,7 +842,7 @@ static int __maybe_unused stm32_timer_cnt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(stm32_timer_cnt_pm_ops, stm32_timer_cnt_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(stm32_timer_cnt_pm_ops, stm32_timer_cnt_suspend,
 			 stm32_timer_cnt_resume);
 
 static const struct of_device_id stm32_timer_cnt_of_match[] = {
@@ -857,7 +857,7 @@ static struct platform_driver stm32_timer_cnt_driver = {
 	.driver = {
 		.name = "stm32-timer-counter",
 		.of_match_table = stm32_timer_cnt_of_match,
-		.pm = &stm32_timer_cnt_pm_ops,
+		.pm = pm_sleep_ptr(&stm32_timer_cnt_pm_ops),
 	},
 };
 module_platform_driver(stm32_timer_cnt_driver);
-- 
2.53.0

