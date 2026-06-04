Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CBD33F8A3
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579036; cv=none; b=cmOhIvo36OKKd2nDvqaevfzszTzVqbS01iK0jKc51Q6npjDDayaHzVgYuWtseRWUioUGDBAtqDqqGSTbL5RlcrW32Twv+h3TBXaMjEijJvbwq2rFF3YaPCiaLTDqxqiUHznkCEtqRMCv+ATm1KNCp6SAl/Ay0z83rm/wGtbCiuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579036; c=relaxed/simple;
	bh=zo5TbhHUky/9AbbJa4J3DCTQeu3dka87sdS4FfXHqc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtRvztvGXmGG3p1aWNaAtaCcvQ2tHr3uHivnhv2wJ0iEpEuPli/818jI/pxTl0U2UwhXjXeHBYs6W9Mz7AC313g9qhHizAm9Gm0u+QTNJVQnMtsW0lbpb9NWnUkxPz0rQWIFZaHO6cSMSUzVPVoQgcuRN5MsA4pRldKKH+6arPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM1dlTy8; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM1dlTy8"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7ea16f090b4so9518047b3.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579034; x=1781183834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDM8Xoj5ZoqsbCsa/gDTbPX+rOqL1i39Hi5xHM5ECCo=;
        b=jM1dlTy8wR8aeewKFPH+VmTm7nGDv6GLvYS8frK6sqvA21rSWdVWFCTM8RS1szlcsy
         N4+gDM1/k0JOWhUWVNNEa9E1VSSLbeWkii7MN+OGsHlfzCJ1QmrFvbxglQuadk5RaX6R
         f2098tQEsDe40tIMsJfzc5o0UXjFs4+PKpbmR8GFRG7X7fRCAjkmNWQButTPp838CzcB
         OOIFCd+ltw/W7QDpTB437TsOXobs5UVBcYGHE5MF9WAlKVUWui133yl3fqw1tnud7EmX
         Dv3V2mEXuccogl7NNgSTR6jWP7WSWm1yShJ6IYRZggxGiCTAv4T9awnJzeBKdDnhOvoE
         sHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579034; x=1781183834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDM8Xoj5ZoqsbCsa/gDTbPX+rOqL1i39Hi5xHM5ECCo=;
        b=YMDFW0foj6MSmADgMsFFX43/dWbPYbw55+S2U1A1B/cN9vbEo5T6uzMfioCynBvFyD
         lBFGfKCxUsMeC52CrJvkxVzNtrRqNnAFfJuFvmUO7vBFYmxzdg+m/fMDn9zHQQQJN3Ja
         +lpHGPNvCz4dZlJcN3e4nIGfSPg70nBXjsthiuJYesrZUxG/jpM/tNgWyuA84omGg03Y
         zRHIWal0pti0kOuk/h3Z42YZDSlIcByj1bpebOT7ipcaWUi9tNdhUAblrjefvIcyPJBq
         nJzE1s6KpVErWzmEN49ICQcdVwpYyehucrsuVflezPz+QgSsiB9Ljudnn6y2jh5yeLgQ
         n9xQ==
X-Forwarded-Encrypted: i=1; AFNElJ/twXjFxkSNQTu3qL5vsxiVTP5VjP4KeNGFi5tFpgKo5z6fXQWEWJtK6gK1lZeZGFe6+gzB9xF/1qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx12pxpKJHlcCwEU+mQuoC5Wk/xjcp2dgMCisFPvA8j0cjSPu2t
	ggjDsfUDNctmNV4bkjGunU4SeKHnYjltN26rovOLtxKxv366bJ36caVL
X-Gm-Gg: Acq92OFYRRdiLgwBfZtu5qOXmT3LKYMiehqlDligLCPE3Dm1AkZSk3G36qXWz3reIpR
	Vtt49B+1LqGOs9+8FhO50YcWtnKYn9ZPULrlB6y2A0rlfVciaY5/IE5z3tPPD8QC3bt5GNBZzPm
	t8Bot2Pw2G1OAlnn9HKmkrec+XYdxBug5DRhR6rRpx87IPCM7gPnUunANCqP2AxtosSdRl/26ug
	u6lgk1WpacpMBAfPf27dNqZ5ZZllyDQlvAcMaptAlKqiHZeGu4pNXRzX7PyH9RKsR04RzFRb977
	c8OCMpVP0JjnZaiIzItsjmNMoyD9w8j6l/thRrI4v0ZmTsnAy71tkVKQ8OPneCg1oiW9zCCofff
	g4o5zUbClRM19CdCbR3EpBhpXSCjxXkMkHNeU0i5NcT1aJZinleuZw7C3MAnp9PUdb25+QREr04
	OLPk2jdlRx6DMRYaC6aRq9OpX6Qc8JOV3LhvkQdjn1NJBDm5/WZVsqUkoHycnfPtthF2lqUUjh+
	ic=
X-Received: by 2002:a05:690c:c522:b0:7e9:a6b4:fb22 with SMTP id 00721157ae682-7ea4bad578dmr73567297b3.49.1780579034125;
        Thu, 04 Jun 2026 06:17:14 -0700 (PDT)
Received: from i-use-arch-btw (c-67-187-47-172.hsd1.ga.comcast.net. [67.187.47.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23a9a421sm33248547b3.39.2026.06.04.06.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:17:13 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: Maxwell Doose <m32285159@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: chemical: scd30: Use devm_mutex_init() over non-devm mutex_init()
Date: Thu,  4 Jun 2026 08:15:18 -0500
Message-ID: <20260604131518.27323-2-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code uses mutex_init() instead of devm_mutex_init(), which
is incorrect as the rest of the file uses the devm automatic resource
management API. Fix this so that the mutex is set up in the same way as
the rest of the device data structure.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 v2:
 - Drop fixes tag per Jonathan's suggestion.
 - Replace dev_err_probe() with return -ENOMEM per Jonathan and Andy's
   suggestions.

 drivers/iio/chemical/scd30_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index db5cc295aeab..198add58affd 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -714,7 +714,10 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
 	state->pressure_comp = SCD30_PRESSURE_COMP_DEFAULT;
 	state->meas_interval = SCD30_MEAS_INTERVAL_DEFAULT;
 	state->command = command;
-	mutex_init(&state->lock);
+	ret = devm_mutex_init(dev, &state->lock);
+	if (ret)
+		return -ENOMEM;
+
 	init_completion(&state->meas_ready);
 
 	dev_set_drvdata(dev, indio_dev);
-- 
2.54.0

