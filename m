Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792747827;
	b=GfzfmStPg1a6YpP0AnTjpR/f8J89Eck11Yah5POid4Xqq/oj9qoqmWlsCfATjvHjtGAT
	 8sb0BqA6Q6YPefS0x+fTKH9e0LbWjmr3doNEzd57oCHkBwLGN/4x7miaCRoeeOkj1Dpos
	 dYwx4oaLPGSrmoiiKXMQgeEBqRQV0g4ATM5DLXYgG9d8JCGj5JwDZV+J80e6WkWH9RLXT
	 +Hrw85188dJw/ClCR2h7SHFU1fU+lRiYrsoG+1jwY7iTF468QYOBeBOJ6Sbbz9kktskII
	 2OB79pBohabMx8eTWem3h5/kRygk1x0hPIIauPI+6KGEueoXkOGE6Ki5pSMFgawX/SQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747827;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lXILviIrYgJkCKo76gxjk3Mg3hBigzZdxDlMCETxfQc=;
	b=y2ViuhBm6kje9hn5WromDaoT8TFHwNHwrFnXlngU98SMghRj3U7n58kwl/NTutMZ5IQl
	 unIPe+CdUlfFIOj6mZfGO5asV5knDhWqfqXoOAH9N0rtUqKSvIC0Fjcf+FVxTynttOZ41
	 PfoRxfyUqDArdNyJVyjQhbc5bashJAc7GbOu4OXs5WXVsXbzXGo2Ek9uBB3gsuHyGsg0F
	 pmB0Eiuqk40hb0JOH8R1ML20j87C7RFMuZIGbZ8/2jU6hZ0WB7ZMOFe13AUUDyaS35B3T
	 XdNTwCZE0Th9azHBEepojdANgf8MGmL4CPA2MSSG2aCVwH9NMstgGyYTL3uGmjj0a5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L2utR2wX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2450606A32C;
	Fri, 23 Oct 2026 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L2utR2wX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792747826;
	b=oaMKlfSarNUsIyWafhdaP80CErtnuYKvMwo8P3Ry5tJ7vbwyJTkcD1GTQ4abHhAZefLp
	 t4vZv/Ha2yBaDrLIBzfvJ9HDxLBA/EwtjoMUvOK6Jx+OdtjD0bb9sfv39NZZ6zMRzklsc
	 /rz/a68A1n5ymZ5mF9lwQdSfPP01neeELE4Xv2YV4MjRMSiJg0+tESmdVHzOWXkIth1nG
	 ogUSCzC9gy9AS+gV3JDJJDWUVyPC8z5PRc5B9Ts/EIF9Jw++SGX4IZEvM/eMRmPhx3E2E
	 5ibmjTLrbjL6/BWLQ5HXnidLqZO1kSNEGoVAIje6gFCKO4D2cnAh7rmlbXT/OIYYomA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792747826;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lXILviIrYgJkCKo76gxjk3Mg3hBigzZdxDlMCETxfQc=;
	b=HOn1eg7P0qrHDdMJ0qKa38ff39Vt//EydxGC8HjKmpH08V8wRwWrMK2SRpyLgGYVG1bg
	 1cA8Qnva3CSueCmCfxQy03VNFTnfkclGnLgvtr4kEMw1ACE8HjjiKxv/5WetLlNaUthwo
	 vDteXIGhGirkyny0BfZKqsW5+TeyaiQatu6tJA+2nhXXh2Q3h5C4F/lMimNuDADww6fX2
	 OC/62fZqc18GNB3uy1Q+ItZX07HiZzm/+d3gI1l4TLa3GZQimNmE5euMHdSGP+4ESrazF
	 JzRCG7DYxcFmMuJn2IyiafSD0A/K9dUt5aogdCsDXeeFWta7Z0NyNb4dQcLHtzHFKVw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7F8F11F031EE;
	Fri, 23 Oct 2026 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792747826;
	bh=lXILviIrYgJkCKo76gxjk3Mg3hBigzZdxDlMCETxfQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=L2utR2wXP9HtDUBUFWNLe8D/00c+H8yWRpb5F+to2KnMHZgdlVGAuhQLyiTVOkGAO
	 dYqIzbCZD/4+gZEX9n4Ux8uuWJvBh+blhYG7m/sUZ7UwBfjaj8AZGcCxyQk4KHDRvQ
	 9mdD8hcdZihQSf/OR7cHp43raJYG2qSXpB2nthjSeHZhHT31pNN6qiN6MkKjauaJJC
	 b2N6Yt0LoMVUFalTL+mm4Dwp1O66phdjVomy6VTMUskgTVBISmq4Kfz5uM4xH8zR/m
	 p8FARocVnpEgLVnFREaNAnpuBx3ozcRUVedf15VE5ivBN/DRDrG0AKaTwTP8ob2KTq
	 0q6DiUMz6c6mQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7CA0D44470;
	Fri, 23 Oct 2026 09:30:21 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 23 Oct 2026 12:30:24 +0300
Subject: [PATCH v4 7/8] iio: imu: adis16607: Add external clock sync
 support
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-adis16607-v4-7-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
In-Reply-To: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@analog.com, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792747820; l=6804;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=OAI6l92vs2pkDqK/vffIE04FoJW3RtdB52JjDSkc/xg=;
 b=bZfUhOmQushmnbE8/mSaMxW13O4gapiM4c+NE4JAMCKXFma6SRtMRMXdLdWcPdkJ+v8gSisMx
 2+08q9L9Bv8DaJSNdk347V4UyZ7g1v0ze7/4GfvqtW4JK4bSudM+Yf3
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 7bit

From: Radu Sabau <radu.sabau@analog.com>

Add support for an optional external clock (clocks property),
selecting between SYNC_DIRECT and SYNC_SCALED modes depending on the
supplied frequency, with the internal 8 kHz clock used as the default
when no clock is provided.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis16607.c | 121 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
index b1f3667d8ce3..3c5b59820be1 100644
--- a/drivers/iio/imu/adis16607.c
+++ b/drivers/iio/imu/adis16607.c
@@ -7,6 +7,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/iio/buffer.h>
@@ -48,6 +49,7 @@
 #define ADIS16607_REG_FIFO_WORD_CNT	0x2B
 #define ADIS16607_REG_USER_GPIO_CFG	0x2F
 #define ADIS16607_REG_SPI_HALFDUPLEX	0x32
+#define ADIS16607_REG_USER_SYNC		0x33
 #define ADIS16607_REG_USER_DATA_CFG	0x34
 #define ADIS16607_REG_USER_FIFO_CFG	0x35
 #define ADIS16607_REG_SOFT_RESET	0x36
@@ -60,10 +62,12 @@
 
 /* Masks */
 #define ADIS16607_RESET_GPIO_MASK	GENMASK(2, 0)
+#define ADIS16607_SYNC_GPIO_MASK	GENMASK(8, 6)
 #define ADIS16607_DR_GPIO_MASK		GENMASK(11, 9)
 #define ADIS16607_DEV_NOK_MASK		GENMASK(14, 12)
 #define ADIS16607_DATA_CNTR_EN_MASK	BIT(14)
 #define ADIS16607_BURST32_MASK		BIT(15)
+#define ADIS16607_SYNC_MODE_MASK	BIT(15)
 #define ADIS16607_BOOTLOADER_BUSY_MASK	BIT(0)
 
 /* FIFO masks */
@@ -90,8 +94,22 @@
 #define ADIS16607_ACCEL_Z_DELTA_MAX	4000
 #define ADIS16607_GYRO_DELTA_MAX	2600
 
+/* Sync modes */
+enum adis16607_sync_mode {
+	ADIS16607_SYNC_DEFAULT,
+	ADIS16607_SYNC_DIRECT,
+	ADIS16607_SYNC_SCALED,
+};
+
+struct adis16607_sync {
+	u16 sync_mode;
+	u16 min_rate;
+	u16 max_rate;
+};
+
 struct adis16607_chip_info {
 	const struct iio_chan_spec *channels;
+	const struct adis16607_sync *sync_mode;
 	const char *name;
 	u32 num_channels;
 	u32 gyro_max_val;
@@ -103,6 +121,7 @@ struct adis16607_chip_info {
 	u32 deltvel_max_val;
 	u32 int_clk_hz;
 	u16 max_dec;
+	u8 num_sync;
 };
 
 struct adis16607 {
@@ -110,6 +129,7 @@ struct adis16607 {
 	const struct adis16607_chip_info *info;
 	unsigned long clk_freq_mhz;
 	u64 sample_period_ns;
+	u32 sync_mode;
 	u16 fifo_watermark;
 	/* Scratch buffer used for FIFO pop operations, see adis16607_fifo_pop() */
 	u8 fifo_buf[ADIS16607_BURST_CMD_SIZE + ADIS16607_FIFO_DATA_LEN] __aligned(IIO_DMA_MINALIGN);
@@ -1004,6 +1024,12 @@ static const struct iio_info adis16607_info = {
 	.hwfifo_set_watermark = adis16607_set_watermark,
 };
 
+static const struct adis16607_sync adis16607_sync_modes[] = {
+	{ ADIS16607_SYNC_DEFAULT, 0, 0 },
+	{ ADIS16607_SYNC_DIRECT, 401, 8000 },
+	{ ADIS16607_SYNC_SCALED, 1, 400 },
+};
+
 static const char * const adis16607_status_error_msgs[] = {
 	[9] = "Boot Memory Failure",
 	[11] = "Power Supply Failure",
@@ -1048,6 +1074,8 @@ static const struct adis16607_chip_info adis16607_2_chip_info = {
 	.deltvel_max_val = IIO_G_TO_M_S_2(40),
 	.int_clk_hz	= 8000,
 	.max_dec	= 65535,
+	.sync_mode	= adis16607_sync_modes,
+	.num_sync	= ARRAY_SIZE(adis16607_sync_modes),
 };
 
 static const struct adis16607_chip_info adis16607_3_chip_info = {
@@ -1063,17 +1091,96 @@ static const struct adis16607_chip_info adis16607_3_chip_info = {
 	.deltvel_max_val = IIO_G_TO_M_S_2(40),
 	.int_clk_hz	= 8000,
 	.max_dec	= 65535,
+	.sync_mode	= adis16607_sync_modes,
+	.num_sync	= ARRAY_SIZE(adis16607_sync_modes),
 };
 
-/*
- * No external clock sync support yet: always run on the internal clock.
- * Default dec=0 after reset, so period = 1 / clk_freq_mhz.
- */
 static int adis16607_config_clk(struct adis16607 *st)
 {
-	st->clk_freq_mhz = st->info->int_clk_hz * MILLI;
-	st->sample_period_ns =
-		DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * MILLI, st->clk_freq_mhz);
+	struct device *dev = &st->adis.spi->dev;
+	const struct adis16607_sync *sync_mode_data = NULL;
+	unsigned long ext_clk_hz = 0;
+	u16 sync_scale = 0;
+	u16 dec;
+	struct clk *clk;
+	int ret, i;
+
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (clk) {
+		ext_clk_hz = clk_get_rate(clk);
+
+		for (i = 1; i < st->info->num_sync; i++) {
+			if (ext_clk_hz >= st->info->sync_mode[i].min_rate &&
+			    ext_clk_hz <= st->info->sync_mode[i].max_rate) {
+				sync_mode_data = &st->info->sync_mode[i];
+				break;
+			}
+		}
+
+		if (!sync_mode_data)
+			return dev_err_probe(dev, -EINVAL,
+					     "Clk rate: %lu not in a valid range\n",
+					     ext_clk_hz);
+
+		st->sync_mode = sync_mode_data->sync_mode;
+	} else {
+		st->sync_mode = ADIS16607_SYNC_DEFAULT;
+	}
+
+	/*
+	 * Write the full desired sync state explicitly for every mode,
+	 * rather than only when enabling non-default sync: USER_SYNC's
+	 * documented reset default (0x0000, direct mode / scale 0) means
+	 * this isn't fixing a known reset-state issue, but each mode
+	 * establishing its own complete state here, instead of only
+	 * touching bits conditionally, is simpler to reason about and
+	 * doesn't depend on that default holding true.
+	 */
+	ret = adis_update_bits_base(&st->adis, ADIS16607_REG_USER_GPIO_CFG,
+				    ADIS16607_SYNC_GPIO_MASK,
+				    FIELD_PREP(ADIS16607_SYNC_GPIO_MASK,
+					       st->sync_mode != ADIS16607_SYNC_DEFAULT), 2);
+	if (ret)
+		return ret;
+
+	if (st->sync_mode == ADIS16607_SYNC_SCALED)
+		sync_scale = DIV_ROUND_CLOSEST(st->info->int_clk_hz, ext_clk_hz);
+
+	ret = adis_write_reg_16(&st->adis, ADIS16607_REG_USER_SYNC,
+				(st->sync_mode == ADIS16607_SYNC_SCALED) ?
+				ADIS16607_SYNC_MODE_MASK | sync_scale : 0);
+	if (ret)
+		return ret;
+
+	switch (st->sync_mode) {
+	case ADIS16607_SYNC_SCALED:
+		/*
+		 * sync_scale is a rounded integer, so the hardware's actual
+		 * effective rate is ext_clk_hz * sync_scale, not necessarily
+		 * int_clk_hz - use the real value here so sample_period_ns (and
+		 * therefore FIFO sample timestamps) don't drift from it.
+		 */
+		st->clk_freq_mhz = (unsigned long)ext_clk_hz * sync_scale * 1000;
+		break;
+	case ADIS16607_SYNC_DIRECT:
+		/* DIRECT: external clock is the effective internal rate */
+		st->clk_freq_mhz = ext_clk_hz * 1000;
+		break;
+	default:
+		st->clk_freq_mhz = (unsigned long)st->info->int_clk_hz * 1000;
+		break;
+	}
+
+	ret = adis_read_reg_16(&st->adis, ADIS16607_REG_DEC_RATE, &dec);
+	if (ret)
+		return ret;
+
+	st->sample_period_ns = DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * 1000ULL * (dec + 1),
+						     st->clk_freq_mhz);
+
 	return 0;
 }
 

-- 
2.43.0


