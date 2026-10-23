Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788138;
	b=eSED5kMcl0eCxWo2hhfmySAwE1j58jCMYoyqy54F0qVu5Solc2cWYTscf1KLywch+4So
	 30ytW1wqqkJPomeYTzaIcSSCLJSaHSwPktpqZ/yr7hWNdYTxuxbSoRpdMNU9eu9C0H4/E
	 pEjw3Hcz1Q9Z+dnPOyNp5tKdAUDZER4c9/I0/QXwI5ZJEI3ulibvWAFtTXSZPzclJLtiW
	 M2T7jc3m8ON2eG6pFL2Szc0qSxcS5dQuyn3ANHgQUZ//8ZB+gtBBYRZh9KuNtRz8JQkG2
	 shTuXwcpTRnIOX7kWtUzkJm9S4scPeMPtUcSMAvbUhqkPocG8GDp8uOj8DD5i6oBG7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pITdMqVGM53TjQ2BXZoI/3VE+gN47ebJK30ImbgbUEg=;
	b=FLJq171XisbIeKybvJLm7+EVj3iVavtp3UgLKkwPxF01o1bAd98xtsKpmpRkZ6BcJbNO
	 WRR93vQwxl78itRqqeCW0j1934fQUo0ywWW8H57FP5Jaw/UfW+eTWXY0FMVrx5HGXmI2G
	 TEr7jMsOKtdfuVsZ2dTGVOtEZlJhJsSRbVCUXL11PxWLDYkSGIBJb5sht1FmVX09aJZw6
	 Z30a/0HIflnyL+D/eKhajWB7HwrMrLDBXNuZZk45RPv8pV1hn/8av0G/9fUeQ8XXMzHY7
	 7HHpzYsq6grazo72aNDAZaprhYZh0E0uD/NAu1kguo2etFynnILFonnLrOzUeJqhRbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Kd0QewIe;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F2A60A260C
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 20:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66F2A60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Kd0QewIe
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48dee593f18so917266f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792788132; x=1793392932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pITdMqVGM53TjQ2BXZoI/3VE+gN47ebJK30ImbgbUEg=;
        b=Kd0QewIegvnOtU1djLiEqfF2WG3+4EcoaKRchjMgy5dbK4aNPf12dJEY0xMmKFycf/
         KD+iDpKeLwAFd+871tWvd4Jpa+EiPrbU+OglC+ZR+ZuEGpxYYmrIJHDDtoWtGnAZhcnA
         S4e42yviFuX6p6Ff/Z4vPujzaQapvi04PXWpDqvXfUhW2C9hEDrmxHz8bfEHFZa0dgmo
         6PGO19P604b8DBcKQiuRQIP1SgMX7KegVpuhnGnDdxVcGffaFpsuROwksgXzRhbOXmf5
         cZLieRBc1dGtHW6PPbMQphd3U3Sw9LssJwxhNN7seDlJ1jYrUUdtJku5y1IEmoSCNfmk
         fgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792788132; x=1793392932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pITdMqVGM53TjQ2BXZoI/3VE+gN47ebJK30ImbgbUEg=;
        b=kdNabOCBcBZPyGFlftZDr4r3cwPUjmS9VIeDNuOeRs0yvkkkANZ2NgpHJuK9rI6baf
         /egrNA0qvZPAXTKaEm8uRjfLfSkeV847AullH47/vkxAInQakn3JSWjRUmtQLZvgh93w
         YEGaNUQT52SCO/UNIyz133iNxWGOj3JHDVGBxUHoK00EmKT2VHl0XYlAZlMGIUaIv0qW
         ndKviDzVzpJLILtM63eAIRfhXh9QUr0eWYgTdxeq0Ios3n7S2/gWjUmQPCCPh0y6OeCv
         jwVWLhAV9eARlXIDdCFp602g0DZpXkrYIBJuwdgLpVWe4pqpX7gMaDdqKCwBS8f1X+2w
         Pb7Q==
X-Forwarded-Encrypted: i=1; AKwUvBx2yYOvkpnBi2XPDh5C5ERndg0lZeg3yY608/5X3qs9mfiDouuvh9RCKf9OPGhEtwYkBBuIQ+K8BgE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvW4vFay3qWFH+Plo3LJ4s73TCFebG4xN+E6BJdtaajrtNSxgB
	MPjUccyXf1EL3ONL0mvh6Q3BzBA+2pLuMygAsoFIiq6sjgrmnMX25tVLX8Lfrxl7p8M=
X-Gm-Gg: AYBFou3CA407UMSi0t19NvdYBDtuJ5x3Wy8KwFspXCsc3zjv7K52GwW8b5i20X4Y0Pr
	VR4UUffoZQJoie3HY4T9/cBg5wiNbMGZmoR12Bxt6CGeeUlo6BwNyaU64gbJMAfhVwe3qSjLNph
	Rngx61HlQwPSKt3WjxNYX42N7rPrmMcf1PLDX0ExD+xLUFi1DtOw8vUqQgEi2RLhI+QwM6YwKAx
	N8xm/LPI3tjT/B09dw7i/1ZTsIDNKOLSXWBGZDRudaXJ5dLKx2mx0/z3lrwEyQMkr1yipvQYOME
	nRxo1EE4pKf3eZJXdSt0nipCzUgCBBnDE7yToyX0fNe9NZJLbIiaurSiD3F2+kMI+0DuS2jXk4v
	GksmRrVgrMHT0XUQDRNWH0kgxD93AJpmTg1IcLTCWUtjxrDS0pcXVU5INaG9hWlxjSbNYoE2bmO
	oq27uWvZkruoHU0VmdCtK3aJR4qp5YO3QmjrSqfSrAE8nDGtKEh27jc+NZrPLumPu/0Fd4JMChn
	mEJGwP0t2pdZkwyirbFOydcaSktXwS8xUw4yurW0sKYyH71wEaKHlqrkj169XeNgFGQkFA/v1jt
	dr6B/CruBxbqj5hjL4uEpjLvSchHFTQT
X-Received: by 2002:a5d:5f56:0:b0:48e:f10:ceb8 with SMTP id ffacd0b85a97d-48e3eb759fcmr253753f8f.11.1792788131670;
        Fri, 23 Oct 2026 13:42:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9c3:9990:89bb:701c:1852:56c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4ba7sm200998f8f.33.2026.10.23.13.42.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 13:42:11 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
Date: Fri, 23 Oct 2026 22:42:09 +0200
Message-ID: <20261023204209.48556-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023204209.48556-1-olivier@mgcrea.io>
References: <20261023204209.48556-1-olivier@mgcrea.io>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X1600's SAR ADC has four auxiliary channels, each with its own start
bit, interrupt flag and 12-bit result, and none of the touchscreen or
battery engines of the JZ47xx ADCs that ingenic-adc drives. Add a small
driver that exposes the four channels as voltages against the 3.3 V
reference.

There is no datasheet here: the register layout and the clock dividers
come from the X1600 driver of the vendor's 4.4 kernel.

Tested on a HiBy R1, whose play/pause and volume keys sit on channel 0
behind adc-keys: all three read and report correctly.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 MAINTAINERS                         |   7 +
 drivers/iio/adc/Kconfig             |  10 ++
 drivers/iio/adc/Makefile            |   1 +
 drivers/iio/adc/ingenic-x1600-adc.c | 227 ++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+)
 create mode 100644 drivers/iio/adc/ingenic-x1600-adc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ecc22d1149d1..bbb63228e330 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12925,6 +12925,13 @@ F:	include/linux/mfd/ingenic-tcu.h
 F:	sound/soc/codecs/jz47*
 F:	sound/soc/jz4740/
 
+INGENIC X1600 ADC DRIVER
+M:	Olivier Louvignes <olivier@mgcrea.io>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
+F:	drivers/iio/adc/ingenic-x1600-adc.c
+
 INJOINIC IP5xxx POWER BANK IC DRIVER
 M:	Samuel Holland <samuel@sholland.org>
 S:	Maintained
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a802d8ee4dd9..7b5c3d3fcfdb 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -881,6 +881,16 @@ config INGENIC_ADC
 	  This driver can also be built as a module. If so, the module will be
 	  called ingenic_adc.
 
+config INGENIC_X1600_ADC
+	tristate "Ingenic X1600 ADC driver"
+	depends on MIPS || COMPILE_TEST
+	help
+	  Say yes here to build support for the SAR ADC of the Ingenic X1600
+	  SoC and its four auxiliary channels.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ingenic-x1600-adc.
+
 config INTEL_DC_TI_ADC
 	tristate "Intel Bay Trail / Cherry Trail Dollar Cove TI ADC driver"
 	depends on INTEL_SOC_PMIC_CHTDC_TI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 9e82c21dbd37..f76e62b0cd04 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_IMX8QXP_ADC) += imx8qxp-adc.o
 obj-$(CONFIG_IMX93_ADC) += imx93_adc.o
 obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
 obj-$(CONFIG_INGENIC_ADC) += ingenic-adc.o
+obj-$(CONFIG_INGENIC_X1600_ADC) += ingenic-x1600-adc.o
 obj-$(CONFIG_INTEL_DC_TI_ADC) += intel_dc_ti_adc.o
 obj-$(CONFIG_INTEL_MRFLD_ADC) += intel_mrfld_adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
diff --git a/drivers/iio/adc/ingenic-x1600-adc.c b/drivers/iio/adc/ingenic-x1600-adc.c
new file mode 100644
index 000000000000..d54f6d7989b6
--- /dev/null
+++ b/drivers/iio/adc/ingenic-x1600-adc.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADC driver for the Ingenic X1600 SoC
+ *
+ * The X1600's SAR ADC has four auxiliary channels, each with its own start
+ * bit, interrupt and 12-bit result, and none of the touchscreen or battery
+ * engines of the JZ47xx ADCs that ingenic-adc drives. The register layout
+ * and the clock set-up were read from the vendor 4.4 kernel's driver.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+
+#define X1600_ADC_REG_ENABLE		0x00
+#define X1600_ADC_REG_CTRL		0x08
+#define X1600_ADC_REG_STATUS		0x0c
+#define X1600_ADC_REG_DATA(ch)		(0x10 + ((ch) / 2) * 4)
+#define X1600_ADC_REG_CLKDIV		0x20
+#define X1600_ADC_REG_STABLE		0x24
+
+/* ENABLE: bits 3..0 start a channel's conversion; bit 15 powers down. */
+#define X1600_ADC_ENABLE_POWER_DOWN	BIT(15)
+/* CTRL: bits 3..0 mask the channels' interrupts. STATUS: write 1 to clear. */
+#define X1600_ADC_CHANNELS_MASK		GENMASK(3, 0)
+#define X1600_ADC_DATA_MASK(ch)		(GENMASK(11, 0) << ((ch) % 2 * 16))
+#define X1600_ADC_CLKDIV_DIV0		GENMASK(7, 0)
+#define X1600_ADC_CLKDIV_DIV1		GENMASK(15, 8)
+#define X1600_ADC_CLKDIV_DIV2		GENMASK(31, 16)
+#define X1600_ADC_STABLE_TIME		GENMASK(15, 0)
+
+#define X1600_ADC_NUM_CHANNELS		4
+#define X1600_ADC_VREF_MV		3300
+#define X1600_ADC_BITS			12
+/* The vendor kernel brings its 140 MHz APB clock down to about this. */
+#define X1600_ADC_CLK_RATE		1166667
+#define X1600_ADC_TIMEOUT_MS		20
+
+struct x1600_adc {
+	void __iomem *base;
+	struct clk *clk;
+	struct completion done;
+	/* Serialises conversions: there is one completion for all channels. */
+	struct mutex lock;
+};
+
+static irqreturn_t x1600_adc_irq(int irq, void *data)
+{
+	struct x1600_adc *adc = data;
+	u32 status = readl(adc->base + X1600_ADC_REG_STATUS) & X1600_ADC_CHANNELS_MASK;
+
+	if (!status)
+		return IRQ_NONE;
+
+	writel(status, adc->base + X1600_ADC_REG_STATUS);
+	complete(&adc->done);
+	return IRQ_HANDLED;
+}
+
+static int x1600_adc_read_raw_channel(struct x1600_adc *adc, unsigned int ch, int *val)
+{
+	u32 data;
+	int ret = 0;
+
+	guard(mutex)(&adc->lock);
+
+	reinit_completion(&adc->done);
+	writel(BIT(ch), adc->base + X1600_ADC_REG_STATUS);
+	writel(readl(adc->base + X1600_ADC_REG_ENABLE) | BIT(ch),
+	       adc->base + X1600_ADC_REG_ENABLE);
+
+	if (!wait_for_completion_timeout(&adc->done,
+					 msecs_to_jiffies(X1600_ADC_TIMEOUT_MS)))
+		ret = -ETIMEDOUT;
+
+	writel(readl(adc->base + X1600_ADC_REG_ENABLE) & ~BIT(ch),
+	       adc->base + X1600_ADC_REG_ENABLE);
+	if (ret)
+		return ret;
+
+	data = readl(adc->base + X1600_ADC_REG_DATA(ch));
+	*val = (data & X1600_ADC_DATA_MASK(ch)) >> (ch % 2 * 16);
+	return 0;
+}
+
+static int x1600_adc_read_raw(struct iio_dev *iio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2, long mask)
+{
+	struct x1600_adc *adc = iio_priv(iio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = x1600_adc_read_raw_channel(adc, chan->channel, val);
+		return ret ? ret : IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = X1600_ADC_VREF_MV;
+		*val2 = X1600_ADC_BITS;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info x1600_adc_info = {
+	.read_raw = x1600_adc_read_raw,
+};
+
+#define X1600_ADC_CHANNEL(ch) {					\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = (ch),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+}
+
+static const struct iio_chan_spec x1600_adc_channels[] = {
+	X1600_ADC_CHANNEL(0),
+	X1600_ADC_CHANNEL(1),
+	X1600_ADC_CHANNEL(2),
+	X1600_ADC_CHANNEL(3),
+};
+
+static void x1600_adc_power_down(void *data)
+{
+	struct x1600_adc *adc = data;
+
+	writel(X1600_ADC_CHANNELS_MASK, adc->base + X1600_ADC_REG_CTRL);
+	writel(X1600_ADC_ENABLE_POWER_DOWN, adc->base + X1600_ADC_REG_ENABLE);
+}
+
+static int x1600_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *iio_dev;
+	struct x1600_adc *adc;
+	unsigned long rate;
+	u32 div0, reg;
+	int irq, ret;
+
+	iio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	adc = iio_priv(iio_dev);
+	init_completion(&adc->done);
+	ret = devm_mutex_init(dev, &adc->lock);
+	if (ret)
+		return ret;
+
+	adc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(adc->base))
+		return PTR_ERR(adc->base);
+
+	adc->clk = devm_clk_get_enabled(dev, "adc");
+	if (IS_ERR(adc->clk))
+		return dev_err_probe(dev, PTR_ERR(adc->clk), "Unable to get clock\n");
+
+	/* Powered down, interrupts masked and cleared, as the vendor does. */
+	writel(X1600_ADC_ENABLE_POWER_DOWN, adc->base + X1600_ADC_REG_ENABLE);
+	writel(X1600_ADC_CHANNELS_MASK, adc->base + X1600_ADC_REG_CTRL);
+	writel(X1600_ADC_CHANNELS_MASK, adc->base + X1600_ADC_REG_STATUS);
+
+	rate = clk_get_rate(adc->clk);
+	div0 = clamp(DIV_ROUND_UP(rate, X1600_ADC_CLK_RATE), 1UL, 256UL) - 1;
+	/* DIV1 and DIV2 as the vendor kernel sets them. */
+	writel(FIELD_PREP(X1600_ADC_CLKDIV_DIV0, div0) |
+	       FIELD_PREP(X1600_ADC_CLKDIV_DIV1, 1) |
+	       FIELD_PREP(X1600_ADC_CLKDIV_DIV2, 99),
+	       adc->base + X1600_ADC_REG_CLKDIV);
+	reg = readl(adc->base + X1600_ADC_REG_STABLE) & ~X1600_ADC_STABLE_TIME;
+	writel(reg | FIELD_PREP(X1600_ADC_STABLE_TIME, 1),
+	       adc->base + X1600_ADC_REG_STABLE);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, x1600_adc_irq, 0, dev_name(dev), adc);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request irq\n");
+
+	/*
+	 * Powered up for good: the keys poll it every few tens of milliseconds,
+	 * and powering up takes 2 ms.
+	 */
+	writel(0, adc->base + X1600_ADC_REG_ENABLE);
+	usleep_range(2000, 3000);
+	writel(0, adc->base + X1600_ADC_REG_CTRL);
+	ret = devm_add_action_or_reset(dev, x1600_adc_power_down, adc);
+	if (ret)
+		return ret;
+
+	iio_dev->name = "x1600-adc";
+	iio_dev->modes = INDIO_DIRECT_MODE;
+	iio_dev->channels = x1600_adc_channels;
+	iio_dev->num_channels = ARRAY_SIZE(x1600_adc_channels);
+	iio_dev->info = &x1600_adc_info;
+
+	return devm_iio_device_register(dev, iio_dev);
+}
+
+static const struct of_device_id x1600_adc_of_match[] = {
+	{ .compatible = "ingenic,x1600-adc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, x1600_adc_of_match);
+
+static struct platform_driver x1600_adc_driver = {
+	.driver = {
+		.name = "ingenic-x1600-adc",
+		.of_match_table = x1600_adc_of_match,
+	},
+	.probe = x1600_adc_probe,
+};
+module_platform_driver(x1600_adc_driver);
+MODULE_DESCRIPTION("ADC driver for the Ingenic X1600 SoC");
+MODULE_LICENSE("GPL");
-- 
2.39.5

