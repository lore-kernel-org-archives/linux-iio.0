Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1B2D6E7E
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772920493; cv=none; b=dKLk3MZWOK9KL/AhI3vNu6ukAFZ07Oss/dCutfG9KzFjhc+TLNw9sM/UhGkIYjaLBYkk4MTJ91puP4ERehFKjhmphQsNoiMHVib3fhd/lZnLf9P4klMxUdxQgwes4vw4LtGMWyYN64KLJwWmkDEjBd411XOBSAGycTz/Dpkfxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772920493; c=relaxed/simple;
	bh=7W9Htn6SI5xO9kM5YPkmn3IM2laxLQhcsmV2bklo1CM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T6kctlYkRhPQ0RpqrSQPMYE/pRgTTo4WAnb+EorS1EEHfFSxMGXRIE5RZ7MwD/iv3z9eOhCdrLCptQzM4+iUoZh49XimxLLI/al4x/7mZFVD0M2oIsZxPrxcIf/wbAW8v3Vxaw8jqjCDCt1I4CFIrgpj03XrGOvQGq7TU9EnkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CctfMs0h; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CctfMs0h"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4043b909ed4so3817483fac.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 13:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772920489; x=1773525289; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Qy+ZGVfT393GLsoVsZBttTtwfSVBX+SuLwdTCMd3QM=;
        b=CctfMs0hEQPsUk7USjh6/XGK3OenXa/zECsKvd8zeVOHNK6TwfBOi0dDmmXDPQpAll
         yBSLVBE1mxy4GmB4a0Hz4igXyWwPNdVybaKzteou5MaiRWylVGr7S59zzoDQvdE//g10
         C3/hqAvUPiUnFqkJ/t+ht1nbKwG5L9EOQnR3shl6Dwift27KXXTGBQJauDZAi7S2kvIU
         Ff/5e1/Za9mFvO8CgTdLaY3QTIMWnMQPawNp9AiEQs8GK/ze0KFGHooh9wNL0GsbVXCi
         eQXDnyvtlU9ClFmneRndRguYyxRyHtxJP24/oArSYlI8Rf1rWT69y1RliIRUGVHbEeMv
         iIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772920489; x=1773525289;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Qy+ZGVfT393GLsoVsZBttTtwfSVBX+SuLwdTCMd3QM=;
        b=ijp9+mJkK8pe6jQ6T1XkhRyFsXtzh4UU6jQp97rIYEuN6XbtSc5neBGeerEgMLPKRN
         fi0UvYYvpGpqS4FSs7jWARFGCaxU3cu85mhFGJT6z6d/RnuuaUi6rWkoxAqG3YepVYIX
         49AEJ/KwnhKCtmFYE48DbczB5auYxnfxjR0aY2CY0SFEKbzW3BYDu74tcX8qgxtgoFP7
         avgNmJ00SKjl4XPByd5aHv75cQ4gAznbw4ebd7hVxY5Uq0oF+wo3sr63c6gQGzpPkdNu
         r9Dd9DFiQ6G/STAckP8lrtJHjrkR08HwEbDfkFR4mNJUFKMYeoSD5yTcB9iYDCLpO5fM
         2VdQ==
X-Gm-Message-State: AOJu0Yws56OPFc2jq9TFdkV2NexvUrAgOZq3GjeV0Fg727ZjJ1P5WTTV
	XkPkIsyxkSbPo/t+EALAK6Wkq1PdcHusLS+ILWQgDO9rLjjnoOTavNCNoa6uDoITZd4=
X-Gm-Gg: ATEYQzxOSoIVXODYA3SFoxIl7IBzUgyjqezNhK55IrKkTR4LVNZCykTR/jB8ajGkFuQ
	BSGBZkDjss5oUb01a+dviQ38+JjbwKqPXNimghzIJB6LZsabeaEOP+Yycob5wsYIhAlxFJhGB6K
	H4UtgsFvKCaYCPw5hK/V9lYlGrkOaUa0w/823CiIgrayC1zrcEXAURZ4z0Ahz03Z0KO/rq/EMDV
	xwxrY1jPbyZo9bxpXI+IUO+7t4+hYygfNNU/yDusZyUg7vtGbiD3xRxnBbpzjVi9LqBCYtq0Lty
	dIFx4Z5SipS57DeIaP4exr5Rs5Ef9E/TUGvMXh1PzhgLaH2vdqLkmC+gpIYBoOe2TJeHD6jZhDV
	FHitzKmUrvbsRCBVaFM939BOLMyz34G9YH1ikJugADQ40bPfSLUylLFm/V/2D668yWe+ComjJZ9
	a9QK8Y36P5oVRomAP3YZu8kwLZf2br
X-Received: by 2002:a05:6870:b4ac:b0:3eb:7a44:744c with SMTP id 586e51a60fabf-416e3fa32c5mr3874633fac.21.1772920489077;
        Sat, 07 Mar 2026 13:54:49 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e6560e20sm4764219fac.4.2026.03.07.13.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 13:54:47 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 07 Mar 2026 15:54:37 -0600
Subject: [PATCH] iio: adc: ti-ads7950: remove chip_info[]
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-iio-adc-ti-ads7950-no-info-array-v1-1-457f9dc64840@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQ7CMAwEv1L5jKWQNkThK4hDmjpgDgmKWwSq+
 vcaOK1mDzMrCDUmgXO3QqMXC9eicDx0kO6x3Ah5UgZr7Mn0xiNzxTglnFlHfHAGS0UuWe/W4ge
 Dy/0YfHSDTaCaZ6PM71/icv2zLOOD0vz1wrbtYsh6SYQAAAA=
X-Change-ID: 20260307-iio-adc-ti-ads7950-no-info-array-95f3b97a542c
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8599; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=7W9Htn6SI5xO9kM5YPkmn3IM2laxLQhcsmV2bklo1CM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBprJ6fmTQel0v+bC26asG91rXAbv3qQjM1350fM
 bOdfE2HDeyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaayenwAKCRDCzCAB/wGP
 wJ1bB/9eUnYPZQ2PtQEIvISIaxKht45NzQPaGTPzSNT73PjcClV5XtDCDMYbyUCj5q7fJOlSMsl
 AAHcj/fAKI/ANbr5IMqXySTqx99olw0s4pO794N2AimyXfHvTBx4+do5deHwmr5bnLnIFgAbVrc
 nwE2+wjme8FuIV6XKXUnimD1sL4UFg7Hez87T58G1eGFm20wLcsiKWOkJYVXr9BOJzW2l84BlvH
 Z72mBITMXVh+Cr+DQX4PRzO+wEgbgI1QINxdq448EcegDSXa/arp7L30GPv9D85oMepiyfHyyg9
 x6GM8xpR5IX2+Q8tooPJHoVftMPnMo9FnpRsNSXqxM9DPfvH
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove the chip_info[] array and related enum used for looking up chip-
specific information. Instead, use individual structs directly in the
module device tables.

Also update to use spi_get_device_match_data() in case the devicetree
table is ever used instead of the SPI device ID table.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Tested on LEGO MINDSTORMS EV3.

This will probably have some fuzz when applying on top of some of the
other patches for this driver currently in flight, but I don't think
anything that will require a manual intervention.

To be safe though, we can hold off on applying this until the other
patches have landed.
---
 drivers/iio/adc/ti-ads7950.c | 172 +++++++++++++++++++++----------------------
 1 file changed, 83 insertions(+), 89 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index bbe1ce577789..fa3b446495ec 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -118,21 +118,6 @@ struct ti_ads7950_chip_info {
 	unsigned int num_channels;
 };
 
-enum ti_ads7950_id {
-	TI_ADS7950,
-	TI_ADS7951,
-	TI_ADS7952,
-	TI_ADS7953,
-	TI_ADS7954,
-	TI_ADS7955,
-	TI_ADS7956,
-	TI_ADS7957,
-	TI_ADS7958,
-	TI_ADS7959,
-	TI_ADS7960,
-	TI_ADS7961,
-};
-
 #define TI_ADS7950_V_CHAN(index, bits)				\
 {								\
 	.type = IIO_VOLTAGE,					\
@@ -225,55 +210,64 @@ static DECLARE_TI_ADS7950_8_CHANNELS(ti_ads7959, 8);
 static DECLARE_TI_ADS7950_12_CHANNELS(ti_ads7960, 8);
 static DECLARE_TI_ADS7950_16_CHANNELS(ti_ads7961, 8);
 
-static const struct ti_ads7950_chip_info ti_ads7950_chip_info[] = {
-	[TI_ADS7950] = {
-		.channels	= ti_ads7950_channels,
-		.num_channels	= ARRAY_SIZE(ti_ads7950_channels),
-	},
-	[TI_ADS7951] = {
-		.channels	= ti_ads7951_channels,
-		.num_channels	= ARRAY_SIZE(ti_ads7951_channels),
-	},
-	[TI_ADS7952] = {
-		.channels	= ti_ads7952_channels,
-		.num_channels	= ARRAY_SIZE(ti_ads7952_channels),
-	},
-	[TI_ADS7953] = {
-		.channels	= ti_ads7953_channels,
-		.num_channels	= ARRAY_SIZE(ti_ads7953_channels),
-	},
-	[TI_ADS7954] = {
-		.channels	= ti_ads7954_channels,
-		.num_channels	= ARRAY_SIZE(ti_ads7954_channels),
-	},
-	[TI_ADS7955] = {
-		.channels	= ti_ads7955_channels,
-		.num_channels	= ARRAY_SIZE(ti_ads7955_channels),
-	},
-	[TI_ADS7956] = {
-		.channels	= ti_ads7956_channels,
-		.num_channels	= ARRAY_SIZE(ti_ads7956_channels),
-	},
-	[TI_ADS7957] = {
-		.channels	= ti_ads7957_channels,
-		.num_channels	= ARRAY_SIZE(ti_ads7957_channels),
-	},
-	[TI_ADS7958] = {
-		.channels	= ti_ads7958_channels,
-		.num_channels	= ARRAY_SIZE(ti_ads7958_channels),
-	},
-	[TI_ADS7959] = {
-		.channels	= ti_ads7959_channels,
-		.num_channels	= ARRAY_SIZE(ti_ads7959_channels),
-	},
-	[TI_ADS7960] = {
-		.channels	= ti_ads7960_channels,
-		.num_channels	= ARRAY_SIZE(ti_ads7960_channels),
-	},
-	[TI_ADS7961] = {
-		.channels	= ti_ads7961_channels,
-		.num_channels	= ARRAY_SIZE(ti_ads7961_channels),
-	},
+static const struct ti_ads7950_chip_info ti_ads7950_chip_info = {
+	.channels	= ti_ads7950_channels,
+	.num_channels	= ARRAY_SIZE(ti_ads7950_channels),
+};
+
+static const struct ti_ads7950_chip_info ti_ads7951_chip_info = {
+	.channels	= ti_ads7951_channels,
+	.num_channels	= ARRAY_SIZE(ti_ads7951_channels),
+};
+
+static const struct ti_ads7950_chip_info ti_ads7952_chip_info = {
+	.channels	= ti_ads7952_channels,
+	.num_channels	= ARRAY_SIZE(ti_ads7952_channels),
+};
+
+static const struct ti_ads7950_chip_info ti_ads7953_chip_info = {
+	.channels	= ti_ads7953_channels,
+	.num_channels	= ARRAY_SIZE(ti_ads7953_channels),
+};
+
+static const struct ti_ads7950_chip_info ti_ads7954_chip_info = {
+	.channels	= ti_ads7954_channels,
+	.num_channels	= ARRAY_SIZE(ti_ads7954_channels),
+};
+
+static const struct ti_ads7950_chip_info ti_ads7955_chip_info = {
+	.channels	= ti_ads7955_channels,
+	.num_channels	= ARRAY_SIZE(ti_ads7955_channels),
+};
+
+static const struct ti_ads7950_chip_info ti_ads7956_chip_info = {
+	.channels	= ti_ads7956_channels,
+	.num_channels	= ARRAY_SIZE(ti_ads7956_channels),
+};
+
+static const struct ti_ads7950_chip_info ti_ads7957_chip_info = {
+	.channels	= ti_ads7957_channels,
+	.num_channels	= ARRAY_SIZE(ti_ads7957_channels),
+};
+
+static const struct ti_ads7950_chip_info ti_ads7958_chip_info = {
+	.channels	= ti_ads7958_channels,
+	.num_channels	= ARRAY_SIZE(ti_ads7958_channels),
+};
+
+static const struct ti_ads7950_chip_info ti_ads7959_chip_info = {
+	.channels	= ti_ads7959_channels,
+	.num_channels	= ARRAY_SIZE(ti_ads7959_channels),
+};
+
+static const struct ti_ads7950_chip_info ti_ads7960_chip_info = {
+	.channels	= ti_ads7960_channels,
+	.num_channels	= ARRAY_SIZE(ti_ads7960_channels),
+};
+
+static const struct ti_ads7950_chip_info ti_ads7961_chip_info = {
+	.channels	= ti_ads7961_channels,
+	.num_channels	= ARRAY_SIZE(ti_ads7961_channels),
 };
 
 /*
@@ -561,7 +555,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
 
 	st->spi = spi;
 
-	info = &ti_ads7950_chip_info[spi_get_device_id(spi)->driver_data];
+	info = spi_get_device_match_data(spi);
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -683,35 +677,35 @@ static void ti_ads7950_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id ti_ads7950_id[] = {
-	{ "ads7950", TI_ADS7950 },
-	{ "ads7951", TI_ADS7951 },
-	{ "ads7952", TI_ADS7952 },
-	{ "ads7953", TI_ADS7953 },
-	{ "ads7954", TI_ADS7954 },
-	{ "ads7955", TI_ADS7955 },
-	{ "ads7956", TI_ADS7956 },
-	{ "ads7957", TI_ADS7957 },
-	{ "ads7958", TI_ADS7958 },
-	{ "ads7959", TI_ADS7959 },
-	{ "ads7960", TI_ADS7960 },
-	{ "ads7961", TI_ADS7961 },
+	{ "ads7950", (kernel_ulong_t)&ti_ads7950_chip_info },
+	{ "ads7951", (kernel_ulong_t)&ti_ads7951_chip_info },
+	{ "ads7952", (kernel_ulong_t)&ti_ads7952_chip_info },
+	{ "ads7953", (kernel_ulong_t)&ti_ads7953_chip_info },
+	{ "ads7954", (kernel_ulong_t)&ti_ads7954_chip_info },
+	{ "ads7955", (kernel_ulong_t)&ti_ads7955_chip_info },
+	{ "ads7956", (kernel_ulong_t)&ti_ads7956_chip_info },
+	{ "ads7957", (kernel_ulong_t)&ti_ads7957_chip_info },
+	{ "ads7958", (kernel_ulong_t)&ti_ads7958_chip_info },
+	{ "ads7959", (kernel_ulong_t)&ti_ads7959_chip_info },
+	{ "ads7960", (kernel_ulong_t)&ti_ads7960_chip_info },
+	{ "ads7961", (kernel_ulong_t)&ti_ads7961_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ti_ads7950_id);
 
 static const struct of_device_id ads7950_of_table[] = {
-	{ .compatible = "ti,ads7950", .data = &ti_ads7950_chip_info[TI_ADS7950] },
-	{ .compatible = "ti,ads7951", .data = &ti_ads7950_chip_info[TI_ADS7951] },
-	{ .compatible = "ti,ads7952", .data = &ti_ads7950_chip_info[TI_ADS7952] },
-	{ .compatible = "ti,ads7953", .data = &ti_ads7950_chip_info[TI_ADS7953] },
-	{ .compatible = "ti,ads7954", .data = &ti_ads7950_chip_info[TI_ADS7954] },
-	{ .compatible = "ti,ads7955", .data = &ti_ads7950_chip_info[TI_ADS7955] },
-	{ .compatible = "ti,ads7956", .data = &ti_ads7950_chip_info[TI_ADS7956] },
-	{ .compatible = "ti,ads7957", .data = &ti_ads7950_chip_info[TI_ADS7957] },
-	{ .compatible = "ti,ads7958", .data = &ti_ads7950_chip_info[TI_ADS7958] },
-	{ .compatible = "ti,ads7959", .data = &ti_ads7950_chip_info[TI_ADS7959] },
-	{ .compatible = "ti,ads7960", .data = &ti_ads7950_chip_info[TI_ADS7960] },
-	{ .compatible = "ti,ads7961", .data = &ti_ads7950_chip_info[TI_ADS7961] },
+	{ .compatible = "ti,ads7950", .data = &ti_ads7950_chip_info },
+	{ .compatible = "ti,ads7951", .data = &ti_ads7951_chip_info },
+	{ .compatible = "ti,ads7952", .data = &ti_ads7952_chip_info },
+	{ .compatible = "ti,ads7953", .data = &ti_ads7953_chip_info },
+	{ .compatible = "ti,ads7954", .data = &ti_ads7954_chip_info },
+	{ .compatible = "ti,ads7955", .data = &ti_ads7955_chip_info },
+	{ .compatible = "ti,ads7956", .data = &ti_ads7956_chip_info },
+	{ .compatible = "ti,ads7957", .data = &ti_ads7957_chip_info },
+	{ .compatible = "ti,ads7958", .data = &ti_ads7958_chip_info },
+	{ .compatible = "ti,ads7959", .data = &ti_ads7959_chip_info },
+	{ .compatible = "ti,ads7960", .data = &ti_ads7960_chip_info },
+	{ .compatible = "ti,ads7961", .data = &ti_ads7961_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ads7950_of_table);

---
base-commit: 6f25a6105c41a7d6b12986dbe80ded396a5667f8
change-id: 20260307-iio-adc-ti-ads7950-no-info-array-95f3b97a542c

Best regards,
--  
David Lechner <dlechner@baylibre.com>

