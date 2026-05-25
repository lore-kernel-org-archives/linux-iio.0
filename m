Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B8388382
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722511; cv=none; b=T8bFuuQ7nx2BNmC1G5K70twoYpJMgs5DoR8sHVJlVOgpvolHlIGRLpgwIazHjKAVfVb+5MoOiSttJukeyFQK4btMk1bv6837kh3KSQc+IlcHTWPtbtTtw9t89nq8AMcycQozy2XdOm/FXS1XayNXHhnsroEEqdEqKhjc5u0pUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722511; c=relaxed/simple;
	bh=Zih5qrvP0uYey2pj2Tiz2fmyOiEkYiF9CfhRE3bbwSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=arcCliOMjDWV6FZl2qn0paTods5t1UTE/N5fZPcSLoLk5Av1gIFnfAXDedpf/g9DsGLn4qy1M6hH4UDk87k9aNC+1BrTd+6P2OEKvC8KuS369EGSsRMJTfnhV3CpYSBD5S3fr7RRf8+bdR5s6sokkXFrLYcVWRN/FiFvef3GM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vb9HAldB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vb9HAldB"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a8772a67bcso867333e87.3
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779722509; x=1780327309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3szcHfwW0La5jre2jpVClNipxO4MhebWvrDcZivRLXc=;
        b=Vb9HAldBdUHOrsnK3tFAA4aCucxtQgTMfbrVxca6+RFmUtbeYLZMsXQP+PoaMbUmH1
         40TvF0NUYzrOJOrLmvZWBP31s3ZmgVJ6ppKOtm2nqNDWzY8qlN0z9w+jGCn/0mjJOG6d
         IfODqa8slqcOBZbt8pdMW7O5Oouf14HaFkfQe9QYyIi/x46zpBWbbHdCc60Pdq/1logv
         2XFNetqoxAIrKP+b3zEqH+kjNmZ+nm+VqfsWeAf1oVClbDuBUCmhhHz0rKbZpBHasqof
         De4lL5OJwwoRY6q98aU94I0i/d/V5tcrhmDajiJrvDehwRYEqSHIrSZkIJORoDujTDbZ
         Ft7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779722509; x=1780327309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3szcHfwW0La5jre2jpVClNipxO4MhebWvrDcZivRLXc=;
        b=NEMzqINlOS/IHHep0AXAUbAshDEQtFOVav2sReQM2RX/O48klrYtH3tanVvrXZxTl7
         yZGSmkgRmr+wKG9Fx6PfDGLV8rG4sVQ6HwsdHP5HlVc1+LNoCPz3wARdO5mNxuUEdTA1
         CdRGkHOH6SSQ9E8Amljs6Vj0D8qQO1GcwaiCzra83Pt6rQS0khmKxEaa2NFL0QYJXQ+s
         f3NmXUPqmA1oPhENinpFKcGZPRb6ofjYzJMo/Wk/N8W2uTfjwcX5OKgA4qHlG7VHbWTE
         HBXAeIUh3t0r7C1eyexwLeVRGkYg+8o81sXhyO7QwO5U64V12SdhGbxd1KAbC+abYAQo
         DdvA==
X-Forwarded-Encrypted: i=1; AFNElJ/HpjO22EwyQIJSqJU56jS+T6mMwLwhhric0TDxsqw45pjVO+BPOu8BWjhL2NnxJSHfnR6E1h4azE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7G5ZcH2w877iG9pS/PTKkG6flj7AsTjLVdeYIzzscCjQJGeQa
	0FO7lrpIsEvqTuEZgRIhpESm9aBAmT1n3GvH4jewQMIM5E9uEhXx9UPF
X-Gm-Gg: Acq92OGjXOG5VUGe8289K4M2uOgjlNGp8aBdSajOLnHo9ROiDe1gleITxZv/KDXhZ0S
	IEl5hQfum523B3ViwKhSlNS2/vlUavbWzvB/FkANuDaRRhsgKFZqvEkBerPnq9Nxvef4en4W5Vy
	l4BDHSRFq5gzOpf8GDIbnJAZQ/vQmQCjzvpVFB+4GkD0OI3b3fyOidTn6uZRniWlvb6lX1ZvBIR
	hnFy7Ov6vZXgCB4xh/7WxZnopkO+AbYJZEmdrmLF/hkyAzK3oCMDuU6F8/s7aUw8tQCW8zYIow3
	tY0y+CAZp+YdQ71vzovLENdsR0srnId7prryo0e13Wuglu8CN3cnWolmlOkt5UkAUETyczuu20m
	2llFkmarT1ogNsJlcnDmN+FxeRTMbP+VgtszKlOMERtGJISEygxtD72JVxIvCccjv7do3OofWYD
	9JKCaWkp08MMlM4F+GbaCO0hUwq2eQAmA38viRs+UtTzgD
X-Received: by 2002:a2e:a593:0:b0:38e:2183:2287 with SMTP id 38308e7fff4ca-395d8d28ba9mr24558311fa.6.1779722508386;
        Mon, 25 May 2026 08:21:48 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc2d61fsm22930941fa.33.2026.05.25.08.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:21:48 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: wbg@kernel.org
Cc: m32285159@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] counter: ti-eqep: balance pm_runtime on devm_clk_get_enabled() failure
Date: Mon, 25 May 2026 20:21:37 +0500
Message-Id: <20260525152137.7428-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ti_eqep_probe() calls pm_runtime_enable() and pm_runtime_get_sync()
before devm_clk_get_enabled(). If the clk call fails, the function
returns directly via dev_err_probe(), leaving runtime PM enabled
and the usage counter incremented.

Route the clk error through the same err_pm cleanup as counter_add()
so the runtime PM state is unwound on every failure path.

Fixes: f213729f6796 ("counter: new TI eQEP driver")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Collapse the dev_err_probe()+assignment pair into a single line
  using its return value (Maxwell)
- Add Fixes tag

v1: https://lore.kernel.org/all/20260523184448.7609-1-sozdayvek@gmail.com/

 drivers/counter/ti-eqep.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index d21c157e5..4f3b17939 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -548,17 +548,21 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 
 	clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
+	if (IS_ERR(clk)) {
+		err = dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
+		goto err_pm;
+	}
 
 	err = counter_add(counter);
-	if (err < 0) {
-		pm_runtime_put_sync(dev);
-		pm_runtime_disable(dev);
-		return err;
-	}
+	if (err < 0)
+		goto err_pm;
 
 	return 0;
+
+err_pm:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	return err;
 }
 
 static void ti_eqep_remove(struct platform_device *pdev)
-- 
2.43.0

