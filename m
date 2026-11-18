Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795007868;
	b=ZcT1LSVwPrtAF/1c8n2mR7pPDPWZ+lzRzgkhwpMkerZTcblLIOvwh581yie1dx+azsHf
	 XKhUw7qjZVMIaXgSKEO0a8Fzr+VISBk2aWenskXe9OGpONliZYMW3wmPMFU2N4bcLwFzq
	 gpSw4f+6a+hbGTu1OKtnLO9NsjjujH0PrSfTtfsTrt3HfK0nyCkOaP1zytHsyapc83IRJ
	 Zc5dBQHPaJg+vwXl6NQT2kmcEUxi712q3Nzyn2Lng7uLDdrREFR+rhoYJYY9T8iiNdSMI
	 YMGcMsYZZJQ0OALJ2iIib7N9xN/Yk9NVjmpgJSnDFuzfZCGPtJrfySCn+4PmcbL130g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007868;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=viW8fyJXZPatv3FgOkRhLz/ynsQIkjkuIQq+DJX78NI=;
	b=ZABYXc9iMNVGm493DYckTajIK6mGTrzW6dhDyjfhpOFk1Cf/qZ/T4UARuncllbNc18xV
	 laD4frx9TWbxZQ9THSP1eeZxtEWNOg9VcCiLn7Bf9gxOVbBIuoVc4CtEWpdMffnWi7aQ/
	 Igk2NIzyctD+5aJRZ72201LwlqlzuuqiwmP/qcYlvJHvJ1NKYPF7cBoOmTwdX+TOuGJO6
	 Ul/yD84w4BKx9/YLicH5x6NtlM0n5iBQiDrMEf9+LF8XEN4j37KOeoYVmIk1qCG5zb+/8
	 Kt6vjOAHTSsGE1DOB2/evKxn9QNrrGQLyelj3p8e2gkMXNoPhwixS430Yv+sh0/li/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=innhysYN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF33E60A2623;
	Wed, 18 Nov 2026 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=innhysYN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795007868;
	b=N2uL2LJC3kZnFDD/EFEafGqUwony3Bkc9NhfxxESGZAtmjeKbHOs+mHCsi4bRrgdnew8
	 Jt3ay9Z4JAlrcoIAtTzoknfuD/EXzfeysWG+r+ky0HCPUS0rkSmF+TAJnCGmb2ovAj//8
	 +eEEwulqqBcv1s4LQrAL2koK3uGcxzaxSizouu6B1vQnWkM0bjgwqQEdJPJ58QeSLSBmm
	 ghPdlskpR6Oppc+X7O9WvKZr8rebOJBu49p4Jw7F9hm/RGSVYD3LAPyfj7dOWQqruN5TF
	 ntiApqA5AaQ0DeYWcym6K+pA89me7HB1pXc65QElBsRtNkvYbopmWyV3yYY4tCXzBWQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007868;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=viW8fyJXZPatv3FgOkRhLz/ynsQIkjkuIQq+DJX78NI=;
	b=EmRsNX485Bo9kvaY0eqCr6eZXJ8GCgOgIh453TOYRLwih0YKNfJs7j+1oR2g1gqiK79C
	 NEWoxNgyjqa7dP/6rIM57v6ydZY9VL9AR+FWysTauLgUc4PInaVz0gJUBu2KpHgBLKegz
	 l68hvk6l7irrn8U8u4ZP+fMxnEJWPJ66tQuGjREvnUUf7vH7k8qPWPRavAVE9As8+fOu3
	 GvF07gLztX0kkitP3uNiOcGw6dkzRbifHCbj+K3hy7SwZIXs2nKV9Gw0JZ/tpSxdsAL/A
	 D49l+YqEiFJeB8FDzpAsdqsnM4XNm/hTRI7i8+sMcADIL5dCppKCBzguBNMMis2jw9A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 131831F000CD;
	Wed, 18 Nov 2026 13:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795007868;
	bh=viW8fyJXZPatv3FgOkRhLz/ynsQIkjkuIQq+DJX78NI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=innhysYN5oI5Ql19UcCrQLW8EWUWT1CysXyd2RX/a9ND4S1/o61VaOUQteeLFaX3+
	 W+ep+ys68wU3XpvDXgP462eSckqjXOeJAfccWXMFbDNZXzrooWP6d/l9sgljpBDJJR
	 K7UiIUxI0wo74adPsiMRKXt/wK9FjxRcUVtgrKjy8hjpSVn7T7gF0hVhPOlFXLRlMG
	 NOGuqt19+ehLzC2SYo6Tvbk136ooRGpJXB+s5j/4GlY7qV50dybOCzS5tDcLIxGvgr
	 Z0y3zD37L9MJEDS4mTdOZO1nFbi24bFj8Flg7S0MUf8bjEMF+5unYuaY6ZQAfuKwEC
	 +kKNAIqRrcRqQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C070E4ADAC;
	Wed, 18 Nov 2026 13:17:45 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Wed, 18 Nov 2026 15:17:48 +0200
Subject: [PATCH v7 6/7] iio: imu: adis16607: Add external clock sync
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
Message-Id: <20261118-adis16607-v7-6-707609737691@analog.com>
References: <20261118-adis16607-v7-0-707609737691@analog.com>
In-Reply-To: <20261118-adis16607-v7-0-707609737691@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Robert Budai <robert.budai@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux@analog.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795007863; l=9337;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=5qVI0G3o2MN7BZvrrZ/vbU7iOmFBM5+ZR0FoEUCi6xA=;
 b=Wi/cGoux+rvZfJmUj4/6fmwDFfvQsbrTs6KIrE/pHJnMZd0HD39gIW7pquF9UsJWIGzhJ+Lom
 nMlQ5P4cpEfBcky4oY6RjBUZSVWpr9wRIqB1izmEZ2xBq8F1QFqln2j
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
at or below the internal rate.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis16607.c | 187 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 181 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
index c53f3e62d3fc..f8f0edcb5d6b 100644
--- a/drivers/iio/imu/adis16607.c
+++ b/drivers/iio/imu/adis16607.c
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/build_bug.h>
+#include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
@@ -44,6 +45,7 @@
 #define ADIS16607_REG_TEMP		0x20
 #define ADIS16607_REG_USER_GPIO_CFG	0x2F
 #define ADIS16607_REG_SPI_HALFDUPLEX	0x32
+#define ADIS16607_REG_USER_SYNC		0x33
 #define ADIS16607_REG_SOFT_RESET	0x36
 #define ADIS16607_REG_SELF_TEST		0x39
 #define ADIS16607_REG_DEC_RATE		0x3A
@@ -54,6 +56,8 @@
 
 /* Masks */
 #define ADIS16607_RESET_GPIO_MASK	GENMASK(2, 0)
+#define ADIS16607_SYNC_GPIO_MASK	GENMASK(8, 6)
+#define ADIS16607_SYNC_MODE_MASK	BIT(15)
 #define ADIS16607_BOOTLOADER_BUSY_MASK	BIT(0)
 
 /* Self-test registers and masks */
@@ -66,8 +70,22 @@
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
@@ -79,12 +97,16 @@ struct adis16607_chip_info {
 	u32 deltvel_max_val;
 	u32 int_clk_Hz;
 	u16 max_dec;
+	u8 num_sync;
 };
 
 struct adis16607 {
 	struct adis adis;
 	const struct adis16607_chip_info *info;
 	unsigned long clk_freq_mHz;
+	unsigned long ext_clk_Hz;
+	u32 sync_mode;
+	u16 sync_scale;
 	u16 dec;
 };
 
@@ -480,19 +502,60 @@ static int adis16607_get_freq(struct adis16607 *st, u32 *freq)
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
 	u32 dec;
 	int ret;
 
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
 
 	adis_dev_auto_scoped_lock(&st->adis) {
 		/* Reset the decimation accumulator before the new value */
@@ -502,6 +565,21 @@ static int adis16607_set_freq(struct adis16607 *st, u32 freq)
 
 		st->dec = 0;
 
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
@@ -681,6 +759,17 @@ static const struct iio_info adis16607_info = {
 	.debugfs_reg_access = adis_debugfs_reg_access,
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
@@ -724,6 +813,8 @@ static const struct adis16607_chip_info adis16607_2_chip_info = {
 	.deltvel_max_val = IIO_G_TO_M_S_2(40),
 	.int_clk_Hz	= 8000,
 	.max_dec	= 65535,
+	.sync_mode	= adis16607_sync_modes,
+	.num_sync	= ARRAY_SIZE(adis16607_sync_modes),
 };
 
 static const struct adis16607_chip_info adis16607_3_chip_info = {
@@ -739,12 +830,96 @@ static const struct adis16607_chip_info adis16607_3_chip_info = {
 	.deltvel_max_val = IIO_G_TO_M_S_2(40),
 	.int_clk_Hz	= 8000,
 	.max_dec	= 65535,
+	.sync_mode	= adis16607_sync_modes,
+	.num_sync	= ARRAY_SIZE(adis16607_sync_modes),
 };
 
-/* No external clock sync support yet: always run on the internal clock */
 static int adis16607_config_clk(struct adis16607 *st)
 {
-	st->clk_freq_mHz = st->info->int_clk_Hz * MILLIHZ_PER_HZ;
+	const struct adis16607_sync *sync_mode_data = NULL;
+	struct device *dev = &st->adis.spi->dev;
+	struct clk *clk;
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
+
+	ret = adis_write_reg_16(&st->adis, ADIS16607_REG_USER_SYNC,
+				(st->sync_mode == ADIS16607_SYNC_SCALED) ?
+				ADIS16607_SYNC_MODE_MASK | st->sync_scale : 0);
+	if (ret)
+		return ret;
+
+	switch (st->sync_mode) {
+	case ADIS16607_SYNC_SCALED:
+		/*
+		 * The effective rate is ext_clk * sync_scale, not necessarily
+		 * int_clk_Hz - use the real value here so the sampling
+		 * frequency is derived from it.
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
 
 	return adis_read_reg_16(&st->adis, ADIS16607_REG_DEC_RATE, &st->dec);
 }

-- 
2.43.0


