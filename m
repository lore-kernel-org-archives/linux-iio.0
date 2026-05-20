Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C133A029
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304149; cv=none; b=ReokcfwSHpxOmNwr6qs6Sy9LlG6yGJawrFZ8tPyFGz66kV7Qbpgw8FF+7hlccNjSQqrDFX45e1cYwSIreMQBdt33McIKqbIm/PNvDmxHHTnAvQFrRlMlglGfVzOB+9g/lv5wLgYVQLuQkIYPtrBoW8in8TjaGHfNPte/UMxnluU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304149; c=relaxed/simple;
	bh=HbrEEVgvCogJkrpCUOP8LE7h0fPQ28zW+lvEBkr6ukI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WuvrlpOIkTiy98HkT6lDyLZ4Y55OojGSYfCMt++A5TOkX2g/mk3NHK4npzXR7IUaVpkRTe8qfB+f2s8larHO4dzYY0kRIcKIbGcLUABAY34QB+VV1S7i2c79/x+4yeWwbNy9Vss16i5Cn5DpA5y0QOQ+20wykf5OKBXT6ESYZFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxgdZhYx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxgdZhYx"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48fde653997so4958915e9.2
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779304146; x=1779908946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QBoKC3tjUQjmu1FwAOZP+PeCdJgFPWSlPi4A9SDxjmo=;
        b=BxgdZhYxP0VkYTAeISu0iiMyBxFBlNnm2BuDEioS7bDPa6ubJhxlcld6Eu3JFwnf1n
         qwBE9zoEuaJnm8NtzpoHdqa8d2Rywc7f6MhT3RKEqAgwAMZLMkQhXwKEpXQdX8y58IM+
         g5yiP+q0vo+ApxYVdKimbrEGB51ydYROi+XFRAH7wAAGp/nNlj9S6g0937N1mWS1SESK
         AAh6OWWAcqviE/MGWDislQbwlqJsBXEY6K5bfczrUkiuJX3whUcq2p0cJeOr1qe3joEw
         Ws4mipFXoxye+s96T1PNdWXfjDVfMapau4pTnBQ+X5dox3beOhgwzBHpu9Xz6QJzQrzS
         dMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779304146; x=1779908946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBoKC3tjUQjmu1FwAOZP+PeCdJgFPWSlPi4A9SDxjmo=;
        b=JDE1PsILVK1p2sv/8yJ54yjs88v1ACzeCcyIBkfAG2kulapiZ6v51QT0AFhXiZNIMJ
         WkOxE6jyiE9u+9KmIgRPkECBem+jps149bM3sl31s6dVUQcP7l6hcgin2stQEPrnxFJC
         +XD+Dcos3HoOJVDQ8D+v2y3d24fPj7dcZIrRrxmSNYbw09y30ZbYfe+3/zMoQyFflxOG
         vKicUNtvUm1XTh3Vg7UPZD1kPTaWIrTKiuL1SpmZB9re8czNzLH9/zcKy+XcDuzGH8xG
         VdMAguYkGhSw+OsVFk+tsoMSFoOi7AEEaCmvotCZV6H+bnw552eX1GedRzId1Znuq2xe
         jtFg==
X-Forwarded-Encrypted: i=1; AFNElJ8NB0FgC9Uj3L3S9SwiTwWOVDWrRd3FauJh+kXAqumKCqJuky9ZKqKAMzPnZvm+ItFODpGHevwMkZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDQb7XOMLZt2IuzZBNb1DS7wsUn3k3rxFMzTb619kMdp1lgmH7
	wrhvf5hs6TnSpj0gRYsLibZLV7kIxZ70ECy2gLCkp3JU+OpNCj/Ri8Ou
X-Gm-Gg: Acq92OENwGHYVsDvKtchS++r6fan1HKIF9GU9Ek7Unp1N+dOuFZQq/Npn/NN8RYR3Zp
	BlZM0/ySPdYhviaX/GamlHD0qzVtmcrd7EbuReeTvYqXAMZzsrGrSTeLCWq/ANFb9YDCOrVFOL0
	SLSRTNskhqDQwIbqBpr9YbDnCORtQQqQjBCPrQHtb9IjINakJKbUYUZRc6pQoa6ucWkLKmD3rbh
	/GuabBZEk1gyxMdv5e0mwioPIHQLUnE8ii9mzZicVV9ug2NCI3cGuYU/NmlNhq7L2qc3De4MFzw
	JYXFtBpL90yVOkyD96W9pjxMxGzaPIs+7lHnRoNPX/sTrYLX2269XILpT4mm6s6zsowGHwYrEDT
	kZQI4COVyy4GXejaj54GWHrlEqTgqdsM/8U/cwQLQRFo4vkdbTaxuk3o/ZyLTZKDk8cXJYAfM5E
	dZEQ1rlq/a6RezPx3YTN1dE/0Amvg/rTf6RrzVwnSlJYhBz/N8w5g+YW8=
X-Received: by 2002:a05:600c:4513:b0:48a:5501:799a with SMTP id 5b1f17b1804b1-48fe664c27cmr193914905e9.5.1779304146011;
        Wed, 20 May 2026 12:09:06 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a178adsm59520456f8f.18.2026.05.20.12.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:09:05 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: andrea.merello@iit.it,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: imu: bno055: terminate dev_err() strings with a newline
Date: Thu, 21 May 2026 00:08:50 +0500
Message-Id: <20260520190851.11390-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two dev_err() calls in bno055_ser_write_reg() and bno055_ser_read_reg()
are missing the trailing newline, so the kernel log buffer continues
the next message on the same line.

Add the missing \n.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/imu/bno055/bno055_ser_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bno055/bno055_ser_core.c b/drivers/iio/imu/bno055/bno055_ser_core.c
index 48669dabb..733f9112d 100644
--- a/drivers/iio/imu/bno055/bno055_ser_core.c
+++ b/drivers/iio/imu/bno055/bno055_ser_core.c
@@ -288,7 +288,7 @@ static int bno055_ser_write_reg(void *context, const void *_data, size_t count)
 	struct bno055_ser_priv *priv = context;
 
 	if (count < 2) {
-		dev_err(&priv->serdev->dev, "Invalid write count %zu", count);
+		dev_err(&priv->serdev->dev, "Invalid write count %zu\n", count);
 		return -EINVAL;
 	}
 
@@ -306,7 +306,7 @@ static int bno055_ser_read_reg(void *context,
 	struct bno055_ser_priv *priv = context;
 
 	if (val_size > 128) {
-		dev_err(&priv->serdev->dev, "Invalid read valsize %zu", val_size);
+		dev_err(&priv->serdev->dev, "Invalid read valsize %zu\n", val_size);
 		return -EINVAL;
 	}
 
-- 
2.43.0

