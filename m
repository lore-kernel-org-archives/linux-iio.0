Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42039B4AE
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789289644; cv=none; b=YVgtxr5UrxzNLoxFImIXrl9Gq+f2Ar3GXdjjviiFZjgIQ1orqPyzvcRUCXzolTXxwhzLSxOCfI1SDMCsQk5i1elyn1AygiYn9nAA6uS+MpQcZzx2skr+MwqX+S0uTzUiOthvCqSST4TH1wmnlliDwwO8g/uo58H7idVz5P2FV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789289644; c=relaxed/simple;
	bh=4qNDIkx2Z+sd0cRmZWMv6HPT0dpHS/9jEtFdCIxz8JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVgMZsA9UlqscBXgE58Qivy7mkO060R3SIRLcAQvf5sUP4ZJQEzODw+reNeDx+3QBKdMJQL0XHhkpzyrW/Idb+q1TPaCwWVMrM4KVhOia7yWsIr+coIZeU5APyDRKulJSJcSIH9fb7t/Ga1q/+ah4UvND43TOGrDM5d8Zf84+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeeS487U; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeeS487U"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so6856845e9.1
        for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789289641; x=1789894441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cr6uYpQbF5rfyq1VxaZzsHsqaGvyw37xfoh8fFiyzec=;
        b=oeeS487UJH92Uph2l1U4Yd+cW6rFONTws2qqezh5OwEkUa7+qlmRJGwHx4Eib3FhRV
         JikIFkUmczXYUbsPFIZWt9CeHHzuZph8eNwaHImUq+6oJaPacTVzLqXSpcnZOrzHWf2t
         E/U6tXXbv71bVbFX56+fcOMqlYHvofsmOBxa9p+mDXMpZrL7RdxPLfZia6JSyTBgDMBu
         CsAHNKjLjx5PfaNH7eTkicBfggXLHkwiqh+pI7T3RGpwxbtBLYdzEHrQgwUMBAiJTSUV
         IsAOLZ08sXQcb64Di8zxeJU+e0FnUEWOeVEIyp4WirfoP0BGxEIEV4U1pYk7jjLyUS2Y
         43yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789289641; x=1789894441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cr6uYpQbF5rfyq1VxaZzsHsqaGvyw37xfoh8fFiyzec=;
        b=mmimyV3iIEplt+IqSP51qaWarisvWHF5HfwMqbltMB2HovDt7f+7/EFamijNLOXSUt
         Ljgo6d6hWmemCPhyN2QM48GZHwasIFbAj2EFUWSBB6/PcPXPtLzikGcvdiZYXAq4vyYG
         kib7sHFq+LdjVpos51XlCfaMnC2zZlUrZVfSl4Cj0oWw++71fMhwklwhaiVnGEjZix6U
         VTR8bWeWDey50ANGI+Y6wcyRZLQg7jPvSrPW1CBkcpNYJmoRM/1MteLsBYw6hYhTfkPo
         H5rdwuOFCrus5vP8trClEVH9Mi1IPAZcofICyeF1SKQf9nXywyocQ4Tfkc1uT1aR3zbM
         qYDA==
X-Forwarded-Encrypted: i=1; AKwUvBxD0L53KmzHFwTACFVt6x19exZVGW+crpVA4bHwo/6eRdVbxFu6OWXuZIx+gcz7PYvGf+wpVt2Efew=@vger.kernel.org
X-Gm-Message-State: AFuF++ljr0tAP+v4ryk5oEOT2MTTf4G3iKY5dMcvY9xPrcDkCsGmfbyB
	HLNHDY1jlngKaePZH3sg1EGLop+TNQ0EzArLk4R7wVFMv27hJmRjKGVb
X-Gm-Gg: AYBFou0cnXCOPeGGaZ3/wGHdNBrCOkcc7h3hjMHDmK5fExN8OTbOHcnvDEEOOK9NkhQ
	bF+X49dYYqQV4KCr/oa62tSgFJWx59ETfWLqz6EwGjFPYgw6OBKx3u30WOR3ESU7HcBjpXn7gJf
	PLwDsM6MFv93H4U3O7fS/iEfXkci5aG0HVbfrP7oOWQNNHpCfOJlOuduj1wZ3n/BB8bW09Z96di
	hyXHmyjDJcKvfsMIValDitWiNMmlYTkKZqsnjzFmOgETh6bWOIY45SU7Z2w2B99h0Lygul+PQlC
	mMwdwHj6JSEb8D4eJuwHlEsNaoY5Qp6oLUW8LjCTfWXwExN/bTsalnfAIVHSUFzBNUwJ8dk7Ex7
	Os/slaYnvnDJYnXt/f6tcEhbaFBnFDyNO7o0fsxv9lZQhzsYcLHXH3KuXkwDn3Dx0LRxqJzi/9U
	ZpEyJdNyn3phGWCKaqDGL+hIBbTwPiqXF+XXXqpmGt4yz6D4mT6vH0CL4LG0RLlksEYdz1XDUFj
	Mmx84IluH5mzuww82/eWlSff6AhUQ==
X-Received: by 2002:a05:600c:3515:b0:49c:fc6c:be09 with SMTP id 5b1f17b1804b1-49e6cc0baccmr46185225e9.32.1789289641059;
        Sun, 13 Sep 2026 01:54:01 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e7f5sm18228489f8f.9.2026.09.13.01.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 01:54:00 -0700 (PDT)
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
Subject: [PATCH v2 3/6] iio: accel: adis16201: prepare driver to support additional parts
Date: Sun, 13 Sep 2026 13:53:04 +0500
Message-ID: <20260913085307.13846-4-shehryar.amd@gmail.com>
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

Introduce adis16201_chip_info to hold per chip data and adis16201_state
to wrap struct adis. Move adis16201 to this infrastructure. This
prepares the driver to support additional chip variants by keeping
chip-specific parameters in adis16201_chip_info. Additionally,
adis16201_write_raw applies mask directly on value.

Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
---
 drivers/iio/accel/adis16201.c | 78 ++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 2ce5c409b..e0bf7df50 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -87,6 +87,22 @@ enum adis16201_scan {
 	ADIS16201_SCAN_TEMP,
 };
 
+struct adis16201_chip_info {
+	const char *name;
+	const struct iio_chan_spec *arr_channels;
+	unsigned int incli_scale_val2;
+	u16 write_mask_incli;
+	u16 diag_stat_mask;
+	unsigned int read_bits_incli;
+	unsigned int num_channels;
+};
+
+struct adis16201_state {
+	struct adis adis;
+	const struct adis16201_chip_info *info;
+	struct adis_data data;
+};
+
 static const u8 adis16201_addresses[] = {
 	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS_REG,
 	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS_REG,
@@ -99,7 +115,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 			      int *val, int *val2,
 			      long mask)
 {
-	struct adis *st = iio_priv(indio_dev);
+	struct adis16201_state *st = iio_priv(indio_dev);
 	int ret;
 	int bits;
 	u8 addr;
@@ -137,7 +153,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_INCLI:
 			*val = 0;
-			*val2 = 100000;
+			*val2 = st->info->incli_scale_val2;
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
@@ -157,13 +173,13 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 			bits = 12;
 			break;
 		case IIO_INCLI:
-			bits = 9;
+			bits = st->info->read_bits_incli;
 			break;
 		default:
 			return -EINVAL;
 		}
 		addr = adis16201_addresses[chan->scan_index];
-		ret = adis_read_reg_16(st, addr, &val16);
+		ret = adis_read_reg_16(&st->adis, addr, &val16);
 		if (ret)
 			return ret;
 
@@ -180,25 +196,24 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 			       int val2,
 			       long mask)
 {
-	struct adis *st = iio_priv(indio_dev);
-	int m;
+	struct adis16201_state *st = iio_priv(indio_dev);
 
 	if (mask != IIO_CHAN_INFO_CALIBBIAS)
 		return -EINVAL;
 
 	switch (chan->type) {
 	case IIO_ACCEL:
-		m = GENMASK(11, 0);
+		val &= GENMASK(11, 0);
 		break;
 	case IIO_INCLI:
-		m = GENMASK(8, 0);
+		val &= st->info->write_mask_incli;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	return adis_write_reg_16(st, adis16201_addresses[chan->scan_index],
-				 val & m);
+	return adis_write_reg_16(&st->adis, adis16201_addresses[chan->scan_index],
+				 val);
 }
 
 static const struct iio_chan_spec adis16201_channels[] = {
@@ -217,6 +232,20 @@ static const struct iio_chan_spec adis16201_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
+static const struct adis16201_chip_info adis16201_chip_data = {
+	.arr_channels = adis16201_channels,
+	.incli_scale_val2 = 100000,
+	.write_mask_incli = GENMASK(8, 0),
+	.diag_stat_mask =
+		BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
+		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
+		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
+		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
+	.read_bits_incli = 9,
+	.num_channels = ARRAY_SIZE(adis16201_channels),
+	.name = "adis16201",
+};
+
 static const struct iio_info adis16201_info = {
 	.read_raw = adis16201_read_raw,
 	.write_raw = adis16201_write_raw,
@@ -248,16 +277,12 @@ static const struct adis_data adis16201_data = {
 	.timeouts = &adis16201_timeouts,
 
 	.status_error_msgs = adis16201_status_error_msgs,
-	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
-		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
-		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
-		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
 };
 
 static int adis16201_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
-	struct adis *st;
+	struct adis16201_state *st;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -266,22 +291,29 @@ static int adis16201_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	indio_dev->name = spi->dev.driver->name;
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -ENODATA;
+
+	indio_dev->name = st->info->name;
 	indio_dev->info = &adis16201_info;
 
-	indio_dev->channels = adis16201_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
+	indio_dev->channels = st->info->arr_channels;
+	indio_dev->num_channels = st->info->num_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = adis_init(st, indio_dev, spi, &adis16201_data);
+	st->data = adis16201_data;
+	st->data.status_error_mask = st->info->diag_stat_mask;
+
+	ret = adis_init(&st->adis, indio_dev, spi, &st->data);
 	if (ret)
 		return ret;
 
-	ret = devm_adis_setup_buffer_and_trigger(st, indio_dev, NULL);
+	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
 	if (ret)
 		return ret;
 
-	ret = __adis_initial_startup(st);
+	ret = __adis_initial_startup(&st->adis);
 	if (ret)
 		return ret;
 
@@ -289,14 +321,14 @@ static int adis16201_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id adis16201_of_match[] = {
-	{ .compatible = "adi,adis16201" },
+	{ .compatible = "adi,adis16201", .data = &adis16201_chip_data },
 	{ },
 };
 
 MODULE_DEVICE_TABLE(of, adis16201_of_match);
 
 static const struct spi_device_id adis16201_ids[] = {
-	{ .name = "adis16201", 0 },
+	{ .name = "adis16201", .driver_data = (kernel_ulong_t)&adis16201_chip_data },
 	{ },
 };
 
-- 
2.43.0

