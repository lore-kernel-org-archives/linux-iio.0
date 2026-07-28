Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC03F8EC3
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225574; cv=none; b=s5AOJ80LcrROxMuR+xcoVtZ3kKMCtuzV6JP+em0ql8XnlYHLsqxGTjJLWA4ZqMY0x+crH5DLdLfrS1COegvSGZyWEp28Bf+hukCHm6avwNEyjqsQrfD6W8va0yFmPcX89PBPvs4TBBdoSlzz2wkVJiU/og47/XOsocg/HZbLWKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225574; c=relaxed/simple;
	bh=VBw5A0VXChwPW7VCZQC31zwwEZMfuLH+UByCUgnxnuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yx6y131pGZhXFu614PDJX8wCobD1Ei+AeHIGkeNPc0FdFCaA5nB9BYqHjIUoVsjOgQLlVEupow9RAR1ouvFpy9aYrLNoBx2ZaCrskD2AeG/6xXimN0+93UhgED2qVfhYnbd2G9N1EOPQASX0pKkGeLSrqyNEycfRNOkXz8CnFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARsxy9o5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARsxy9o5"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc61541f8cso11419165ad.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 00:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785225572; x=1785830372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UXZ4xlDp/Lm7tXZbjH7cAthJIW/XlFlPvYMC2HOtics=;
        b=ARsxy9o5SVIkC6gju58hO3sVGfb7ruRclQNiBupOiPSXBUKydmML3FiHEvSRWIPs7t
         7UX3M/7YymLhqynM6IfA/HccoMnuJCth0+oVWdQ3xWukc08atw4XxbKU7846b4FG/IF4
         huVHmo/K/zwIshBwAkDLpl0tNUAjqYa2aWqALd9IFqG2RGBJS7dYOt0fyhj+tOC9N6ov
         PjzGMGS82b87cxr8P5S9hy68FznLUYMzfUDKEq/qf3wLl9c/uzkLWe/keKW2Ceo/f/w6
         poZPi9yrXYhY9w4Jp5748qbhyF8d742sYZmdooA44LysP/UQQhZqXmdrIeMB7zftyXrZ
         nvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785225572; x=1785830372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UXZ4xlDp/Lm7tXZbjH7cAthJIW/XlFlPvYMC2HOtics=;
        b=UFMJDX5njZcf3DVCouOi4DZFt3G163m4usJIlfEU5pNluzqt85dxE1LLfwVZzWHjOC
         HtBzkQEJZKROW5mscyxW45q9dc+zZQzeR+trrNF5aG1CXTwyALJcwvO94cfHYb/Ew8jc
         Ik/M6Lptwyk2LKAiBTk+HvKCMe87KfR042DynLhIFKSLzMFyKETIOtj9R9FuRRFS6Lgc
         UpU1AWRJT9QBc2Cvs9jonCYDnxLucwVjvKEQChbhwQv9sYPNfNrgsKJtuiMHokc7okAC
         Fms/VX1CIIyPDf/587X3iZA4Izw+MDM0hoLqpGgggxmSED3aPKw57h4nJ3LssEz2kDBZ
         zcKg==
X-Gm-Message-State: AOJu0Yy5w8mo25xJSfiFZDWMiquA8KONBKoz3myGmZk6aII6qL/m8qvp
	834jGiVjbKo2zme+EFf2Vk1TyWtCWPMjuM/QXWQSw3bE3fiTyed2rPUx
X-Gm-Gg: AR+sD12l6U7GE+1h/WV9kAW3PqyYySBQ6Bx9PTex7AKpK5Wn94WISy2yiCSRoOiH/1F
	yGmTAT2iPnj0+0l5JO37qngH7+6ZgKF5BkUDHYErAHB8GdqJzXAqPyVlbSA3WjFbv1xYZijN9ju
	Ld/4vfCvEJZmEHM0Lx6aDWXUc7y6iprQF00CqElogyCz4JvCmxukkP8k6hiq+fcRbQsWJxuof7B
	whiFHj2MQ8ipOEF/PsYlt7T0z+NrpbTH39nsAOD8Lc2zryxpOQLY2Uzl/y916BTNJB6EWJlNYqv
	w6FfWGI3Kk/2zQoqfTPbQF+dL5EluH+q12CgPhN/XFT6LWUTG3DBa5iEQFy8tIqecxAzXZFexGM
	uAYChN0EBG1PKdp0Ze9vKpRW2zICLmDTpsKCX61FDg7Apu2MK3eKOKwHv+qawaYdgRs8HJumKI4
	otphSJ4SU9wy+YXd3WCMd4BPjBxpdP+nOceGzcSfV322wJnzOHfhDvcHKGCDpSf9YYHnyLSOd7U
	KFnCuEWHQgrxdOege/ax0LCpewi
X-Received: by 2002:a17:903:41ca:b0:2cc:841d:cd7e with SMTP id d9443c01a7336-2d015eebe48mr14938315ad.21.1785225572140;
        Tue, 28 Jul 2026 00:59:32 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81d81csm47543915ad.80.2026.07.28.00.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:59:31 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 28 Jul 2026 16:01:18 +0800
Subject: [PATCH 2/2] iio: adc: ti-ads112c04: Add support for TI ADS112C04
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-ti-ads112c04-driver-v1-2-475efe4e2b78@gmail.com>
References: <20260728-ti-ads112c04-driver-v1-0-475efe4e2b78@gmail.com>
In-Reply-To: <20260728-ti-ads112c04-driver-v1-0-475efe4e2b78@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10582;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=VBw5A0VXChwPW7VCZQC31zwwEZMfuLH+UByCUgnxnuE=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqaGHQ0YDBD1i+cMmMP7dLauHjW2OL9xRC/tCJI
 /qeHBnE+pKJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCamhh0AAKCRClg0K3CVbE
 gUoHB/sE8OOp72husgWkRCPEKO52wKJx8/vSYjI4v/CM1+PocCgrTDwN396rOWcNoDF0iPaqrqO
 5UdNYKdRQE1RkPvYEYrPwRnlOWPMm4e/VIyHOec132YDJAhm7AB0ANZ7Ixj5Ivamh5BaBzCpbgN
 1OTtt6Tges9xvvnUv3vjldPHNwFEECinm16viGrggSG4xOWqf4yojVASHeYA24zkLqMkpHHTQhM
 s7OHAMBZ7zfmbCWettHWZrpHuANQCN9MgymqCa67QLC8dpFi2FJDaSfH7phBIg3HN80d+5tI1XU
 rBRp+45KZ8RjoOt2mil7F+uOJ1+kvm/pSJ5OMNTUb/bMh392
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
delta-sigma ADCs.

The driver implements:
- Single-shot conversions using the IIO raw read interface.
- MUX configuration for single-ended and differential channels.
- Hardware interrupt support via the DRDY pin, falling back to
  software polling of the configuration register if no IRQ is provided.
- Scale calculation based on the internal 2.048V reference.
- Dynamic reference voltage scaling via the regulator subsystem
  (vref-supply), falling back to the internal 2.048V reference
  if not specified.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 drivers/iio/adc/Kconfig        |  10 ++
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/ti-ads112c04.c | 317 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 328 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 3755a81c1efd..402e841bc083 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1789,6 +1789,16 @@ config TI_ADS1119
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
 config TI_ADS124S08
 	tristate "Texas Instruments ADS124S08"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 707dd708912f..ebf9d4047a5a 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -153,6 +153,7 @@ obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS1018) += ti-ads1018.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
+obj-$(CONFIG_TI_ADS112C04)	+= ti-ads112c04.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
diff --git a/drivers/iio/adc/ti-ads112c04.c b/drivers/iio/adc/ti-ads112c04.c
new file mode 100644
index 000000000000..0f1d415e3f21
--- /dev/null
+++ b/drivers/iio/adc/ti-ads112c04.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments ADS112C04 16-bit I2C ADC driver
+ * Based on TI Reference Code and standard Linux IIO framework.
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/regulator/consumer.h>
+
+/* ADS112C04 Commands */
+#define ADS112C04_CMD_RESET         0x06
+#define ADS112C04_CMD_START_SYNC    0x08
+#define ADS112C04_CMD_POWERDOWN     0x02
+#define ADS112C04_CMD_RDATA         0x10
+#define ADS112C04_CMD_RREG(reg)     (0x20 | ((reg) << 2))
+#define ADS112C04_CMD_WREG(reg)     (0x40 | ((reg) << 2))
+
+/* Registers */
+#define ADS112C04_REG_CONFIG0       0x00
+#define ADS112C04_REG_CONFIG1       0x01
+#define ADS112C04_REG_CONFIG2       0x02
+#define ADS112C04_REG_CONFIG3       0x03
+
+/* Config2 Masks */
+#define ADS112C04_DRDY_MASK         BIT(7)
+
+struct ads112c04_state {
+	struct i2c_client *client;
+	/* Protects concurrent ADC reads and device configuration */
+	struct mutex lock;
+	struct completion completion;
+	struct regulator *vref_reg;
+	int vref_mv;
+	u8 config0;
+	u8 config1;
+};
+
+static int ads112c04_write_cmd(struct i2c_client *client, u8 cmd)
+{
+	return i2c_master_send(client, &cmd, 1);
+}
+
+static int ads112c04_read_reg(struct i2c_client *client, u8 reg, u8 *val)
+{
+	u8 cmd = ADS112C04_CMD_RREG(reg);
+	int ret;
+
+	ret = i2c_master_send(client, &cmd, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_master_recv(client, val, 1);
+	return ret < 0 ? ret : 0;
+}
+
+static int ads112c04_write_reg(struct i2c_client *client, u8 reg, u8 val)
+{
+	u8 buf[2] = { ADS112C04_CMD_WREG(reg), val };
+	int ret;
+
+	ret = i2c_master_send(client, buf, 2);
+	return ret < 0 ? ret : 0;
+}
+
+static int ads112c04_wait_for_data(struct ads112c04_state *st)
+{
+	int ret, timeout = 50;
+	u8 val;
+
+	/* If IRQ is available, wait for DRDY interrupt completion */
+	if (st->client->irq > 0) {
+		ret = wait_for_completion_timeout(&st->completion, msecs_to_jiffies(1000));
+		if (!ret)
+			return -ETIMEDOUT;
+		return 0;
+	}
+
+	/* Fallback: Poll DRDY bit in CONFIG2 */
+	while (timeout--) {
+		ret = ads112c04_read_reg(st->client, ADS112C04_REG_CONFIG2, &val);
+		if (ret < 0)
+			return ret;
+		if (val & ADS112C04_DRDY_MASK)
+			return 0;
+		usleep_range(1000, 2000);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int ads112c04_read_data(struct ads112c04_state *st, int *val)
+{
+	u8 cmd = ADS112C04_CMD_RDATA;
+	u8 buf[2];
+	int ret;
+
+	ret = i2c_master_send(st->client, &cmd, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_master_recv(st->client, buf, 2);
+	if (ret < 0)
+		return ret;
+
+	/* 16-bit 2's complement conversion */
+	*val = (s16)((buf[0] << 8) | buf[1]);
+	return 0;
+}
+
+static int ads112c04_get_adc_result(struct ads112c04_state *st,
+				    struct iio_chan_spec const *chan,
+				    int *val)
+{
+	int ret;
+	u8 mux;
+
+	mux = (chan->address << 4) & 0xF0;
+	if ((st->config0 & 0xF0) != mux) {
+		st->config0 = (st->config0 & 0x0F) | mux;
+		ads112c04_write_reg(st->client, ADS112C04_REG_CONFIG0, st->config0);
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
+	int ret, raw;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = ads112c04_get_adc_result(st, chan, val);
+		mutex_unlock(&st->lock);
+
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_mv;
+		*val2 = 15; /* 2^15 */
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
+	return IRQ_HANDLED;
+}
+
+#define ADS112C04_V_CHAN(_chan, _addr) {			\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = _chan,					\
+	.address = _addr,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+}
+
+#define ADS112C04_V_DIFF_CHAN(_chan, _chan2, _addr) {		\
+	.type = IIO_VOLTAGE,					\
+	.differential = 1,					\
+	.indexed = 1,						\
+	.channel = _chan,					\
+	.channel2 = _chan2,					\
+	.address = _addr,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+}
+
+static const struct iio_chan_spec ads112c04_channels[] = {
+	ADS112C04_V_DIFF_CHAN(0, 1, 0x00),
+	ADS112C04_V_DIFF_CHAN(0, 2, 0x01),
+	ADS112C04_V_DIFF_CHAN(0, 3, 0x02),
+	ADS112C04_V_DIFF_CHAN(1, 0, 0x03),
+	ADS112C04_V_DIFF_CHAN(1, 2, 0x04),
+	ADS112C04_V_DIFF_CHAN(1, 3, 0x05),
+	ADS112C04_V_DIFF_CHAN(2, 3, 0x06),
+	ADS112C04_V_DIFF_CHAN(3, 2, 0x07),
+	ADS112C04_V_CHAN(0, 0x08),
+	ADS112C04_V_CHAN(1, 0x09),
+	ADS112C04_V_CHAN(2, 0x0A),
+	ADS112C04_V_CHAN(3, 0x0B),
+};
+
+static const struct iio_info ads112c04_info = {
+	.read_raw = ads112c04_read_raw,
+};
+
+static void ads112c04_regulator_disable(void *data)
+{
+	regulator_disable(data);
+}
+
+static int ads112c04_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct ads112c04_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->client = client;
+	mutex_init(&st->lock);
+	init_completion(&st->completion);
+
+	indio_dev->name = "ads112c04";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ads112c04_info;
+	indio_dev->channels = ads112c04_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ads112c04_channels);
+
+	st->vref_reg = devm_regulator_get_optional(&client->dev, "vref");
+	if (IS_ERR(st->vref_reg)) {
+		ret = PTR_ERR(st->vref_reg);
+		if (ret == -ENODEV) {
+			st->vref_mv = 2048;
+			st->config1 = 0x00; /* VREF[1:0] = 00 */
+		} else {
+			return ret;
+		}
+	} else {
+		ret = regulator_enable(st->vref_reg);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(&client->dev, ads112c04_regulator_disable,
+					       st->vref_reg);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(st->vref_reg);
+		if (ret < 0)
+			return ret;
+
+		st->vref_mv = ret / 1000;
+		st->config1 = 0x02;
+	}
+
+	/* Reset device to defaults */
+	ads112c04_write_cmd(client, ADS112C04_CMD_RESET);
+	usleep_range(1000, 2000);
+
+	/* Set defaults: PGA Disabled (For single-ended safety), Gain=1 */
+	st->config0 = 0x01;
+
+	ads112c04_write_reg(client, ADS112C04_REG_CONFIG1, st->config1);
+
+	if (client->irq > 0) {
+		ret = devm_request_irq(&client->dev, client->irq,
+				       ads112c04_irq_handler,
+				       IRQF_TRIGGER_FALLING,
+				       indio_dev->name, indio_dev);
+		if (ret) {
+			dev_err(&client->dev, "Failed to request DRDY IRQ\n");
+			return ret;
+		}
+	}
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id ads112c04_id[] = {
+	{ "ads112c04", 0 },
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

