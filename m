Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BCF33343C
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561212; cv=none; b=XpzqMmpPduIEN2PWrWm9F5sePHqk+29W831WPD6Vbwc1RqGE2wpZPZhB6+ximpIXJeaZ1inJIbimgqLd6toaxY5vYqWYivrqPgBbZ2b4vpCC6o/+IdhMQKqUaPNEml/C3DKILVbJu2dqbJu6LkgGDqUArkqIL9dszOtBCbjo434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561212; c=relaxed/simple;
	bh=Zmc4UTC8Cyc7cRFaYuTJ6UebqJkFGo/yktm1Av823R4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OKGlRxpHgEigEJ20Gi+zNkEnmCrLNd0MQm/4+Nmc7IwBH3lzNPca5DV/vMtCzITgzYK8x1ZAbdOy7sqMpD+a0TlYD9tm43Qc/lp57ezx3D73+B7G3LEDj61Nlaw4B9z1qPNcqik77ysV2VT4sfvHPEh3U5W6UFchrHqKIbnLf+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqkYWpfO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqkYWpfO"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso35070445ad.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 01:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787561206; x=1788166006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JPpjGcH4zng9ZOV28SjLrGGqQxlOLxlHDs251S7Goa4=;
        b=iqkYWpfOhqi0WBAQZ9pJpHmHZ8RBWSgo7mRaFQW+2meiHHMURPAQuV49gUI7LdEyIQ
         m8gCGvqslm3/2Q5iBHOhVyLxFDFUYe60k8rDHWnT/o2gVYvYDwqKFRdZuZrlOagFrzQT
         0icZ/olrT4/Okv0C+e9KaECosoN8PZ3LalXa9oW0ZFRZxxs7zJnikM7r8uu3ln8Y3f0h
         ZQ/Pj9J8MeIibTOKWPzSnUe6o91nbP9cOvXpqI72k/4v3mS8OHdcIasm66AC82e/XywS
         saPs5xfABNuuB/8qwz+2eEL3WmWu5KhqTZ18sq42NWf/unLIuMmtG7fKaWppobJ3Y2ZF
         d12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787561206; x=1788166006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPpjGcH4zng9ZOV28SjLrGGqQxlOLxlHDs251S7Goa4=;
        b=f8oVwsdiya/O0zz/KKNFeUyin4KRQ6u0zImbmzpAcZmnbd6/CXEOVqXzt3gLu7FQje
         rZ8tkLtJq8d0c2hda5EFhGX/3BouC0n/oTJNiv1yenLnp/v27z7+gClRmojKwoU0MISY
         t1a3+7+SdcNm9TjzXFruQo0eaDn1vcAVBQX56H6FN/LhDjCCPuT8FvCIxwIDwTrlQVXq
         HALeu9WFBPYZaW6DEVNu3KTjmec4EQUEKfs2oPS60rjdOz6I6pBoHczP3Ek4bXwOgCoQ
         bfK9O9D5nwJm1+onNeffwIDqSc78SSxDgSaURi0WL0S6ESkkdaP2Ie6n0NLmPlDiIb8j
         96nA==
X-Gm-Message-State: AFuF++kgKwz7rzagWnxO+gk5zrklIs9rqfW47U0tVYbc9vU0TeYiUQpM
	0hOSz3+P62TOfpx4wcU+jOu8D3fxPKIBXDgK/ktZOAh1acUD+w33SPIR
X-Gm-Gg: AR+sD13BonkIQAAHsuyoeAt7mkdkSwso8v2O0rZWjazWK4XrdUNBitMO4zmAHugAIQX
	fGElbilT+zqXdObZA5mAfoCah8VAon2P+otDH//QdgtNBNldNqh3MoBxnCH/0FW2D18cgUjSNex
	NWqEqvh+seWTI0xJyMvh2iUzz8eOMHrDFK9agQjxXFrIyrIZ844cFYWlTUX8C41zbtxbL0I8Zd+
	mS0ck8eWV/7vEX5wONcbk19a1l2mwBqm4M9FRBi6NBw1jsMYmFbCwbq//GKKnBkzuQEhrWnAwHm
	Rh6si5/+Q+w3H0YVs8iqv9aSZahWgfPdUyyoTR40uzKSxy7WrLUfQZdtaUBBA5WIkScETuQVVF6
	jzQWkEgpqQzuyjJUSy5JBDyYyW0itzPOb6hW0H7TnAhVa4eAEJymKy2JdThC7n1XIe8zmTOZOib
	M+4vES3zKUPbykBZe/we7Se3wBKbD5L0ZCmwo/qpLryF1juF/B6BqphMAVBzy3T7+/THGldrxVk
	ceKhUzRkSUtzRznT/R+y3FlGRCe
X-Received: by 2002:a17:903:390d:b0:2c9:fb11:1bf4 with SMTP id d9443c01a7336-2d64af4eea9mr474030975ad.7.1787561205491;
        Mon, 24 Aug 2026 01:46:45 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768e9ebbsm15343265ad.80.2026.08.24.01.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:46:44 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Mon, 24 Aug 2026 16:49:39 +0800
Subject: [PATCH v7 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-ti-ads112c04-driver-v7-2-6b3c9c87d0e4@gmail.com>
References: <20260824-ti-ads112c04-driver-v7-0-6b3c9c87d0e4@gmail.com>
In-Reply-To: <20260824-ti-ads112c04-driver-v7-0-6b3c9c87d0e4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=18299;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=Zmc4UTC8Cyc7cRFaYuTJ6UebqJkFGo/yktm1Av823R4=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqjAWxUBPsd2xfS/372NJuRQUpa3zf1pWqmodol
 tUkjsVhUKCJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaowFsQAKCRClg0K3CVbE
 gWu9B/4vBJhED8HmTCuYMYFyR2iKqZqJx5haE42mAkEuTxWcJQKQF2rNS/kfnJ456h/0IKJllaG
 ZYpE8SJ6qv8/w2I8P38cgLgG/eZl9p2HRZ8CV25mn6sZLU3hPGSJTeVJGuuFQESdoIRGs4VuxfZ
 h+hW7cYol49Y4U8F/OqNS//AnWlc8dETt6xDsBfNOsrUBP7WxQzyJlNOxOgtk5nOTAf04uc8nFI
 UOuGInDdRL+SK5NgnxU1zyEBgzOXvjmq7y0XBipGdtT0PkUqgPSC64MLMCYKE5ax7/ic2adRqdX
 ZjFfj0ghUHQj5sngRIo4bCCVJ1VRYXErF4D2mYfH9bWsXVaR
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
delta-sigma ADCs.

The driver implements:
- Single-shot conversions using the IIO raw read interface.
- Dynamic parsing of single-ended and differential channels from
  device tree child nodes.
- Hardware interrupt support via the DRDY pin, falling back to
  software polling if no IRQ is provided.
- Per-channel reference source selection (internal 2.048V, external
  REFP/REFN, or AVDD) via the reference-sources device tree property.
  refn-supply is not yet supported.
- Hardware reset via the reset controller framework, falling back to
  the RESET command when no reset controller is present.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 MAINTAINERS                    |   1 +
 drivers/iio/adc/Kconfig        |  10 +
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/ti-ads112c04.c | 524 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 536 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 417d74b6d6cc..f51fbda9d4b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26992,6 +26992,7 @@ M:	Kyle Hsieh <kylehsieh1995@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
+F:	drivers/iio/adc/ti-ads112c04.c
 
 TI ADS112C14 ADC DRIVER
 M:	David Lechner <dlechner@baylibre.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 990e7b3e7212..037fc7df8415 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1817,6 +1817,16 @@ config TI_ADS1119
          This driver can also be built as a module. If so, the module will be
          called ti-ads1119.
 
+config TI_ADS112C04
+	tristate "Texas Instruments ADS112C04 ADC"
+	depends on I2C
+	help
+	  If you say yes here you get support for Texas Instruments
+	  ADS112C04 (16-bit) I2C analog to digital converters.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads112c04.
+
 config TI_ADS112C14
 	tristate "Texas Instruments ADS112C14/ADS122C14"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index dcec0abb03b7..d8acf2831fd2 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -155,6 +155,7 @@ obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS1018) += ti-ads1018.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
+obj-$(CONFIG_TI_ADS112C04) += ti-ads112c04.o
 obj-$(CONFIG_TI_ADS112C14) += ti-ads112c14.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
diff --git a/drivers/iio/adc/ti-ads112c04.c b/drivers/iio/adc/ti-ads112c04.c
new file mode 100644
index 000000000000..acf7209db761
--- /dev/null
+++ b/drivers/iio/adc/ti-ads112c04.c
@@ -0,0 +1,524 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Texas Instruments ADS112C04 16-bit I2C ADC driver
+ *
+ * Copyright (c) 2026 Kyle Hsieh <kylehsieh1995@gmail.com>
+ *
+ * Datasheet: https://www.ti.com/lit/ds/symlink/ads112c04.pdf
+ * Based on TI Reference Code and standard Linux IIO framework.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+
+#define ADS112C04_CMD_RESET		0x06
+#define ADS112C04_CMD_START_SYNC	0x08
+#define ADS112C04_CMD_RDATA		0x10
+#define ADS112C04_CMD_RREG(reg)		(0x20 | ((reg) << 2))
+#define ADS112C04_CMD_WREG(reg)		(0x40 | ((reg) << 2))
+
+#define ADS112C04_REG_CONFIG0			0x00
+#define   ADS112C04_CONF0_MUX			  GENMASK(7, 4)
+#define     ADS112C04_CONF0_MUX_AIN0_AIN1	    0
+#define     ADS112C04_CONF0_MUX_AIN_SINGLE_BASE	    8
+#define   ADS112C04_CONF0_GAIN			  GENMASK(3, 1)
+#define     ADS112C04_CONF0_GAIN_X1		    0
+#define   ADS112C04_CONF0_PGA_BYPASS		  BIT(0)
+
+#define ADS112C04_REG_CONFIG1			0x01
+#define   ADS112C04_CONF1_DR			  GENMASK(7, 5)
+#define     ADS112C04_CONF1_DR_20SPS		    0
+#define   ADS112C04_CONF1_MODE			  BIT(4)
+#define     ADS112C04_CONF1_MODE_NORMAL		    0
+#define   ADS112C04_CONF1_CM			  BIT(3)
+#define     ADS112C04_CONF1_CM_SINGLE_SHOT	    0
+#define   ADS112C04_CONF1_VREF			  GENMASK(2, 1)
+#define     ADS112C04_CONF1_VREF_INTERNAL	    0
+#define     ADS112C04_CONF1_VREF_EXTERNAL	    1
+#define     ADS112C04_CONF1_VREF_AVDD		    2
+#define   ADS112C04_CONF1_TS			  BIT(0)
+#define     ADS112C04_CONF1_TS_DISABLED		    0
+
+#define ADS112C04_REG_CONFIG2			0x02
+#define   ADS112C04_CONF2_DRDY			  BIT(7)
+
+#define ADS112C04_INT_REF_mV			2048
+
+#define ADS112C04_MAX_CHANNELS		12
+
+#define ADS112C04_RESOLUTION_BITS	16
+
+enum {
+	ADS112C04_VREF_SOURCE_INTERNAL,
+	ADS112C04_VREF_SOURCE_EXTERNAL,
+	ADS112C04_VREF_SOURCE_AVDD,
+};
+
+static const char * const ads112c04_vref_names[] = {
+	[ADS112C04_VREF_SOURCE_INTERNAL] = "internal",
+	[ADS112C04_VREF_SOURCE_EXTERNAL] = "external",
+	[ADS112C04_VREF_SOURCE_AVDD]     = "avdd",
+};
+
+static const u8 ads112c04_vref_reg_val[] = {
+	[ADS112C04_VREF_SOURCE_INTERNAL] = ADS112C04_CONF1_VREF_INTERNAL,
+	[ADS112C04_VREF_SOURCE_EXTERNAL] = ADS112C04_CONF1_VREF_EXTERNAL,
+	[ADS112C04_VREF_SOURCE_AVDD]     = ADS112C04_CONF1_VREF_AVDD,
+};
+
+/* Indexed by [AINP][AINN], -1 means the combination is not available. */
+static const s8 ads112c04_diff_mux[4][4] = {
+	{ -1,  0,  1,  2 },
+	{  3, -1,  4,  5 },
+	{ -1, -1, -1,  6 },
+	{ -1, -1,  7, -1 },
+};
+
+struct ads112c04_state {
+	struct i2c_client *client;
+	/* Protects concurrent ADC reads and device configuration */
+	struct mutex lock;
+	struct completion completion;
+	u32 avdd_mV;
+	u32 ext_ref_mV;
+	u8 *vref_source;	/* one entry per channel, indexed by scan order */
+	u8 config0;
+	u8 config1;
+};
+
+static int ads112c04_write_cmd(struct i2c_client *client, u8 cmd)
+{
+	return i2c_smbus_write_byte(client, cmd);
+}
+
+static int ads112c04_read_reg(struct i2c_client *client, u8 reg, u8 *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, ADS112C04_CMD_RREG(reg));
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+
+	return 0;
+}
+
+static int ads112c04_write_reg(struct i2c_client *client, u8 reg, u8 val)
+{
+	return i2c_smbus_write_byte_data(client, ADS112C04_CMD_WREG(reg), val);
+}
+
+static int ads112c04_wait_for_data(struct ads112c04_state *st)
+{
+	int ret, err;
+	u8 val;
+
+	if (st->client->irq > 0) {
+		/* Timeout is 100ms (slowest data rate is 20 SPS) */
+		if (!wait_for_completion_timeout(&st->completion, msecs_to_jiffies(100)))
+			return -ETIMEDOUT;
+
+		return 0;
+	}
+
+	ret = read_poll_timeout(ads112c04_read_reg, err,
+				err < 0 || (val & ADS112C04_CONF2_DRDY),
+				1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC, false,
+				st->client, ADS112C04_REG_CONFIG2, &val);
+	if (err < 0)
+		return err;
+
+	return ret;
+}
+
+static int ads112c04_read_data(struct ads112c04_state *st, int *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_swapped(st->client, ADS112C04_CMD_RDATA);
+	if (ret < 0)
+		return ret;
+
+	*val = sign_extend32(ret, ADS112C04_RESOLUTION_BITS - 1);
+
+	return 0;
+}
+
+static int ads112c04_get_adc_result(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    int *val)
+{
+	struct ads112c04_state *st = iio_priv(indio_dev);
+	unsigned int idx = chan - indio_dev->channels;
+	u8 new_config0, new_config1;
+	int ret;
+
+	new_config0 = st->config0;
+	FIELD_MODIFY(ADS112C04_CONF0_MUX, &new_config0, chan->address);
+
+	if (st->config0 != new_config0) {
+		ret = ads112c04_write_reg(st->client, ADS112C04_REG_CONFIG0,
+					  new_config0);
+		if (ret < 0)
+			return ret;
+
+		st->config0 = new_config0;
+	}
+
+	new_config1 = st->config1;
+	FIELD_MODIFY(ADS112C04_CONF1_VREF, &new_config1,
+		     ads112c04_vref_reg_val[st->vref_source[idx]]);
+
+	if (st->config1 != new_config1) {
+		ret = ads112c04_write_reg(st->client, ADS112C04_REG_CONFIG1,
+					  new_config1);
+		if (ret < 0)
+			return ret;
+
+		st->config1 = new_config1;
+	}
+
+	reinit_completion(&st->completion);
+
+	ret = ads112c04_write_cmd(st->client, ADS112C04_CMD_START_SYNC);
+	if (ret < 0)
+		return ret;
+
+	ret = ads112c04_wait_for_data(st);
+	if (ret < 0)
+		return ret;
+
+	return ads112c04_read_data(st, val);
+}
+
+static int ads112c04_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2, long mask)
+{
+	struct ads112c04_state *st = iio_priv(indio_dev);
+	unsigned int idx = chan - indio_dev->channels;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = ads112c04_get_adc_result(indio_dev, chan, val);
+		mutex_unlock(&st->lock);
+
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (st->vref_source[idx]) {
+		case ADS112C04_VREF_SOURCE_EXTERNAL:
+			*val = st->ext_ref_mV;
+			break;
+		case ADS112C04_VREF_SOURCE_AVDD:
+			*val = st->avdd_mV;
+			break;
+		default:
+			*val = ADS112C04_INT_REF_mV;
+			break;
+		}
+		*val2 = ADS112C04_RESOLUTION_BITS - 1;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t ads112c04_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct ads112c04_state *st = iio_priv(indio_dev);
+
+	complete(&st->completion);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_info ads112c04_info = {
+	.read_raw = ads112c04_read_raw,
+};
+
+static int ads112c04_parse_vref_source(struct fwnode_handle *child)
+{
+	if (!fwnode_property_present(child, "reference-sources"))
+		return ADS112C04_VREF_SOURCE_INTERNAL;
+
+	return fwnode_property_match_property_string(child, "reference-sources",
+						    ads112c04_vref_names,
+						    ARRAY_SIZE(ads112c04_vref_names));
+}
+
+static int ads112c04_parse_channels(struct iio_dev *indio_dev,
+				    bool *need_avdd_ref, bool *need_ext_ref)
+{
+	struct device *dev = indio_dev->dev.parent;
+	struct ads112c04_state *st = iio_priv(indio_dev);
+	struct iio_chan_spec *channels;
+	u32 num_channels, pair[2], channel;
+	unsigned int i;
+	int ret;
+
+	num_channels = device_get_named_child_node_count(dev, "channel");
+	if (!num_channels)
+		return dev_err_probe(dev, -EINVAL, "no channel subnodes found\n");
+
+	if (num_channels > ADS112C04_MAX_CHANNELS)
+		return dev_err_probe(dev, -EINVAL,
+				     "num of channel nodes exceeds %d\n",
+				     ADS112C04_MAX_CHANNELS);
+
+	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	st->vref_source = devm_kcalloc(dev, num_channels,
+				       sizeof(*st->vref_source), GFP_KERNEL);
+	if (!st->vref_source)
+		return -ENOMEM;
+
+	i = 0;
+	device_for_each_named_child_node_scoped(dev, child, "channel") {
+		const char *s_chan = "single-channel", *d_chan = "diff-channels";
+		struct iio_chan_spec *spec = &channels[i];
+
+		if (fwnode_property_present(child, "excitation-channels"))
+			return dev_err_probe(dev, -EOPNOTSUPP,
+					     "excitation-channels is not supported yet\n");
+
+		ret = ads112c04_parse_vref_source(child);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "invalid reference-sources value\n");
+
+		st->vref_source[i] = ret;
+
+		*need_ext_ref |= st->vref_source[i] == ADS112C04_VREF_SOURCE_EXTERNAL;
+		*need_avdd_ref |= st->vref_source[i] == ADS112C04_VREF_SOURCE_AVDD;
+
+		/*
+		 * REVISIT: when ti,refp-refn-resistor-ohms is implemented, a
+		 * channel using an external resistor reference is effectively
+		 * a resistance measurement and should use IIO_RESISTANCE.
+		 */
+		spec->type = IIO_VOLTAGE;
+		spec->indexed = 1;
+		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
+
+		if (fwnode_property_present(child, s_chan)) {
+			ret = fwnode_property_read_u32(child, s_chan, &channel);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read %s property\n", s_chan);
+
+			if (channel > 3)
+				return dev_err_probe(dev, -EINVAL, "%s must be 0-3\n", s_chan);
+
+			spec->channel = channel;
+			spec->address = ADS112C04_CONF0_MUX_AIN_SINGLE_BASE + channel;
+		} else if (fwnode_property_present(child, d_chan)) {
+			ret = fwnode_property_read_u32_array(child, d_chan, pair, ARRAY_SIZE(pair));
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read %s property\n", d_chan);
+
+			if (pair[0] > 3 || pair[1] > 3)
+				return dev_err_probe(dev, -EINVAL, "%s must be 0-3\n", d_chan);
+
+			spec->channel = pair[0];
+			spec->channel2 = pair[1];
+			spec->differential = 1;
+
+			if (ads112c04_diff_mux[pair[0]][pair[1]] < 0)
+				return dev_err_probe(dev, -EINVAL,
+						     "invalid %s combination\n", d_chan);
+
+			spec->address = ads112c04_diff_mux[pair[0]][pair[1]];
+		} else {
+			return dev_err_probe(dev, -EINVAL,
+					     "channel node must have %s or %s\n", s_chan, d_chan);
+		}
+
+		i++;
+	}
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = i;
+
+	return 0;
+}
+
+static int ads112c04_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct ads112c04_state *st;
+	struct reset_control *reset;
+	bool need_avdd_ref = false, need_ext_ref = false;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->client = client;
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	init_completion(&st->completion);
+
+	indio_dev->name = "ads112c04";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ads112c04_info;
+
+	/* Forward compatibility checks for unimplemented DT properties */
+	if (device_property_present(dev, "refn-supply") ||
+	    device_property_present(dev, "ti,refp-refn-resistor-ohms"))
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "refn-supply and external resistors are not supported yet\n");
+
+	ret = ads112c04_parse_channels(indio_dev, &need_avdd_ref, &need_ext_ref);
+	if (ret)
+		return ret;
+
+	if (need_avdd_ref) {
+		ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "failed to get avdd voltage\n");
+
+		st->avdd_mV = ret / (MICRO / MILLI);
+	} else {
+		ret = devm_regulator_get_enable(dev, "avdd");
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
+	}
+
+	ret = devm_regulator_get_enable(dev, "dvdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
+
+	if (device_property_present(dev, "refp-supply")) {
+		ret = devm_regulator_get_enable_read_voltage(dev, "refp");
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "failed to get refp voltage\n");
+
+		st->ext_ref_mV = ret / (MICRO / MILLI);
+	}
+
+	if (need_ext_ref && !st->ext_ref_mV)
+		return dev_err_probe(dev, -EINVAL,
+				     "external reference measurements require refp-supply\n");
+
+	/* Datasheet: POR releases ~500us after supplies are stable */
+	fsleep(500);
+
+	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset), "failed to get reset\n");
+
+	if (reset) {
+		/* Datasheet: tw(RSL), the RESET low pulse, is 250ns minimum */
+		fsleep(1);
+
+		ret = reset_control_deassert(reset);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to deassert reset\n");
+	} else {
+		ret = ads112c04_write_cmd(client, ADS112C04_CMD_RESET);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Datasheet: td(RSSTA) is 100ns minimum after the RESET rising edge */
+	fsleep(1);
+
+	/*
+	 * Initialize CONFIG0 with all fields explicit: gain of 1 with the PGA
+	 * bypassed, which allows full-scale single-ended measurements. The MUX
+	 * field is updated per channel before each conversion.
+	 */
+	st->config0 = FIELD_PREP(ADS112C04_CONF0_MUX,
+				 ADS112C04_CONF0_MUX_AIN0_AIN1) |
+		      FIELD_PREP(ADS112C04_CONF0_GAIN,
+				 ADS112C04_CONF0_GAIN_X1) |
+		      ADS112C04_CONF0_PGA_BYPASS;
+
+	ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG0, st->config0);
+	if (ret)
+		return ret;
+
+	st->config1 = FIELD_PREP(ADS112C04_CONF1_DR,
+				 ADS112C04_CONF1_DR_20SPS) |
+		      FIELD_PREP(ADS112C04_CONF1_MODE,
+				 ADS112C04_CONF1_MODE_NORMAL) |
+		      FIELD_PREP(ADS112C04_CONF1_CM,
+				 ADS112C04_CONF1_CM_SINGLE_SHOT) |
+		      FIELD_PREP(ADS112C04_CONF1_VREF,
+				 ADS112C04_CONF1_VREF_INTERNAL) |
+		      FIELD_PREP(ADS112C04_CONF1_TS,
+				 ADS112C04_CONF1_TS_DISABLED);
+
+	ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG1, st->config1);
+	if (ret)
+		return ret;
+
+	if (client->irq > 0) {
+		ret = devm_request_irq(dev, client->irq, ads112c04_irq_handler, 0,
+				       indio_dev->name, indio_dev);
+		if (ret)
+			return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id ads112c04_id[] = {
+	{ .name = "ads112c04" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ads112c04_id);
+
+static const struct of_device_id ads112c04_of_match[] = {
+	{ .compatible = "ti,ads112c04" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ads112c04_of_match);
+
+static struct i2c_driver ads112c04_driver = {
+	.driver = {
+		.name = "ads112c04",
+		.of_match_table = ads112c04_of_match,
+	},
+	.probe = ads112c04_probe,
+	.id_table = ads112c04_id,
+};
+module_i2c_driver(ads112c04_driver);
+
+MODULE_AUTHOR("Kyle Hsieh <kylehsieh1995@gmail.com>");
+MODULE_DESCRIPTION("Texas Instruments ADS112C04 ADC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

