Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792682353;
	b=rFivczNDKPP7lWvcjYop23XO9EEQ4XduDHIW/+G1YsXqbCqGy/58cSZ+AwxaP53RYmEX
	 Jirpp4RJ88Xlrdwq4EP7fC39k/FWHB5FRF86kXGZHS682m+LxOLZ+Oa5elhSK4fHzuKo+
	 +Joz6ojWa3hLmzn6BmbdM+8WcYta9O+Z87RHFGhrO68I4uWE+k4WNSq1bTmW4+8JrBfpz
	 N8z05TL8OrY7HSTdHoQ/H5M8pJgBlgRMRUx60/NYzFaMusKuTM0VWfw0F8sAP0i+/em3b
	 rYoPrgzTYx2nImkEQu8gVbIE2gxXVEJXR3YlE157gmCeR5P4N8L2cD780EnIjBVI1Hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682353;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oJsB/DytyL4k823jwaMeEOB0kGngjvgULQLUFB1RXrg=;
	b=VB2y5uzxn1xKF/ZE3egWGRlOQCuRHoAMbzEWVxYFuFfmxpi07w3SKlE0q2J95tbm/yLF
	 Tz1hxR2mqD7XKfj/BP0LdS/PrVLhmt//1GV5larG6Fs4bu7vXTyEQwNET26N3G9yyYe+8
	 u3P7roBofhRC2732rYgRF+OwEDS74l2Gl3/RqsAv1zB0YgHatXFRBSnZiut0YddnWebdU
	 3Asxi5kmvXgHYJwTUg9O6yobCepyraty/S7xr3zMs+okbYmcDArBcNU/lijYQmhJSfdIM
	 ILF+lyKSNGmlFs26qFteNNQI06IzjyDFIkXTnYjjbb7RT4gJBU3D79wRknAc1GQ0sTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdiPlTmb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A37606D4C9;
	Thu, 22 Oct 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdiPlTmb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792682352;
	b=oQWFHc3FQIE9/JB8SQKZwPO8ThxF33mgnCj/oazsKXycOzUqHDyIzpo97PF+L72AkEYF
	 HGLQ06dckLH0BAzUfPBpINvDqwKKmgP9Yj72erDyC9gsnOfadV9jYK1oUJGITDkaErlAj
	 vIung0m05y1DQ6c48RZbjW9nYXV+r4xwMSYXocPj4uSXUAiMDk0FAYG9OVtm4BrN6ZvIu
	 NyFkdvMdwSxkgvgk0rDjE9Bc8p+UnzNQC1SBvDtmsmBVy4+VxsZOEM6MKztGpcTWJCn4H
	 oZ1whzx2y6k5R+oXXWu1T2tNcloe7jqnBQfCValsApH2DYXYvZVT8WvbNhn73hpYYSw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792682352;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oJsB/DytyL4k823jwaMeEOB0kGngjvgULQLUFB1RXrg=;
	b=zJmLVL0tzm6Sp9wnw1x3SlyFv7EF+2IfVZWqjPFL6yMjWvOi3YpDJ6RvLJxxeGT8shlR
	 sCodkPPnLu9LliRFd/eAD0hE9FxbP9NpQwnQHWb7qqdbnZK7eyS/2c7Jxx94FnR3DzcZM
	 n5NAz4IkoCJxBU0d1l+B3UGCpNH7jVwmWzRBnFYV+81UX3p8wxCAUHDlKOSNhMaeRqR09
	 mNNykrF/n5ah54vjbOO0Y7jfKdfWYiu/uFZlCvVGo9ZGyNFbkhPhf1+IWoj9RzhCzbogI
	 KdpYTpJdfxTZZM/Embi+BNI2hMOpIekBJz7v/XJGn9uCw9Mn/o6Wm9wNtD22YtxpQ0A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C2DDF1F031E6;
	Thu, 22 Oct 2026 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682352;
	bh=oJsB/DytyL4k823jwaMeEOB0kGngjvgULQLUFB1RXrg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZdiPlTmbXws2tGpJbGfKd1CPYZfaaOtZuRyTtpTiAkUnXfDYDL2NSyGnNhduAyzDU
	 0tQuYTVvMaXvtRdnMQWYM9kPoPcXmGzr5B7BLzDvA9tDn0QV4nyCg1uLIrJ/5pOFe8
	 NX2sj9lVOE6xYwRyf4wATXnz95nn8Qvuw12qKXUr9QE51d2YsEaTxGHUusLXbQBrP/
	 80JOZLdACz5ufhS2TDvy1RkaLO8V2xWX3MnBf3eAJXSQB9joaKWsqPhgkK5eZaTnsA
	 ldEPW1kh2AcCeaydLtkkCYQskoZjJuF2ovXYfmv3RdtfWP9N1ahtENnkuELmQ68fak
	 JNoRyn+oJs7nA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 954AB41E5E;
	Thu, 22 Oct 2026 15:19:08 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 22 Oct 2026 12:19:04 -0300
Subject: [PATCH v2 06/10] iio: frequency: ad9910: add axi backend driver
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
Message-Id: <20261022-ad9910-backend-support-v2-6-0ff7f0bff326@analog.com>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
In-Reply-To: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792682347; l=18974;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=b81S0u53Z7GW/he410X9LoYNn4PYTbzojgL2N4oyueE=;
 b=Y4q2a7o/PLmoZTvqF1+J8xUMcY+1V7ssKZBZMzL3uGiARjLDnvF6XxDs4F7PUPBvLkIyqPbwa
 +KgAPENTPoWCJCBcCkB3QFO42RbJgCXG+6hDsnQ6TnjJIg3+B/4Ggi0
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add the driver for the AD9910 AXI backend IP core, which interfaces with
the data and control pins of the AD9910 DDS. It registers as an IIO
backend that provides:

- a DMA output buffer that streams data into the parallel data port;
- the parallel data destination (F[1:0] pins) and data rate, derived
  from the PDCLK frequency;
- the PROFILE[2:0] pins control, through profile channel enables.

It also registers a PWM chip with a single output driving the DRCTL
pin, which the AD9910 driver uses to control the digital ramp generator
direction. The PWM implements the waveform callbacks, with period, duty
length and duty offset programmed in SYNC_CLK cycles. The duty offset
is realized by a delay applied once, before DRCTL starts toggling. The
waveform is reprogrammed when the SYNC_CLK rate changes, so that the PWM
output keeps its timing.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 MAINTAINERS                                |   1 +
 drivers/iio/frequency/Kconfig              |  17 +
 drivers/iio/frequency/Makefile             |   1 +
 drivers/iio/frequency/ad9910-axi-backend.c | 525 +++++++++++++++++++++++++++++
 4 files changed, 544 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64aa7b539ca3..abfbbf0b6b4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1734,6 +1734,7 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
 F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910-axi-backend.yaml
 F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
 F:	Documentation/iio/ad9910.rst
+F:	drivers/iio/frequency/ad9910-axi-backend.c
 F:	drivers/iio/frequency/ad9910.c
 F:	drivers/iio/frequency/ad9910.h
 
diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 994d199080eb..f7f5c3cce005 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -42,6 +42,23 @@ config AD9910
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad9910.
 
+config AD9910_AXI_BACKEND
+	tristate "Analog Devices AD9910 AXI Backend driver"
+	depends on AD9910
+	depends on HAS_IOMEM && PWM
+	select IIO_BACKEND
+	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
+	select REGMAP_MMIO
+	help
+	  Say yes here to build support for the AXI Backend Driver for the
+	  Analog Devices AD9910 DDS. The IP core is used to drive digital ramp
+	  control pins and interface with the parallel data port of the AD9910
+	  device.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad9910-axi-backend.
+
 endmenu
 
 #
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index e3b1d36ed620..bfac9e205e81 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -6,6 +6,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD9523) += ad9523.o
 obj-$(CONFIG_AD9910) += ad9910.o
+obj-$(CONFIG_AD9910_AXI_BACKEND) += ad9910-axi-backend.o
 obj-$(CONFIG_ADF41513) += adf41513.o
 obj-$(CONFIG_ADF4350) += adf4350.o
 obj-$(CONFIG_ADF4371) += adf4371.o
diff --git a/drivers/iio/frequency/ad9910-axi-backend.c b/drivers/iio/frequency/ad9910-axi-backend.c
new file mode 100644
index 000000000000..f5374aeb2afe
--- /dev/null
+++ b/drivers/iio/frequency/ad9910-axi-backend.c
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AD9910 AXI Backend driver
+ *
+ * Copyright 2026 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+
+#include <linux/iio/backend.h>
+#include <linux/iio/buffer-dmaengine.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+
+#include "ad9910.h"
+
+/* Register addresses */
+#define AD9910_AXI_REG_RESET		0x040
+#define AD9910_AXI_REG_DRG		0x084
+#define AD9910_AXI_REG_PROFILE		0x088
+#define AD9910_AXI_REG_DRCTL_PERIOD	0x08C
+#define AD9910_AXI_REG_DRCTL_WIDTH	0x090
+#define AD9910_AXI_REG_DRCTL_DELAY	0x094
+#define AD9910_AXI_REG_BURST_COUNT	0x098
+#define AD9910_AXI_REG_BURST_DELAY	0x09C
+#define AD9910_AXI_REG_RAMP_CFG		0x0A0
+
+#define AD9910_AXI_REG_UPDATE_CTRL	0x104
+#define AD9910_AXI_REG_PAR_RATE		0x108
+#define AD9910_AXI_REG_F_CFG		0x10C
+
+#define AD9910_AXI_REG_RESET_CORE_MSK		BIT(0)
+
+#define AD9910_AXI_REG_DRG_DRCTL_MSK		BIT(2)
+#define AD9910_AXI_REG_DRG_TOGGLE_EN_MSK	BIT(3)
+
+#define AD9910_AXI_REG_RAMP_CFG_ONE_SHOT_MSK	GENMASK(1, 0)
+#define AD9910_AXI_REG_BURST_COUNT_MSK		GENMASK(19, 0)
+
+#define AD9910_AXI_REG_UPDATE_RATE_MSK		BIT(0)
+#define AD9910_AXI_REG_UPDATE_PAR_IF_EN_MSK	BIT(1)
+#define AD9910_AXI_REG_UPDATE_EXT_TRIG_MSK	BIT(2)
+
+#define AD9910_AXI_REG_PROFILE_MSK		GENMASK(2, 0)
+#define AD9910_AXI_REG_IO_UPDATE_MSK		BIT(0)
+#define AD9910_AXI_REG_F_CFG_MSK		GENMASK(1, 0)
+
+#define AD9910_AXI_PD_CLK_MAX_FREQ_HZ		(250ULL * HZ_PER_MHZ)
+#define AD9910_AXI_PAR_RATE_MAX			U16_MAX
+#define AD9910_AXI_ONE_SHOT_BURST		1
+
+struct ad9910_axi_state {
+	struct device *dev;
+	struct regmap *regmap;
+	/*
+	 * lock to protect multiple accesses to the device registers and global
+	 * data/variables.
+	 */
+	struct mutex lock;
+	u64 pd_clk_freq_uhz;
+	/* last applied DRCTL waveform, kept when the SYNC_CLK rate changes */
+	struct pwm_waveform drctl_wf;
+};
+
+/* DRCTL waveform in SYNC_CLK cycles, a zero period means disabled */
+struct ad9910_axi_drctl_wfhw {
+	u32 period;
+	u32 width;
+	u32 delay;
+};
+
+static u32 ad9910_axi_ns_to_cycles(struct ad9910_axi_state *st, u64 ns)
+{
+	return min(mul_u64_u64_div_u64(ns, st->pd_clk_freq_uhz,
+				       1ULL * NANO * MICROHZ_PER_HZ), U32_MAX);
+}
+
+static u64 ad9910_axi_cycles_to_ns(struct ad9910_axi_state *st, u32 cycles)
+{
+	return mul_u64_u64_div_u64_roundup((u64)cycles * NANO, MICROHZ_PER_HZ,
+					   st->pd_clk_freq_uhz);
+}
+
+static int ad9910_axi_drctl_tohw(struct ad9910_axi_state *st,
+				 const struct pwm_waveform *wf,
+				 struct ad9910_axi_drctl_wfhw *wfhw)
+{
+	if (!wf->period_length_ns) {
+		*wfhw = (struct ad9910_axi_drctl_wfhw){ };
+		return 0;
+	}
+
+	wfhw->period = ad9910_axi_ns_to_cycles(st, wf->period_length_ns);
+	if (!wfhw->period) {
+		/* round up to the shortest period, with no duty and no delay */
+		*wfhw = (struct ad9910_axi_drctl_wfhw){ .period = 1 };
+		return 1;
+	}
+
+	wfhw->width = min(ad9910_axi_ns_to_cycles(st, wf->duty_length_ns),
+			  wfhw->period);
+	/*
+	 * The delay is applied once, before DRCTL starts toggling, which
+	 * results in the duty offset of the periodic waveform. A delay of a
+	 * whole period is the same as no delay at all.
+	 */
+	wfhw->delay = ad9910_axi_ns_to_cycles(st, wf->duty_offset_ns);
+	if (wfhw->delay >= wfhw->period)
+		wfhw->delay = 0;
+
+	return 0;
+}
+
+static void ad9910_axi_drctl_fromhw(struct ad9910_axi_state *st,
+				    const struct ad9910_axi_drctl_wfhw *wfhw,
+				    struct pwm_waveform *wf)
+{
+	if (!wfhw->period) {
+		*wf = (struct pwm_waveform){ };
+		return;
+	}
+
+	wf->period_length_ns = ad9910_axi_cycles_to_ns(st, wfhw->period);
+	wf->duty_length_ns = ad9910_axi_cycles_to_ns(st, wfhw->width);
+	wf->duty_offset_ns = ad9910_axi_cycles_to_ns(st, wfhw->delay);
+}
+
+static int ad9910_axi_drctl_write(struct ad9910_axi_state *st,
+				  const struct ad9910_axi_drctl_wfhw *wfhw)
+{
+	int ret;
+
+	/*
+	 * DRCTL toggling restarts, applying the delay, when enabled or when
+	 * its period or width changes. Changing the delay alone does not
+	 * restart it, so disable toggling while updating the waveform.
+	 */
+	ret = regmap_clear_bits(st->regmap, AD9910_AXI_REG_DRG,
+				AD9910_AXI_REG_DRG_TOGGLE_EN_MSK);
+	if (ret || !wfhw->period)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD9910_AXI_REG_DRCTL_DELAY, wfhw->delay);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD9910_AXI_REG_DRCTL_WIDTH, wfhw->width);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD9910_AXI_REG_DRCTL_PERIOD, wfhw->period);
+	if (ret)
+		return ret;
+
+	/*
+	 * Register values reach the SYNC_CLK domain in snapshots, taken every
+	 * 64 AXI clock cycles. Make sure toggling being disabled is captured
+	 * by one of them before enabling it again.
+	 */
+	fsleep(2);
+
+	return regmap_set_bits(st->regmap, AD9910_AXI_REG_DRG,
+			       AD9910_AXI_REG_DRG_TOGGLE_EN_MSK);
+}
+
+static int ad9910_axi_chan_enable(struct iio_backend *back, unsigned int chan)
+{
+	struct ad9910_axi_state *st = iio_backend_get_priv(back);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	switch (chan) {
+	/*
+	 * Profiles are mutually exclusive, as the PROFILE[2:0] pins always
+	 * select one of them. Enabling a profile channel selects it, which
+	 * implicitly disables the previously selected one, hence there is
+	 * nothing to do when disabling a profile channel.
+	 */
+	case AD9910_CHAN_IDX_PROFILE_0 ... AD9910_CHAN_IDX_PROFILE_7:
+		chan -= AD9910_CHAN_IDX_PROFILE_0;
+		return regmap_update_bits(st->regmap, AD9910_AXI_REG_PROFILE,
+					  AD9910_AXI_REG_PROFILE_MSK,
+					  FIELD_PREP(AD9910_AXI_REG_PROFILE_MSK, chan));
+	case AD9910_CHAN_IDX_PARALLEL_AMP ... AD9910_CHAN_IDX_PARALLEL_POLAR_PHASE:
+		/*
+		 * F[1:0] destination follows the parallel channel order:
+		 * amplitude, phase, frequency and polar.
+		 */
+		chan = min(chan - AD9910_CHAN_IDX_PARALLEL_AMP,
+			   FIELD_MAX(AD9910_AXI_REG_F_CFG_MSK));
+		ret = regmap_update_bits(st->regmap, AD9910_AXI_REG_F_CFG,
+					 AD9910_AXI_REG_F_CFG_MSK, chan);
+		if (ret)
+			return ret;
+
+		return regmap_set_bits(st->regmap, AD9910_AXI_REG_UPDATE_CTRL,
+				       AD9910_AXI_REG_UPDATE_PAR_IF_EN_MSK);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad9910_axi_chan_disable(struct iio_backend *back, unsigned int chan)
+{
+	struct ad9910_axi_state *st = iio_backend_get_priv(back);
+
+	switch (chan) {
+	case AD9910_CHAN_IDX_PROFILE_0 ... AD9910_CHAN_IDX_PROFILE_7:
+		return 0;
+	case AD9910_CHAN_IDX_PARALLEL_AMP ... AD9910_CHAN_IDX_PARALLEL_POLAR_PHASE:
+		return regmap_clear_bits(st->regmap, AD9910_AXI_REG_UPDATE_CTRL,
+					 AD9910_AXI_REG_UPDATE_PAR_IF_EN_MSK);
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct iio_buffer *ad9910_axi_request_buffer(struct iio_backend *back,
+						    struct iio_dev *indio_dev)
+{
+	struct ad9910_axi_state *st = iio_backend_get_priv(back);
+	const char *dma_name;
+
+	if (device_property_read_string(st->dev, "dma-names", &dma_name))
+		dma_name = "tx";
+
+	return iio_dmaengine_buffer_setup_ext(st->dev, indio_dev, dma_name,
+					      IIO_BUFFER_DIRECTION_OUT);
+}
+
+static void ad9910_axi_free_buffer(struct iio_backend *back,
+				   struct iio_buffer *buffer)
+{
+	iio_dmaengine_buffer_teardown(buffer);
+}
+
+static int ad9910_axi_set_sample_rate(struct iio_backend *back,
+				      unsigned int chan, u64 sample_rate)
+{
+	struct ad9910_axi_state *st = iio_backend_get_priv(back);
+	struct ad9910_axi_drctl_wfhw wfhw;
+	u64 div, pd_clk_freq_uhz;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	switch (chan) {
+	case AD9910_CHAN_IDX_PHY:
+		if (!sample_rate || sample_rate > 4 * AD9910_AXI_PD_CLK_MAX_FREQ_HZ)
+			return -EINVAL;
+
+		pd_clk_freq_uhz = sample_rate * MICROHZ_PER_HZ >> 2;
+		if (pd_clk_freq_uhz == st->pd_clk_freq_uhz)
+			return 0;
+
+		st->pd_clk_freq_uhz = pd_clk_freq_uhz;
+		if (!st->drctl_wf.period_length_ns)
+			return 0;
+
+		/*
+		 * DRCTL is clocked by SYNC_CLK, reprogram it so that the PWM
+		 * output keeps the applied waveform.
+		 */
+		ad9910_axi_drctl_tohw(st, &st->drctl_wf, &wfhw);
+		return ad9910_axi_drctl_write(st, &wfhw);
+	case AD9910_CHAN_IDX_PARALLEL_AMP ... AD9910_CHAN_IDX_PARALLEL_POLAR_PHASE:
+		if (!sample_rate || sample_rate > AD9910_AXI_PD_CLK_MAX_FREQ_HZ)
+			return -EINVAL;
+
+		sample_rate *= MICROHZ_PER_HZ;
+		div = DIV64_U64_ROUND_CLOSEST(st->pd_clk_freq_uhz, sample_rate);
+		div = clamp(div, 1U, AD9910_AXI_PAR_RATE_MAX);
+		ret = regmap_write(st->regmap, AD9910_AXI_REG_PAR_RATE, div - 1);
+		if (ret)
+			return ret;
+
+		return regmap_set_bits(st->regmap, AD9910_AXI_REG_UPDATE_CTRL,
+				       AD9910_AXI_REG_UPDATE_RATE_MSK);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad9910_axi_read_raw(struct iio_backend *back,
+			       struct iio_chan_spec const *chan, int *val,
+			       int *val2, long mask)
+{
+	struct ad9910_axi_state *st = iio_backend_get_priv(back);
+	u32 div;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->address) {
+		case AD9910_CHAN_IDX_PARALLEL_AMP ... AD9910_CHAN_IDX_PARALLEL_POLAR_PHASE: {
+			guard(mutex)(&st->lock);
+
+			ret = regmap_read(st->regmap, AD9910_AXI_REG_PAR_RATE,
+					  &div);
+			if (ret)
+				return ret;
+
+			iio_val_s64_decompose(div64_u64(st->pd_clk_freq_uhz,
+							(u64)div + 1),
+					      val, val2);
+			return IIO_VAL_DECIMAL64_MICRO;
+		}
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad9910_axi_reg_access(struct iio_backend *back, unsigned int reg,
+				 unsigned int writeval, unsigned int *readval)
+{
+	struct ad9910_axi_state *st = iio_backend_get_priv(back);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static const struct iio_backend_ops ad9910_axi_iio_back_ops = {
+	.chan_enable = ad9910_axi_chan_enable,
+	.chan_disable = ad9910_axi_chan_disable,
+	.request_buffer = ad9910_axi_request_buffer,
+	.free_buffer = ad9910_axi_free_buffer,
+	.set_sample_rate = ad9910_axi_set_sample_rate,
+	.read_raw = ad9910_axi_read_raw,
+	.debugfs_reg_access = iio_backend_debugfs_ptr(ad9910_axi_reg_access),
+};
+
+static const struct iio_backend_info ad9910_axi_back_info = {
+	.name = "ad9910-axi",
+	.ops = &ad9910_axi_iio_back_ops,
+};
+
+static const struct regmap_config ad9910_axi_regmap_config = {
+	.val_bits = 32,
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x0800,
+};
+
+static int ad9910_axi_pwm_round_waveform_tohw(struct pwm_chip *chip,
+					      struct pwm_device *pwm,
+					      const struct pwm_waveform *wf,
+					      void *wfhw)
+{
+	struct ad9910_axi_state *st = pwmchip_get_drvdata(chip);
+
+	guard(mutex)(&st->lock);
+
+	return ad9910_axi_drctl_tohw(st, wf, wfhw);
+}
+
+static int ad9910_axi_pwm_round_waveform_fromhw(struct pwm_chip *chip,
+						struct pwm_device *pwm,
+						const void *wfhw,
+						struct pwm_waveform *wf)
+{
+	struct ad9910_axi_state *st = pwmchip_get_drvdata(chip);
+
+	guard(mutex)(&st->lock);
+
+	ad9910_axi_drctl_fromhw(st, wfhw, wf);
+
+	return 0;
+}
+
+static int ad9910_axi_pwm_read_waveform(struct pwm_chip *chip,
+					struct pwm_device *pwm, void *_wfhw)
+{
+	struct ad9910_axi_state *st = pwmchip_get_drvdata(chip);
+	struct ad9910_axi_drctl_wfhw *wfhw = _wfhw;
+	u32 drg;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->regmap, AD9910_AXI_REG_DRG, &drg);
+	if (ret)
+		return ret;
+
+	if (!FIELD_GET(AD9910_AXI_REG_DRG_TOGGLE_EN_MSK, drg)) {
+		*wfhw = (struct ad9910_axi_drctl_wfhw){ };
+		return 0;
+	}
+
+	ret = regmap_read(st->regmap, AD9910_AXI_REG_DRCTL_PERIOD, &wfhw->period);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD9910_AXI_REG_DRCTL_WIDTH, &wfhw->width);
+	if (ret)
+		return ret;
+
+	return regmap_read(st->regmap, AD9910_AXI_REG_DRCTL_DELAY, &wfhw->delay);
+}
+
+static int ad9910_axi_pwm_write_waveform(struct pwm_chip *chip,
+					 struct pwm_device *pwm,
+					 const void *_wfhw)
+{
+	struct ad9910_axi_state *st = pwmchip_get_drvdata(chip);
+	const struct ad9910_axi_drctl_wfhw *wfhw = _wfhw;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = ad9910_axi_drctl_write(st, wfhw);
+	if (ret)
+		return ret;
+
+	ad9910_axi_drctl_fromhw(st, wfhw, &st->drctl_wf);
+
+	return 0;
+}
+
+static const struct pwm_ops ad9910_axi_pwm_ops = {
+	.sizeof_wfhw = sizeof(struct ad9910_axi_drctl_wfhw),
+	.round_waveform_tohw = ad9910_axi_pwm_round_waveform_tohw,
+	.round_waveform_fromhw = ad9910_axi_pwm_round_waveform_fromhw,
+	.read_waveform = ad9910_axi_pwm_read_waveform,
+	.write_waveform = ad9910_axi_pwm_write_waveform,
+};
+
+static int ad9910_axi_setup(struct ad9910_axi_state *st)
+{
+	int ret;
+
+	st->pd_clk_freq_uhz = AD9910_AXI_PD_CLK_MAX_FREQ_HZ * MICROHZ_PER_HZ;
+
+	ret = regmap_set_bits(st->regmap, AD9910_AXI_REG_RESET,
+			      AD9910_AXI_REG_RESET_CORE_MSK);
+	if (ret)
+		return ret;
+
+	return regmap_clear_bits(st->regmap, AD9910_AXI_REG_RESET,
+				 AD9910_AXI_REG_RESET_CORE_MSK);
+}
+
+static int ad9910_axi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ad9910_axi_state *st;
+	struct pwm_chip *chip;
+	void __iomem *base;
+	struct clk *clk;
+	int ret;
+
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*st));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	st = pwmchip_get_drvdata(chip);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
+
+	st->dev = dev;
+	st->regmap = devm_regmap_init_mmio(dev, base,
+					   &ad9910_axi_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "failed to init register map\n");
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	ret = ad9910_axi_setup(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup device\n");
+
+	chip->ops = &ad9910_axi_pwm_ops;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
+
+	return devm_iio_backend_register(dev, &ad9910_axi_back_info, st);
+}
+
+static const struct of_device_id ad9910_axi_of_match[] = {
+	{ .compatible = "adi,ad9910-axi-backend" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad9910_axi_of_match);
+
+static struct platform_driver ad9910_axi_driver = {
+	.driver = {
+		.name = "ad9910-axi-backend",
+		.of_match_table = ad9910_axi_of_match,
+	},
+	.probe = ad9910_axi_probe,
+};
+module_platform_driver(ad9910_axi_driver);
+
+MODULE_AUTHOR("Rodrigo Alencar <rodrigo.alencar@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD9910 AXI Backend driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
+MODULE_IMPORT_NS("IIO_BACKEND");

-- 
2.43.0


