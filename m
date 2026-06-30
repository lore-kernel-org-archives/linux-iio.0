Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA404449EB6
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833758; cv=none; b=fm/q/vgYYGLwK3B8NtovGatnsyOAx+2RXKnhBXh6KemNUh5TtRrgpEsGgvRLdcrmf7kk3Qurptg77CAMCQR+I6BmDUu/J9r1uj7ZC4i/mr0YiEZFXT6QJITF12y3pWX6cxGizAKVkhKqyVtBRQe1yg2toLzrInpj0LEh3Sp0LTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833758; c=relaxed/simple;
	bh=CsNdRISgavy4f/5QLWbpqvA2kn9lQIh+huewHIkpTb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rrx76daRbMt5ZuoWhP/GwndYTVaS0PcNhSIdyLUjVivQNYGISJTrueaUcYs+bMr3cW6iFljdhIw7lyJCIxLhYajoVvanNglZM4oSCUkYC+7biiu2YW5G+l5TpSTMrHVnw+cfPz6vhLf1uRpjsoRtYVR1ReCCnwSU9+LhvqF5Cs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TrEcZCPq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TrEcZCPq"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-46ed4f66256so3702265f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 08:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782833755; x=1783438555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3UlcWLs5NaZ4qry0LnKWeBygtpSZt+nguGpV8sC52k=;
        b=TrEcZCPqnpal/oS+ZgLJxUwUsGiMQNICuwy0wCuUrbli9eC2zov4WJGEX/J2Q42TUh
         d7cwE1uCuuXOhx2RtVvMbT6bA8TBk3kArS1xA4eCXCgfvN9HpVovKZ8vOi+XU1paAil4
         SOMl1ksfuRX8KPsGqvoSLXFWTByZvwejz/lsshkLB+m5iP8f2M/AmzP7XsbjNEWw2Lp2
         Lzj2MNh1Fkroi+xxNl01tX5S2HsM+BEKDZYSfhdoUrih7EL1FJ7nqhp8/8v0ZdyBKxTF
         iTft7zrAv6bdy9Vh8D+vjLi/DetryTPVgpYa5BDIgumNKCxa6NuywBg/eSrFQ/9kdsKf
         38WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833755; x=1783438555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C3UlcWLs5NaZ4qry0LnKWeBygtpSZt+nguGpV8sC52k=;
        b=mGaDu8fI2EIZH0aDEnmo7+YdJX+BOZMnDv5hT1geBBrQLi5ThUA+hjsc7zNcGP3p26
         9SedZ+BVJ0reyCRxCKeLtl4KzsTdPeEtvQelDNMFmgeVWkk3wKb7WLwMtwNARFOTwqSE
         zKoE1hIfJKAu0cuZS+j0CUn3NueHLC9AIr2P+RdvtZpcUFnfTeYai8mWWSYUXE6yakPf
         af4qlsUKc+cKvGMKRl0AGUmR4nZXa4vGPbGQgFl3nQzC1PuOk4Uh7XyHm3GO2h8ts8N3
         nPpb0thYbNbBjLled8edJPVkwSqdt3N3gmsim0ICnu63XMf6MVk0EdwUqKJF5qmw07fZ
         005A==
X-Forwarded-Encrypted: i=1; AHgh+RoP6T5B5+u67DhDRFWyXaL6vQIhbz/VVtogjA6VQaxD/TjfpGINenCupbJjyaij6olLjI3ELnJsWnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztnhD7j/hGi88YfBdxcgcSvFbCih7Z4YqrkhkjHyOYtA1fY5+b
	EOO0Yt5Uy6SCsudMiGZ9xVB1OGOF1pFsRGQRseFrEbuY8z3HHwLslfjYE/H7o45tjAY=
X-Gm-Gg: AfdE7cmdaagv6BcpuQ/rnKiLJ7iB8RGdC/WJAyNRS+ekOYge1HS7IMbqjdTcddQmpZs
	BoQnmWrkwRf5Hb3DdB1T/ZCdLgyjLRnOPRzP3I517PJ0vRCS0rzf556fFRT+QOOADLIoba5leoD
	vjREX6JirWbgHMuACijLkcLZ4GTvGIaR2kdY13UgdUCTGfPxnRIB8xA+0upmWWApZZUaeShbG8v
	UpsBhT+BGdQJ17TbuvWkZVhdxF2CfqYCf18XR7az3yKGj5oCwPFlESJq1FZkS2EPe6iLFOfHBlA
	zdlxF9b2mOdDxXfq816VKM2ttsq2dhleHj6r6eL5rAsh7gHEf19JYHrGlzU1NgJlqfMDF0nuctv
	wvhh12Eyjp4umMoQ/DJkR4UpzhFNuFmZ6aZ1tncRyymHUns9W73VnPVh1oAifnibH4uDKoHEl3U
	A7y3PaDwYjwjmck8Peo4FSSzITI0+1X0Z9+2Lbq7QSxzuTzqZmX8ChNSQHP/ohgmz9v7VBu0yM7
	dMV
X-Received: by 2002:a05:6000:25c6:b0:46f:7d90:811c with SMTP id ffacd0b85a97d-47551737ee7mr5786128f8f.13.1782833755449;
        Tue, 30 Jun 2026 08:35:55 -0700 (PDT)
Received: from localhost (p200300f65f47db042a9b551def0a6b94.dip0.t-ipconnect.de. [2003:f6:5f47:db04:2a9b:551d:ef0a:6b94])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4756636ce7esm9309530f8f.23.2026.06.30.08.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:35:54 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iio: imu: adis16550: Simplify device abstraction
Date: Tue, 30 Jun 2026 17:35:35 +0200
Message-ID:  <f9c18b3c1ee486341704f917e06b91f7a39119ec.1782833415.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782833415.git.u.kleine-koenig@baylibre.com>
References: <cover.1782833415.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6569; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=CsNdRISgavy4f/5QLWbpqvA2kn9lQIh+huewHIkpTb4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhiznRz7OLfWbXjM/vDHl8umTaZs2n67qYWFUM19W+DWyy f0vyzreTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmkmDH/r/mvOO/4ooFfTvm z66pmHZHt+3HlWXOn1ewlxa+yu4wUW83fWlRf9JKKIxn74SySA//9H+vdk8Qdbp05lhEyW67tqY 7HVtrJGzY+jbccLuz515ud/jEkuQDUk/uV/x9mJUgpdJgbtwUx+LOLXhyZ6FBzMk7Wte7f32+Lm XCPf/QzHC3NYKnT/vOO3v286k+D5OrUwXfOBRl8KzhtyiJSdAPEZKU2JqjyRwk92+F+Zn7iral3 YK6+rt/8r0NC7L5EWl/lpdX+Yvo9sNLm5wbFXqe2HPm+SV/sPF2Pm+u6/VWL/mzdfFNJfGeyn3L bq42TspZKHNmieSyFN/NlXeC9X7yB3mZbv8042QPw38+AA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver supports a single chip variant only. Simplify the driver by
hard-coding the device properties instead of using the id_table's
abstraction for a single chip type and a lookup in a table with only one
entry.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/imu/adis16550.c | 89 +++++++++++--------------------------
 1 file changed, 26 insertions(+), 63 deletions(-)

diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
index 75679612052f..fe0034964408 100644
--- a/drivers/iio/imu/adis16550.c
+++ b/drivers/iio/imu/adis16550.c
@@ -89,25 +89,7 @@ struct adis16550_sync {
 	u16 max_rate;
 };
 
-struct adis16550_chip_info {
-	const struct iio_chan_spec *channels;
-	const struct adis16550_sync *sync_mode;
-	char *name;
-	u32 num_channels;
-	u32 gyro_max_val;
-	u32 gyro_max_scale;
-	u32 accel_max_val;
-	u32 accel_max_scale;
-	u32 temp_scale;
-	u32 deltang_max_val;
-	u32 deltvel_max_val;
-	u32 int_clk;
-	u16 max_dec;
-	u16 num_sync;
-};
-
 struct adis16550 {
-	const struct adis16550_chip_info *info;
 	struct adis adis;
 	unsigned long clk_freq_hz;
 	u32 sync_mode;
@@ -450,8 +432,8 @@ static int adis16550_set_freq_hz(struct adis16550 *st, u32 freq_hz)
 	 * The optimal sample rate for the supported IMUs is between
 	 * int_clk - 1000 and int_clk + 500.
 	 */
-	u32 max_sample_rate = st->info->int_clk * 1000 + 500000;
-	u32 min_sample_rate = st->info->int_clk * 1000 - 1000000;
+	u32 max_sample_rate = 4000 * 1000 + 500000;
+	u32 min_sample_rate = 4000 * 1000 - 1000000;
 
 	if (!freq_hz)
 		return -EINVAL;
@@ -484,7 +466,7 @@ static int adis16550_set_freq_hz(struct adis16550 *st, u32 freq_hz)
 	if (dec)
 		dec--;
 
-	dec = min(dec, st->info->max_dec);
+	dec = min(dec, 4095);
 
 	return __adis_write_reg_16(&st->adis, ADIS16550_REG_DEC_RATE, dec);
 }
@@ -592,30 +574,30 @@ static int adis16550_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			*val = st->info->gyro_max_val;
-			*val2 = st->info->gyro_max_scale;
+			*val = 1;
+			*val2 = IIO_RAD_TO_DEGREE(80 << 16);
 			return IIO_VAL_FRACTIONAL;
 		case IIO_ACCEL:
-			*val = st->info->accel_max_val;
-			*val2 = st->info->accel_max_scale;
+			*val = 1;
+			*val2 = IIO_M_S_2_TO_G(102400000);
 			return IIO_VAL_FRACTIONAL;
 		case IIO_TEMP:
-			*val = st->info->temp_scale;
+			*val = 4;
 			return IIO_VAL_INT;
 		case IIO_DELTA_ANGL:
-			*val = st->info->deltang_max_val;
+			*val = IIO_DEGREE_TO_RAD(720);
 			*val2 = 31;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		case IIO_DELTA_VELOCITY:
-			*val = st->info->deltvel_max_val;
+			*val = 125;
 			*val2 = 31;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_OFFSET:
-		/* temperature centered at 25°C */
-		*val = DIV_ROUND_CLOSEST(25000, st->info->temp_scale);
+		/* temperature centered at 25°C divided by temp scale */
+		*val = 25000 / 4;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = adis_read_reg_32(&st->adis,
@@ -793,23 +775,6 @@ static const struct adis16550_sync adis16550_sync_modes[] = {
 	{ ADIS16550_SYNC_MODE_SCALED, 1, 128 },
 };
 
-static const struct adis16550_chip_info adis16550_chip_info = {
-	.num_channels = ARRAY_SIZE(adis16550_channels),
-	.channels = adis16550_channels,
-	.name = "adis16550",
-	.gyro_max_val = 1,
-	.gyro_max_scale = IIO_RAD_TO_DEGREE(80 << 16),
-	.accel_max_val = 1,
-	.accel_max_scale = IIO_M_S_2_TO_G(102400000),
-	.temp_scale = 4,
-	.deltang_max_val = IIO_DEGREE_TO_RAD(720),
-	.deltvel_max_val = 125,
-	.int_clk = 4000,
-	.max_dec = 4095,
-	.sync_mode = adis16550_sync_modes,
-	.num_sync = ARRAY_SIZE(adis16550_sync_modes),
-};
-
 static u32 adis16550_validate_crc(__be32 *buffer, const u8 n_elem)
 {
 	int i;
@@ -918,21 +883,21 @@ static int adis16550_config_sync(struct adis16550 *st)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 	if (!clk) {
-		st->clk_freq_hz = st->info->int_clk * 1000;
+		st->clk_freq_hz = 4000000;
 		return 0;
 	}
 
 	st->clk_freq_hz = clk_get_rate(clk);
 
-	for (i = 0; i < st->info->num_sync; i++) {
-		if (st->clk_freq_hz >= st->info->sync_mode[i].min_rate &&
-		    st->clk_freq_hz <= st->info->sync_mode[i].max_rate) {
-			sync_mode_data = &st->info->sync_mode[i];
+	for (i = 0; i < ARRAY_SIZE(adis16550_sync_modes); i++) {
+		if (st->clk_freq_hz >= adis16550_sync_modes[i].min_rate &&
+		    st->clk_freq_hz <= adis16550_sync_modes[i].max_rate) {
+			sync_mode_data = &adis16550_sync_modes[i];
 			break;
 		}
 	}
 
-	if (i == st->info->num_sync)
+	if (i == ARRAY_SIZE(adis16550_sync_modes))
 		return dev_err_probe(dev, -EINVAL, "Clk rate: %lu not in a valid range",
 				     st->clk_freq_hz);
 
@@ -943,7 +908,7 @@ static int adis16550_config_sync(struct adis16550 *st)
 		 * of [3000 4500].
 		 */
 
-		sync_scale = DIV_ROUND_CLOSEST(st->info->int_clk, st->clk_freq_hz);
+		sync_scale = DIV_ROUND_CLOSEST(4000, st->clk_freq_hz);
 
 		if (3000 > sync_scale || 4500 < sync_scale)
 			return dev_err_probe(dev, -EINVAL,
@@ -955,7 +920,7 @@ static int adis16550_config_sync(struct adis16550 *st)
 		if (ret)
 			return ret;
 
-		st->clk_freq_hz = st->info->int_clk;
+		st->clk_freq_hz = 4000;
 	}
 
 	st->clk_freq_hz *= 1000;
@@ -1064,13 +1029,11 @@ static int adis16550_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	st->info = spi_get_device_match_data(spi);
-	if (!st->info)
-		return -EINVAL;
+
 	adis = &st->adis;
-	indio_dev->name = st->info->name;
-	indio_dev->channels = st->info->channels;
-	indio_dev->num_channels = st->info->num_channels;
+	indio_dev->name = "adis16550";
+	indio_dev->channels = adis16550_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adis16550_channels);
 	indio_dev->available_scan_masks = adis16550_channel_masks;
 	indio_dev->info = &adis16550_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1117,13 +1080,13 @@ static int adis16550_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id adis16550_id[] = {
-	{ "adis16550",  (kernel_ulong_t)&adis16550_chip_info},
+	{ .name = "adis16550" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adis16550_id);
 
 static const struct of_device_id adis16550_of_match[] = {
-	{ .compatible = "adi,adis16550", .data = &adis16550_chip_info },
+	{ .compatible = "adi,adis16550" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adis16550_of_match);
-- 
2.47.3

