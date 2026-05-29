Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B5E3CCFB4
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051558; cv=none; b=WJ+28j2PwsdY4fxU572zGjdg0181LVJ7KaECSCJOU5cOt6Taoq/Eb5EtD/tAw5Tg8owZD29cqTtkienlFP8S7WFFs20Noxd/oL/VQ3ppcAXX4YUxsae1Ofv1mHo6RHOLTxjLI37FdPpCIRRYdGQQGNOZj8OWCNX9dNjr3lsHvgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051558; c=relaxed/simple;
	bh=gefyxywsiMBSr6d14j+d4bay8IyQt8dXGWBKJWpislU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yh54UMUBIlIv7zn91pbaFbtwSnEEarc6XTKrxBgVQgHPwcKF9vc8CPIaGWB+aaI6Hg3Um6EGlWXrxlYk66zGGjnNp6NQPQhasGm7qmh2W75tSvaq0mobNrrxyHmCyU3BoCywjgjkXvtLAEdVhzB/mTchwLg/Z+P0JHoLgVlgxIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5sutoLL; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5sutoLL"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a875ca312eso1432826e87.3
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780051556; x=1780656356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OXH2+flOB/VPx3klyh9xxXOIX/pTbIIlXVLEZ4fguY=;
        b=O5sutoLLd5tTbXz4l0n/TvXi6ebjd6U+gSOdcys4AHKVotpZm/s2no680ZouY9NWU1
         e2B5YnA+AkZV2ebf1qEfSXhOHGV6yjID0vXprGr182E+TzAc0WtLwObzzcgpH7ZK7Qdy
         xtUCDQMVlpVi16J7Zw8KLmgVFMjCZ6k0KOq8PsL7pWMx4XcPU+F+r6lBE4dYQrGrUFrT
         1K8GsFSaWGSCjnPhFlWN2t4Wm7M2+y7oj4iexak578A+oy5cxenbYwfgSdLYSVxoA/2j
         1XYziCzun6TqGqmkv/PWaO/NFrZJ6LcqUtKyeKLyuy8cKoiiYApqO71woztFW6xbG8Ng
         mmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051556; x=1780656356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7OXH2+flOB/VPx3klyh9xxXOIX/pTbIIlXVLEZ4fguY=;
        b=izy2OaVghWLnu8YYON16glan7woKMKhi96889C6sagR8bmC+oySbx76DfcgFpF/KUY
         Y7BJZFoZmFO6lJgQbRq+P8VCOSZt6Ks5IEZ1MLXhJhrwCmtTNVpg4vCiqql4xlcmasnA
         c3/PAlbLjtyG52J7L3o4Z06MdXlEznpp8K430CiAKjKzUbNPE+dI+XN9AdlN0lMilJ0C
         7YyolwEbC1MDfXzQHSkKqsuweiiMzaC/6eVrhWIvwsLg1+6Ubw+jhOvIGeNI3l6kPkSn
         20WmGPSv37oT2sKFsKAUXmJcGt2dN046ohtV1gMsDZ4tnw97+QIoH4QaS9faYwgQ2HQ0
         7F1A==
X-Forwarded-Encrypted: i=1; AFNElJ8htyCZS7e5svpIsJ8YPmG2TdF+jgZpELzqKUK3Fkm7G/H7hHP3jAt0lXE+ViXUvyb05Vfdf+xKuhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ4+zB615i3RyDUWc6waIzYf0LReMTnQTUzxayZCXIh9dvlaRj
	ek2kS+jSumKOZ4J92CB41GZWALvP6g9nR3DHTRkXEhJRYu3O0f6K6oVE
X-Gm-Gg: Acq92OH0Fa0vRzblbjipbMXDnWKYbLXt/EP7AWZrYV3jscliVt9vvMAE28LvprIfdJV
	6e4OcmWOrW3Y3t4iLke5xmMog6Qm/9Aw9S1Dkpav8Wrai6hA7G4BcGN5Ji32btpes0/SaEpNK24
	2L1j/DD4bKPNKIanfBijVc8YT8BlWzMmua7xXqNeBJyDybb18tcHEySA/zZlHq3FHJsFP3TVpZm
	Ft0SoTSUzw5d+6QpTmnUiIbmMQXX9sslFna1hHrp1FRjSUT0QrscoX9O5JnI9mPQl/pvBZ9yLZC
	JEHfBfi6fA2W2lN/nUdphfDrDV6a48NAP2ID+4CC2c7E4WlbcTwKuyYoKjPnaRVuVUI1AkmhdLr
	x/U1PKm9WwijaRSBTip7DQp/EsPY0NgpzEBTQHT8K5WO3KAKBTVZoJWfJZhhHmNAhW8+KPL1eDo
	zpxBSPJ+K/BGjjq2sKA4UjxicYfzuX2CEkEeb1retrMcf7Sc4Gv32bQF8=
X-Received: by 2002:a05:6512:3996:b0:5a8:7218:47b9 with SMTP id 2adb3069b0e04-5aa594c30edmr358949e87.8.1780051555661;
        Fri, 29 May 2026 03:45:55 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b788811sm192604e87.63.2026.05.29.03.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:45:53 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iio: light: pa12203001: use devm_pm_runtime_enable() to fix probe error path
Date: Fri, 29 May 2026 15:45:41 +0500
Message-Id: <04c4962d435d4df8e8ce6655598c0964014392f1.1780051096.git.sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <cover.1780051096.git.sozdayvek@gmail.com>
References: <cover.1780051096.git.sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pa12203001_probe() calls pm_runtime_enable() and then
iio_device_register().  If iio_device_register() fails the function
jumps to out_err but the existing out_err handler does not call
pm_runtime_disable(), leaking the runtime PM enable_count on probe
failure and on subsequent rebind.

Switch to devm_pm_runtime_enable() so the enable (and the matching
dont_use_autosuspend) are torn down automatically.  On its new error path
the probe jumps to the existing out_err label so the chip-disable cleanup
stays in step with the rest of the manual unwind.  The pm_runtime_disable()
and pm_runtime_set_suspended() calls in pa12203001_remove() are dropped;
the devm action runs after .remove() and handles the teardown.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/light/pa12203001.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index 98a1f1624c75..b9f50c9070a3 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -372,7 +372,9 @@ static int pa12203001_probe(struct i2c_client *client)
 	if (ret < 0)
 		goto out_err;
 
-	pm_runtime_enable(&client->dev);
+	ret = devm_pm_runtime_enable(&client->dev);
+	if (ret)
+		goto out_err;
 	pm_runtime_set_autosuspend_delay(&client->dev,
 					 PA12203001_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
@@ -395,9 +397,6 @@ static void pa12203001_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-
 	ret = pa12203001_power_chip(indio_dev, PA12203001_CHIP_DISABLE);
 	if (ret)
 		dev_warn(&client->dev, "Failed to power down (%pe)\n",
-- 
2.43.0

