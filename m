Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793611549;
	b=gE6kO+dGq4FV1Y8nIGEXi4lGZd/ImD4V6CxOqJgCOEhsDPV+x4idmnV3pcxU1zJb7Ai3
	 uICkkcHl35ZwjK0WRY2L6G8xOrtSmYjUExC7GEq9M6bfv1AU3ijjFhOycUEQoBGKjAZVr
	 W2tE2w0etciFZhqCjF2KfALspP3edB2GEgY+v4j1aVxlX0hRG19zoJOQvBdqd3YcNExxH
	 rHge1PNGWcURdZx3BsqfH6UIac0m3K+lHwyDOmrzy29pn6ZZlwskckGduMld5gU8MUITX
	 bLX9KkYnbEhjcy+tAM+cNiK5EdlI5dOeI+ReliEoJGcqwVz7/oRRixjhicUqGDARrGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611549;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=B4hXwDUfOKlDrCVYq771WnIr58+pezoHwIGNOz/7HM0=;
	b=Joed+KwhZ4KKYCfOkRCYfmsajqMiBtih2EUBAAdoZIVdc/6iH2b2Z5OiEzdNz1/YF31M
	 Vd8vipMCg7gE8qmGL1DhmZ5EfvmMqeN31wMgJtLl+EC64hnD+Vlv8nU340PiboZYjeJd3
	 +gAFs5gC0tPE0WHdvk7wFTKEwl5LRm4/I90ErXKVugijgXlXsKsDsxrrrZcM3Obtx0EDN
	 AnyIgbqSdYR2W+slcepZ4HJzAJ4IfVwlDC38k3pR5vmqDSinWAsXWy/IfJkkX8Ce0QziH
	 XTJhNriaUwJmDXotYl/7+g6ds0pL7Zi0IKU2f0PUrMCYviUt/UB2nsjLxXjEQmq8GQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRyuLIfy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF860A3833;
	Mon,  2 Nov 2026 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRyuLIfy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793611548;
	b=i/95AaLnd0eIpJeY3kgk+LVm2g01jHVqYLmGVeVhLi7rRmp56FJ7SZgaUV7HHhS+GVyB
	 9NNhxg4lcgOGxC+0MvOESXy+egp4r+dFR9o52bvmvK6ZDzVfLqjhilNsP6mQ6I5wVE13d
	 SyqPoZrC7VypVG0hjmIYF9l2kHMnhh7zn8bYCyERLtU7Mjzfl9NI/w1zPCbXn6IVXoPk3
	 0n8xy9+hwALP3M+3Q9hCCjZu+qz+IzBo1b9jxz1U8s1ofymHgZssieufxeriODD/oQf+I
	 3dTELufxbhmqAyWWteNt2M0+dT6in+zFZjlJ+lI9f5MRAmqMF3dyINByy+l4zX4y9Fg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793611548;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=B4hXwDUfOKlDrCVYq771WnIr58+pezoHwIGNOz/7HM0=;
	b=oAb63AUXU6806QBrUlzY/2e4fUkJksOmXmydx/DlD4kAQX9vReKAPQkqjVc9iwhH3OTT
	 L/tU16IShBbpG4maavjazMgRnmD0eUqlxKrvzcbS+1i+bL0FqgwA1jFobwIXkw+4vNJBq
	 78kuo/rOu3DoyEmTlhdyCXOaIoOsRPVBgGfK85u9wf6yc/vNEnIKrxQBWqYDBMg8Bz7Fi
	 XLTp6RX5PGox9fSJjf9m++LU+NFPredmGYKPoJOYqAF/415F+vTrJp1ASTxHfSz02DO4A
	 CdrsTY+FfMKQ2ZFAj/DB2zDsPkEloRSJBopSCP4TuPH3/AkjLHPtHJTACSzxNr2IEbQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C81091F00A18;
	Mon,  2 Nov 2026 09:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611548;
	bh=B4hXwDUfOKlDrCVYq771WnIr58+pezoHwIGNOz/7HM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dRyuLIfypDDUWzsvyp60ki6FcAtqOGr9+Bz5sJQbRj5INHfvPLhtL6RuLHiN9vU9e
	 NBvKW3mG7dUqyXQjTY3XHjJj1bb9S7+KNgc8gh0VppdlS7hGnK56ijrRjgx4xvYDfW
	 kJNqhlhSSuqkfI4cJn/nJgeX6A48h9uzBD5aAaV7inqtiewxUsXA1Vi3cq+8QAS9Ao
	 KB9dKiVQjRt0iEDNQ6jsNwQXnXrj1i0w64RUSmDzfctIWN0LJJ9VhtG6bHolr3Pg7Z
	 4sAMuGniOlIosgVxpCWUUH/VhlyDQDrEFdN5l2M53Im4sfhjZn+df7rd2Q5h0ifoDl
	 kuRFVZLcV34ig==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 07D6846455;
	Mon,  2 Nov 2026 09:25:41 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 02 Nov 2026 11:25:43 +0200
Subject: [PATCH v5 7/8] iio: imu: adis16607: Add external clock sync
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
Message-Id: <20261102-adis16607-v5-7-4f98b0d271ac@analog.com>
References: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
In-Reply-To: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793611539; l=11832;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=Ylk05uW9ugh2tgjL5wxtfOdaTVWwFFqtc2VpPHNBiAM=;
 b=7UfS4dw+6HrRVJzthbJ+j5Rg2WmzbJbtvSKtDoUTGY7/qDfvlKoAwIGygJWKPa+lMUZ8gpRCu
 On01W1jZAGCCwNro+FGQESjsKotmKsG1vEaiZZxB8acEVOJpoZch8Ve
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 7bit

From: Radu Sabau <radu.sabau@analog.com>

Add support for an optional external clock (clocks property),
selecting between SYNC_DIRECT (1 kHz to 8 kHz) and SYNC_SCALED (1 Hz
to 400 Hz) depending on the supplied frequency, with the internal
8 kHz clock used as the default when no clock is provided.

The clock rate is requested as exclusive since the sample period and
the sync scale are derived from it. In scaled mode the sync scale is
chosen when the sampling frequency is set, so that the requested rate
is matched as closely as possible while keeping the clock multiplied
at or below the internal rate. Loss of sync or of the PLL lock is
reported from the trigger handler, as the device keeps sampling
without it.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis16607.c | 219 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 206 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
index bd7752f7a1ec..58504d351de1 100644
--- a/drivers/iio/imu/adis16607.c
+++ b/drivers/iio/imu/adis16607.c
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/build_bug.h>
+#include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/iio/buffer.h>
@@ -50,6 +51,7 @@
 #define ADIS16607_REG_FIFO_WORD_CNT	0x2B
 #define ADIS16607_REG_USER_GPIO_CFG	0x2F
 #define ADIS16607_REG_SPI_HALFDUPLEX	0x32
+#define ADIS16607_REG_USER_SYNC		0x33
 #define ADIS16607_REG_USER_DATA_CFG	0x34
 #define ADIS16607_REG_USER_FIFO_CFG	0x35
 #define ADIS16607_REG_SOFT_RESET	0x36
@@ -62,12 +64,18 @@
 
 /* Masks */
 #define ADIS16607_RESET_GPIO_MASK	GENMASK(2, 0)
+#define ADIS16607_SYNC_GPIO_MASK	GENMASK(8, 6)
 #define ADIS16607_DR_GPIO_MASK		GENMASK(11, 9)
 #define ADIS16607_DEV_NOK_MASK		GENMASK(14, 12)
 #define ADIS16607_DATA_CNTR_EN_MASK	BIT(14)
 #define ADIS16607_BURST32_MASK		BIT(15)
+#define ADIS16607_SYNC_MODE_MASK	BIT(15)
 #define ADIS16607_BOOTLOADER_BUSY_MASK	BIT(0)
 
+/* DIAG_STAT sync flags */
+#define ADIS16607_DIAG_DPLL_UNLOCKED	BIT(1)
+#define ADIS16607_DIAG_SYNC_LOST	BIT(2)
+
 /* FIFO masks */
 #define ADIS16607_FIFO_THR_MASK		GENMASK(10, 0)
 #define ADIS16607_FIFO_FLUSH_MASK	BIT(15)
@@ -95,8 +103,22 @@
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
@@ -108,6 +130,7 @@ struct adis16607_chip_info {
 	u32 deltvel_max_val;
 	u32 int_clk_Hz;
 	u16 max_dec;
+	u8 num_sync;
 };
 
 struct adis16607 {
@@ -115,6 +138,9 @@ struct adis16607 {
 	const struct adis16607_chip_info *info;
 	unsigned long clk_freq_mHz;
 	u64 sample_period_ns;
+	unsigned long ext_clk_Hz;
+	u32 sync_mode;
+	u16 sync_scale;
 	u16 fifo_watermark;
 	/* IIO buffer for reordered data - sized for max channels */
 	IIO_DECLARE_BUFFER_WITH_TS(u8, data, ADIS16607_SCAN_DATA_SIZE);
@@ -407,11 +433,18 @@ static void adis16607_fifo_drain(struct iio_dev *indio_dev, s64 irq_timestamp)
 
 	adis_dev_auto_lock(&st->adis);
 
-	/* Check if FIFO threshold is met */
 	ret = __adis_read_reg_16(&st->adis, ADIS16607_REG_DIAG_STAT, &diag_stat);
 	if (ret)
 		return;
 
+	/* The device keeps sampling without sync, so only warn about it */
+	if (diag_stat & ADIS16607_DIAG_SYNC_LOST)
+		dev_warn_ratelimited(&st->adis.spi->dev, "external sync lost\n");
+
+	if (diag_stat & ADIS16607_DIAG_DPLL_UNLOCKED)
+		dev_warn_ratelimited(&st->adis.spi->dev, "sync PLL unlocked\n");
+
+	/* Check if FIFO threshold is met */
 	if (!(diag_stat & ADIS16607_FIFO_THR_MET_MASK))
 		return;
 
@@ -841,8 +874,44 @@ static int adis16607_get_freq(struct adis16607 *st, u32 *freq)
 	return 0;
 }
 
+/*
+ * In scaled sync mode the output rate is ext_clk * scale / (dec + 1). Find the
+ * (scale, dec) pair closest to the requested rate (in mHz), keeping
+ * ext_clk * scale at or below the internal rate. On a tie the higher scale
+ * wins, so the decimation filter averages more samples.
+ */
+static void adis16607_scaled_params(struct adis16607 *st, u32 freq,
+				    u16 *scale, u32 *dec)
+{
+	u32 max_scale = st->info->int_clk_Hz / st->ext_clk_Hz;
+	u32 max_dec = st->info->max_dec + 1;
+	u64 best_err = U64_MAX;
+	u64 target = freq;
+
+	for (u32 k = 1; k <= max_scale; k++) {
+		u64 rate = st->ext_clk_Hz;
+		u64 div, odr, err;
+
+		rate *= k;
+		rate *= MILLIHZ_PER_HZ;
+
+		div = DIV_ROUND_CLOSEST_ULL(rate, freq);
+		div = clamp(div, 1, max_dec);
+		odr = DIV_ROUND_CLOSEST_ULL(rate, div);
+		err = abs_diff(odr, target);
+		if (err > best_err)
+			continue;
+
+		best_err = err;
+		*scale = k;
+		*dec = div - 1;
+	}
+}
+
 static int adis16607_set_freq(struct adis16607 *st, u32 freq)
 {
+	unsigned long clk_freq_mHz = st->clk_freq_mHz;
+	u16 scale = st->sync_scale;
 	u64 period_ns;
 	u32 dec;
 	int ret;
@@ -850,11 +919,16 @@ static int adis16607_set_freq(struct adis16607 *st, u32 freq)
 	if (!freq)
 		return -EINVAL;
 
-	dec = DIV_ROUND_CLOSEST(st->clk_freq_mHz, freq);
-	if (dec)
-		dec--;
+	if (st->sync_mode == ADIS16607_SYNC_SCALED) {
+		adis16607_scaled_params(st, freq, &scale, &dec);
+		clk_freq_mHz = st->ext_clk_Hz * scale * MILLIHZ_PER_HZ;
+	} else {
+		dec = DIV_ROUND_CLOSEST(clk_freq_mHz, freq);
+		if (dec)
+			dec--;
 
-	dec = min(dec, st->info->max_dec);
+		dec = min(dec, st->info->max_dec);
+	}
 
 	/*
 	 * The sample period is (dec + 1) / clk_freq. clk_freq_mHz is in
@@ -865,7 +939,7 @@ static int adis16607_set_freq(struct adis16607 *st, u32 freq)
 	period_ns = NSEC_PER_SEC;
 	period_ns *= MILLIHZ_PER_HZ;
 	period_ns *= dec + 1;
-	period_ns = DIV_ROUND_CLOSEST_ULL(period_ns, st->clk_freq_mHz);
+	period_ns = DIV_ROUND_CLOSEST_ULL(period_ns, clk_freq_mHz);
 
 	adis_dev_auto_scoped_lock(&st->adis) {
 		/* Reset the decimation accumulator before the new value */
@@ -873,6 +947,21 @@ static int adis16607_set_freq(struct adis16607 *st, u32 freq)
 		if (ret)
 			return ret;
 
+		/*
+		 * Writing USER_SYNC restarts the PLL lock, so only do it when
+		 * the scale actually changes.
+		 */
+		if (scale != st->sync_scale) {
+			ret = __adis_write_reg_16(&st->adis,
+						  ADIS16607_REG_USER_SYNC,
+						  ADIS16607_SYNC_MODE_MASK | scale);
+			if (ret)
+				return ret;
+
+			st->sync_scale = scale;
+			st->clk_freq_mHz = clk_freq_mHz;
+		}
+
 		if (dec) {
 			ret = __adis_write_reg_16(&st->adis,
 						  ADIS16607_REG_DEC_RATE, dec);
@@ -1079,6 +1168,17 @@ static const struct iio_info adis16607_info = {
 	.hwfifo_set_watermark = adis16607_set_watermark,
 };
 
+/*
+ * External sync clock ranges in Hz. The datasheet gives 0.8 Hz as the scaled
+ * mode minimum, but clk_get_rate() reports whole Hz so 1 Hz is the lowest
+ * rate we can match.
+ */
+static const struct adis16607_sync adis16607_sync_modes[] = {
+	{ ADIS16607_SYNC_DEFAULT, 0, 0 },
+	{ ADIS16607_SYNC_DIRECT, 1000, 8000 },
+	{ ADIS16607_SYNC_SCALED, 1, 400 },
+};
+
 static const char * const adis16607_status_error_msgs[] = {
 	[9] = "Boot Memory Failure",
 	[11] = "Power Supply Failure",
@@ -1123,6 +1223,8 @@ static const struct adis16607_chip_info adis16607_2_chip_info = {
 	.deltvel_max_val = IIO_G_TO_M_S_2(40),
 	.int_clk_Hz	= 8000,
 	.max_dec	= 65535,
+	.sync_mode	= adis16607_sync_modes,
+	.num_sync	= ARRAY_SIZE(adis16607_sync_modes),
 };
 
 static const struct adis16607_chip_info adis16607_3_chip_info = {
@@ -1138,22 +1240,113 @@ static const struct adis16607_chip_info adis16607_3_chip_info = {
 	.deltvel_max_val = IIO_G_TO_M_S_2(40),
 	.int_clk_Hz	= 8000,
 	.max_dec	= 65535,
+	.sync_mode	= adis16607_sync_modes,
+	.num_sync	= ARRAY_SIZE(adis16607_sync_modes),
 };
 
-/*
- * No external clock sync support yet: always run on the internal clock.
- * Default dec=0 after reset, so period = 1 / clk_freq_mHz.
- */
 static int adis16607_config_clk(struct adis16607 *st)
 {
-	u64 period_ns = NSEC_PER_SEC;
+	const struct adis16607_sync *sync_mode_data = NULL;
+	struct device *dev = &st->adis.spi->dev;
+	struct clk *clk;
+	u64 period_ns;
+	u16 dec;
+	int ret;
+
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (clk) {
+		/* The sync scale and sample period depend on this rate */
+		ret = devm_clk_rate_exclusive_get(dev, clk);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to get exclusive clk rate\n");
+
+		st->ext_clk_Hz = clk_get_rate(clk);
+
+		for (unsigned int i = 1; i < st->info->num_sync; i++) {
+			if (st->ext_clk_Hz >= st->info->sync_mode[i].min_rate &&
+			    st->ext_clk_Hz <= st->info->sync_mode[i].max_rate) {
+				sync_mode_data = &st->info->sync_mode[i];
+				break;
+			}
+		}
+
+		if (!sync_mode_data)
+			return dev_err_probe(dev, -EINVAL,
+					     "Clk rate: %lu not in a valid range\n",
+					     st->ext_clk_Hz);
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
+	/*
+	 * Start at the highest scale that keeps ext_clk * scale at or below
+	 * the internal rate, which the datasheet says the part performs best
+	 * with. set_freq() picks the scale from then on.
+	 */
+	if (st->sync_mode == ADIS16607_SYNC_SCALED)
+		st->sync_scale = st->info->int_clk_Hz / st->ext_clk_Hz;
 
-	st->clk_freq_mHz = st->info->int_clk_Hz * MILLIHZ_PER_HZ;
+	ret = adis_write_reg_16(&st->adis, ADIS16607_REG_USER_SYNC,
+				(st->sync_mode == ADIS16607_SYNC_SCALED) ?
+				ADIS16607_SYNC_MODE_MASK | st->sync_scale : 0);
+	if (ret)
+		return ret;
 
-	/* clk_freq_mHz is in millihertz: scale to get the period in ns */
+	switch (st->sync_mode) {
+	case ADIS16607_SYNC_SCALED:
+		/*
+		 * The effective rate is ext_clk * sync_scale, not necessarily
+		 * int_clk_Hz - use the real value here so sample_period_ns (and
+		 * therefore FIFO sample timestamps) don't drift from it.
+		 */
+		st->clk_freq_mHz = st->ext_clk_Hz * st->sync_scale *
+				   MILLIHZ_PER_HZ;
+		break;
+	case ADIS16607_SYNC_DIRECT:
+		/* DIRECT: external clock is the effective internal rate */
+		st->clk_freq_mHz = st->ext_clk_Hz * MILLIHZ_PER_HZ;
+		break;
+	default:
+		st->clk_freq_mHz = st->info->int_clk_Hz * MILLIHZ_PER_HZ;
+		break;
+	}
+
+	ret = adis_read_reg_16(&st->adis, ADIS16607_REG_DEC_RATE, &dec);
+	if (ret)
+		return ret;
+
+	/*
+	 * Sample period is (dec + 1) / clk_freq, with clk_freq_mHz in
+	 * millihertz. Same u64-first scheme as adis16607_set_freq().
+	 */
+	period_ns = NSEC_PER_SEC;
 	period_ns *= MILLIHZ_PER_HZ;
+	period_ns *= dec + 1;
 	st->sample_period_ns = DIV_ROUND_CLOSEST_ULL(period_ns,
 						     st->clk_freq_mHz);
+
 	return 0;
 }
 

-- 
2.43.0


