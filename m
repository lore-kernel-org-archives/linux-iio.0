Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB244E042
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576372; cv=none; b=KEeuLljeSyZuh2oLqOL0e03ARfUo1soj3lBJNrab7WajrOGdQUnIwVQejTf0DqTxyX1mNfCDUvr52pHAkE9FZ8V3r7829oVd07Z48jV5gw9+NvUclIl2BxMU7wLBVTFsglat+7v3S/8zFUpbKHejjB7cvhEhBs/TeTV4dBJIZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576372; c=relaxed/simple;
	bh=E8m3m8XTS5TIoPN9299SRPXn/mLhXEctm+wdxmEAGyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IjICry9MTg9H/UREWam7z2hs+Pmgbs5PfCsftyqWkxnq+AOo9iI68YoT5tDRFeLVBbeo+rPTf8vP1jKvA9nR958LookbVO+Up36DMipqamsAN4A3und/faSVDIT8supWAAceqZK1bRO8ivr7RtlbrgxnFoYTfitheinUdYw0IQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0Iswoh3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0Iswoh3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cab973140bso129101355ad.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 12:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784576370; x=1785181170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JpGuakV6/SQbZZ9011+gRtKsdWAwPDNjjQWuQfdvvoI=;
        b=i0Iswoh3ci5nQV+u7TDyOKtHPb5fURk0kOLXDygVTDd3/ZmUAtcM0sxmn+T2rM4Ktb
         G4+oheM37lFeXPdDHR8lIp0IeMke6JLZve2g1T/z0J9SfTnibysH6SJYD8cUKSYI84k8
         a6b/L0gboiFMJaj0Otfn1hEr6s3zgKGbWsT2ATEExdJ8v76j5XaQUeC1MRxnRwLX3BDa
         RUZaWZkNCvqbB7OKKVy6LEuze+iQkOfjd6bly6LaIt9oF3xbHYCNRTT/mP8hKjKaSGnp
         yF3x7DuQe4YCmcvpu5Mc61jGh1TjjoVCfwFCwYMMujit8eSItKASFEHXS/I5P5ZStb95
         R8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576370; x=1785181170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JpGuakV6/SQbZZ9011+gRtKsdWAwPDNjjQWuQfdvvoI=;
        b=Wh4bl2vH2DETk52sybLa+5ffg8fXQnPPAsXLylCOKnTXZPg/CmaX1Bylbh7vDYnqB4
         yJFJ+4eSSirrykwxBAGo9sJDso8fi0NzJ+tYnoDbYhxAxidbO/WDUBREPzonPE8E6u3F
         A0HsuXDXlVll7+E7m7LQND7SKeQ6iAmfkK3ik0GXjpht9q+fbHu/HKEASQS0nAwwRA7a
         sLoUyNyBXaTKhduX2VfkJOJf1sWS9lw7nRBb5imXL8JhXVa3yePNeqc2F8ZKkvv/4Zy0
         gpdHiojdjyJ4LTJtC42xJ/SKaObJcKsaOxpuD7SPdI5z8hs9iDEGSm9pyCuXS5Z9Zv2M
         HssA==
X-Forwarded-Encrypted: i=1; AHgh+RqSUrBy5nUu729pCKdcn1R5+xR4HIDuV8TX/i6Glx4CaJP72NhsiqlNNo6rf8CWqd3Q6o0zaZAcliQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvOCwl5Dsp1qPe03/KmYqFLDNpxgZw6DFMhivw2iNXaJ7FzqEg
	oNnnZURx4iWC71CTp0L+0QNrNBTSxxLdN17RW55foE1pLREgvR0/SEs=
X-Gm-Gg: AfdE7ckxuMMM4yb6r787ZLEVsnpgc9lXkaF5qv8h/7npe7Qh19s05laK55h9rMgEwfz
	Mg52dVFVrfZi7mEICKxxdKRHWQ1xJNJEdrkh0LHnMYc1sa17Z12+QF2TCOuH1X2lvXdPgfA4+XJ
	vKZzFyHCU+pLcQegfsyOnu9S5bKaxtRzidi8Dp7yuaGDCeB3Qx3VghM4l6eIgwaCfTqUdADotH5
	vvENxEMtAEM0OQtou3KcwF8tIFGNv+AHY49gNXZJ8sRxGyND1wn8/E8lH8MY7FSxfxd6MjdTZf6
	gS+ViHQivMNP2ZJFbOxxWff3RT/f9zRnEr9Rg6JHHPyc+JnHWIBThbzlt6qOxOzHo6f40l+EHEe
	uz57nGJGfWcAkcysafeYfBt+CVNppCZdLnwX+HagkZlHAiYbSORiDk1KdnLsAb4KgXz40CQoW5X
	ZLs/ImozD3sO71mjUk24BHudjld2etYyZwKXJ3ujSS
X-Received: by 2002:a05:6a20:9397:b0:3bf:6c08:fb94 with SMTP id adf61e73a8af0-3c3ada37416mr16404386637.54.1784576370328;
        Mon, 20 Jul 2026 12:39:30 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29ffb13sm33935340c88.6.2026.07.20.12.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:39:29 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v1 3/3] iio: light: gp2ap002: Fix regulator leaks in runtime resume error path
Date: Tue, 21 Jul 2026 01:09:11 +0530
Message-Id: <20260720193911.74919-4-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720193911.74919-1-nikhilgtr@gmail.com>
References: <20260720193911.74919-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If enabling vio fails, vdd is left enabled; if re-initializing the
sensor fails, both regulators are left enabled.

unwind previously enabled regulators on failure, mirroring the error
handling already used in probe.

Fixes: 97d642e23037c ("iio: light: Add a driver for Sharp GP2AP002x00F")

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/gp2ap002.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index 96dab4d1d8ac..b6dde3dce39a 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -678,7 +678,7 @@ static int gp2ap002_runtime_resume(struct device *dev)
 	ret = regulator_enable(gp2ap002->vio);
 	if (ret) {
 		dev_err(dev, "failed to enable VIO regulator in resume path\n");
-		return ret;
+		goto out_disable_vdd;
 	}
 
 	msleep(20);
@@ -686,13 +686,19 @@ static int gp2ap002_runtime_resume(struct device *dev)
 	ret = gp2ap002_init(gp2ap002);
 	if (ret) {
 		dev_err(dev, "re-initialization failed\n");
-		return ret;
+		goto out_disable_vio;
 	}
 
 	/* Re-activate the IRQ */
 	enable_irq(gp2ap002->irq);
 
 	return 0;
+
+out_disable_vio:
+	regulator_disable(gp2ap002->vio);
+out_disable_vdd:
+	regulator_disable(gp2ap002->vdd);
+	return ret;
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(gp2ap002_dev_pm_ops, gp2ap002_runtime_suspend,
-- 
2.39.5

