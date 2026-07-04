Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8683280035
	for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2026 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783154061; cv=none; b=LiKocsV4ZzMV5qqGveJBX/cIAfqJKWfGu4AJOeVoz7CJBiCRahYsmL+xeCoA3cTyZ4itS0dbDM3COcz/c1U6XNf06BJIBISyorczbzAonsElxb7qAz8+d8K9KA8gpCZlU/kwCTWaziMmBOjRjMjK2Ackty17HVamvpS5+lzNNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783154061; c=relaxed/simple;
	bh=Jz4ve4QEm9Edc0AwfZOQrOpfbjh7fXdxn+sLXflgJwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KlNu0JE5viS5NIj+IxA6kFCKFABD1XcDJcm5U5mbYDzPhGbKzlRAm5NRHfvFqoShscZaJz+f30AP2sEyBBsIjIk357FQTKlYY8/TuOWUGhMUXRkLTze1dafD/3mhqgwwqK4WYQWL61vgVbKu0U61p9/k/MqdJxvjskpWp85/d1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvaZ43jY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvaZ43jY"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-381b831d535so1100338a91.0
        for <linux-iio@vger.kernel.org>; Sat, 04 Jul 2026 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783154060; x=1783758860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LbHfGXFcxYP9CA0eEthZoKFBg7syUAmY2ajW76MS+sc=;
        b=bvaZ43jYa77RHjcht+DjHGXA8WBPXuvwFkL6vH2pWQPE6+m0llEmZ+We1Gbc2gd93W
         qluVKE48EXkwNyFvAQ2sCHIUFSri8hph+C9/TQamddxItO5kfZIpDGXfxBVfsprVb5TB
         gtB9NCnYKG5DLvSwAtvWQ5dtZSQKb/tBFa9k9NxtAM1kDEyVZKNBmI/4yZId96HqOX9f
         CI3rqsuuF/nfRJmVkj1Mlo2le84QRWlN4fLhHWMHK5xfySMlmaSqc2c6XtaJUIVFZnJY
         Iui9n7MmE0iI/g6DVkquJD6T+oqHdOHHWE6qU/vkdTQFMCglEuFIMxr6FTiDiKZnL8ww
         BWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783154060; x=1783758860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbHfGXFcxYP9CA0eEthZoKFBg7syUAmY2ajW76MS+sc=;
        b=XJXWwVOwaujzjXsVtDK3QWBwbTB0qnVjb1vDmmKS/0OHMmFWG02FdJiAp4+46BjkrP
         efRslx4SFdVq+YWcj7VApnRKPCaI37EkdWd/kftpPR99s+CbAS7Nhoupb75eZRIK6BmF
         xYKuAXhjP4pJuoXZV8IaQ3AnjVBjsXI8AFUdDi3zF+xDQxnh0cpW+iPi8vJaLH/U1K1f
         5Iyr58C13KVf1DA8KLOCgkeftxpYY/o9MFv48dqZJ/+2ifcJL4+MJBcVO4DzLX2XFYu6
         GEfgjZunIbTFisVZMSLHP8tak9OcFzTGqOcxJ6iHlqUnKq3623qfa3mfU2zgOLAgKy09
         cjSg==
X-Forwarded-Encrypted: i=1; AHgh+RpJiK0hq3UPmXzUZ809zWYCkqdm/i5++OLTcfpM3mRHcGTN51tH6ENMD6tjbG4d6vuLzoxjeGrWQ9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW9yZZ7wGY4epXm+3JiqnE6sXKheu+Bn8IfnNfpbs4k6jq6M4i
	MwvSwDa93CsLOoxpPic4m2noS1/2HuDdVuhZsbBD3jZeWTpUQco7iBMO
X-Gm-Gg: AfdE7ckK5H/yGhTNoqJXXscjUL7B8zODQnl2UwB60HBLkEUTpLxlhXDvxJF6ftHr4V7
	DC1Gb/IrCx3pqsDWZpJuW5hNGStCbz4I0T2qS1uyhGYptPYI0VVeNM+QAV2OPzbaAKmlblUtHWx
	ndT1NOyTso7ERs07JaIG4W471t7PlDDO7USOu413hUC3qlyTXKQMLJOzpFIUjHN/6HnvMb920X1
	TYoW+tEHnc+SBiB1G2fWrYOfsTfPSdE4AEir5g+RmrfKZ//O6tkydJ/rWq2HaJYuoa/0+3Q9H6s
	7SOVUAG5mAvIQIOYV+D/lsXgUMYzshhXlLeIuaNSwl4/NHO8sAowzMcepx6LbqTJDbZdAZflolD
	VUQCz5zrAC+T9yLbCCZ6jiCWvXYKuq4K6sa/7wvdZotO48GtKL+LvRhayCGI2KAW9cEkyTXVQjh
	XdzGWbLHl8sUcn2bskdKw0tM46FnvFtSHdl2wTw3tqVinW0toqfsxSDkAQ3aDQZg==
X-Received: by 2002:a17:90b:1d04:b0:381:abcc:c8e9 with SMTP id 98e67ed59e1d1-382803b43b1mr2776756a91.7.1783154059883;
        Sat, 04 Jul 2026 01:34:19 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:1a77:4d22:a645:ecb4:40eb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f38ee1333sm11749163eec.24.2026.07.04.01.34.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Jul 2026 01:34:19 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: gp2ap002: Disable regulators on resume failure
Date: Sat,  4 Jul 2026 14:19:12 +0545
Message-ID: <20260704083412.43145-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If enabling VIO fails after VDD has been enabled, runtime resume
returns without disabling VDD. Likewise, if device reinitialization
fails, both supplies remain enabled. The runtime PM core keeps the
device suspended when its resume callback fails, so the supplies must
be restored to the suspended state.

Disable the supplies enabled by the callback before returning an error.

Fixes: 97d642e23037 ("iio: light: Add a driver for Sharp GP2AP002x00F")
Assisted-by: Codex:gpt-5
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/iio/light/gp2ap002.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index c83f67f..efef332 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -669,7 +669,7 @@ static int gp2ap002_runtime_resume(struct device *dev)
 	ret = regulator_enable(gp2ap002->vio);
 	if (ret) {
 		dev_err(dev, "failed to enable VIO regulator in resume path\n");
-		return ret;
+		goto out_disable_vdd;
 	}
 
 	msleep(20);
@@ -677,13 +677,19 @@ static int gp2ap002_runtime_resume(struct device *dev)
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
2.51.2

