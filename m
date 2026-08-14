Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A4476054
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714880; cv=none; b=pI7T7Ir5FVwbtQ+ucTuxgcb0RSwf89iD9eyzKGTSYah/g2CaugeT4+m/nBWTESFMxxwfktxxhehZ0bzHyextD7UWyhpbd2mE2RVlXE56rrg3TvaRjATvckSaOAQjU9eabZE+N0WqffQ5C+Hm3mdnYD6aiPM6djvjdNm+8/+wZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714880; c=relaxed/simple;
	bh=d1Gvs4AL/f4vX3QgVhKPTz1KJyFcjbEiYJDmT1kb2Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RvJCcFKcA5BliOUzXP+vZCn07KQq686woF5jAcJMsug7JC+zue9R/4HmRo6ATeG/JPUgfTvuxyWYEx8bCIlaQpo8M9dWS4tDtLmEHYXkVk0wt1CSDvBSEGPEPkwW7E+gG+x94HQ2ITD174zzfOTWxdXaWJcBvBDd9qn4pLdMCP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/V2rZYm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/V2rZYm"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so13141615ad.1
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714878; x=1787319678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N51mCAdH2/WtaJCTP7hQirjbIZKOCCBLaOzBiUgg0fk=;
        b=d/V2rZYmJSN0aTzkeq16PM4hXmyZ3ihMWVBgNTGbZVP5mzeXDnCzTweIwb+WoqbJQH
         6IEu8KQLbXh7NOVWJOwe24KLShbz0vcpAEWW2h2b+pZk2BFkpzqJ6UNY3ChQgt+LJu64
         cQFlXTyJjK/kQw9rCFDj6Ts8clgeEvEuE1oD4i/xRluXCawpCnG95nPui76rrEQwB75U
         k1SC94S76H1D3jHU/wnWsbyjMUacDUAYkRjC8duEKNj8ajcYsBw5yB576kOcJgIZFsKY
         l5C485I0ciN/kwnXau3oacuzGN/vAFTcvvXfmQpBCEJN1ZBDvmvhiVgFcjqUpmoCO8lN
         ojNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714878; x=1787319678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N51mCAdH2/WtaJCTP7hQirjbIZKOCCBLaOzBiUgg0fk=;
        b=lklV9Lz7NzfK05pGg/99WsAfWejwriu1Aus3rHZLbTBz8uxAkQKNQw9Cv3BF/eAnRJ
         3GhiDzv8QlfsNbxYPDgw+qVdhQfaq1oQBmJyXIo8RlpdDt2k/L3tIi7dwWfDcyoRcWns
         kD3QAaTAfKPPkorMv4uTPV25R9wtZFXXV6gprZmflixaF1s+yYsQmp943W4MBkQuAa5c
         wkPHhBgcS9/jYvBiTojdG8DxmbNj4oesIo4j80O9/mt5xA2MZwrEOH0sRH4LI44MgCKK
         dhkf13sakFOSbJJ6GrCr7s2oweRkn2X3pheDiwM7bVFBH3sCLj1c6sBI84FwgCSlwW+Z
         KFJw==
X-Gm-Message-State: AOJu0YwteBWw79ZuiSBkl+iRMd/di+mz4yjH2kvOBSh8ZYDjR0PHGjzZ
	wt1SH/X/5Q2OeNT7hiPbnbzfinPC5BFeH5zkgPXyAPUIdA+ONapH/ZKa
X-Gm-Gg: AR+sD13R2Osl7lVHXZBTIzH1uS77o0aMypXITVw4YfxW8R+6WOnnLONT1Ls16uPek+6
	gHEo7R49dnjY9fFLnDZq3xn7VRkDpeoXZKarUGdyv7c7hZy3LzQbPn2HWvytWvsy0vvpFzkGDly
	bMX3qzpWJ0oflmX/sl+C7Qk6VE1C5X69cEGNI+godxgQf8KD23QP8o6almgKHhYMIOtC5cVtznS
	9oFsEcNwCwFQ6bqsA+mdUVJHcMBg4j0ZZjjCPwW/Sd8vNW40RNy6iukXGSxZPM7F/H6mrg4U40n
	+nlhWpVudsoD+REp+omUvCrSjTzl9wk2gPIjxlS6g8MAqfxM8FelDaz6y82rSnoa3Zx9VS3xHOC
	mZN0a0fI8NvJqxdvdc4bZr1Rf+kJyffbDdMV7oEJzzDeD0yD/kdvtN8rOpDYnWGE2nUYS+rmfp/
	ZE8VclviM42tAqn9bdD3pH+rf3mnwm+mk7B4kB2G9rz0n7a5AkPcSqdW/JvN2pUxR0SII+3TGgL
	n/Btf5p
X-Received: by 2002:a17:903:1a86:b0:2d1:134:b86e with SMTP id d9443c01a7336-2d3b082b567mr66513245ad.2.1786714877703;
        Fri, 14 Aug 2026 06:41:17 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aebc3a08sm9516005ad.69.2026.08.14.06.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:41:17 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] iio: gyro: mpu3050: Fix runtime PM leak on trigger errors
Date: Fri, 14 Aug 2026 21:41:11 +0800
Message-ID: <20260814134111.1387580-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first user of the MPU-3050 data-ready trigger takes a runtime PM
reference before configuring the FIFO, sample engine and interrupt. If
any of those operations fails, iio_trigger_attach_poll_func() tears down
its IRQ resources without calling set_trigger_state(false). The buffer
error path then releases only its preenable reference, leaving the
trigger's reference held and preventing runtime suspend.

Use pm_runtime_resume_and_get() so a resume failure does not leave a
usage count behind. Route later setup failures through a common unwind
that clears hw_irq_trigger and drops the trigger's reference. Successful
enable and disable behavior is unchanged.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: f11d59d87b8622 ("iio: Move attach/detach of the poll func to the core")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b4314..33a98a6e9cb84 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -988,20 +988,23 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 		return 0;
 	} else {
 		/* Else we're enabling the trigger from this point */
-		pm_runtime_get_sync(mpu3050->dev);
+		ret = pm_runtime_resume_and_get(mpu3050->dev);
+		if (ret)
+			return ret;
+
 		mpu3050->hw_irq_trigger = true;
 
 		/* Disable all things in the FIFO */
 		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 
 		/* Reset and enable the FIFO */
 		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
 				      MPU3050_USR_CTRL_FIFO_EN |
 				      MPU3050_USR_CTRL_FIFO_RST);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 
 		mpu3050->pending_fifo_footer = false;
 
@@ -1013,12 +1016,12 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 				   MPU3050_FIFO_EN_GYRO_ZOUT |
 				   MPU3050_FIFO_EN_FOOTER);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 
 		/* Configure the sample engine */
 		ret = mpu3050_start_sampling(mpu3050);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 
 		/* Clear IRQ flag */
 		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
@@ -1037,10 +1040,16 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 
 		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 	}
 
 	return 0;
+
+err_pm_put:
+	mpu3050->hw_irq_trigger = false;
+	pm_runtime_put_autosuspend(mpu3050->dev);
+
+	return ret;
 }
 
 static const struct iio_trigger_ops mpu3050_trigger_ops = {
-- 
2.51.0
