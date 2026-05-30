Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD903A8730
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160826; cv=none; b=FnzvEf1+D7/fdwqzxpGoQauNkEwJH5q+FUL1du+U6Qg/C6rz3iEHD/twqioh40scPexvxD9vNyDX8xfTyaC1hxgJ1QJKL8tFpYYFBzIQNgqmyEltmF7xcZXDgQNHLzvDs3Chz52ets/CQwmrg0S8FvwEKMKojQjcYrZZIn4z3VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160826; c=relaxed/simple;
	bh=jMM9AGZQ1yhZL0bWDi+kjv/9mqJ4r/aXSTBbYH4dJH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgdx3mYZn5FTw6wl9QHDYwXo9Rc4dvf0XaPmnW7lHKzghetg6hwxwZ++92Y8ezfyRW7OzPcY+MEwwZtYnYhFVXQ6v27EM/J9HJ5c7h2xEYMcWhW0bXglSFuqjIEkG8sveqyhNbhDKGS34y+64GClfniKYZ2/hkry/jGWzUaqpsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB1SKpB/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB1SKpB/"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48fde648a71so96994145e9.0
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 10:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780160823; x=1780765623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90TfCW3zN1Ef3sxTtmqfO0zZaMtigiDXfaKQLQneVQc=;
        b=YB1SKpB/JowEPmEGa2ODssfU+e4RbzzgU1dBk13QAdz6c+XLtPKjJjtoQOU+HFt0Oh
         wFGVvZoax7tqIKX4NrciwK9kvAm08sB90Pi0tL1SUsVwCiXxwHipWXEEcQFqKjqf2+gh
         dPdMuLp6MSEj8Jnmx62wyMvpXk8bWPbe17fI3vLkREXn19maGXLcGOGHtO6w2RwUUsIu
         VEyNtj/HZCvHKUs5YUb50M3xH0Xy3t9YkzHAz14WpDU5cvK9PFTOMUzvgfs6YLuAy93c
         yqBwP505sZkbIUPD29uo/MRFd95kg2JhKCO7wNMKvpsD808uQ442Uf9KnDutFfKB/CgY
         OEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780160823; x=1780765623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=90TfCW3zN1Ef3sxTtmqfO0zZaMtigiDXfaKQLQneVQc=;
        b=hnh5EWxYkCN/TlA8ryFrCl0R+JEN8XrehvBiSZvzfzykBKSuw5iKTBB5i0hOZqWuME
         Vw/G8TISD2T9P60QHeSOEQsRtWi/I8AwBte6/DBmIKMoXoIum637z4xLMK2XoBqRcKNJ
         M/pBATx0OH3oHGw2gNRzwdgiwDCiKZT8D3g7N5ePWiW1Zu814bcILogzcOuOhmCchMWN
         KvwC7Y3KfF1mRDXjclxuiEeU/0YYqHDTKV0ARPANNFzW5mAlkd27s9yGoY+VVMAevVHn
         bSYzDGeOc2dctz5C2nKWwlDFnvKuDGArZ8XLXRXM2enreUYD85Per6Nhx9idphNJk/ot
         NVFg==
X-Gm-Message-State: AOJu0YzVkr//Fzw4dw6qtdGnzBlN5RPtobOxnSFQ3DuRK3Iga6p09+hf
	KjqJurOSB/Jggg53JDHnoTLe43i3KpSsNeMpYuqoZHP35FwUtiaoj3rc
X-Gm-Gg: Acq92OENDrs0OPjO1hzlQ4mNYReK0XBLqRQSM9E6hsoTicFD6rflxhMYlqa73LY7Ism
	MBr6o8e66HmluoM+urtxjlQGbrZ3/ad4oVHgvAtzugm1qjzTF8qYEzk7Nii39zHX7KNJqYjWCiU
	SXewS/fAPK5988rrR4Ab/JvfD/cqf2SG0YiUU2PCTq1la+IstMEAYwyu9A5HHRu3EfC+2a01Lyq
	k3QL6P5hqb1RQAFulYRqm98ju8wD4Fy1BysivpPWLJt0KTARW4JlgRwrfYTDFDlNfiP1hBEUrSm
	Lq76o4acWrthcmPfkPEuyMohtITC8mYIaYLNKhRBKcjxiaN2o5ZztgnGSwGFQ3Kic37L1Ny+q8c
	RO2xVOqdZpymXvSgNoLV/KCqdAHBqOEtEe1Z9QZBDB0mhpD+RYOtLTMFcv/6qVd5J749QnmT6hW
	02+BGaveeN9CGCH1tP9PbIRNVSo5SaLdMXl6TkcGNfV5mDpkocMW/HM8HoJRRAnd6U5dgF1q5qN
	wWFZyHNYSHUj0GE08X1DaqMj635omhssnbgdEMs6ExdD1DWRuBIyrVK+jCsNVddnDKtPjCOseme
	nAwNtNEKq3P5optRbDJegSFN5S5RbQhnihEG1T+y8P9/+RMMdZ0pduNN0XLJHQ==
X-Received: by 2002:a05:600c:34c3:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-490a2a2aab7mr62392065e9.8.1780160822571;
        Sat, 30 May 2026 10:07:02 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909cab0e79sm229144675e9.13.2026.05.30.10.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 10:07:02 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 30 May 2026 19:06:47 +0200
Subject: [PATCH v3 2/2] iio: light: veml3328: add support for new device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-veml3328-v3-2-dd562eaee8d9@gmail.com>
References: <20260530-veml3328-v3-0-dd562eaee8d9@gmail.com>
In-Reply-To: <20260530-veml3328-v3-0-dd562eaee8d9@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780160820; l=14010;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=jMM9AGZQ1yhZL0bWDi+kjv/9mqJ4r/aXSTBbYH4dJH8=;
 b=qc/siRnPju+80nkB8SRvDUJ6/VKXfamWBXGB6b1wH61oK7WrHIcpZGTuAkUHfZtgO3pCJtblW
 YCEuHMPKbCzDMsjWvDvSX7xuDB7f007M4QfYTbBoISN6c2DcuDd/4qc
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Add support for the Vishay VEML3328 RGB/IR light sensor communicating
via I2C (SMBus compatible).

Also add a new entry for said driver into Kconfig and Makefile.

Assisted-by: Gemini:3.1-Pro
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 MAINTAINERS                  |   5 +
 drivers/iio/light/Kconfig    |  11 ++
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/veml3328.c | 413 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 430 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e9457c7bba6..a893a1a1181e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28402,6 +28402,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
 F:	drivers/iio/light/veml3235.c
 
+VISHAY VEML3328 RGB IR LIGHT SENSOR DRIVER
+M:	Joshua Crofts <joshua.crofts1@gmail.com>
+S:	Maintained
+F:	drivers/iio/light/veml3328.c
+
 VISHAY VEML6030 AMBIENT LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index da4807a3fd3d..ef36824f312f 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -713,6 +713,17 @@ config VEML3235
 	  To compile this driver as a module, choose M here: the
 	  module will be called veml3235.
 
+config VEML3328
+	tristate "VEML3328 RGBCIR light sensor"
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  Say Y here if you want to build a driver for the Vishay VEML3328
+	  RGB IR light sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called veml3328
+
 config VEML6030
 	tristate "VEML6030 and VEML6035 ambient light sensors"
 	select REGMAP_I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 39e62dfc10c7..64e354c49ed8 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_US5182D)		+= us5182d.o
 obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
 obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
 obj-$(CONFIG_VEML3235)		+= veml3235.o
+obj-$(CONFIG_VEML3328)		+= veml3328.o
 obj-$(CONFIG_VEML6030)		+= veml6030.o
 obj-$(CONFIG_VEML6040)		+= veml6040.o
 obj-$(CONFIG_VEML6046X00)	+= veml6046x00.o
diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
new file mode 100644
index 000000000000..1def67fd9b51
--- /dev/null
+++ b/drivers/iio/light/veml3328.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Vishay VEML3328 RGBCIR light sensor driver
+ *
+ * Copyright (c) 2026 Joshua Crofts <joshua.crofts1@gmail.com>
+ *
+ * Datasheet: https://www.vishay.com/docs/84968/veml3328.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+
+#define VEML3328_REG_CONF		0x00
+#define VEML3328_REG_ID			0x0c
+#define VEML3328_REG_DATA_C		0x04
+#define VEML3328_REG_DATA_R		0x05
+#define VEML3328_REG_DATA_G		0x06
+#define VEML3328_REG_DATA_B		0x07
+#define VEML3328_REG_DATA_IR		0x08
+
+#define VEML3328_CONF_IT_MASK		GENMASK(5, 4)
+#define VEML3328_CONF_GAIN_MASK		GENMASK(11, 10)
+
+#define VEML3328_MAX_IT_TIME		(400 * USEC_PER_MSEC)
+
+#define VEML3328_ID_VAL			0x28
+
+#define VEML3328_SHUTDOWN		(BIT(0) | BIT(15))
+
+struct veml3328_data {
+	struct regmap *regmap;
+};
+
+static const struct regmap_config veml3328_regmap_config = {
+	.name = "veml3328",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = VEML3328_REG_ID,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+#define VEML3328_CHAN_SPEC(_color, _addr) { \
+	.type = IIO_INTENSITY, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_LIGHT_##_color, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME), \
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME), \
+	.address = _addr, \
+}
+
+static const struct iio_chan_spec veml3328_channels[] = {
+	{
+		.type = IIO_LIGHT,
+
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.address = VEML3328_REG_DATA_G,
+	},
+	VEML3328_CHAN_SPEC(CLEAR, VEML3328_REG_DATA_C),
+	VEML3328_CHAN_SPEC(RED, VEML3328_REG_DATA_R),
+	VEML3328_CHAN_SPEC(GREEN, VEML3328_REG_DATA_G),
+	VEML3328_CHAN_SPEC(BLUE, VEML3328_REG_DATA_B),
+	VEML3328_CHAN_SPEC(IR, VEML3328_REG_DATA_IR),
+};
+
+/*
+ * Precomputed scale values (micro units).
+ * Formula for calculation: 0.384 * (50000 / IT_us) * (1 / Gain)
+ * Gain indexes: 0 (x0.5), 1 (x1), 2 (x2), 3 (x4)
+ * IT indexes: 0 (50ms), 1 (100ms), 2 (200ms), 3 (400ms)
+ */
+static const int veml3328_scale_vals[4][8] = {
+	{ 0, 768000, 0, 384000, 0, 192000, 0, 96000 },
+	{ 0, 384000, 0, 192000, 0, 96000,  0, 48000 },
+	{ 0, 192000, 0, 96000,  0, 48000,  0, 24000 },
+	{ 0, 96000,  0, 48000,  0, 24000,  0, 12000 },
+};
+
+/* integration times in microseconds */
+static const int veml3328_it_times[][2] = {
+	{ 0, 50 * USEC_PER_MSEC },
+	{ 0, 100 * USEC_PER_MSEC },
+	{ 0, 200 * USEC_PER_MSEC },
+	{ 0, 400 * USEC_PER_MSEC },
+};
+
+static int veml3328_power_down(struct veml3328_data *data)
+{
+	return regmap_set_bits(data->regmap, VEML3328_REG_CONF,
+			       VEML3328_SHUTDOWN);
+}
+
+static int veml3328_power_up(struct veml3328_data *data)
+{
+	int ret;
+
+	ret = regmap_clear_bits(data->regmap, VEML3328_REG_CONF,
+				VEML3328_SHUTDOWN);
+	if (ret)
+		return ret;
+
+	/*
+	 * Sleep for maximum integration time to ensure sensor is powered on
+	 * correctly.
+	 */
+	fsleep(VEML3328_MAX_IT_TIME);
+
+	return 0;
+}
+
+static void veml3328_power_down_action(void *data)
+{
+	veml3328_power_down(data);
+}
+
+static int veml3328_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct veml3328_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	struct device *dev = regmap_get_device(regmap);
+	unsigned int reg_val;
+	int it_inx, gain_inx;
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(regmap, chan->address, &reg_val);
+		if (ret)
+			return ret;
+
+		*val = reg_val;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_INT_TIME:
+		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
+		if (ret)
+			return ret;
+
+		it_inx = FIELD_GET(VEML3328_CONF_IT_MASK, reg_val);
+		if (it_inx >= ARRAY_SIZE(veml3328_it_times))
+			return -EINVAL;
+
+		*val = veml3328_it_times[it_inx][0];
+		*val2 = veml3328_it_times[it_inx][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
+		if (ret)
+			return ret;
+
+		it_inx = FIELD_GET(VEML3328_CONF_IT_MASK, reg_val);
+		gain_inx = FIELD_GET(VEML3328_CONF_GAIN_MASK, reg_val);
+
+		if (it_inx >= ARRAY_SIZE(veml3328_it_times) || gain_inx >= 4)
+			return -EINVAL;
+
+		/* Stride by 2 through the flattened array to match (val, val2) */
+		*val = veml3328_scale_vals[it_inx][gain_inx * 2];
+		*val2 = veml3328_scale_vals[it_inx][gain_inx * 2 + 1];
+
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml3328_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	struct veml3328_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int reg_val;
+	int ret, it_inx;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*length = ARRAY_SIZE(veml3328_it_times) * 2;
+		*vals = (const int *)veml3328_it_times;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+
+	case IIO_CHAN_INFO_SCALE:
+		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
+		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+		if (ret)
+			return ret;
+
+		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
+		if (ret)
+			return ret;
+
+		it_inx = FIELD_GET(VEML3328_CONF_IT_MASK, reg_val);
+		if (it_inx >= ARRAY_SIZE(veml3328_it_times))
+			return -EINVAL;
+
+		*length = 8;
+		*vals = (const int *)veml3328_scale_vals[it_inx];
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml3328_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct veml3328_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	struct device *dev = regmap_get_device(regmap);
+	unsigned int reg_val;
+	int i, it_inx;
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val != 0)
+			return -EINVAL;
+
+		for (i = 0; i < ARRAY_SIZE(veml3328_it_times); i++) {
+			if (veml3328_it_times[i][1] == val2)
+				break;
+		}
+
+		if (i == ARRAY_SIZE(veml3328_it_times))
+			return -EINVAL;
+
+		return regmap_update_bits(regmap, VEML3328_REG_CONF,
+					  VEML3328_CONF_IT_MASK,
+					  FIELD_PREP(VEML3328_CONF_IT_MASK, i));
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
+		if (ret)
+			return ret;
+
+		it_inx = FIELD_GET(VEML3328_CONF_IT_MASK, reg_val);
+		if (it_inx >= ARRAY_SIZE(veml3328_it_times))
+			return -EINVAL;
+
+		for (i = 0; i < 4; i++) {
+			if (val == veml3328_scale_vals[it_inx][i * 2] &&
+			    val2 == veml3328_scale_vals[it_inx][i * 2 + 1])
+				break;
+		}
+
+		if (i == 4)
+			return -EINVAL;
+
+		return regmap_update_bits(regmap, VEML3328_REG_CONF,
+					  VEML3328_CONF_GAIN_MASK,
+					  FIELD_PREP(VEML3328_CONF_GAIN_MASK, i));
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info veml3328_info = {
+	.read_raw = veml3328_read_raw,
+	.write_raw = veml3328_write_raw,
+	.read_avail = veml3328_read_avail,
+};
+
+static int veml3328_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct veml3328_data *data;
+	struct iio_dev *indio_dev;
+	unsigned int reg_val;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+
+	data->regmap = devm_regmap_init_i2c(client, &veml3328_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "Failed to initialize regmap\n");
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
+
+	ret = regmap_read(data->regmap, VEML3328_REG_ID, &reg_val);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read ID register\n");
+
+	if ((reg_val & 0xff) != VEML3328_ID_VAL)
+		dev_warn(dev, "Unknown device ID: 0x%02x\n", reg_val & 0xff);
+
+	ret = veml3328_power_up(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to power on sensor\n");
+
+	ret = devm_add_action_or_reset(dev, veml3328_power_down_action, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register teardown\n");
+
+	indio_dev->name = "veml3328";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &veml3328_info;
+	indio_dev->channels = veml3328_channels;
+	indio_dev->num_channels = ARRAY_SIZE(veml3328_channels);
+
+	pm_runtime_set_active(dev);
+	pm_runtime_set_autosuspend_delay(dev, 2000);
+	pm_runtime_use_autosuspend(dev);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int veml3328_runtime_suspend(struct device *dev)
+{
+	struct veml3328_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	ret = veml3328_power_down(data);
+	if (ret)
+		dev_err(dev, "Failed to suspend: %d\n", ret);
+
+	return ret;
+}
+
+static int veml3328_runtime_resume(struct device *dev)
+{
+	struct veml3328_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	ret = veml3328_power_up(data);
+	if (ret)
+		dev_err(dev, "Failed to resume: %d\n", ret);
+
+	return ret;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(veml3328_pm_ops,
+				 veml3328_runtime_suspend,
+				 veml3328_runtime_resume,
+				 NULL);
+
+static const struct of_device_id veml3328_of_match[] = {
+	{ .compatible = "vishay,veml3328" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, veml3328_of_match);
+
+static const struct i2c_device_id veml3328_id[] = {
+	{ .name = "veml3328" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, veml3328_id);
+
+static struct i2c_driver veml3328_driver = {
+	.driver = {
+		.name = "veml3328",
+		.of_match_table = veml3328_of_match,
+		.pm = pm_ptr(&veml3328_pm_ops),
+	},
+	.probe = veml3328_probe,
+	.id_table = veml3328_id,
+};
+module_i2c_driver(veml3328_driver);
+
+MODULE_AUTHOR("Joshua Crofts <joshua.crofts1@gmail.com>");
+MODULE_DESCRIPTION("VEML3328 RGBCIR Light Sensor");
+MODULE_LICENSE("GPL");

-- 
2.54.0

