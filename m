Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A22BDC32
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884538; cv=none; b=hrhuQX429uNrnMOLJZFlC/ZFfCfdWNHVxUbKj+2vi2DRjLjuY54zSmVSwQoz9ikQCUx3CFKe9XE2wKyNZHPt6iwyfldLOVUs3WyVvWZGi3Vkb6Ui7e7BVkbsxfT3I2/3xNlRTQSyAIbM0jKVRB752w+442sKT/k+IkIuUJJTwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884538; c=relaxed/simple;
	bh=27dzNMNZQnxdSDnKXyGDYnEZfoL61bCTuPKi0nZZwDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KG6fHEF4njBdqJi0TWNylo8F83M+JStNRT4B3AjkBghzR6G/LHdm9dCTs+QewsS0DQydwAtk4HqhCngvprAX6fbu4RYeGDd7cSouUQGcrX94IwueTdM1J9ypQDktVoe/oQyqIqALjr8NKfM5hPMtHwxVCh9R3lSxCIu5Pwqnfo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=IhwEdjWD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="IhwEdjWD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45fe59255beso1251332f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 08:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781884528; x=1782489328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CU6AY6iBLEOZiBP2qPyJskoabacOIMKcahMcvsaK3Zo=;
        b=IhwEdjWDPZRTzGR9oYmXkKfb3Qrmp5EJsB8cS8jFII81rfUuPg8O61tDb3WgRMaugO
         waeVlprlwb2h5YJAtCt7X3SghJJO0WewAF94IKNKjuNpXWu5OBG+3/RYDJ2uz+Lv+HUr
         DlOZDehsyWaLOfwv4euUgdM172l/3iKRDPqQZxoCtx2Wj3ob0pje9mHvth09cqdbs01F
         BhCHsf3ldmvt70QsoCDHvOuKfs9+Ao1JTk4Qnl3ognK+XU7EoDTycfQubysDZrl801a0
         inLa6QbSsSM1l9GxxgBOAirzl8/QSJmPUZLDM6Z99dM2C8y/9Qez8k78q7ojPltuI7a9
         C0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781884528; x=1782489328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CU6AY6iBLEOZiBP2qPyJskoabacOIMKcahMcvsaK3Zo=;
        b=F0x8H64EFAOA/FddR8vwXl/CThfY53VZLNScvMopLqMVyqvglbM2AiRjVemBqX6BgT
         X8Bxvozcos3lfCXGoa+NHIFVsSkIwvKi6+IXgmroOAdYd0XXllid0vFd+r2/BU5m0mig
         AS4+yBGE/Sjv+h6W3J7vrfHDlXbupWdJAMD1INkNmEBRFoPkOOUhbYGpGhniWdtYA2ID
         Te9VWPfGq01XtWP2uuCj0g+N3R7CI02na01UdWUPp7pnIJmIBEnsJAfegP3Q7VJWGtnR
         YlAo3x/vK8LphDz+TNC6c2o0B4FAkmjC8v7TOiBtYNSinepF+r8VsEvSGXdFoE1QGIHf
         7lPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ZmpWH9PoPMPJHSosQNXEFhDg49d1yLgo3HWNXvmQomgovEwzj/rWhzd7zlio8qTLMFjwsrl4cDHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnSJuYDbeUsQUjcaOYV3z0VLfxl1rG6w4qwI9p/tkCuGnfVyDq
	IMLE0TFKtlxX1eWVHWpDSgCmvKJ83dxQ85t9CijMSaCa160YNqZa/UVLCrva+2N1Wm0=
X-Gm-Gg: AfdE7cnqbn32L2zA6mo02BbVjdLMwRPq7u2GPIWXQi17eRFFPx20pewMKt1rxPePLI4
	zOpLc4VzoWg7PrB1aw5Tr2LqsadOSAnm1Frx7f3AFTLqWpTlconxcfAF0SmtCVrqIQ1DqHLIcKN
	CAtgfi8Xf8r53AVkeQfjDPQloA4xFFMjxu4xJUQV5eDdVhEgl//CwVHlFD236I17fvmVtIwLLHW
	nctHodMOF6do44Rq+gHJ+rIm2OVyHsdB768LB1rWanU4pAHajgU8sT1LVlUn+My/Q6nwemBp9I8
	ANcSf1fG8vPW0atRiChI/zVuQDBX/lqSRGtKfbm8WcF/lXVR2q8jDxec2qPz5n2gDxuYgswq77c
	JapuUaKxisHPrIFNGeoZZKHHDki35eS1NRckPD6nk8ljXCiQekhAyjAfX9eKyAZ1fxIASWfNnmx
	GeHCS8fnxfhAwPO+eQCCifW6nPcprWBJbH9poQJXaiFUDeRgeWucgKa3t/YYA4DtWHNsR3KAd2L
	V8BPsGocef4HA==
X-Received: by 2002:a5d:5d10:0:b0:462:4b98:3c83 with SMTP id ffacd0b85a97d-4656f4704a9mr4518423f8f.23.1781884528364;
        Fri, 19 Jun 2026 08:55:28 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-466643f563dsm49973f8f.3.2026.06.19.08.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:55:27 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/13] iio: magnetometer: hmc5843: Simplify device abstraction
Date: Fri, 19 Jun 2026 17:54:36 +0200
Message-ID:  <e5cf8297220b8d560854f6c64e80f00c4d093593.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=27dzNMNZQnxdSDnKXyGDYnEZfoL61bCTuPKi0nZZwDk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqNWZJCVh+EQ7wWRpdJOw3RnI/73iYwUn6z7unr +ltyLId1VuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajVmSQAKCRCPgPtYfRL+ TiHdCAChsDikYqNcvPQC8kOw9u+crijJX3Q8NhM94ae/728Hqt8L5DI45INKmJQJA9+iNwE2Yws rYLGoYrzOPE1bHlQEUlIOzJTKiC+fYN+K5A04HqOswoSZ/86n7QQZFgPTvWG/jTScvbd11bNQlj izutYTRo01JCHVSUE6lbb/Qv+29HvrpkIeIcuAfG/1pCuNaaGNZZau1coq0+ecb83XYQkn/gV8u FJe7N/9NXl1zWofBVi3Gq5F+XggxuxJ/0lOqdfgkTsUsjWZTzmFJKjemM9EReNtQN2PPMTBy8LX OHGCwVIwrNkWrMT74Px0Jv7s4IyXCWvANX3gGral9a+VxVfU
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver supports a single chip variant only. Simplify the driver by
hard-coding the device properties instead of using the id_table's
abstraction for a single chip type and a lookup in a table with only one
entry.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/magnetometer/hmc5843_spi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
index 6a55c1559b0d..29dee5dce2ae 100644
--- a/drivers/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/iio/magnetometer/hmc5843_spi.c
@@ -56,7 +56,6 @@ static int hmc5843_spi_probe(struct spi_device *spi)
 {
 	int ret;
 	struct regmap *regmap;
-	const struct spi_device_id *id = spi_get_device_id(spi);
 
 	spi->mode = SPI_MODE_3;
 	spi->max_speed_hz = 8000000;
@@ -69,8 +68,7 @@ static int hmc5843_spi_probe(struct spi_device *spi)
 		return PTR_ERR(regmap);
 
 	return hmc5843_common_probe(&spi->dev,
-			regmap,
-			id->driver_data, id->name);
+			regmap, HMC5983_ID, "hmc5983");
 }
 
 static void hmc5843_spi_remove(struct spi_device *spi)
@@ -79,7 +77,7 @@ static void hmc5843_spi_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id hmc5843_id[] = {
-	{ "hmc5983", HMC5983_ID },
+	{ .name = "hmc5983" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, hmc5843_id);
-- 
2.47.3

