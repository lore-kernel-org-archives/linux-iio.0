Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56EC39183A
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789289648; cv=none; b=YdpvBqEAK8jy96fAECo8s/t0kSr05gf17E1+Oz6qix9v5zqdEnrHrakhlrsQGkz9+BhsTAqJPKF9AA+OnjQVC1uAm+hD+oD5CM9cTzPw39veP+wtdpTRdgbppQ6PpcCEO37MdWJhNflNdZ/y6wcHLofrWKoUAVkJQ2N8JOhUEJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789289648; c=relaxed/simple;
	bh=VPxwzLREslsbpmwkvkwJ+oSeDvr9GufTBU2tE5gVVLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPeODKGXp7JNTrNeNunxXGYTReigPjrOFOb7Nw6sg0+dtc1AjNblTUceon4w8B0mFlVTmMnhDR/lfQfzj1F8gcZElhaBYJy0bjilPA9qYZL7v8eSMnRff8u+Lf4LKFtdsgL/mmVt9sKQdrFcsEpOwlY4E+LE7Gt1jaVW3FgZSPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfqI2g9a; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfqI2g9a"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48351e5bb47so816196f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789289645; x=1789894445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g0OWEY6i3wEnrwVt7jMGeVNMMCw4YyaXULhY7agaqrk=;
        b=UfqI2g9alEhAILu3oYXOPxzP6Qh1slYg3BN+rgTLWWHEQhlNtXjaQIyGsB6I2oHpao
         a1GwGSAXSU4JTyJ4pWtq7NyGGg7vHo2PnohgWn45iTY0y//9b9mlZBsc+g61v1yVf+5Z
         9oiH5JWzY1Jmj4QzqEQeZBanNF9uZ5y54JKHF4saX3FLyPveE5fbRTWDPHvN6oHg/a39
         iqEZO7QPvVoW4bGoD4whv+WwgS9veb4CTrtumWic8JIEENROnw4cDp15uFhRSuH2kSB7
         YyXTl4HnV16QPMZdNpVmNF2lkUtcZ2TLUUAuPlqK2u0uNIkxSXS9GHDn1YWL4IyGa44J
         SjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789289645; x=1789894445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g0OWEY6i3wEnrwVt7jMGeVNMMCw4YyaXULhY7agaqrk=;
        b=WmniX9ZpalNMtqb/8ObPMgQ1S8zYoE2/P9N6qlWv73qC5NkEVKriq3RQnHAVksBlGd
         CkL4OhSDfG+qqaPLtZ8iRY1lSZiafpKF/Det07BqENJ/xeth81jPIabObghxrQZzvVEY
         DsWGiROqVNGt87ZuKfTjvrE36dIKREwYoXUEdKvmAYCW6nzBILHKUKwZ68RULr5mZAqp
         oo9eMvJw+XN3Pa6yyr1vV2JUjAh9Cl4OHeM/rZyR2c6oSm6Cp3azKGgQa79aaOSdn4nn
         EkvFaH4Em7Om55d1T16A/Z1oF67fGr09JTJAeUuoxUdwq0EBXzZl+AdxHr+MuvIo1VTV
         4Fyg==
X-Forwarded-Encrypted: i=1; AKwUvBw23GZ23iMLY6hS9ys5xPXQrurGNXE9N2AYLOSBTTs1xSicvsrZKxIciFoKtpL5eompNQvYR4fM/sA=@vger.kernel.org
X-Gm-Message-State: AFuF++kBsUTmpRzINYzyMIea1uG6gaVtmaLqqaJoV1kw0qC7Gj/R0+EQ
	lDYyA2CUGZD6fl62TSNAGFIs1twClGahdT/TFPS8qj+htolpUhuqkcov
X-Gm-Gg: AYBFou0+Lr1ByxBJha2QgNO/76VVhAPRUSmLZqUn9yyU3WJ7bxD03lrnpy3aLTH3H9W
	VMXpviK6VbSpaCLbBD33y/vKryz1kteClF8wWJ6TobkSAMpCtXUSvVTXjgC0vMI0xPIKO19n5WZ
	4jWB0hiLGnoFmVvOqR1fvrKxew+RrBbY5F2JDSvczwekUr96vHFdTIFGqX3axqAhFGAbCMlEi6I
	2YDc88ZmSuEK07QCei4UVW652VRenjROZwiXNP2dgJxCmx+R5eCYMeE7fyCZkjjJkYazcg/YnN6
	S5LeXtMh3JhOFFBOdQAhpypq3jAG5HHb19sZ2ZctbAgf1xPeZQkSR1o1X1JT24MXz8PXUfcznoL
	nHKOAWCoN6et0dKCBPMAMS9iNQ0e2M3BvFZ9p/j6G4NtvvxHTUN+Lj5eGykGdXD8K2hs1SmkvfW
	YSKk7gXyhrcyxW17cu6XLzfCwTJjtQ4PLkwc8k7iD9hsSzh3pAn6x0E1ni45xXzn76mek04kjI0
	NT1ceRYmfTWwNrrGyE=
X-Received: by 2002:a5d:630b:0:b0:484:3604:c7bd with SMTP id ffacd0b85a97d-486eb31c4d4mr19672165f8f.17.1789289644914;
        Sun, 13 Sep 2026 01:54:04 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e7f5sm18228489f8f.9.2026.09.13.01.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 01:54:04 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org,
	Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: [PATCH v2 4/6] iio: accel: adis16201: add ADIS16203 support
Date: Sun, 13 Sep 2026 13:53:05 +0500
Message-ID: <20260913085307.13846-5-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913085307.13846-1-shehryar.amd@gmail.com>
References: <20260913085307.13846-1-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ADIS16203 from staging to mainline ADIS16201. ADIS16203 shares same
SPI protocol and register addresses. Differing parameters are handled by
adis16201_chip_info structure.

ADIS16203 specific support includes DIAG_STAT_SELFTEST_FAIL_BIT, which
is supported only on ADIS16203, and a separate channel array.

Kconfig is updated accordingly.

Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
---
 drivers/iio/accel/Kconfig     |  6 +++---
 drivers/iio/accel/adis16201.c | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 4094299e2..f884ec66f 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -7,13 +7,13 @@
 menu "Accelerometers"
 
 config ADIS16201
-	tristate "Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer"
+	tristate "ADIS16201 Digital Inclinometer and similar"
 	depends on SPI
 	select IIO_ADIS_LIB
 	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
 	help
-	  Say Y here to build support for Analog Devices adis16201 dual-axis
-	  digital inclinometer and accelerometer.
+	  Say Y here to build support for Analog Devices adis16201 Digital
+	  Inclinometer and similar
 
 	  To compile this driver as a module, say M here: the module will
 	  be called adis16201.
diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index e0bf7df50..8e8e612fd 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
+ * ADIS16201 Digital Inclinometer and similar
  *
  * Copyright 2010 Analog Devices Inc.
  */
@@ -63,6 +63,7 @@
 #define ADIS16201_DIAG_STAT_REG				0x3C
 #define  ADIS16201_DIAG_STAT_ALARM2			BIT(9)
 #define  ADIS16201_DIAG_STAT_ALARM1			BIT(8)
+#define ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT		5	/* ADIS16203 only */
 #define  ADIS16201_DIAG_STAT_SPI_FAIL_BIT		3
 #define  ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT		2
 /* Power supply above 3.625 V */
@@ -232,6 +233,15 @@ static const struct iio_chan_spec adis16201_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
+static const struct iio_chan_spec adis16203_channels[] = {
+	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
+	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
+	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
+	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+	IIO_CHAN_SOFT_TIMESTAMP(7),
+};
+
 static const struct adis16201_chip_info adis16201_chip_data = {
 	.arr_channels = adis16201_channels,
 	.incli_scale_val2 = 100000,
@@ -246,6 +256,21 @@ static const struct adis16201_chip_info adis16201_chip_data = {
 	.name = "adis16201",
 };
 
+static const struct adis16201_chip_info adis16203_chip_data = {
+	.arr_channels = adis16203_channels,
+	.incli_scale_val2 = 25000,
+	.write_mask_incli = GENMASK(13, 0),
+	.diag_stat_mask =
+		BIT(ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT) |
+		BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
+		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
+		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
+		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
+	.read_bits_incli = 14,
+	.num_channels = ARRAY_SIZE(adis16203_channels),
+	.name = "adis16203",
+};
+
 static const struct iio_info adis16201_info = {
 	.read_raw = adis16201_read_raw,
 	.write_raw = adis16201_write_raw,
@@ -253,6 +278,7 @@ static const struct iio_info adis16201_info = {
 };
 
 static const char * const adis16201_status_error_msgs[] = {
+	[ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
 	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
 	[ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
 	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
@@ -322,6 +348,7 @@ static int adis16201_probe(struct spi_device *spi)
 
 static const struct of_device_id adis16201_of_match[] = {
 	{ .compatible = "adi,adis16201", .data = &adis16201_chip_data },
+	{ .compatible = "adi,adis16203", .data = &adis16203_chip_data },
 	{ },
 };
 
@@ -329,6 +356,7 @@ MODULE_DEVICE_TABLE(of, adis16201_of_match);
 
 static const struct spi_device_id adis16201_ids[] = {
 	{ .name = "adis16201", .driver_data = (kernel_ulong_t)&adis16201_chip_data },
+	{ .name = "adis16203", .driver_data = (kernel_ulong_t)&adis16203_chip_data },
 	{ },
 };
 
@@ -345,6 +373,6 @@ static struct spi_driver adis16201_driver = {
 module_spi_driver(adis16201_driver);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
+MODULE_DESCRIPTION("Analog Devices ADIS16201 Inclinometer and similar");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("IIO_ADISLIB");
-- 
2.43.0

