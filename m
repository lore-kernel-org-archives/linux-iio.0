Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B4471264;
	Thu,  8 Oct 2026 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448345; cv=none; b=XMVAkNRXJ2qqB9mwFaRnt2qqPr6/XxUlMo4rAzPD6m3X/cVP9OIUZjQ3pAq0xeH0B0z6pmXuzJRrR9Iqoa4MsSv5dhbiwmjK+x5KJi688ynFP9/0nk+NBVrKQl5cMXILQOOnecDTHUGFUmH4+q5Hpx+86QfygywVC6riw9nW7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448345; c=relaxed/simple;
	bh=wqjtZfYdSyq87rdyaySlCVMf79FASBdXubMvbq5w7KM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gCUjA+LEn8JuEak59VS1Qzy1xEMqxxO+yZzNPuI/qdEDFfRWiUYe+YQl8K5erLfqjf+oMwrYcXfmqwMXxJVCSpqNv3/loYrsWmCq0SKk4QimCGZFIMmgc82XISwIveRNwuRAgSeE4mX2kJGX0rpY8Ji/6d0pjaMZPHGfwqNel58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwq2WMCy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwq2WMCy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E75DC4AF11;
	Thu,  8 Oct 2026 08:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791448345;
	bh=wqjtZfYdSyq87rdyaySlCVMf79FASBdXubMvbq5w7KM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hwq2WMCyJ0dIW450QjhNCzBqjCMNQloM1A5abTbJi7LRSPi7Q7ekzzjpp56gjRMkR
	 wOxLuexTdatDuQ0acYgk7bToYT5qh//t2XNhxksAq2NUvhcxhY72p8onOz3/ulPVMx
	 BngPO9bpvbVjKCaxXCWGwRZoVU7ZRcpdd7ZvfiZxHQvMczUmL4pwRRCzWDfUGOH17C
	 IahaouBxXY7+NeerhY3QhzquqVn7I9j/hdhOMP1QzPxa1ibD/fWGjFxiBUItprQFyc
	 W1jEfAzr+/KWxSCfOwHgmf/ewApeV1EBlrA2bCcnn8Z+qoIa0MUFDd1MMnBIl5Y8GH
	 2kH27rtiItCOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149B7CA600B;
	Thu,  8 Oct 2026 08:32:25 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Thu, 08 Oct 2026 11:31:57 +0300
Subject: [PATCH v2 5/6] iio: imu: adis16607: Add external clock sync
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261008-adis16607-v2-5-7c94df80878a@analog.com>
References: <20261008-adis16607-v2-0-7c94df80878a@analog.com>
In-Reply-To: <20261008-adis16607-v2-0-7c94df80878a@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791448343; l=5885;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=1CKBAD3Qy+qLZgYcU4cSY2B5g+NSBbHeriyyv2liYZ4=;
 b=fylgWk2azz5iRPSHhtfEdOgTZDarCc2XazRIfMIxZPnJ05e40N7rh6kENYUCp6caGf/m7ojv2
 UAnogN8jQHHBP4WFN3D3dkriVIVZCCE7kW17z5wDCpwchZ3Ifw4o489
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com

From: Radu Sabau <radu.sabau@analog.com>

Add support for an optional external clock (clocks property),
selecting between SYNC_DIRECT and SYNC_SCALED modes depending on the
supplied frequency, with the internal 8 kHz clock used as the default
when no clock is provided.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis16607.c | 102 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
index 90688037cbd3..0147eba0b173 100644
--- a/drivers/iio/imu/adis16607.c
+++ b/drivers/iio/imu/adis16607.c
@@ -6,6 +6,7 @@
  */
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/iio/buffer.h>
@@ -47,6 +48,7 @@
 #define ADIS16607_REG_FIFO_WORD_CNT	0x2B
 #define ADIS16607_REG_USER_GPIO_CFG	0x2F
 #define ADIS16607_REG_SPI_HALFDUPLEX	0x32
+#define ADIS16607_REG_USER_SYNC		0x33
 #define ADIS16607_REG_USER_DATA_CFG	0x34
 #define ADIS16607_REG_USER_FIFO_CFG	0x35
 #define ADIS16607_REG_SOFT_RESET	0x36
@@ -59,10 +61,12 @@
 
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
@@ -89,8 +93,22 @@
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
@@ -102,6 +120,7 @@ struct adis16607_chip_info {
 	u32 deltvel_max_val;
 	u32 int_clk;
 	u16 max_dec;
+	u8 num_sync;
 };
 
 struct adis16607 {
@@ -109,6 +128,7 @@ struct adis16607 {
 	struct adis adis;
 	unsigned long clk_freq;	/* millihertz */
 	u64 sample_period_ns;
+	u32 sync_mode;
 	u16 fifo_watermark;
 	/* Scratch buffer used for FIFO pop operations, see adis16607_fifo_pop() */
 	u8 *fifo_buf;
@@ -1089,6 +1109,12 @@ static const struct iio_info adis16607_info = {
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
@@ -1128,7 +1154,9 @@ static const struct adis_data adis16607_data = {
 	.temp_scale	= 5,						\
 	.deltvel_max_val = IIO_G_TO_M_S_2(40),				\
 	.int_clk	= 8000,						\
-	.max_dec	= 65535
+	.max_dec	= 65535,					\
+	.sync_mode	= adis16607_sync_modes,				\
+	.num_sync	= ARRAY_SIZE(adis16607_sync_modes)
 
 static const struct adis16607_chip_info adis16607_2_chip_info = {
 	ADIS16607_CHIP_INFO_COMMON,
@@ -1146,15 +1174,75 @@ static const struct adis16607_chip_info adis16607_3_chip_info = {
 	.deltang_max_val = IIO_DEGREE_TO_RAD(2000),
 };
 
-/*
- * No external clock sync support yet: always run on the internal clock.
- * Default dec=0 after reset, so period = 1 / clk_freq.
- */
 static int adis16607_config_clk(struct adis16607 *st)
 {
-	st->clk_freq = (unsigned long)st->info->int_clk * 1000;
+	struct device *dev = &st->adis.spi->dev;
+	const struct adis16607_sync *sync_mode_data = NULL;
+	unsigned long ext_clk_hz;
+	struct clk *clk;
+	int i;
+
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (!clk) {
+		st->clk_freq = (unsigned long)st->info->int_clk * 1000;
+		st->sync_mode = ADIS16607_SYNC_DEFAULT;
+		st->sample_period_ns = DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * 1000ULL,
+							     st->clk_freq);
+		return 0;
+	}
+
+	ext_clk_hz = clk_get_rate(clk);
+
+	for (i = 1; i < st->info->num_sync; i++) {
+		if (ext_clk_hz >= st->info->sync_mode[i].min_rate &&
+		    ext_clk_hz <= st->info->sync_mode[i].max_rate) {
+			sync_mode_data = &st->info->sync_mode[i];
+			break;
+		}
+	}
+
+	if (!sync_mode_data)
+		return dev_err_probe(dev, -EINVAL,
+				     "Clk rate: %lu not in a valid range\n",
+				     ext_clk_hz);
+
+	st->sync_mode = sync_mode_data->sync_mode;
+	/* DIRECT: external clock is the effective internal rate */
+	st->clk_freq = ext_clk_hz * 1000;
+
+	/* Configure sync via USER_GPIO_CFG and USER_SYNC registers */
+	if (st->sync_mode != ADIS16607_SYNC_DEFAULT) {
+		int ret;
+
+		/* Enable sync GPIO function */
+		ret = adis_update_bits_base(&st->adis, ADIS16607_REG_USER_GPIO_CFG,
+					    ADIS16607_SYNC_GPIO_MASK,
+					    FIELD_PREP(ADIS16607_SYNC_GPIO_MASK, 1), 2);
+		if (ret)
+			return ret;
+
+		/* Set sync mode in USER_SYNC register */
+		if (st->sync_mode == ADIS16607_SYNC_SCALED) {
+			u16 sync_scale;
+
+			sync_scale = st->info->int_clk / ext_clk_hz;
+			ret = adis_write_reg_16(&st->adis, ADIS16607_REG_USER_SYNC,
+						ADIS16607_SYNC_MODE_MASK | sync_scale);
+			if (ret)
+				return ret;
+
+			/* SCALED: effective rate is int_clk (ext_clk × sync_scale ≈ int_clk) */
+			st->clk_freq = (unsigned long)st->info->int_clk * 1000;
+		}
+	}
+
+	/* Default dec=0 after reset: period = 1 / clk_freq */
 	st->sample_period_ns = DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * 1000ULL,
-						     st->clk_freq);
+						      st->clk_freq);
+
 	return 0;
 }
 

-- 
2.43.0


