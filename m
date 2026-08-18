Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C23F889E
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059865; cv=none; b=ZB9IN8w1zMIbyDFV0ccP/H9VNhRf6MBa4g5iCpZ5EexhB+P3b8voNSMl0IveMRbz3a5nAn4LK3PnD4leU2M+mqM2a+rAKMCT3fpuAb+2g+xP+/czIyH5F9tonBn5BGQtqvxY+87e56i3k6YK+C4bjlvQpwiJ+FKuQ0C8rKJ5KAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059865; c=relaxed/simple;
	bh=T0JJJLUuhNcrIAsh1KIF8Nwu4qzw5TFxBskkWdQOYYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=goJ78iKkvBzMdh1iPlAg9ICkkfEiTX3f1BQ/99+FvgfC7aR+hW62c7jHIhDrxg3jSu9FljABk8b5EM84ADnyUg8YDXEDh2+iI7FKhgmNGjoazutvM7F2A2wv7PDaUj7B4KzGUilDMfoGpOnokoAAh+QweprAZC0T5l7GcCOQgSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ob4cudml; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ob4cudml"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so3734369b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787059864; x=1787664664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LNuQ7ERVi19pNvBz+ivTEZwwR+8EHVvrbTUExY6Tln8=;
        b=ob4cudml3zQFT5rbZbSeBR7P/KeBFxZS+tk1+zj9ipSl83NyaLbqYQ2nYDvTPDUA6z
         4VG+6+wgP5mOvc/PfFxP5Mvay/o+AsUE3Q5lSe6qbRlQgBt79K85y/5Zaq5nwazCEchK
         buz2vr8gIIPPYvGH4RD549IxxF4uAVP6NYEPF+8dUj3vCWvoTRIamk6ktb2nNhUlruMB
         oTIbaai5zezQTd5Cbs0ICa8ufKGdb9bQmnrznw+gadqTlOYZs1LiagmRzkFwtqm7ezSQ
         F/y0Ap+RBf8L0x05Uir+oPLI1o2g2UI28c9Hj/bLhA1egL0mTlvmYNSGsXlcXBx0tuQK
         847g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787059864; x=1787664664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LNuQ7ERVi19pNvBz+ivTEZwwR+8EHVvrbTUExY6Tln8=;
        b=cRRXgXtv2fOdKn/tjRb1OJrrpBFmRpdXsX8je2Uuit+Mb0p+g4W/ZySrZR+YVmemd0
         fRjIv5xr3BLSSUWAe6gvhme95gqoGg6lRyBaRY3v4VSwkAcSQrxrNNks/QdrJppQviEh
         5BUi4J/bIuB4w2nDXLp2MfsSsjZeGuCl66/TqhXUsATvmWY+7Yx4F+jnKmBuZ5DYFPm2
         O9+TvFIKcVpj0lyRz+K6W8s+5b4qvUMfaVEicTphIKPaM80cyRGgapeiPWc5kjpio2qM
         IIYplphJRPgYtE7vUn6kkCe5nwPr7WzZ0BNWsvImRdfsLovkYmx+P3vqhFD1N2ovi9ej
         0+sQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/eW7uKVicfYaP0dZybCSgjn1KjKaFVSIfwzfAN/OeRjY3fWA/Nwd+497Y8Q5ZSD2FsdtxHHh9qd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPvw8s0oeQmNIWiHeHShFVR1B29RMhLYsTl2bwtJ1RxplYGNK
	0YLz3ApeQjEPWXV8HvVBviUK7WwhAVrZ5Xu8CUnLMN+wORWYQnpHzk9/
X-Gm-Gg: AR+sD10wbZhSoCyqHONK7U3xX20PDUHp/umlm05y++DI5lDerbfCCxnxeXpqKwu9C8J
	+HmFG3bW+oWH8jBv/39vZIdrjG1y3h1G7QhUfXaGoCYiCI/BaUMGJ6Y2M8KmZnJ+hT3WaGxBkZn
	3NBFYvF3xX1gXgS8FpPjlpEfAImyKEKagSHO+uROl5OfT6VgVPDQeX73dPId6YRLIKYYUNVME0u
	LZY+N5pVwMC4lEYOkpxWT9pbBdPJvDFwBIyjW7MoOPeYq0Dk1uXnea9qom9yTg3zWDodRKa9U5y
	Y+Im/6tM7fXwQZTaU0EU8k/Jzkb4bDblYvXoKNsatJSlJVxRI9mn2EQRadwYeQRjtIHiNiHwQ5Q
	XsIJicbmUCfRVkSFdo2aHZE+gQdjAcAKOnTlnx5jEznaHRUhotvLseiSpu+M2Ym+JB5RdSdiEu4
	MHIKtYqS+b+SbpKDn7AERFGDEzwnukFCt8PZj1Irv0Po9j+NXLMFr4r9XiJThttDxh3+8nAB6CM
	RRUny/z
X-Received: by 2002:a05:6a00:428e:b0:848:8445:6956 with SMTP id d2e1a72fcca58-84fde223e4cmr36519557b3a.18.1787059863800;
        Tue, 18 Aug 2026 06:31:03 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:2c00:7ca6:1bcd:6269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851c2fc690bsm644505b3a.14.2026.08.18.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:31:03 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH v2] iio: gyro: mpu3050: Fix runtime PM leak on trigger errors
Date: Tue, 18 Aug 2026 21:30:46 +0800
Message-ID: <20260818133046.858005-1-ruoyuw560@gmail.com>
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

Use PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND() so a failed resume does
not leave a usage count behind and later setup failures automatically
release the acquired reference. Disarm the scoped cleanup after the
interrupt has been enabled, leaving the disable path to release the
trigger's reference. Keep hw_irq_trigger clear unless interrupt setup
succeeds.

This issue was found by a static analysis checker and confirmed by manual
source review.

Fixes: f11d59d87b8622 ("iio: Move attach/detach of the poll func to the core")
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
Changes in v2:
- Use the PM_RUNTIME_ACQUIRE*() cleanup API requested by Andy Shevchenko.
- Retain the runtime PM reference only after trigger setup succeeds.

Link: https://lore.kernel.org/r/20260814134111.1387580-1-ruoyuw560@gmail.com/
---
 drivers/iio/gyro/mpu3050-core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b4314..d3ae998445115 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -988,8 +988,10 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 		return 0;
 	} else {
 		/* Else we're enabling the trigger from this point */
-		pm_runtime_get_sync(mpu3050->dev);
-		mpu3050->hw_irq_trigger = true;
+		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(mpu3050->dev, pm);
+		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+		if (ret)
+			return ret;
 
 		/* Disable all things in the FIFO */
 		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
@@ -1035,9 +1037,14 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 		if (mpu3050->irq_opendrain)
 			val |= MPU3050_INT_OPEN;
 
+		mpu3050->hw_irq_trigger = true;
 		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
-		if (ret)
+		if (ret) {
+			mpu3050->hw_irq_trigger = false;
 			return ret;
+		}
+
+		retain_and_null_ptr(pm);
 	}
 
 	return 0;
-- 
2.51.0

