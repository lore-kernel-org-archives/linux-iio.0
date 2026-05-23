Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA5B324B22
	for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779561877; cv=none; b=EzgSNHAsXFhPfti2HdjnlaDQc0DEKJKdxFldBB6rQodtYiBs9mW+OR3tdoThPIJee6cpO0lYGn1j5vqm7QJoR13vn1vaSw+5BlI+JZs0Uz5P13c0yxYFYmNiNpjS2EmOVKaVAyhCxJDI2dDaPEvucH6qzlP7JMXv8L3N53WfEH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779561877; c=relaxed/simple;
	bh=2yTx6C0f/mTYMA5A8f+aRJ7WSq3MtvQikrfp6DLbPzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yqd91MfMjSDX9qciyc0DJQTV1HoimSjWEW9rBo/649XsEMov3KFUCNiLv4abIUmdszL74Id0zjbbwImLeMJWFSJmeHPFT+GW2AADw2VsKjqD1wqfN4oey4RZkDyKNSKKinEI3RpZ9yBFywHSl6dODx9T8VtX9t+ciCC8Aeyd9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H23qASHw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H23qASHw"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4903ff574c5so1027585e9.2
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 11:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779561875; x=1780166675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HxOghcmNcfA/iUZNdF8b+429qOk9rwvNrnW9Yx5aklU=;
        b=H23qASHwVSNGa14L8aHAQf71e4KrIxSZZ3M/OBBPINdmnSvB+sQRM8VUVgPrc2MCQ1
         ho4di2lG+p+Pnn+vls5mrFUHEh66zc5nOyPJFGvI42A4ZMYKSwjMxIC5cauKOdP5gKG7
         GNb4qnF6VkS+TBaaYSt0sqdQND4GLRLd0col93IZ7iHFn5izBthTkunPJR9PxauCSSUk
         F5fYhVuWILVg9355KPHTQ/XWLpS6ldkZOx2FyHJ/YSlL9UatOonXKQN2bwON6LVNjhB2
         vBxpb1ZqFjzugbcRZKXGgn3z7dp8uvRMdL1q+zZIQ4//DTH6JWar6zU+LEcPJKfIsswS
         1AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779561875; x=1780166675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxOghcmNcfA/iUZNdF8b+429qOk9rwvNrnW9Yx5aklU=;
        b=onjoajHafjwHi4ObgjWKSNkCBgp4k4jA1t8NNEZLgN26CipUMhA9ghFvQorSmQOuhD
         7Dz/HH/XHZgmuajwyVG9JAYELLAWqoMWfqAKmiu88F20V/vyK0If7ZcgIsEhgZe6IGYN
         nRBZFw+z1VSWECt6hKNievSdZxhag+tyPCSJUF96CB/z05HFgKXThXT1q9MRN4g8rzot
         Bf2tjnheh5W4+FDsnj7eX9BqDzOyUs73lzru5GxPTc8qqB1T+PNgRI5COmOXt8AY9lYB
         FdAjrKYwp5GDiG1e5Y89V+KBmSgjjTiWM1erPyv2/Q0jShsUmF1/+5XVyqRAHPseeS72
         V0hg==
X-Forwarded-Encrypted: i=1; AFNElJ/r5OnYLDYynSf3VrgNVXB0aENQUFcmpCN9dGBvlTAS6xdSzj6GNi/+6Vo9vTIMwW+dfqHcYoDEZvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7XxR0NeYtc6ynd9k/YLOSsJTxl7YJDUWHLGygxUz1cmiMp2Y1
	9IK/pTDhOCaRa+faT4S4zTz4cbKlxO0fLnK9JHZPzF/V40BDf31aIN7G
X-Gm-Gg: Acq92OFGWuhsyRyjOX7SS2ovcQCmyuGUKwEHg1tNDf4m2FgjZKhDHYF5oDSANtHSiAb
	rICgfYcx2sfhqoEv/6gjmEX8L9rDcxxkBH7aAAXvZUOADgzGSX1/r4Hzf8B8HZHuoaYKy+BZEF/
	5E/TwDZ/syoT7UXhWUbQhgEGw3Z5rMviMpXtMbYsbPTmArdBfUPxtma+VkmkVA/As2SxAowzFfP
	QPOX4rcvr2GLThPQa8KAjCkioYpX8nzTbG05mKV6biw85BlVVvY3ILNYT4BjHoQjhrhgsuQ6K3w
	6+nClEi57hxy7Tp1t3vcgThQGKF2A3hMnooK5G+5mmEQMxRN0gPVxsQfv6SMQiCy5J6yRKLXs30
	pgJIqKOKwkodAI0GxIEkv1fHG1UZ00uLYd7+GiOj90Gs09becsO3eIbmnLqNc2Gx9GUGXCLgSJr
	dvK9p8DlTVFbppqdN9KpWoi2vth8jv0nKsRsljUazLrlAZ
X-Received: by 2002:a05:600c:444b:b0:489:1fa8:b895 with SMTP id 5b1f17b1804b1-49042486a39mr56029925e9.2.1779561874651;
        Sat, 23 May 2026 11:44:34 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454ea134sm148505855e9.8.2026.05.23.11.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 11:44:34 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: wbg@kernel.org
Cc: o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] counter: interrupt-cnt: use devm_mutex_init()
Date: Sat, 23 May 2026 23:44:18 +0500
Message-Id: <20260523184418.7586-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

interrupt_cnt_probe() calls mutex_init() but neither this driver
nor the counter core issues a matching mutex_destroy() on unbind,
so the lock debug state is leaked.

Switch to devm_mutex_init() so the mutex is torn down in the same
devm scope it was set up in.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/counter/interrupt-cnt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index e6100b5fb..cd475382a 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -233,7 +233,9 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	mutex_init(&priv->lock);
+	ret = devm_mutex_init(dev, &priv->lock);
+	if (ret)
+		return ret;
 
 	ret = devm_counter_add(dev, counter);
 	if (ret < 0)
-- 
2.43.0

