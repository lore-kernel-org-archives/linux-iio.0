Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9264F3DA5A2
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275094; cv=none; b=ZtOVwnOQmnEC2rlf89LbsfoNGUCzrtxf7x29txm4Mf4Mr0oFgdg4bUWKlnaHEMRWjeZHM3oZsEQKxCLdBf5KgF2Ya/OBYKVquBA2wCo3ur7PVa4hqlb/u2VHuygRxVNH6Xinf7tVtRld3iogvfes+xzu0dnnWzcyaEvQolgRQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275094; c=relaxed/simple;
	bh=ke0gpjaGr+kZ3qP39FMMy64jhRk5PSmJHcJ62SMMYjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J0Y2rqbUJgbHxgoaaeklWC2M/F7NXYMjN23pFDWc5xZ3bsFI2eGMpsnb4OrBUUSJOs0xihNyyqMKCL46mXFBWzduuwZ8JDjV7e2D96dLPXLJwsKQ2EJK8IdY2V7ke5lqB958ijOEKPqiNIMah9GBKaMqAJhX1DRnzbSOz1lycBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnvTw0Dq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnvTw0Dq"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-393b0fa758fso7139341fa.3
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 04:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779275092; x=1779879892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RYIaXBYmg5H7GBqJdVw4CRmxqOBtJQxdADPRcv+Im8w=;
        b=DnvTw0DqYPZxJGfX1RDJKe5jd69raCfcYUER0tXt4bpQuGIo87i3s1dffsq10217xN
         E4ZqEaNdJvLqJ1Cii11nXq+tFZ8zjAK7qFmfdFXnekCSgOa/jsgWvIzBYZ+AchVMZtKs
         6+1IMn6/ApOXaMr4KTRdbXOeHMOxQUaCYcGTo8L7BpRHX/nnpT7MJe/qo4qHdEAVWAZY
         2L8Do8KVDE0vxi0uY32/VJgnydNKp8uMnXHwrHNErbZ4oA9jr7p+IKd9fdufiZ7ACYRz
         EKeNtl0UOzZ66uwhA4YefWk6ZzGLm9AHQF2KgawXfRkLR7tRgyqBAiDANu3FoCZE4KNu
         Fv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779275092; x=1779879892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYIaXBYmg5H7GBqJdVw4CRmxqOBtJQxdADPRcv+Im8w=;
        b=LpGrC1ZfmdE4ykcGW7/9iWQNwowjWBzhL5KNtrbc8H12LSFYrPAPr6xgAm2OJyeAfp
         4/Cec8fByhb6QRIFSWq6waV3q3MA0twzANGN7FV9RYB5cpzaKidA1gFO6H8e6qPg1w0A
         geI1DACcTTy0aqbQVj0+OnBdC05/WGFKU2vAE8iCsTA5mrjVB97/f2STSzOuGKyMTo3u
         jj3M9USCVF0lBkWIP8zNDdpFYBSbc8o7/IqhOOhk1RND8/8Os/gp6UiX52dXO/3msSp7
         8OoUwZM4GPezlcjyc+eH+4NoAL8YCfa1k3D4N2+pZj+4fELVidvgUFcfjcZtDaLAjIX1
         H2Dw==
X-Forwarded-Encrypted: i=1; AFNElJ/PuuHqsuuJmDgwlhPeRzILjHbW0Fj+6hSSZcGYLYoOS3G95UC65t4XKkr2D1aw5ja6w+bH5dZWTZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp53sg57S+t1/rizpbxNQd+y8cZwWQ2anB2/BkSsrr3289mBPJ
	VJesYC726N31hKCF2VfNhILlXJNbOzjnHB25tEgEFAGUVFFiUsE7JZ0S
X-Gm-Gg: Acq92OHdXx+dq3gC6t+nqLD9behcCe62dgzuNxuTVk5uJ6i6irWQjhcyrzIn05uN75N
	Y58dSkmYzxyB8nl6YBHU2i98XCbo5lbm/viRPdO0puO2DFhNEnQFB7/0fuOWoW/yd9sQSwF4gGS
	pacsMrsfsx02Gyf0sEwDOrbBN6j4/d9wydIBITh7JZKR+kA/J8TK+M3GfJjsNng0Ncr0H4c6uCt
	R08n8PFj9+dLqKgKytjZvE3n84UXYevbxrerjJ0oSJ3RThdc4UULgkgKkuy/+rX6IDbFBXt8Iho
	LsLOvF9HrXwa9ALt3MsjijTsTFwqaf5n2K35Slb6DDBOWpNxRzW05ysn11pwgjoaCubK3G2y6PE
	DP5TTARwmg6Ct4BjsEw7FIyXiPFLZOVMUHMtqoPPW/eDfXjB+lO+MJlwVSml9smLY+nBP5UFBEG
	yuqrfnWgeuDBH5EictKoBf6nHt8tprsYBVYmy+K1IfU+mQ1BA=
X-Received: by 2002:a05:651c:515:b0:38c:670a:ca50 with SMTP id 38308e7fff4ca-39561d33220mr32468801fa.6.1779275091452;
        Wed, 20 May 2026 04:04:51 -0700 (PDT)
Received: from localhost.localdomain ([213.230.116.218])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882c41c1sm27572611fa.12.2026.05.20.04.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:04:50 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: linus.walleij@linaro.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: gyro: mpu3050: use devm_iio_trigger_register()
Date: Wed, 20 May 2026 16:04:36 +0500
Message-Id: <20260520110437.13955-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpu3050_trigger_probe() allocates the DRDY trigger with
devm_iio_trigger_alloc() but registers it with plain
iio_trigger_register(). mpu3050_common_remove() never calls
iio_trigger_unregister(), so on module unload the trigger stays
in the global trigger list while its memory is later released by
devm, leaving a dangling entry.

Switch to devm_iio_trigger_register() so the registration is
undone in the same devm scope as the allocation.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b..596919318 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1127,7 +1127,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 	mpu3050->trig->ops = &mpu3050_trigger_ops;
 	iio_trigger_set_drvdata(mpu3050->trig, indio_dev);
 
-	ret = iio_trigger_register(mpu3050->trig);
+	ret = devm_iio_trigger_register(&indio_dev->dev, mpu3050->trig);
 	if (ret)
 		goto err_iio_trigger;
 
-- 
2.43.0

