Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B4A542EEE;
	Thu, 15 Oct 2026 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082995; cv=none; b=qEHMLerQU2Pb90/or/ACtqSMTmeAt6N6/L+3SYmEyXYNy1EkHTJXvkpeaOKTrZEGZgYABAu3mhPzxlYGmhiJZEh9X/iank78etnkvGrmivIoeyk80eMMHCWxPIkF0GwAyauX4xzVUj+PmyaoCIUH9wtUq9u7E2rKeKCZFOS3jQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082995; c=relaxed/simple;
	bh=twxHn1Sa2xtmpgYIMApvVRr7bkrFmQmOYjsco0YLF+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e1mHc5OZfdJECHLrFaaL0gsxM9c8W4M4oBZcJa/esRGU+cdpm/vQ7Unq/fopHwqLuEhZ0KooajKMKlRMuz28C9zaV978nm4O4svZF/0K0KfkI4h+r1nzVJRD4Yg1HrJKnA4k+ml3CErgHobHt9m6QeDvCWhQrYWmlLJIyM+eGGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVVKYwRS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVVKYwRS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F2E3C4AF17;
	Thu, 15 Oct 2026 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792082995;
	bh=twxHn1Sa2xtmpgYIMApvVRr7bkrFmQmOYjsco0YLF+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dVVKYwRSqXDRqcoqyNt5gsIroaPvqFgtoL0jtauOHjE9ghnYOPtM4iotTwrwgHcld
	 mtYBPycU7BQG6mbVVpTAHj0o3w3EgpbznRQN8x3vQkbk4UYCPeudG2T7Fh/uZ0xTv8
	 1/1tqGUitPMNvHiBx+Wb5nMApvrTNsaa5kP4JMM/lo5COR0U4vdUjiSE4Fa+W1/J3g
	 tUaZnggeDVto82UNYZl8a9V7TWtBUJ6azzBdkBew10dluKBLSjlpDy+SctxDojPPxh
	 kY3gKWbZsecXp1nmZaRxzOcJyeoND0lFyma8nLuK0DEb3UhuvRXjZHH159+WswfQzn
	 UTZaNMo4wftyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A51FCC6B33;
	Thu, 15 Oct 2026 16:49:55 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 15 Oct 2026 13:49:46 -0300
Subject: [PATCH 06/10] iio: frequency: ad9910: add axi backend driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-ad9910-backend-support-v1-6-3c21648c8e26@analog.com>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
In-Reply-To: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792082993; l=14888;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=XfuzLOIG3CdJGmC6H/5fgpP60BtJ7Wf2VfwhRUiUfLs=;
 b=fIG+RWV5bxDXN3EUqyZ1FH8LFA02it77jhtrWxp+l8zV6Ok6EPsyq/rIfrcXyd9mH+8nLqRdp
 /mycUUAqNEYAQWICiA9ylhUmYbZcBicA6Kvsf52l4fIzBBxst4puZwE
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

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
direction. PWM period and duty cycle are programmed in PDCLK cycles.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 MAINTAINERS                                |   1 +
 drivers/iio/frequency/Kconfig              |  17 ++
 drivers/iio/frequency/Makefile             |   1 +
 drivers/iio/frequency/ad9910-axi-backend.c | 396 +++++++++++++++++++++++++++++
 4 files changed, 415 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a9cb4396b3e1..c3cda855dabb 100644
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
index 000000000000..f94cb54af517
--- /dev/null
+++ b/drivers/iio/frequency/ad9910-axi-backend.c
@@ -0,0 +1,396 @@
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
+#define AD9910_AXI_REG_RAMP_DELAY_BST	0x094
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
+	enum pwm_polarity pwm_polarity;
+};
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
+		chan = min(chan - AD9910_CHAN_IDX_PARALLEL_AMP, AD9910_DEST_POLAR);
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
+	u64 div;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	switch (chan) {
+	case AD9910_CHAN_IDX_PHY:
+		if (!sample_rate || sample_rate > 4 * AD9910_AXI_PD_CLK_MAX_FREQ_HZ)
+			return -EINVAL;
+
+		st->pd_clk_freq_uhz = sample_rate * MICROHZ_PER_HZ >> 2;
+		return 0;
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
+			iio_val_s64_decompose(div_s64(st->pd_clk_freq_uhz, div + 1),
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
+static int ad9910_axi_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+				const struct pwm_state *state)
+{
+	struct ad9910_axi_state *st = pwmchip_get_drvdata(chip);
+	u64 period, duty;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	period = mul_u64_u64_div_u64(state->period, st->pd_clk_freq_uhz,
+				     1ULL * NANO * MICROHZ_PER_HZ);
+	period = min(period, U32_MAX);
+	duty = mul_u64_u64_div_u64(state->duty_cycle, st->pd_clk_freq_uhz,
+				   1ULL * NANO * MICROHZ_PER_HZ);
+	duty = min(duty, period);
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		duty = period - duty;
+
+	ret = regmap_write(st->regmap, AD9910_AXI_REG_DRCTL_PERIOD, period);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD9910_AXI_REG_DRCTL_WIDTH, duty);
+	if (ret)
+		return ret;
+
+	st->pwm_polarity = state->polarity;
+
+	if (state->enabled)
+		return regmap_set_bits(st->regmap, AD9910_AXI_REG_DRG,
+				       AD9910_AXI_REG_DRG_TOGGLE_EN_MSK);
+
+	return regmap_clear_bits(st->regmap, AD9910_AXI_REG_DRG,
+				 AD9910_AXI_REG_DRG_TOGGLE_EN_MSK);
+}
+
+static int ad9910_axi_pwm_get_state(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    struct pwm_state *state)
+{
+	struct ad9910_axi_state *st = pwmchip_get_drvdata(chip);
+	u32 period, width, drg;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->regmap, AD9910_AXI_REG_DRCTL_PERIOD, &period);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD9910_AXI_REG_DRCTL_WIDTH, &width);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD9910_AXI_REG_DRG, &drg);
+	if (ret)
+		return ret;
+
+	state->period = mul_u64_u64_div_u64_roundup((u64)period * NANO,
+						    MICROHZ_PER_HZ,
+						    st->pd_clk_freq_uhz);
+	if (st->pwm_polarity == PWM_POLARITY_INVERSED)
+		width = period - width;
+	state->duty_cycle = mul_u64_u64_div_u64_roundup((u64)width * NANO,
+							MICROHZ_PER_HZ,
+							st->pd_clk_freq_uhz);
+	state->polarity = st->pwm_polarity;
+	state->enabled = FIELD_GET(AD9910_AXI_REG_DRG_TOGGLE_EN_MSK, drg);
+
+	return 0;
+}
+
+static const struct pwm_ops ad9910_axi_pwm_ops = {
+	.apply = ad9910_axi_pwm_apply,
+	.get_state = ad9910_axi_pwm_get_state,
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
+	struct pwm_chip *pwm;
+	void __iomem *base;
+	struct clk *clk;
+	int ret;
+
+	pwm = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*st));
+	if (IS_ERR(pwm))
+		return PTR_ERR(pwm);
+
+	st = pwmchip_get_drvdata(pwm);
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
+	pwm->ops = &ad9910_axi_pwm_ops;
+
+	ret = devm_pwmchip_add(dev, pwm);
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


