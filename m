Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA4439F6D
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737384; cv=none; b=KiLaKIXG9fJrSKz60TiyYe6MMnybnP7z38QTwh/aKVWrS5gZMBku8PsRNhm4THSucR0JQrujXz2bbQtdcmnjoOrTWLtglVtRlbxRSzODfYR648KJH6IvXCJamK4pln8/nCMTNiU33lnYY3GShunSp0JrrUcgjCBlCa3TpsEjUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737384; c=relaxed/simple;
	bh=b1zwzYrehw2xMiWnP3qCyD8im9SRTQveIPIOMZLKT+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WcTl9JtzmCLCBH2rJ67WCxMURcnf74or8GneNyJLz9BjX7K8JNYeccyhXF0vXDH6KS+0nwz8tZQ5QW/02fUu72QLWi7ZAqWxHvACX5OOf5evLl8/FzMlpxmfTIzFljyMp+0cRUasG30XEkcaGHPkKBUM3x1E9mMxlMBbz2c4AEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPD0YiEM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPD0YiEM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceb096e675so132079435ad.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784737382; x=1785342182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jUyRifTnAdWj9oo8ReezTF2SEzJ7h//arZ1iHXc2iOE=;
        b=EPD0YiEMo2RVUVO6QZYs3rC/cxuYbI80TXdGaWKx3JliJ9cCOpd6J/LBpt0mf/KM4a
         7WeNu3KMdMha5zB3jf2jkTfhgukvoNcHumxF2HZ4aEMaZ24WxtlAb1SgyOiSNTj4WuEn
         v8ej1sY1U8c0yRLLF7rGpnWRMX2kDA4xSAo8+7Ga13ZyAt4EypZeSdW1JaXKjtfP+FrH
         sTfscTN5Ebpu4ckXEPtevUigLaTLqfdU2N3L17l40X7attFqoLEpwy0iVU2Qpk/RV75V
         WRdFSRy7tdhlG6v/GmT/I4k5sSDxPVnjDUhdjymFLs/XcVcO3gUWk/6bZw9ut19fkHTJ
         JpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784737382; x=1785342182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jUyRifTnAdWj9oo8ReezTF2SEzJ7h//arZ1iHXc2iOE=;
        b=ScXDfB/ZElHxkgIP+ImdbkgnBZ21AuJJcyM21mwEBCfFDsvfLxoE0vl4Ja4B+xdyDO
         +hPkbw4N/Q8Izo15bXdf5blL0CRdlU9x4cUGtDoSJB7F1jBNAUO8oZKZm8jZu5Ez70qx
         +bnX0T17j6Uhl+F2eOo7V+KkF+bagczeuuWWCtKai5a1XYrePMKjpqMCIeoYCjc1WWzW
         cTG6TcJVs35yTxRqz0ZJMcxIvLgVI3HXGR91VLbx7Y7n7mK4p373NhzUOFt2nuQt2nNy
         1+Mk4B+MJ9kMIYpCn+P5ihNJlCmOeO9d1coDhJbo7bTsv9HlAM9C/iWPpqBIUMtDzVJw
         E+dQ==
X-Forwarded-Encrypted: i=1; AHgh+RqD967HoGhT9il7FZwB09UA1sF3i/YOQsBndfC86zhyMRBcOVL0hlV5Van1wvBlPtmEqayn8ASODwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM3Rfyu+Cnro1rtoEwl6XM+K17O0I2HopG3TOjU0SWOVRqaSND
	hx/QCPNWVl/yLBizWZouG38E3+y+FMJ3xdobb72BIoCV7roaRVS2Kf0=
X-Gm-Gg: AR+sD10tw0jW1CiFrUii2MnlstUnGz4ENtehFuQNLOUCDS55OS7hhzCajN0BWdeFH++
	GZxj6S1NRQEXayrlpv9ptXt80yL11m7UE751lBtpPtE9upRV2fo9dgRJyhbVHOM9+Bn9tm4HFZu
	OnWqCZFhWRWcjujjMirTMjaJ7k0xNHU6Qb9+O4YY++eNl51joJV+NpWvneWCaCkHzMxjTsQAgp4
	8yn8ZJ+byEp4B3ZKwLV674dold1CTdfSMT17XPruA0OkL9JYQalgvNdpjD1TYW7j05aDfzjvJfo
	5sCEscnynAuYRwa5t6eY2Q9rBUJGmbXFh1DJ4MLzevmY6ihSn6Fav+uBsWgi3WVaZ/kPuYFJmLE
	DjPJ7zIW04yYq2ni1ka0Bnt+gDxs0aDhruOUhar7h/xv6P9WTjw+G56GMI+boQaU7/zULE+rUOQ
	Bcy7VPaqGthBn0hLeo7oiEYcSmRM6pv688tCsYd7VyeHpOWaUGkOcr
X-Received: by 2002:a17:902:e944:b0:2cc:f7c6:8320 with SMTP id d9443c01a7336-2cf34a28988mr236046735ad.46.1784737381719;
        Wed, 22 Jul 2026 09:23:01 -0700 (PDT)
Received: from localhost.localdomain ([101.0.62.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1e3d9sm9260471eec.5.2026.07.22.09.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:23:01 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2 1/3] iio: light: gp2ap002: Fix unbalanced runtime PM on repeated event writes
Date: Wed, 22 Jul 2026 21:52:45 +0530
Message-Id: <20260722162247.8229-2-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260722162247.8229-1-nikhilgtr@gmail.com>
References: <20260722162247.8229-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IIO core does not filter duplicate writes to the event enable
attribute, so writing the same value twice invokes
write_event_config() twice. Enabling twice leaks a runtime PM
reference, preventing the device from ever suspending again;
disabling twice underflows the usage count and triggers a
"Runtime PM usage count underflow" warning.

Bail out early when the requested state matches the current state.
While at it, switch to pm_runtime_resume_and_get() so a failed
resume is propagated to userspace instead of silently marking the
event enabled.

Fixes: 97d642e23037c ("iio: light: Add a driver for Sharp GP2AP002x00F")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/gp2ap002.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index 42859e5b1089..966459994995 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -343,6 +343,10 @@ static int gp2ap002_write_event_config(struct iio_dev *indio_dev,
 				       bool state)
 {
 	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
+	int ret;
+
+	if (state == gp2ap002->enabled)
+		return 0;
 
 	if (state) {
 		/*
@@ -350,14 +354,15 @@ static int gp2ap002_write_event_config(struct iio_dev *indio_dev,
 		 * already) and reintialize the sensor by using runtime_pm
 		 * callbacks.
 		 */
-		pm_runtime_get_sync(gp2ap002->dev);
-		gp2ap002->enabled = true;
+
+		ret = pm_runtime_resume_and_get(gp2ap002->dev);
+		if (ret)
+			return ret;
 	} else {
-		pm_runtime_mark_last_busy(gp2ap002->dev);
 		pm_runtime_put_autosuspend(gp2ap002->dev);
-		gp2ap002->enabled = false;
 	}
 
+	gp2ap002->enabled = state;
 	return 0;
 }
 
-- 
2.39.5

