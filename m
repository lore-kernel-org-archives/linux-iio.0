Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF33F7E63
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042675; cv=none; b=a10XZ7SrlBGk4BGGreXcH2koJ4yq71FiiKay42B/SOW9Qh28r0wI1Cw0EWvtSJ+EMkkQcfz6uzFDgp6yBEZb0GD+YVzXIo56lNZNy75bfeJGTKl2Fq7LjQj3NRaEMvh6NjoIwCugKyFGk/IN7GNcOMVadlBMdM3QkNnCBnB4pkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042675; c=relaxed/simple;
	bh=3IjlnXsQWM7Aj87wzBBDGiJHN8ZzSaBFZTOLaBH9gj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IzIMABw+aR00chUxk+0ioqYNGtM6E+/NsfJSiLBCb+lhN8zaoFseCBZ72cCIcYwnS9drXMp1AboIsts6fuv3t8n7g1ZCkyVE06sHClkRIZ+R2jitI23l1UP+ntc1larcXPsqmxY49OEqyputX7Sr4mwuUfa/YAockM6CNEBy1/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayMMnfTH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayMMnfTH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48541edecf9so81150685e9.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 04:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775042672; x=1775647472; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVZxzasvJgXpw52P6Yruea8GpgUI8zXUa3GTgD1XQVo=;
        b=ayMMnfTH0FmCGnzWHnQw5S6teixojaJqr4L10ohMe453u2GAO2l2V+gV4ZdS5BH7MH
         nAIQ9H1BS7tOztHmMoPLE07WouC5/wvJ/gGBcyGywMRS0MgkgWchctLFp6u8WrdfTlJ/
         XY63Jy2OcbAJh5NPyoJFOMBypdBcytafrr/sS8Fz4D+tQZ63e1t0zko3cM7ism8zCtlc
         9GxEBIBgPXziNIk8E/DRBHur+ffDsCdrcy4dPfgX0w8mAt8ULVE4Zle4sDGM+W4OoKy/
         nyhnlbHMNsC/LJ5wgUyClrt1BQpJp3R+CIJivAsSTtjR3jPQtyUletwjp8vb5R4iRQCF
         RfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775042672; x=1775647472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FVZxzasvJgXpw52P6Yruea8GpgUI8zXUa3GTgD1XQVo=;
        b=pqLzcoD6xIqhCVG0AgcZhLg3vtmrAvcVpJoFXLQUCd3WXmlJPWqrYKJHK7KGW8Xta8
         5Dg6Cmg66mMObZ1wTFEps7oK87viDxN0LxJz7NZdOIxBYTitcNHRHPcB6csEjCVhb3SK
         BfTSGHLZ4p67kWMCJxisRvGLlFjZkvDiJjg+DexgoNpoC3/GaiHFJ4z6+I8d2ZyPAbgX
         Mz0FTI1J3dIZTIesLEoag3Xm3SgU0/46qKILNnNpLscw2kO3To5tZllG6u0UrLmWyupU
         Ig1LibYRrchgSxKX+vKrjAnueEwN54yEKXvNhH7S/rlg3Jxfr0TMeGqNqOouv7ihj0/R
         EI9A==
X-Gm-Message-State: AOJu0Yx3+KRuuBXyM6fHm0aC+rImYQ+yoSDRaDrLLrnf0NkfOCn7f8nh
	uEN4EeHALV7FHmW5pJZA9/MKptpnGdng7tfdYVARKRbkrLS5HkbwqmEl
X-Gm-Gg: ATEYQzyz2Qoq3LiFueNFsQgsXhIAE/PWl+lynwqs3xGnT3tLF++NqxMc3Tp1vzRMcoT
	1Z1LtcfGoNUhmV5ax6vq3yWmjLrZKKBxBRfC8pULbv0wA4kvbuyQ5Sy2sGb217sPDuxH1CPrXth
	ElvKeAvVnl84uBOqel/Xwb2/biAcB4Ig87Hsfp4wHENeC5odCUZIHwZqfdEi5ifKnUmRqCOo9LQ
	qlbrgsuLT2tgx/UCE2j2VTk7t/OgRlTORvH5zwwfZKEmH5APm49TyxLUrYcBESZSUyJQ/kvvumV
	uruQBRvrsh8hxiM1x+wIn81CxUB30zN+CvYUHC5A8iEG2U5+98FOXXe59TuTusxtR87Dxm92Inq
	FnG4/qN5jIv27AVqJ0BGIwnq55vqoexut0X0fpO2W07cFZJslrPlmb3WECS0/nFqfrzOxuMsTXW
	2geGV9lHD3mqv2MxPwqaEzeQ==
X-Received: by 2002:a05:600c:858e:b0:485:3ee1:eba5 with SMTP id 5b1f17b1804b1-488835ccc9dmr43122425e9.27.1775042671874;
        Wed, 01 Apr 2026 04:24:31 -0700 (PDT)
Received: from [127.0.0.1] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887aacb99csm43450165e9.1.2026.04.01.04.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 04:24:31 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Wed, 01 Apr 2026 14:22:36 +0300
Subject: [PATCH 1/3] iio: light: vcnl4000: validate device by prod ID
 instead of table ID
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-vcnl4000-drop-enum-v1-1-ffd201f0c848@gmail.com>
References: <20260401-vcnl4000-drop-enum-v1-0-ffd201f0c848@gmail.com>
In-Reply-To: <20260401-vcnl4000-drop-enum-v1-0-ffd201f0c848@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

Add a new field for vcnl4000_chip_spec and check if we have the right
device by that instead of the index from enum table. This leaves the
enum table being used only for picking the right vcnl4000_chip_spec,
allowing us to drop it later on.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 9650dbc41f2b..72d68d54864e 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -234,6 +234,7 @@ struct vcnl4000_chip_spec {
 	const int(*als_it_times)[][2];
 	const int num_als_it_times;
 	const unsigned int ulux_step;
+	const int prod_id;
 };
 
 static const struct i2c_device_id vcnl4000_id[] = {
@@ -265,12 +266,12 @@ static int vcnl4000_init(struct vcnl4000_data *data)
 	prod_id = ret >> 4;
 	switch (prod_id) {
 	case VCNL4000_PROD_ID:
-		if (data->id != VCNL4000)
+		if (data->chip_spec->prod_id != VCNL4000_PROD_ID)
 			dev_warn(&data->client->dev,
 					"wrong device id, use vcnl4000");
 		break;
 	case VCNL4010_PROD_ID:
-		if (data->id != VCNL4010)
+		if (data->chip_spec->prod_id != VCNL4010_PROD_ID)
 			dev_warn(&data->client->dev,
 					"wrong device id, use vcnl4010/4020");
 		break;
@@ -1901,6 +1902,7 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.int_reg = VCNL4040_INT_FLAGS,
 		.ps_it_times = &vcnl4040_ps_it_times,
 		.num_ps_it_times = ARRAY_SIZE(vcnl4040_ps_it_times),
+		.prod_id = VCNL4040_PROD_ID,
 	},
 	[VCNL4000] = {
 		.prod = "VCNL4000",
@@ -1911,6 +1913,7 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.channels = vcnl4000_channels,
 		.num_channels = ARRAY_SIZE(vcnl4000_channels),
 		.info = &vcnl4000_info,
+		.prod_id = VCNL4000_PROD_ID,
 	},
 	[VCNL4010] = {
 		.prod = "VCNL4010/4020",
@@ -1924,6 +1927,7 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.irq_thread = vcnl4010_irq_thread,
 		.trig_buffer_func = vcnl4010_trigger_handler,
 		.buffer_setup_ops = &vcnl4010_buffer_ops,
+		.prod_id = VCNL4010_PROD_ID,
 	},
 	[VCNL4040] = {
 		.prod = "VCNL4040",
@@ -1941,6 +1945,7 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.als_it_times = &vcnl4040_als_it_times,
 		.num_als_it_times = ARRAY_SIZE(vcnl4040_als_it_times),
 		.ulux_step = 100000,
+		.prod_id = VCNL4040_PROD_ID,
 	},
 	[VCNL4200] = {
 		.prod = "VCNL4200",
@@ -1958,6 +1963,7 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.als_it_times = &vcnl4200_als_it_times,
 		.num_als_it_times = ARRAY_SIZE(vcnl4200_als_it_times),
 		.ulux_step = 24000,
+		.prod_id = VCNL4200_PROD_ID,
 	},
 };
 

-- 
2.52.0

