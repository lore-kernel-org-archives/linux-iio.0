Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63A493637
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788528766; cv=none; b=OhHQjf90JqdZLQ+rtrv1pkPr63aMP/ri8Ilyhen9H4HMQXZBOOTGSaAcGOnKqvSaTXFOIgH8D96mrldLyA1jW+dnVrltaX0cva8s0J/y/R1DW3bBtWayEZ4ZM+DAC02MALmXbm6IUzi8EB7bY4oZ1QYI9xq2K+LgTQTdxWeCmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788528766; c=relaxed/simple;
	bh=2G1xZrHjM1JHXnoDsstI3b2BjufIFU1p5k/dPACFxeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QV82g2LyzTn9SNiYdqfE/WLQi5r0iF1kl/tjoi0QamKiYjvOwcRT1sL+LXTVHT7IXQ0Ib7nFxCRNpYNDUnXx5qhaK0EecfhdPr54ALUko4zW1UgMmicqhM6IywVmRH845IAKO5QmgPmhK8vRkendsG0NMqIPt9DruXUXYs3AZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akbnEXFH; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akbnEXFH"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b5f21afe8cso2874462e87.1
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788528762; x=1789133562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0c/Sgi1T4W7/Ogmdz2aUIy6QPzImiY6hgRc7tBhpmno=;
        b=akbnEXFHTukprwLqgaYiGJEqLq0EVpy1dfch/Zok4MWovfhYy/PSgMoom7cBRjn3H3
         JRzpmyHZAWi9X558iELqy36WlfN3V3NhYIWwkT7SKG1gz+UTAZfnv/7M6khiG0OIftKD
         dnaJqa7lN/jIclNdboliT1Cac6bj7rCTRbEdERzCcJXvXErk6xUMdsltkhGz9WTjtGkE
         WiSdIhnGxYr9CY0mHoTLKAQBUBI9yzjlNNtjMFOkkus19bCTg1+IKkdFyS5plB4axQ2i
         7Y+26W0EBk+ga1YrREBBZpWZ+axnJbSQvjcXtLP0TWlIx/PixEu0a43Oo6BEMkQGByN2
         FXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788528762; x=1789133562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0c/Sgi1T4W7/Ogmdz2aUIy6QPzImiY6hgRc7tBhpmno=;
        b=fgZetkbz7uF8LFs8UtF3jFJmiGCYlLJSYbTUa4X8kODrddDWblHazxc29lUpZgMHfy
         gS6y9/sJzqQqd6MAlkXJ9I8FdQP4KIXdpg2KmFgeOv0Yp6C/fMsNjJMvAhQSK2uFF/i5
         AF1u/VV6vRpCuJPcvqw8osEB7jM5Ik0nUlxfCxPGUap+MMkZysZ1LOrvejrUqsq4RMUe
         f3GTWmnbS/w5WjgISMH+5GA8Lrx6a6SaJ+dc0/U0c6JttB7djlZIbNqmzhsA7GuhulTZ
         /GW5mGQzbwU63v9pxpL2/gZKUZtd1v3Mty16fvyYDG5bpFUc08OP/QX9FBBOmJCXk026
         xdFg==
X-Forwarded-Encrypted: i=1; AKwUvBwUCba5qJdMno9qd6la+BG5/aJHPvv39y0DmDfVvV4kMcWseMjyjE/cFlxD8Ofn9cS69XgipHsxUn8=@vger.kernel.org
X-Gm-Message-State: AFuF++k+EO8/e6JSrjt+9LNGT6mdoA8gx1ZOltMig3bKrCTcXq00OzDU
	BKLkRjspzeacAj2WLMeiVI/PgevBKdcn2IP3732kcLkIXv1vJRlN2gD/
X-Gm-Gg: AYBFou2uR6fy3IGbK5OvlT6Ico4t5xt7w6fBIMSPyRgjSX4voW5t91Z+Csn9Tp8uYrb
	yGx2QLes8esYdgfdYINNIPaW4sxD0XqL8Pbis5Zcy5PulVC4LJihfgmKyabE69mGK3ZHBzAkHOZ
	bremfd5PZOyHWyk78V3AEmYeUoRMW48sWfd2PLVMnJwQwkk7xqb5IDVyu4Ih62UMTmg3ajkUSPl
	FY1R43QnP21MErQWC4e2Id1wrdQ2PBK+mNKjkhRfcoJbTC7BWExm7FtseMv2dGyPr5xCBtQl9qV
	H5EVAdSqeyYYLVYQbpbje0i8szIwwAsx9/8ijtBSBxD81hgCo8CwDhTLpbaqYdpS2Mhfu408oE9
	6yoFXqrBFrgOVeVzO7L0X1ked/2un9X4SWyqOOo8eTGXyJwhBkiQzzCoKajWwePjxxCBfEWh//L
	ExjGGPdLlRtfW4iG/HVbMzUKq25+KiOhXDQdr+DuJqBU6St8EvoBdVsTbBTbJj7ASRBeuGmV5U4
	dnBmS/w9gNb3stpRco=
X-Received: by 2002:a05:6512:2344:b0:5b5:e8d6:8870 with SMTP id 2adb3069b0e04-5b60e6a6340mr2137250e87.1.1788528762134;
        Fri, 04 Sep 2026 06:32:42 -0700 (PDT)
Received: from fedora (pd9f1e316.dip0.t-ipconnect.de. [217.241.227.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858bcefd59sm3661297f8f.19.2026.09.04.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:32:41 -0700 (PDT)
From: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hans de Goede <hansg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>
Subject: [PATCH] iio: adc: axp288: Add TS bias override for Haier HV103H
Date: Fri,  4 Sep 2026 15:31:55 +0200
Message-ID: <20260904133155.51290-1-cactucatu4eckuu@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Haier HV103H firmware configures the AXP288 TS pin bias
current to 60 uA. This causes the battery temperature reading to
cross the charging temperature threshold under load, incorrectly
stopping battery charging.

Setting the TS bias current to 80 uA fixes the temperature
measurement and prevents charging from being incorrectly disabled.

Add a DMI quirk to use the 80 uA TS bias current on the Haier
HV103H.

Signed-off-by: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>
---
 drivers/iio/adc/axp288_adc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index c8283279c47..c98863d612a 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -207,6 +207,14 @@ static const struct dmi_system_id axp288_adc_ts_bias_override[] = {
 		},
 		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
 	},
+	{
+		/* Haier HV103H */
+		.matches = {
+		  DMI_MATCH(DMI_SYS_VENDOR, "Haier"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "HV103H"),
+		},
+		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
+	},
 	{ }
 };
 
-- 
2.55.0

