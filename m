Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9123CE0BB
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538530; cv=none; b=CiHKb8hGVGgtqcl1n/UbOpNJHd8TkPQ+MaEbPnZyRyk0KttQQfmUcblQOkRe89rUWBR+LpxQHE7tZOXfAuWlzkRkSv33CAWCvmEWq+k3aR20BKslNLblfA9RwvVNFjZqQcG7N0W/8LuVvKirkIxb+0wbp15eDs4qoFb2ZLUGcSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538530; c=relaxed/simple;
	bh=Ff/uIxBKxwu67J2uM2AgrO0HyRL6W+2X5pd4BlLjP48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtT3+wlOXV3pryl0Ff+2ifv2HvwMnNAALe4Nxk8gN9eodyhBfftpguqSMPm/PUF6KEGGtlQhqo+EgrYTzwsXQUdkq0V/xjYmnZWcKmIHcZrUdJlTcaSvX1XFffm2ClzCILiAJZDT3y0Wgb1KNSbVzTwEvnt0eyqO9YSuRC6nsK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjmUqUbU; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjmUqUbU"
Received: by mail-oo2-f5.google.com with SMTP id 006d021491bc7-6c184d8081eso380507eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 23:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538525; x=1790143325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yqZNF6eZF6D55QJWIBmesvsnEqcHnYR5jPB3jzgWMMM=;
        b=DjmUqUbUMeX2Y80RAxFUOQWDD5gaq6OlKbM0zfGBXfkk4MuhihYihYVb0oloF5zKPx
         TWv0w167jIiCLxatS/IPFOfJPdzJ7JpKo2ni9Z+MN+Db75WEdPLjrghmZv4it4L3BNGC
         fOdpcVqcNfdR4jVOuQElE0Ad0WCTMRJcn1Ci4LMOAlekPSx3YndWgl/w6ZaORk6aeSW3
         dvRwbrPTRnYvKZEB3acF3WR1SwQSISTvW9WHkDX91+dGjFsxRKpyOpfnG8q7216jhG8u
         M+jU/jTTOVuzKMDcW2hmIBkwXFTMGDn3fpolWujckF96Mp9+FAic0pjc2CagSQXUsQp6
         +2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538525; x=1790143325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yqZNF6eZF6D55QJWIBmesvsnEqcHnYR5jPB3jzgWMMM=;
        b=SFhxVotcQMB7DN0Qz9nV64OW5DI38914SCpFwVtRu5OLdWbgR4GDR/FIpuoBbBogDn
         FiTV4f42bWO9OizXv1YkLCMveKYow7KUpSGClBIllgS8B6I3S3Lut4sRNS9duP6A7dxn
         Yot7OQFUFUPc2VTFKnf0jbQaHCUOpqqL1Pz8FAE5VFT/PRRrAXA/SXYDBbXJ+sMBuGWB
         9JK6ywd4hIeZ1vEmtqiIqBFvyK3BQ5VRJoH21k7bAUdMGfH2m56NRAZkrYiU+xBYb02y
         Qk2kZIwO+7qwVqyrpzEmXlc42pt58PfIjO3kMv6wYm0y+XUW11USUbY7eyw0N60RLKm9
         I2pA==
X-Gm-Message-State: AFuF++npzlfydTTbodCCiiM5YlamPpikYJ6vk4u0oGwbLF8qczqT9gwC
	lMW40HpxL+nTes0VgJHbBTjwvzDm2NJOwxVVeObuLCWyB9ZC86gMn5qn/Cg1vYCDqwU=
X-Gm-Gg: AYBFou3hBHs9012DguahhD7N5PLnQJqyrLLJ05/Xtn2sobOlXYp7cW5rEl4IrSgmpVQ
	Nvjj6gqS3C45+dcoegQDkkdKndhvaUnRiWToTPV/4K13+SLCH4jfdSWGYnZnS/2ZMHxlNWnujBI
	GXCyBrm/coq7DenokD+i8Qmri1I/MH0U8JYEo/2hmuuP2Xq2D20koB//fWWB09RPpJp/Y1mYnws
	2r8exUwbjJf7WjDJdXwIKNS9U3POhqdFpmvWBM1WnOxnylg11ZRIPrX1z3M0c1rS119T9x7J9pc
	9KYZ9Z7iPHCJ8PZ1Y/5sHSlKNbj4d+3LQvofU4XUP/b8y/KZrZUq7Y1d4zzDVnyUbk9vLcw9WFZ
	+w3hxh8Vjb5RaLHBsjXR800lSVHE8LnIaUgdETDYcKFzEZK58c3r51jRtx5FMFD5oCJwvhoNFi2
	t8/XDmMU0SqX3gPae8sKeH3CCA5qy7CltwQYWAoVUfmlZqWdAo6jIo9kOeh9V2TIrVbjQkpFN+V
	0l2WqZf9tdD7cvJ5nI=
X-Received: by 2002:a05:6820:180f:b0:6b7:8396:f3d4 with SMTP id 006d021491bc7-6c7d41d7f0fmr1585632eaf.54.1789538525076;
        Tue, 15 Sep 2026 23:02:05 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aa1194sm5150929eec.14.2026.09.15.23.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:02:04 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: linux-iio@vger.kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org
Cc: Shehryar Ahmad <shehryar.amd@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 4/7] iio: accel: adis16201: prepare driver to support additional parts
Date: Wed, 16 Sep 2026 10:55:34 +0500
Message-ID: <20260916055547.15206-5-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916055547.15206-1-shehryar.amd@gmail.com>
References: <20260916055547.15206-1-shehryar.amd@gmail.com>
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
 drivers/iio/accel/adis16201.c | 66 +++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index cbac23d4d..592dc6451 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -87,6 +87,21 @@ enum adis16201_scan {
 	ADIS16201_SCAN_TEMP,
 };
 
+struct adis16201_chip_info {
+	const char *name;
+	const struct iio_chan_spec *arr_channels;
+	const struct adis_data *data;
+	unsigned int incli_scale_val2;
+	unsigned int read_bits_incli;
+	unsigned int num_channels;
+	u16 write_mask_incli;
+};
+
+struct adis16201_state {
+	struct adis adis;
+	const struct adis16201_chip_info *info;
+};
+
 static const u8 adis16201_addresses[] = {
 	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS_REG,
 	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS_REG,
@@ -99,7 +114,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 			      int *val, int *val2,
 			      long mask)
 {
-	struct adis *st = iio_priv(indio_dev);
+	struct adis16201_state *st = iio_priv(indio_dev);
 	int ret;
 	int bits;
 	u8 addr;
@@ -137,7 +152,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_INCLI:
 			*val = 0;
-			*val2 = 100000;
+			*val2 = st->info->incli_scale_val2;
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
@@ -157,13 +172,13 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
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
 
@@ -180,25 +195,24 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
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
@@ -254,10 +268,20 @@ static const struct adis_data adis16201_data = {
 		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
 };
 
+static const struct adis16201_chip_info adis16201_chip_data = {
+	.arr_channels = adis16201_channels,
+	.incli_scale_val2 = 100000,
+	.write_mask_incli = GENMASK(8, 0),
+	.read_bits_incli = 9,
+	.num_channels = ARRAY_SIZE(adis16201_channels),
+	.name = "adis16201",
+	.data = &adis16201_data,
+};
+
 static int adis16201_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
-	struct adis *st;
+	struct adis16201_state *st;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -266,22 +290,26 @@ static int adis16201_probe(struct spi_device *spi)
 
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
+	ret = adis_init(&st->adis, indio_dev, spi, st->info->data);
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
 
@@ -289,13 +317,13 @@ static int adis16201_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id adis16201_of_match[] = {
-	{ .compatible = "adi,adis16201" },
+	{ .compatible = "adi,adis16201", .data = &adis16201_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adis16201_of_match);
 
 static const struct spi_device_id adis16201_ids[] = {
-	{ .name = "adis16201" },
+	{ .name = "adis16201", .driver_data = (kernel_ulong_t)&adis16201_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adis16201_ids);
-- 
2.43.0

