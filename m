Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D013D6CC9
	for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 05:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214387; cv=none; b=uqO6zb9pg4FJkVWHc+roRw9BV+2DZmn/9eqnq+MQCLZ34tuD4xcPw4sLN44wPuNX8CX4IqAY/PHHdImIlWuEvkvs818QVoCySbmctLBr6Qa69lwOrED7dMA1oXXo/etAy6orzQ5zw349t/EU79VSqSbqjrRd4Ob9Dqg43ObFx8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214387; c=relaxed/simple;
	bh=SWBmXu448zjzxYjCx3pUm9k+IVsTZM+Oeo1N4UfrkmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VgiKK1O8xyY8XWVar8Hiq6cvufLDaBAsiDZGzL4NA7ltEVFSYsztB5CuzMYhfDHAfYFt2c0v32vUlZ7bCLItnQ9Zts+kK84OAD4jbwZLWOx9k3Opd1DROj+GQkhNTIXgXANS95liT9ACPTRrAvNlJcpOszlUx35GRuxf2TQCGcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I02ItFUu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I02ItFUu"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49ff680331aso5478795e9.3
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 22:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792214384; x=1792819184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/dnusO2vMBZJOXXq/LcKes7+kqYaIPlF1nsGZCt+1mw=;
        b=I02ItFUupSWO3qGt/U1fQo2Y/vHnIePCw+EtE/R5rKNAoK0GDrZmxyfty0HjPeXHL6
         k+TxVm1S1+H4rNz9zSYDFRfCJYxh21nsr79tAaq4jRU2hqj4MluvrHaBG0Fd8ORvPQH6
         GDqM3x32sQF7qD11eHiDTsoJWnQveJAZPWHSWTtlC/wFrfWdwCOiU287Gl6dmzcUz1rn
         HEhHkCqaj/TZTa4OA5x4PkIg4HeALufuIG/WaqyaqtXCvD5hPDIYZ2eodkd3deJhy7fR
         t7x3Tm1fgZy2slneDZmiwrqg/3hHfgzr87gKOzmDbBR9IDszIjpWFQFQNJDst4PvRQy2
         JJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792214384; x=1792819184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/dnusO2vMBZJOXXq/LcKes7+kqYaIPlF1nsGZCt+1mw=;
        b=BB2Vx/NpPQiPwVVEpAaSbPVAwwcNhMI5wA9nE4jLAmcKK4EIN/jaGM/OqYjsllZFbY
         H9cAe9qU1QMtVPazgStcfd8N8BlWcm0YS58V5Kl8IE2715EpdGU08m87V1vg2HC+OEY6
         Mb0g/QMXeD/HL+M5hh1LIKjmAM6Z3BfXnpXEOzSuZHXYeXFtRxWa+4WSeEm7aslDGt1r
         KLCxdM58aghQ+aM/PIhmUyVCZuSJgNJ6HfGuPWflCFOmry/QyFPgp5clDOVelR76q2Jm
         YN4YlrrmZEqEYyYH1Hvv08b0XDVC913b5ob9l5/QW+iO4wESemwbEx0OrXsOdsfHeY+9
         zJmg==
X-Gm-Message-State: AFq9FYKKZluD2CywBk1dCpr5OAnAfjVNoSsg2hjNs8XLa+qSG7x/a6Ib
	YtpRg7KVvKMni+uBrtPmnr2DwvmFYzWXzXY6WnSoa9Khsu52kDDFgsWI
X-Gm-Gg: AYBFou2CRMOEjsYiCFioXLTzqdLKBVzQPvfJWWdEgntlJKTJwX+nQOWgjdtajTdgDDm
	SjP8g6bKAh+6DDwPr6OA7OPceYRjhKKUvHUEmLCSEYoOumO6/aXKMy1sOEDDA4vL8DQItc/YzOM
	G9CtazOGKumDRNJ6d8VRy/2UMz/gMdVLuP64IP9Au0wqcqX0XtKMyuzLj5Rnn0TwZ7WJFutCt+x
	+EtlAZjezswQAcAyl1hlmVVpgz6Zu9BOpd0xVdJK41t0qXLhk1nWfAbjZs8TCImElZCCdGtUiXM
	MOdV84yPtTnvKodRJF9rI1JHni+4W8gIBf4rXbuGyaFn2jLT4+XlrWCJif9LWVMnoK/JPmQ0SJY
	129UHVGhPfMvdIg7U4UZ2w5Sf/D5jvZ8z8HoOPzg+sXDj8Ny92huZEqiSp+Tq5zysnqNSbjmsN+
	rUNLqvFwNn/2DvnlD0IMW1ZqiXSPd08C+0kvIZydkuwLKLhvJUKWUF22fg32usUyNAbpCWPsoqa
	aF0sS5rS5v0CynGHPkkhH7fZqCV9+AzJL35O49uDn2FyBXeLOp7LYsDBI1xhbpnrnsRJsvBhYJ4
	pd0aEI0cs99+GNxaXsNFvJfAQmbLoFA5lR0DLUDgYPw4o1PZRx2jKtXpMZJeXkaQ7nxyNgc12rL
	kXqGBlO/C1G/KiWP8V9Zec0uQx2zhyqP3+v/h9Na8CpUDzt6wHCTJ/z1hzBx1FTFatcc01NsneY
	o6+0i5JRE=
X-Received: by 2002:a05:600c:1552:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4a1d762a26bmr37921725e9.32.1792214383959;
        Fri, 16 Oct 2026 22:19:43 -0700 (PDT)
Received: from [10.200.7.52] (109-81-110-105.rct.o2.cz. [109.81.110.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1dc952d63sm16432585e9.2.2026.10.16.22.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:19:43 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 17 Oct 2026 07:19:21 +0200
Subject: [PATCH v3 2/2] iio: gyro: mpu3050: add missing trigger cleanup on
 remove()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-mpu3050-fix-v3-2-d6f29f335a2b@gmail.com>
References: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
In-Reply-To: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Dingisoul <dingiso.kernel@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792214381; l=1550;
 i=joshua.crofts1@gmail.com; s=20261015; h=from:subject:message-id;
 bh=SWBmXu448zjzxYjCx3pUm9k+IVsTZM+Oeo1N4UfrkmA=;
 b=Fev/aLp/t11PuIxED9XWHh8KFvT+A+vQaVp18KaBwGEewZtgXbUFr+4wGlDOjtM2p045I2Rxo
 mcfut4HanCTBy+iHu47QabIH0hrPyOukxNqQYLWwPzM2r2m9f1AoDr0
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The mpu3050_trigger_probe() registers a trigger but
mpu3050_common_remove() and error paths in mpu3050_common_probe() forget
to clean it up, causing a use-after-free bug.

Add the missing calls to the iio_trigger_unregister() function.

Reported-by: Dingisoul <dingiso.kernel@gmail.com>
Closes: https://lore.kernel.org/all/20261010203601.1686148-1-dingiso.kernel@gmail.com/
Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 879caf3b729c..9e747836df3e 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1262,7 +1262,9 @@ int mpu3050_common_probe(struct device *dev,
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-	if (irq)
+	if (mpu3050->trig)
+		iio_trigger_unregister(mpu3050->trig);
+	if (mpu3050->irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
 err_cleanup_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
@@ -1281,6 +1283,8 @@ void mpu3050_common_remove(struct device *dev)
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
+	if (mpu3050->trig)
+		iio_trigger_unregister(mpu3050->trig);
 	if (mpu3050->irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
 	iio_triggered_buffer_cleanup(indio_dev);

-- 
2.56.0

