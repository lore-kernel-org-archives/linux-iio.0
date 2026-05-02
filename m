Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C62C235E
	for <linux-iio@vger.kernel.org>; Sat,  2 May 2026 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777765460; cv=none; b=PaVBrm3PKzOHPdLNxXrl8mV6cDmmzx2blP/DfqlpgNQut4jjwSQM4if6hzYysbTYhvyDS1H/WENEVuGbx+4zuTQsE6kbmUCCV0NgdYdqtaUrqWiJmH1fLB4gISvYYS3dVdmjKIvuTuss76huEgZODm3G3QUZr8R5zBtaG2BLVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777765460; c=relaxed/simple;
	bh=sQBnQu6EpskJniu0szdiVP799Z85ObXfVTeA0OKNgZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSLOQKiT1YQzRmGXew285QRZ2m0OWqjQk37oA3EH4B7XucUMW/bc0+zZx440naMItR916ptN8SbWV8uUtiWZRNyJvPiluAMae5SmOL1MkjRJsclVUN9o0h+72Jfa9iNg8wFu7dYmbTKiu9RdaE0NuAwt015cKy7FktbbXr6tYlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Vp+29zi4; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Vp+29zi4"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5751b7d147aso65497e0c.2
        for <linux-iio@vger.kernel.org>; Sat, 02 May 2026 16:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777765457; x=1778370257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMjdO2jOIeGWN+cDfB6lfXaQxs4NYX6Fy7boARX/ei0=;
        b=Vp+29zi4DUhMhfMRp/QJj0anyVjvIixjg73GCPJFkJnqehmvGl5lqwM8MjpHGyPLjx
         nTIarHvS492Mv8crX1BMtZDUCdv5u6oePPwGODMr98vskHlvbjSAPlRmnMmPR1rycOMq
         75IRTldi+OZnLg6ZV0rD4+wyXpF+PAaKWyUW/lwDUVZ5RQkh2l09w/RmCTrSTZXHGWSA
         6O9fumu4+B+fP18ARW8OPV7ZIeIiD94mdGoyY07mmnMUV2GulvxwZDbXeLp8aZPOVe5p
         spDXN9RA2M4kyB5Y4RP2gy7kjZ9omTrmoOl4NTL3u1na99SxzIVBlpos2mk4CNujF9XI
         tF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777765457; x=1778370257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oMjdO2jOIeGWN+cDfB6lfXaQxs4NYX6Fy7boARX/ei0=;
        b=rJWsdbbWGT00Wb+GLNYr1cgtL9QGew2DwtPx595QJndMLQKIuxpR94K3uMXIaeX3FM
         B/8GLQLtCoc2pIV6JB/e1JHOKizN4PycwPzvcMJrFJM8xuFYMnRe0pZElLFAzMGX/WDY
         EBXmrq0d67BBgAiB1gcXRzkeA/TeCLLSDX8tSZt1cbiFkccU0/G7Ca/pEpOJd6oeJqWa
         IW+1gx9BhsRXzIThGBXhdD/5DMcZEPc5mUv3HE6GBh/7lHAU9ouwFuok1O78TZ1pC5Ai
         A8dmy3pKXImWcu+u3YPh0Z5oNz7I+8vORzbjXZA/5xq0yaZRpIQdz44uWscqIdXRrywJ
         gPaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+b3x/phQl49tKyVDjxPmZvj62dLwzZUtQQn8naK4/De9UaHGLFGu1ajo0BCohyFIlyJP/d6YmDoY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+tVV6YXtmGKeGoOTQMYHSSqD16mFGpoCgFi6Dw91O/RnQ+k3s
	iqvYgzDd1OE1dZgCe/kRDccTN1VeDw69U/shlGsdb9HLxuifksTpq1zdBAg69kkpf6Y=
X-Gm-Gg: AeBDieuiIy/F51PBqPVZ1oFKlXDRF/S1kn/RgQYdwLu0SE4QUA6d4sBwSrrnCxc5Zov
	o8lKxzkdXQhjrAp4OQjqdLXItbo5Cu1IvOY71k3uO9kEAzaJKyEc32uTC0nupGWaygaMy7uQ/Wv
	sr3x/jyq9e2P1rxdYlAvu7CWML/Hwxis4RMreLhMJ94Bk6rUKaWfGz/gkvR4FSZ6LK5VcPUytt3
	ymzfxdKKrf/hLEGx1vM+G6wrNjNhnqF5oXfwpHGNJks8+chAk/1xR59ebQpiU229FhfL+VMRgLT
	iyFikPwZ1e00y5T8nR18QqlDL5zAOW/hZR70UHDTKP3SJOOYHNcwmoNK+hfMD44KzNNmEBsWaR/
	R/vZZGNe3Nm4+5Qsgcy58TEhDde1nD36wSjNPi9O1QldpQhVw8V+K/juk1tvypRqxPBlC/zBSW/
	OxeLG4shKFL3DU3JcREj3uMBm6DASdl1Yk47C5
X-Received: by 2002:a05:6122:1d87:b0:56f:61d8:86d7 with SMTP id 71dfb90a1353d-5750c5aedacmr1841460e0c.7.1777765457116;
        Sat, 02 May 2026 16:44:17 -0700 (PDT)
Received: from gigagabriel-PC ([177.33.85.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5749f7e9f72sm3752167e0c.3.2026.05.02.16.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 16:44:16 -0700 (PDT)
From: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	javier.carrasco.cruz@gmail.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: ricardo.kojo@ime.usp.br,
	elliancarlos@gmail.com,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 1/2] iio: light: veml6030: Remove 'x' wildcard usages in file
Date: Sat,  2 May 2026 20:41:03 -0300
Message-ID: <20260502234348.131563-2-gabrielblo@ime.usp.br>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260502234348.131563-1-gabrielblo@ime.usp.br>
References: <20260502234348.131563-1-gabrielblo@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove use of 'x' wildcard at struct veml603x_chip, as it is not
particularly future-proof. Instead, use name veml6030_chip_desc.

Signed-off-by: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
Co-developed-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
Signed-off-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
Co-developed-by: Ellian Carlos <elliancarlos@gmail.com>
Signed-off-by: Ellian Carlos <elliancarlos@gmail.com>
---
 drivers/iio/light/veml6030.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 6bcacae3863c..3d11e4736330 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -82,7 +82,7 @@ struct veml6030_rf {
 	struct regmap_field *gain;
 };
 
-struct veml603x_chip {
+struct veml6030_chip_desc {
 	const char *name;
 	const struct iio_chan_spec *channels;
 	const int num_channels;
@@ -108,7 +108,7 @@ struct veml6030_data {
 	struct i2c_client *client;
 	struct regmap *regmap;
 	struct veml6030_rf rf;
-	const struct veml603x_chip *chip;
+	const struct veml6030_chip_desc *chip;
 	struct iio_gts gts;
 
 };
@@ -1167,7 +1167,7 @@ static int veml6030_runtime_resume(struct device *dev)
 static DEFINE_RUNTIME_DEV_PM_OPS(veml6030_pm_ops, veml6030_runtime_suspend,
 				 veml6030_runtime_resume, NULL);
 
-static const struct veml603x_chip veml6030_chip = {
+static const struct veml6030_chip_desc veml6030_chip = {
 	.name = "veml6030",
 	.channels = veml6030_channels,
 	.num_channels = ARRAY_SIZE(veml6030_channels),
@@ -1178,7 +1178,7 @@ static const struct veml603x_chip veml6030_chip = {
 	.set_info = veml6030_set_info,
 };
 
-static const struct veml603x_chip veml6035_chip = {
+static const struct veml6030_chip_desc veml6035_chip = {
 	.name = "veml6035",
 	.channels = veml6030_channels,
 	.num_channels = ARRAY_SIZE(veml6030_channels),
@@ -1189,7 +1189,7 @@ static const struct veml603x_chip veml6035_chip = {
 	.set_info = veml6030_set_info,
 };
 
-static const struct veml603x_chip veml7700_chip = {
+static const struct veml6030_chip_desc veml7700_chip = {
 	.name = "veml7700",
 	.channels = veml7700_channels,
 	.num_channels = ARRAY_SIZE(veml7700_channels),
-- 
2.54.0

