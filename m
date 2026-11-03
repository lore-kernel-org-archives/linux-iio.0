Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717587;
	b=JzQHYGGOXic83ztJQe/bNvq2k8wd9miiVmyDv3I7o/Ll7oj/MKzjEwFBuNZ8ic8MzDVq
	 Y8QkLbdoRYnabQKQpe/ruUC1nP64CbYcLXcDZ0i+ID639pNzHwcpPeYDmYISGgo+iREvW
	 FF/bn98pDx/fyH3+jcFduX+TcJf1F0/YJjwCecMZwvJsYWPpdHg1bpHd6Gv5YorN8tbTz
	 98Sa1e25YjhfwCYlAvNFb6oHfn9bRI3Tm0k8rO7dsJlzXM90PgjPtx6NPrH2q55jLuM4T
	 96tG0en5IJYoEvxgKfLt40XdiTj6M/4XeL0l2FFpt6LL9FzOdA1NZF7g5VbdHFnLWVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717587;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1uhNVCTzVS+kGEvz9JwvbAIUa7QZJPUmF5cr7gSzhu4=;
	b=ux/lMN0kHVKl8HK/N8zcKVsAL6x9aKAHGyAlz3dVqno16L8p/aJ3DK62ztJSURH1J/rr
	 zjFR9LhZscH3vxzoil+KU7N3E7ZNh6szAQcCmtJ6K58XshYjZoFKENmRgcMUV58CQP/uR
	 fbZR+2StEAiE+BIjVvKNaOl/jslCnTihOygis8vMRfaCL9bA6/o9iL1EViXq5Zxau3BdW
	 WngPH2hlIfkZh2CAhKuPNoPA3KQnj8egorAuCe2LCTEGZEUIZMdtQs5luIp2FCcd0txRM
	 lpN8VOb/AZrM+/GcUvipH8vCHTnDqrOtpmT4ga9R3cxB7FDQVp6ftMFgxvglMnXsuKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2qYShd4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B960A6F65;
	Tue,  3 Nov 2026 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2qYShd4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793717586;
	b=vovtnMIJ9OvJhbUeG6JdUKBxjAEMGjShMXscClTyfvS0RHmrSBVho5PCGnL8LPfYxSrs
	 JWjHmOt0rCfW+Lor16i385e/cDtKrNud7YdOGG00Wg9tf3q5CVAVv4EMhkkMoJ8hFIHvF
	 QjPc4e/78SHgO7UZmH2KqKkU9e2L2qOBMSICpdu62GYgjikeehlowagmQJvFQK9YiULOC
	 AizqK/P7U0wb2/5qdtrd8kQD3/cAsB5cGWJ0WpU2AWGxJgCJc0qz4Rb2h8JTez7XqP0EP
	 Div/euBfOCT8hg4YW7vbuROvNv6DCARfOJLUHS2nqTsaBQtpLSXSOfExsXDv+Rv+0FQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717586;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1uhNVCTzVS+kGEvz9JwvbAIUa7QZJPUmF5cr7gSzhu4=;
	b=F4jmZ1M0ggfFMFWrOq8ceYFMlFDNxuaGm6/3ploMlmyo8hQHxHpVmC4632cs2OhopAYK
	 wcGeeKICJhkXbw51VAFlS4GuiFHaKHhQtc2T4KQYTOrQsttJkujITLdvdpjUW4wD9EqEf
	 XGd3VLcyjLOf+xaGWB9oC+j72t8GGJW1+htgvFFXalqSE4yfrLSo7gwfcft4Ib54DYX58
	 bW+nEMEznlngS6NTutCE0TqMsB2puocTaxmv+/MAnqkkYJC0MdNNsF2RpPGN14t/F/38o
	 qk5e4000A17tqAUWVwbfiYhirMopeDeX9/I16hnPZojEjc0T/k5b7dQvVU4Xzkrbh7w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B30DE1F00A15;
	Tue,  3 Nov 2026 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717586;
	bh=1uhNVCTzVS+kGEvz9JwvbAIUa7QZJPUmF5cr7gSzhu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=g2qYShd4g4Xm4DvN1PA/XAQhluzTtyIXI7OJ9nw7aR0DdHrDEw29Cogf7kayJYGaH
	 4h/rMdvmukZAPs5MoCh+v5OcymP23wG0Sy/bW/4EV2fEiNrXkNLhLN7xmk5+JRIdLE
	 tOFhEEtLZRvY+vpV/Gr4EkNSTFXz/fP2MMKFjfhMC/n2LlQGK3ixyJ4Bq2hhNCPNjF
	 nv2lACog7kdj4ohF5Gz2T+TpWy7ofuQ/lOCsdNK0Sebm9JSlhx2BQKoYc/pfH+eX5Y
	 NNmP2M66zJdzTLHICoTbtlkJd0z1OVRGa/dvwOtYtT8BcawWSgn8r4s7kh9/BRRdNE
	 F52U2m+bwvGkw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B9E7D469BA;
	Tue,  3 Nov 2026 14:53:01 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Nov 2026 11:53:04 -0300
Subject: [PATCH v3 08/10] iio: frequency: ad9910: support iio backend
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
Message-Id: <20261103-ad9910-backend-support-v3-8-0e9224ddf7b7@analog.com>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
In-Reply-To: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793717581; l=18138;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=bxDb/PfWuKvdNGxSPgVr3O0UX+IplMSBzJkHpK8JcWo=;
 b=B0a46VYbw//2HKZqoK/vtoyZeW12hHuudguNzK1gBhwZT0o4xLftE4IbouMRfotLF4FJ47KpG
 it8H28kJ4KbCu+NdVOT2JHubsIfhMRnXOORImp5qtvOav18sXQ8Zq8g
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 8bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

The AD9910 parallel data port allows modulation of the DDS core parameters
at up to the PDCLK rate, which requires a high-speed data source. Add
support for an optional IIO backend that provides such interface, with
data streamed into the device through an output buffer.

The parallel port channels get scan indexes and scan types according to
the data destination: 14-bit amplitude, 16-bit phase, 16-bit frequency,
or the 8-bit amplitude and phase pair for polar modulation. As only one
destination can be active at a time, this is enforced by the available
scan masks. On buffer enable, the destination is configured in the
backend and the parallel data port is enabled. The sampling_frequency
attribute of the parallel port channels controls the backend data rate.

The backend is also notified about profile changes, as it may drive the
PROFILE[2:0] pins, and the debugfs source attributes now consider the
parallel data port when reporting which channel controls each DDS core
parameter.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/Kconfig  |   1 +
 drivers/iio/frequency/ad9910.c | 222 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 217 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 591476f23ace..b3ed2e39e2fb 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -33,6 +33,7 @@ config AD9910
 	select CRC32
 	select FW_LOADER
 	select FW_UPLOAD
+	select IIO_BACKEND
 	help
 	  Say yes here to build support for Analog Devices AD9910
 	  1 GSPS, 14-Bit DDS with integrated DAC.
diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index 7ab5e9d60476..51b85fdb6cb2 100644
--- a/drivers/iio/frequency/ad9910.c
+++ b/drivers/iio/frequency/ad9910.c
@@ -31,6 +31,7 @@
 #include <linux/units.h>
 #include <linux/unaligned.h>
 
+#include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
@@ -300,6 +301,15 @@ struct ad9910_ram_fw {
 	__be32 words[] __counted_by_be(wcount);
 } __packed;
 
+enum {
+	AD9910_SCAN_IDX_AMP = 0,
+	AD9910_SCAN_IDX_PHASE,
+	AD9910_SCAN_IDX_FREQ,
+	/* polar phase goes first, as it is placed in the lower byte, D[7:0] */
+	AD9910_SCAN_IDX_POLAR_PHASE,
+	AD9910_SCAN_IDX_POLAR_AMP,
+};
+
 enum {
 	AD9910_POWERDOWN,
 	AD9910_DWELL_EN,
@@ -331,6 +341,7 @@ struct ad9910_state {
 	struct gpio_desc *gpio_pwdown;
 	struct gpio_desc *gpio_update;
 	struct gpio_descs *gpio_profile;
+	struct iio_backend *back;
 
 	s64 ramp_up_time_ns;
 	s64 ramp_down_time_ns;
@@ -350,6 +361,7 @@ struct ad9910_state {
 
 	struct ad9910_data data;
 	u8 profile;
+	u8 scan_mask;
 
 	bool ram_fwu_cancel;
 	char ram_fwu_name[20];
@@ -568,6 +580,16 @@ static int ad9910_set_sysclk_freq(struct ad9910_state *st, u32 freq_hz,
 
 	st->data.sysclk_freq_hz = sysclk_freq_hz;
 
+	/*
+	 * SYSCLK is already updated in the device, so the driver state is not
+	 * rolled back on a backend failure. The error is still returned, which
+	 * lets userspace know that something went wrong.
+	 */
+	if (st->back)
+		return iio_backend_set_sampling_freq(st->back,
+						     AD9910_CHAN_IDX_PHY,
+						     sysclk_freq_hz);
+
 	return 0;
 }
 
@@ -579,6 +601,10 @@ static int ad9910_profile_set(struct ad9910_state *st, u8 profile)
 	values[0] = profile;
 	gpiod_multi_set_value_cansleep(st->gpio_profile, values);
 
+	if (st->back)
+		return iio_backend_chan_enable(st->back,
+					       AD9910_CHAN_IDX_PROFILE_0 + profile);
+
 	return 0;
 }
 
@@ -1008,6 +1034,7 @@ static const struct iio_chan_spec_ext_info ad9910_osk_ext_info[] = {
 	.output = 1,						\
 	.channel = AD9910_CHANNEL_PROFILE_ ## idx,		\
 	.address = AD9910_CHAN_IDX_PROFILE_ ## idx,		\
+	.scan_index = -1,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE) |	\
 			      BIT(IIO_CHAN_INFO_FREQUENCY) |	\
 			      BIT(IIO_CHAN_INFO_PHASE) |	\
@@ -1022,6 +1049,7 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_PHY,
 		.address = AD9910_CHAN_IDX_PHY,
+		.scan_index = -1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.ext_info = ad9910_phy_ext_info,
@@ -1040,6 +1068,14 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_PARALLEL,
 		.address = AD9910_CHAN_IDX_PARALLEL_AMP,
+		.scan_index = AD9910_SCAN_IDX_AMP,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 14,
+			.storagebits = 16,
+			.shift = 2,
+		},
+		.info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_PHY],
 	},
 	[AD9910_CHAN_IDX_PARALLEL_PHASE] = {
@@ -1048,7 +1084,14 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_PARALLEL,
 		.address = AD9910_CHAN_IDX_PARALLEL_PHASE,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = AD9910_SCAN_IDX_PHASE,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+		},
+		.info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+				      BIT(IIO_CHAN_INFO_SCALE),
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_PHY],
 	},
 	[AD9910_CHAN_IDX_PARALLEL_FREQ] = {
@@ -1057,7 +1100,14 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_PARALLEL,
 		.address = AD9910_CHAN_IDX_PARALLEL_FREQ,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_OFFSET) |
+		.scan_index = AD9910_SCAN_IDX_FREQ,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+		},
+		.info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+				      BIT(IIO_CHAN_INFO_OFFSET) |
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_PHY],
 	},
@@ -1067,7 +1117,14 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_PARALLEL_POLAR,
 		.address = AD9910_CHAN_IDX_PARALLEL_POLAR_AMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_OFFSET) |
+		.scan_index = AD9910_SCAN_IDX_POLAR_AMP,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 8,
+			.storagebits = 8,
+		},
+		.info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+				      BIT(IIO_CHAN_INFO_OFFSET) |
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_PHY],
 	},
@@ -1077,7 +1134,14 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_PARALLEL_POLAR,
 		.address = AD9910_CHAN_IDX_PARALLEL_POLAR_PHASE,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_OFFSET) |
+		.scan_index = AD9910_SCAN_IDX_POLAR_PHASE,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 8,
+			.storagebits = 8,
+		},
+		.info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+				      BIT(IIO_CHAN_INFO_OFFSET) |
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_PHY],
 	},
@@ -1087,6 +1151,7 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_DRG,
 		.address = AD9910_CHAN_IDX_DRG_FREQ,
+		.scan_index = -1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE) |
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_PHY],
@@ -1097,6 +1162,7 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_DRG,
 		.address = AD9910_CHAN_IDX_DRG_PHASE,
+		.scan_index = -1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE) |
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_PHY],
@@ -1107,6 +1173,7 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_DRG,
 		.address = AD9910_CHAN_IDX_DRG_AMP,
+		.scan_index = -1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE) |
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_PHY],
@@ -1117,6 +1184,7 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_DRG_RAMP_UP,
 		.address = AD9910_CHAN_IDX_DRG_FREQ_RAMP_UP,
+		.scan_index = -1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 				      BIT(IIO_CHAN_INFO_INT_TIME),
@@ -1129,6 +1197,7 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_DRG_RAMP_DOWN,
 		.address = AD9910_CHAN_IDX_DRG_FREQ_RAMP_DOWN,
+		.scan_index = -1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 				      BIT(IIO_CHAN_INFO_INT_TIME),
@@ -1141,6 +1210,7 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_DRG_RAMP_UP,
 		.address = AD9910_CHAN_IDX_DRG_PHASE_RAMP_UP,
+		.scan_index = -1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 				      BIT(IIO_CHAN_INFO_INT_TIME),
@@ -1153,6 +1223,7 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_DRG_RAMP_DOWN,
 		.address = AD9910_CHAN_IDX_DRG_PHASE_RAMP_DOWN,
+		.scan_index = -1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 				      BIT(IIO_CHAN_INFO_INT_TIME),
@@ -1165,6 +1236,7 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_DRG_RAMP_UP,
 		.address = AD9910_CHAN_IDX_DRG_AMP_RAMP_UP,
+		.scan_index = -1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 				      BIT(IIO_CHAN_INFO_INT_TIME),
@@ -1177,6 +1249,7 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_DRG_RAMP_DOWN,
 		.address = AD9910_CHAN_IDX_DRG_AMP_RAMP_DOWN,
+		.scan_index = -1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 				      BIT(IIO_CHAN_INFO_INT_TIME),
@@ -1189,6 +1262,7 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_RAM,
 		.address = AD9910_CHAN_IDX_RAM,
+		.scan_index = -1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE) |
 				      BIT(IIO_CHAN_INFO_FREQUENCY) |
 				      BIT(IIO_CHAN_INFO_PHASE) |
@@ -1201,6 +1275,7 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.output = 1,
 		.channel = AD9910_CHANNEL_OSK,
 		.address = AD9910_CHAN_IDX_OSK,
+		.scan_index = -1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE) |
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
@@ -1314,6 +1389,12 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
 		case AD9910_CHANNEL_PHY:
 			*val = st->data.sysclk_freq_hz;
 			return IIO_VAL_INT;
+		case AD9910_CHANNEL_PARALLEL:
+		case AD9910_CHANNEL_PARALLEL_POLAR:
+			if (!st->back)
+				return -EOPNOTSUPP;
+
+			return iio_backend_read_raw(st->back, chan, val, val2, info);
 		case AD9910_CHANNEL_DRG_RAMP_UP:
 			tmp32 = FIELD_GET(AD9910_DRG_RATE_INC_MSK,
 					  st->reg[AD9910_REG_DRG_RATE].val32);
@@ -1623,6 +1704,17 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 		if (chan->channel == AD9910_CHANNEL_PHY)
 			return ad9910_set_sysclk_freq(st, val, true);
 
+		if (chan->channel == AD9910_CHANNEL_PARALLEL ||
+		    chan->channel == AD9910_CHANNEL_PARALLEL_POLAR) {
+			if (!st->back)
+				return -EOPNOTSUPP;
+			if (val < 0)
+				return -EINVAL;
+
+			return iio_backend_set_sampling_freq(st->back,
+							     chan->address, val);
+		}
+
 		if (val < 0 || val2 < 0 || val > st->data.sysclk_freq_hz / 4)
 			return -EINVAL;
 
@@ -1773,9 +1865,14 @@ static int ad9910_write_raw_get_fmt(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (chan->channel == AD9910_CHANNEL_PHY)
+		switch (chan->channel) {
+		case AD9910_CHANNEL_PHY:
+		case AD9910_CHANNEL_PARALLEL:
+		case AD9910_CHANNEL_PARALLEL_POLAR:
 			return IIO_VAL_INT;
-		return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return IIO_VAL_INT_PLUS_MICRO;
+		}
 	case IIO_CHAN_INFO_SCALE:
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_OFFSET:
@@ -2169,6 +2266,12 @@ static inline const char *ad9910_frequency_source_get(struct ad9910_state *st)
 				 st->reg[AD9910_REG_CFR2].val32))
 		return ad9910_channel_str[AD9910_CHAN_IDX_DRG_FREQ];
 
+	/* Parallel data port enabled and data destination is frequency */
+	mode_en = FIELD_GET(AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
+			    st->reg[AD9910_REG_CFR2].val32);
+	if (mode_en && (st->scan_mask & BIT(AD9910_SCAN_IDX_FREQ)))
+		return ad9910_channel_str[AD9910_CHAN_IDX_PARALLEL_FREQ];
+
 	/* FTW: RAM enabled and data destination is phase, amplitude, or polar */
 	if (ram_en)
 		return ad9910_channel_str[AD9910_CHAN_IDX_RAM];
@@ -2209,6 +2312,16 @@ static inline const char *ad9910_phase_source_get(struct ad9910_state *st)
 				 st->reg[AD9910_REG_CFR2].val32))
 		return ad9910_channel_str[AD9910_CHAN_IDX_DRG_PHASE];
 
+	/* Parallel data port enabled and data destination is phase */
+	mode_en = FIELD_GET(AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
+			    st->reg[AD9910_REG_CFR2].val32);
+	if (mode_en) {
+		if (st->scan_mask & BIT(AD9910_SCAN_IDX_PHASE))
+			return ad9910_channel_str[AD9910_CHAN_IDX_PARALLEL_PHASE];
+		if (st->scan_mask & BIT(AD9910_SCAN_IDX_POLAR_PHASE))
+			return ad9910_channel_str[AD9910_CHAN_IDX_PARALLEL_POLAR_PHASE];
+	}
+
 	/* POW: RAM enabled and data destination is frequency or amplitude */
 	if (ram_en)
 		return ad9910_channel_str[AD9910_CHAN_IDX_RAM];
@@ -2255,6 +2368,16 @@ static inline const char *ad9910_amplitude_source_get(struct ad9910_state *st)
 				 st->reg[AD9910_REG_CFR2].val32))
 		return ad9910_channel_str[AD9910_CHAN_IDX_DRG_AMP];
 
+	/* Parallel data port enabled and data destination is amplitude */
+	mode_en = FIELD_GET(AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
+			    st->reg[AD9910_REG_CFR2].val32);
+	if (mode_en) {
+		if (st->scan_mask & BIT(AD9910_SCAN_IDX_AMP))
+			return ad9910_channel_str[AD9910_CHAN_IDX_PARALLEL_AMP];
+		if (st->scan_mask & BIT(AD9910_SCAN_IDX_POLAR_AMP))
+			return ad9910_channel_str[AD9910_CHAN_IDX_PARALLEL_POLAR_AMP];
+	}
+
 	/* only way to control amplitude at this point is through OSK */
 	if (ram_en)
 		return ad9910_channel_str[AD9910_CHAN_IDX_OSK];
@@ -2283,6 +2406,78 @@ static inline void ad9910_debugfs_init(struct ad9910_state *st,
 			    &ad9910_amplitude_source_fops);
 }
 
+static const u8 ad9910_scan_chan_idx[] = {
+	[AD9910_SCAN_IDX_AMP] = AD9910_CHAN_IDX_PARALLEL_AMP,
+	[AD9910_SCAN_IDX_PHASE] = AD9910_CHAN_IDX_PARALLEL_PHASE,
+	[AD9910_SCAN_IDX_FREQ] = AD9910_CHAN_IDX_PARALLEL_FREQ,
+	[AD9910_SCAN_IDX_POLAR_PHASE] = AD9910_CHAN_IDX_PARALLEL_POLAR_PHASE,
+	[AD9910_SCAN_IDX_POLAR_AMP] = AD9910_CHAN_IDX_PARALLEL_POLAR_AMP,
+};
+
+static u32 ad9910_buffer_chan_idx(struct iio_dev *indio_dev)
+{
+	unsigned int scan_idx = find_first_bit(indio_dev->active_scan_mask,
+					       iio_get_masklength(indio_dev));
+
+	return ad9910_scan_chan_idx[scan_idx];
+}
+
+static int ad9910_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad9910_state *st = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	st->scan_mask = *indio_dev->active_scan_mask;
+	ret = iio_backend_chan_enable(st->back,
+				      ad9910_buffer_chan_idx(indio_dev));
+	if (ret)
+		return ret;
+
+	ret = ad9910_reg32_update(st, AD9910_REG_CFR2,
+				  AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
+				  AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
+				  true);
+	if (ret)
+		iio_backend_chan_disable(st->back,
+					 ad9910_buffer_chan_idx(indio_dev));
+
+	return ret;
+}
+
+static int ad9910_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad9910_state *st = iio_priv(indio_dev);
+	int ret, ret2;
+
+	guard(mutex)(&st->lock);
+
+	st->scan_mask = 0;
+	ret = ad9910_reg32_update(st, AD9910_REG_CFR2,
+				  AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
+				  0, true);
+
+	/* disable the backend channel regardless, return the first error */
+	ret2 = iio_backend_chan_disable(st->back,
+					ad9910_buffer_chan_idx(indio_dev));
+
+	return ret ?: ret2;
+}
+
+static const struct iio_buffer_setup_ops ad9910_buffer_setup_ops = {
+	.preenable = ad9910_buffer_preenable,
+	.postdisable = ad9910_buffer_postdisable,
+};
+
+static const unsigned long ad9910_available_scan_masks[] = {
+	BIT(AD9910_SCAN_IDX_AMP),
+	BIT(AD9910_SCAN_IDX_PHASE),
+	BIT(AD9910_SCAN_IDX_FREQ),
+	BIT(AD9910_SCAN_IDX_POLAR_AMP) | BIT(AD9910_SCAN_IDX_POLAR_PHASE),
+	0
+};
+
 static int ad9910_probe(struct spi_device *spi)
 {
 	static const char * const supplies[] = {
@@ -2326,6 +2521,20 @@ static int ad9910_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(dev_rst),
 				     "failed to get device reset control\n");
 
+	st->back = devm_iio_backend_get_optional(dev, NULL);
+	if (IS_ERR(st->back))
+		return dev_err_probe(dev, PTR_ERR(st->back),
+				     "failed to get iio backend\n");
+	if (st->back) {
+		ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to request iio backend buffer\n");
+
+		indio_dev->setup_ops = &ad9910_buffer_setup_ops;
+		indio_dev->available_scan_masks = ad9910_available_scan_masks;
+	}
+
 	/*
 	 * The IO RESET pin is not used in this driver, as we assume that all
 	 * SPI transfers are complete, but if it is wired up, we need to make
@@ -2440,3 +2649,4 @@ module_spi_driver(ad9910_driver);
 MODULE_AUTHOR("Rodrigo Alencar <rodrigo.alencar@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD9910 DDS driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");

-- 
2.43.0


