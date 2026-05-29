Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96943C9ED9
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051517; cv=none; b=L3PBPGD6vWQRYl5uXZ4Cei/MznMW934U56JYGEOpC11KnlmvXIfQApvKkjnQrekLmj9M+wnsHorN+HZuizQnqVZclaRsmUK2TN3kaanggKWkmExcplz0A8fk8H48HYX1PcyHBKyLRUb1g/a2Xkl6roM3Preb1UdvvqXJuW/rnuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051517; c=relaxed/simple;
	bh=v6N3OFP1Y/kL7gSI8Ozv1RZjj9iqSCTmKAuWK2R/IpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pPMkSr9XXPKz4yhEUNWRVgCBqBwKG+GkFAmtHFNDB1GOEPQMcq0pny7itysnWm4CLQXaiKv3MimYrBQsrD2awohFJ2i1FyBjkA2QtoXnXqsWwnEr7zrnhcvHkAT6ttj3Q8oUKHXtigViMqAk0BHIwWtrmye/chq69+3vp6fZIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePEOctVh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePEOctVh"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a8e3849de7so1528477e87.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 03:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780051514; x=1780656314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETzqxfvatOTulZdiDscTQ3AqA8L5AtJ3+8JSfJIcyQM=;
        b=ePEOctVhpvStyqPgxl6oI2G7TEmqFzSMZZTByGhflbDM+aDP8KKwb4u4OXPFxh9gtx
         ik4uByyH2BGQi/+AdVCx47IH0RHHoU6KUuqo7AwGvVivza9Xwb2uperLutjqvuF9Ztrt
         lwj6e34BKiMbJHc+hNEhYMDtGzU6e8e8YpT/CgNFA7craWCPn6+Z4CujfdUOekbgepHN
         a85jSNUYI8rSnMOXdWa6UP/h4o1Bvhe2hh+/mHZ73i7k9xZvyMj9gypOsgPbmR8z2lZg
         JhBm5FMjtxiU3gTE6c79PAxE1diXfZIB6yYte3BW+tKEjRKh93p8gytJCwGxLrn45l6C
         qvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051514; x=1780656314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ETzqxfvatOTulZdiDscTQ3AqA8L5AtJ3+8JSfJIcyQM=;
        b=TxJC1qcVaeTR/EWN/3lhC5Hbn4beV2PPAHuGM0WbFStlxI39jsY5pwxE+fe6IPivdr
         Jg4P/PhCclm/s0Th8hLzqwYha2IDEeone8afdD11wzQK7OuZadrIAjfWU+KP6f5fWicr
         gkGC0R0DANPN+LFNk4vAjUtMmy8BOVXWY46KsUaIoSrSriX7MTBGQ7ORPdJUbCiyyBmS
         hYXu7THv9oGKwQ60feZwgQoeK8LjRUT+7DmH7639y6wyZiwifxubviPePbx942X1+zvo
         ISe53eU1eJeF14u+6TlJeK0674m512/RtrjwqJlx+p1bCpzRtLwT9k1PmnhyBPT6myZL
         +JIw==
X-Forwarded-Encrypted: i=1; AFNElJ+Yw6PhJYeOaZiDm4EsqwRxlhWYYaMjLqT1HpwSyHNZ92sOSX2VnEhB3BpY+44kIOjxLB2I8+j/Dh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQYJTmR4TgE5bPY5ajEAjd3+8Mvo9EUBUzHlw+xIowTsbMU3H
	AnvXV8BLKeRG2WcCHN2n8qPUrqy2v2jYJniBeEAPdhqtygDeLkkd+YY9
X-Gm-Gg: Acq92OGXTuLpZIz8qMyWhWfk5lQACdl/GB9/TAukU+kwQhfzLNcRicKiDYLYjLvm5qs
	lVkXZighvo/MvZsTpesWfVareEnat58Ei04wHtv7zMDVPJ/Xtl9pG5h1EqsJ5ffd9nlbQ33/ldv
	2b395xlURWRyjPtVgkt61Aw4MtJUReyGaBavIVA9WFrJckmrx1FQQX9QCMoczgHl2Cs7z/JgEwN
	iIhzby9itbzklHTjAbjESP+ex/TqKZUX2H1nPpJ1B68Ix/Ub9dHD9jajXmFYGJrwd2DSUtK79qf
	WkNer3FaZ+Yeetqo07i0SH1JMAKcu5mTtaycf8zzt0dLDzqI9f5ipeBMAClDzeyx5wmPf88y6pl
	9VIo9GnqdykWejIS5caRD27gAKiBj0mnSDLVI2yAL5LEd69JGWtSbM/Nxr85N4ZNJDOSA+dRPyb
	TxQtrWUuCFXs6QtN0KI7wTugrTIqijobGba+03yBw5cqGJiQ0jDjjqXis=
X-Received: by 2002:a05:6512:3ca7:b0:5aa:2777:e0c5 with SMTP id 2adb3069b0e04-5aa5946c4e5mr319606e87.1.1780051513729;
        Fri, 29 May 2026 03:45:13 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b071d25sm205269e87.18.2026.05.29.03.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:45:11 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iio: light: tsl2583: use devm_pm_runtime_enable() to fix probe error path
Date: Fri, 29 May 2026 15:44:54 +0500
Message-Id: <a812124efcc1a5ab973826154b5b9a22cdedd760.1780050609.git.sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <cover.1780050609.git.sozdayvek@gmail.com>
References: <cover.1780050609.git.sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tsl2583_probe() calls pm_runtime_enable() and then invokes the non-devm iio_device_register(). If iio_device_register() fails, the function returns without calling pm_runtime_disable(), so the runtime PM enable_count is leaked. On rebind the kernel emits an "Unbalanced pm_runtime_enable" warning.

Switch to devm_pm_runtime_enable() so that the runtime PM disable is tied to device lifetime and is also performed on probe error. The pm_runtime_set_autosuspend_delay() and pm_runtime_use_autosuspend() calls do not need to be undone explicitly because both autosuspend bits are torn down together with the runtime PM state at device release.

With probe now using devres, drop the matching pm_runtime_disable() and pm_runtime_set_suspended() calls from tsl2583_remove(). The remaining tsl2583_set_power_state(TSL2583_CNTL_PWR_OFF) call only issues an i2c write and does not depend on runtime PM being disabled, so its behaviour is unchanged.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/light/tsl2583.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 8801a491de77..62542d904b3b 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -846,7 +846,9 @@ static int tsl2583_probe(struct i2c_client *clientp)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = chip->client->name;
 
-	pm_runtime_enable(&clientp->dev);
+	ret = devm_pm_runtime_enable(&clientp->dev);
+	if (ret)
+		return ret;
 	pm_runtime_set_autosuspend_delay(&clientp->dev,
 					 TSL2583_POWER_OFF_DELAY_MS);
 	pm_runtime_use_autosuspend(&clientp->dev);
@@ -873,8 +875,6 @@ static void tsl2583_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
 
 	tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_OFF);
 }
-- 
2.43.0

