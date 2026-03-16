Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C437419C
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651653; cv=none; b=StSxVP5vvA7/MH3vYnz0SDDvpKBCTcQcH+U9JvoE5RB5yrPWb0fA3LJ8BCpJEc6mu0AEc/1XbJ5EaYsM7j6jL7vtuUjkYxu3bs89Uhxer8yJ4ZDPZjaMXSJxAxZlP6YphEqTiCYYhisbvx8PskJnOgwSqR/WbEhoht++QniQJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651653; c=relaxed/simple;
	bh=aGIOwxlkTFN9XmXTP+DXifEScsZFFp5ZytQiqt6OzYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsqmIAGqhUOnfvjb5SZ9BquBI53bFJJnIhfTB1x/eJaEnhl6c6WSobAqIjgX5u4UmJzEtX9G2vkQUzhY4Y95IwFHxkAIhLDR+CpxYv+xHzgKgKonqMg4Kkr/oLadNA6Ij2WxEcs24dc24Xd0sK332rtxDacFYUa7y3jDfjdvCZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUN9zlW0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUN9zlW0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad617d5b80so30256995ad.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651651; x=1774256451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krIBvcQ9qVWVyiQdGz226MUf38FMQABPS7ogaQR3zjU=;
        b=BUN9zlW0kkZG6zRy6NPqBqUKmXaH2jBBKKHap8Yr3XD4a86mCCx0EyLL50TfLYTWox
         y8FkWHpap0YgSPOTeKmvQ9oR+3i4PSzepFdyEzDyrSlIRpkFx/H12a2JcDWXziBmA5PH
         ARJHixfSbSs0ktD3Rojt/EVHnRUDJ+4SeZ/WnwaKbnHghwtO+abq0oJeEeGgt9gZouRR
         SjFPwjiJGi5ihjB0Tv89wLMTJCUGoljh269Xo04rMWLyjSk+a/1nwZXBJOI1y0I/8zhW
         k5QexGkZLRTGsvl5sf28K+zY8hXxFU54C4pj5aJBJHTZd9+I3o4EUKS/4PH+TINFCbZI
         pS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651651; x=1774256451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=krIBvcQ9qVWVyiQdGz226MUf38FMQABPS7ogaQR3zjU=;
        b=JIsOWm1p55Ajpd2Rn/NxdkLGbCoWZrP0hHPnJUwzR6/bGyH5J5rupHx8Fe403wUqvb
         tIUkZCQJ5Zx0qR8QHhk54NeMEO9oxPskTaLswJRi0WjmNY62y7/+H1az6AJOlpx8Frx7
         l5R4dUKQnd/WqOxfizA2+BOfj5OncC5iGA4mIF4PwYT8icxnv+3a4igjzgL3YKaWQY/3
         99FyrXxYkpO51GaCgGU8CfYNItIIiE/JwpGpqpW7mXAia/PYWnG7OsjU5A10mjjoTCHo
         1o4qXMTTiJKZvNbj8XEOZYTvqgXcuvIVmGrS9liXuOSKsUZ9/WZtA6zZ6eTZjTYbdLfn
         akHw==
X-Forwarded-Encrypted: i=1; AJvYcCWOuPqnFjIe16yl77H/pst4c90PkJetWe7aU9WBGfLDQyQ/A+9W36q6ps0JrMjJmTsOTwYmTVpQ2uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlpJcESDvhxjg8KqEfcv0OZNfu8YmpSfYbQrnUzOFXwJHjOYWU
	VkKU55JkFPFk1nm8w/IIuUjROwgwtAoBC1OJ1+XGwHcG2XSfRu/l4Ouv
X-Gm-Gg: ATEYQzz1ZWcmlU6GHhPNvji/Qo1eeTL8NxoiR3eup3eip65pT8Wu+OGAzJe3/EnviLW
	/MUS0PcPTU9VyluLzsqwajkP6SBcUYkIcbhUpUFhT/8u9vJpPSXpRwRU/Sjp1RL6BQGdRDv1aUf
	+xf5wG32hbg6Kb2TsyeRG9T1C0/ToDUPAQdOQ1W60Kj9t2DW2b153+r+4YdF+0Moa3J5LkmVLWk
	BavPYwZa8sTNjvUgZyD3JldH3SyWlz/UY1NcweeDLZvNDdeWf/C1gd0vnxfXF69GGfxM/VyFWgt
	Et/6lBWXrDaUC4CeE3aS7D9YX3FBsGK2Zudflr0N5/VVQiqJcevtlAiHCGB3YzhbhZBHSGgN+m3
	wsOltsF0t3au1VKQHYM1tG3rc6curWO7dYbXi0P1CVGxHASOBH2gHOn55ioBonKO59N2lQKGhah
	P62nz7YL3yWjdo0w1z+1LLwIAt
X-Received: by 2002:a17:902:daca:b0:2b0:5520:f4a0 with SMTP id d9443c01a7336-2b055210ab4mr35920165ad.11.1773651649598;
        Mon, 16 Mar 2026 02:00:49 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:00:49 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v5 02/14] iio: light: fix several incorrect spellings
Date: Mon, 16 Mar 2026 14:30:10 +0530
Message-ID: <20260316090023.14691-3-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316090023.14691-1-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistakes reported by codespell.

- sesnor -> sensor
- substraction -> subtraction
- simulataneous -> simultaneous
- proccessed -> processed
- coefficents -> coefficients

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/light/Kconfig    | 2 +-
 drivers/iio/light/apds9160.c | 2 +-
 drivers/iio/light/ltr390.c   | 2 +-
 drivers/iio/light/opt3001.c  | 2 +-
 drivers/iio/light/tsl2772.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index ac1408d374c9..eff33e456c70 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -359,7 +359,7 @@ config ROHM_BU27034
	select IIO_KFIFO_BUF
	help
	  Enable support for the ROHM BU27034 ambient light sensor. ROHM BU27034
-	  is an ambient light sesnor with 3 channels and 3 photo diodes capable
+	  is an ambient light sensor with 3 channels and 3 photo diodes capable
	  of detecting a very wide range of illuminance.
	  Typical application is adjusting LCD and backlight power of TVs and
	  mobile phones.
diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
index 9b8af11b7b67..3da0bdac04cf 100644
--- a/drivers/iio/light/apds9160.c
+++ b/drivers/iio/light/apds9160.c
@@ -620,7 +620,7 @@ static int apds9160_set_ps_gain(struct apds9160_chip *data, int val)

 /*
  * The PS intelligent cancellation level register allows
- * for an on-chip substraction of the ADC count caused by
+ * for an on-chip subtraction of the ADC count caused by
  * unwanted reflected light from PS ADC output.
  */
 static int apds9160_set_ps_cancellation_level(struct apds9160_chip *data,
diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index fc387426fa87..f1702aca582d 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -101,7 +101,7 @@ enum ltr390_meas_rate {
 struct ltr390_data {
	struct regmap *regmap;
	struct i2c_client *client;
-	/* Protects device from simulataneous reads */
+	/* Protects device from simultaneous reads */
	struct mutex lock;
	enum ltr390_mode mode;
	int gain;
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 393a3d2fbe1d..53bc455b7bad 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -91,7 +91,7 @@ struct opt3001_chip_info {
	 */
	int factor_integer;
	/*
-	 * Factor used to align decimal part of proccessed value to six decimal
+	 * Factor used to align decimal part of processed value to six decimal
	 * places.
	 */
	int factor_decimal;
diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 0b171106441a..c8f15ba95267 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -190,7 +190,7 @@ struct tsl2772_chip {
 };

 /*
- * Different devices require different coefficents, and these numbers were
+ * Different devices require different coefficients, and these numbers were
  * derived from the 'Lux Equation' section of the various device datasheets.
  * All of these coefficients assume a Glass Attenuation (GA) factor of 1.
  * The coefficients are multiplied by 1000 to avoid floating point operations.
--
2.53.0
