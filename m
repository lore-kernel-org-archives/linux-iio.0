Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E8288C2D
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837720; cv=none; b=ZqzzZe0ELOVL24Sm8TzdEjk/KSmd4gBSTHbT4OOb/eRmfOlnDQ1/UWEg8BxaueIJVN7viQEZFMy2sxmI4RwJ08/0uu4eQ9swLwH6RiEEdMhXfae3cOYzY/NA+b0Xdavbka1fElmx/rztZCZ8x+bkBEVs2nTOtAbeQW92F2vQsL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837720; c=relaxed/simple;
	bh=v2rZtfsGEcqvkNleqRX3XjmSo2Lct8wNsREjYiEreN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FaDdBzl4VfQYg5ZItabwkKUrSGNqazmk9rc6Pg9xYN4vUB8PjNffLlD8mCW4ONeYrRiXfJyLPnP9y8/WXOyUPaUcSQkyf/+3S10o/S0irHhB3R1YzTXpYb4J69KU469m3htse6Je0rmeAoeDLmAzL4xcgH9ekeqGWY81O7WKQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhzgmgzY; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhzgmgzY"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6507a833e68so2337948d50.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 09:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775837718; x=1776442518; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdS8fPV/eM7tvbU7iuT8bTWahQQCYtva+pfa9FZ/WIw=;
        b=lhzgmgzY/A9HvmJaGznZK/ej1FVUiAgO5bQA6uhJCSD9943x3pKKhRakg/66gHIRaL
         4AUa2NEDyTOXSU7gcUp5etiIUfLFwnSoBSX4ZYIzQrOVNOoNYlplIxbNelxDsOpVILTX
         Ad1YZqkaFno7905TYVjP4uiGFMfEVVpoR6P5ljO5174N0xJrQaAyl3P/n3gRVAmRWGwq
         1JHlp1HCDEY88VLlaPRJ5jj6VehjfOy1MmoUnh1VjQMRPh7qYc3uNQMlrtmNN7blGsUq
         bNq7DGo9OxSQGHqsxR2/RYOApAd930TKrM5Dtg01LG28lheztpv+0+nc5msx3cG0ROmv
         fEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775837718; x=1776442518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AdS8fPV/eM7tvbU7iuT8bTWahQQCYtva+pfa9FZ/WIw=;
        b=C1/Xc3AddyNE5ZkjP5aQ6DNqlIoRo3Ad7NkHRjJHgDz20Xwjah9M/IF9NuNeQNx8me
         9d0kPdOdKUkGXJnlirVdLGXM1chGb6rjA+uFPHSVaJgd1GBPo2Rxw9SHaqboHCvqexf9
         TwbQmPDSComFE1sCIKEGctyW0ii1iEoCxJ9D6zKWhFx07K1AadAiIkpOUGFrq3miRl5a
         wRwFOpq1/Gc6KCxCCxepSuqkQheeTsJeRxSt6MrDXBqzEJj3VFa3FJyfam/dTQfO5T/8
         ogiG/5DsDk0qCvrFs8U/LZxbJgTdHUgA9609K1KqTqfZELycyXUK0ogXU1A9J3ve/SMQ
         wdHA==
X-Gm-Message-State: AOJu0Yy0GWwkE+9VTnzfULbJ8a1TOsJ8vjXEqkqbmvDoe+TPcGzK/QFZ
	0mAQUpkWSq+PZg8XG75ysnvOuXRl6EHL3577HcqbKr6iUX+EZ7d2Wfn4
X-Gm-Gg: AeBDieu3Zt5Tufv8pqLdWVmHNBcrgC4OwuCGx1ehiJn5koYlWj5eB9GnIVFKBj0Jbz7
	Hg/8TiDiyjDO8RhpvyEphHpkNctNB3ZydnyG+IdEL3vDIa+/D5mW8u/k8aUdxi8+/tB6pBQdiFF
	fy93LiriTDhatXMNohRPl8bUYSssAYUBYKv0SEm7y9VwyGsvZpH7GgLugZfQhzkPwyYD4uHcO9V
	uVYnaSbc34jRi+hc2XgX4DRVFNam8S5qJQPTYP8T3mLmSxJ1REp5Mhqo5pyl8f8TUPPCqe4QXRV
	xC5lG/fppHWe1ZShvPKd87k+yqfScrWYeo9VY+qcmQCoUP9RUUd6F8TJdEfgimxscYTIFdy148Z
	agpccMuTLBjaFygsLC3p32RP+Ym5C+69aa22t7SEFio7ji3AjTvbcaDan/GXx7bpgFC81sYGzzm
	5taa1GZWoJuWZpRR3AFwcl1qcQibQslBWKpECh
X-Received: by 2002:a05:690c:6b01:b0:79d:67bd:53f9 with SMTP id 00721157ae682-7af6ec4c6e4mr40745757b3.4.1775837718433;
        Fri, 10 Apr 2026 09:15:18 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa05b48sm15408337b3.33.2026.04.10.09.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:15:17 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Fri, 10 Apr 2026 19:11:17 +0300
Subject: [PATCH v3 1/6] iio: light: vcnl4000: validate device by prod ID
 instead of table ID
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-vcnl4000-drop-enum-v3-1-2ea2bc6f5dfb@gmail.com>
References: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
In-Reply-To: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.1

Add a new field for vcnl4000_chip_spec and check if we have the right
device by that instead of the index from enum table. This leaves the
enum table being used only for picking the right vcnl4000_chip_spec,
allowing us to drop it later on.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
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
2.53.0

