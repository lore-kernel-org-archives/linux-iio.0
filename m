Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A934F68B1
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892633; cv=none; b=AnP5/zOnVQmgHuxfYdfceORyQvDmfuw1oKzTtNeoCjymrJvjvylAfpHaB1gN+KH/e6scHs2Igk7LbO18tPcbIpwhddUzez1x13qkSJJrbI5b6HsnruYJ9npQH7/XiAOIHI/0AqrfegZaaAkGi8GnrIKIB5H62ezQAJOacpNMo2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892633; c=relaxed/simple;
	bh=riNgx44VH33hXNlVUJ1N3GXvboQZ1U1iSjTWyfqF09I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9j9+67/3amMnmM8ezsEZY5D69YjPxaXfxXsnDwW4+wig3UZXPXnfXkYBnTm54FlzzUPySSxMUNnMfMWIAf8jvUUK/hh5Y5rqYXsrN1sJDZ/hRdudDoC7i5R4GD9VwgXzftxzMpOfhv/u3xKlmkA+xW4aGz/y+hc+zqcXAI5TJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0tKsLMj; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0tKsLMj"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so1961955eec.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 04:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791892629; x=1792497429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lOANsQbLLTH+UDYeNMR3MHw8Jy3A04SNwjfmJXYMeH8=;
        b=G0tKsLMjwD5g7NA182rQFX3+FoWeZPmMJJB0RrRtUjM+9/THcZkan9kbhhA40jneH5
         5MM0hnanYfz278l9pA7Ittjqmd47aILWB//Odt3xRxwtpU1XoSYn+Lem2ivT86ksHMe8
         8Y5YsJ+G+98lRkXl+pD682SeeiTTBi/kRToV5YUvOZLHyXPlmLaO74lxl3UqElsgFbB/
         rfUbPN+v+OmyR1TuWvFmdYa9wi6w0gTNUB7mJWFerLNm06hvhH3LUw/XR3gqLf0t1AFZ
         UZqQw02RzsnjrKm3Qa9i5cYcAF0bFAR2SDV8+Ix8F19AoYKatE1CmpMh5y61UHnT4iIX
         8aBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791892629; x=1792497429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lOANsQbLLTH+UDYeNMR3MHw8Jy3A04SNwjfmJXYMeH8=;
        b=dKxAw0HZDQhGwjVeQprgLcg1h5TM+ZB8XyrHSdtTgLozPy2E4tP+jMImtMdeLzHFi4
         zeaP1hrswQierxk1A/9S+WEkATIMAgQCnbhGJ57Njz+DAAW5QR9MHzzRSgqB0ByfOC6S
         4bkcJxPo9E+FHrxJHZmptZ19x7Pj7p+o9copxkW3/b9/7njCczXyP70RDVyx8VhyRHXK
         GJtRSkdKkWCSoFoLfgRFq9KmqP2f8SSrO8IIuqc8AiejXxUtQdfY0DjsvGOba1WomCC8
         IuMgsSejYuEWkIf8syTguRgORjOB+7zhs1vir6wm3D39O5D6H2awQMkk1NzVT+xRdTHT
         0yIQ==
X-Forwarded-Encrypted: i=1; AKwUvByWSTulfkalkl7RIaofJOOKCN05R7uSV7IEHiPb3krnQLviX/iCxsuWc7ygw4yC5ceRkIpyq12nzyg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmL+S4Xwh00cSQP+2HYT5T+7rK6+RTOcVGQ/CopUnmN9DlmhHn
	XH8YgIQOPsgY+VTVAztX6sGGarVBirYg3xqjnaB4iUaHIJHMx1vug3tK
X-Gm-Gg: AYBFou2YMNr8M4SALaKBmNfUuZ1kIix4NOvGEy/hrCjGZmnj0zDLJ6Q7L4nLJnXdbj5
	DlRWChJyM+1tB7EeUe5mgdcbGNf9Q5EjAAA1L2eguW4+qtK49Bn4ukNw3FbN4paN4/l475p54Zk
	aO0Jr1V67b13LZ6y4en7Vkwi5SWP5YzdV5G+ty5Ldfnx1VQMHRiyh27plQU4FlFBMiKi32DEJBO
	GxNc1n7jQs302zgPDB/hKW6EcQFSg1/19o8PHa2cocw21gY82i1Thorxr+6qfM8Iy98s1lwD2Ob
	br4oLpxQxv9TVah3xc3xSuoQdp7dvuaYWlFfA107Uv8+QXf5qbyAd9rJyy9UspQqTamVAX2dBkg
	T+BA/Hn5olm2KJQBfhPJ1VoUm8xvW0K2YAw92yn2QO39J9uowWCeMoDOkm5bDt2slHmzpwHh93/
	ze7EhetzIEoSvzzFDKF2HP+TM9GmuCvoUnfekG+9feevKxFylbMQiumzWkfGs0rIMtx57uzveu4
	f1mM1b8Vbs=
X-Received: by 2002:a05:7300:fa15:b0:35b:9851:a896 with SMTP id 5a478bee46e88-35b9851ab64mr5051567eec.10.1791892628695;
        Tue, 13 Oct 2026 04:57:08 -0700 (PDT)
Received: from localhost ([104.156.230.40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b556sm57827725eec.9.2026.10.13.04.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:57:08 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] iio: light: add AS7343 multi-spectral sensor driver
Date: Tue, 13 Oct 2026 19:56:39 +0800
Message-ID: <20261013115639.167433-3-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013115639.167433-1-marcus.yu.56@gmail.com>
References: <20261013115639.167433-1-marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the AMS AS7343 14-channel multi-spectral sensor.

The AS7343 is a 14-channel spectral sensor featuring 11 visible
channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
flicker detection channel.

The driver exposes 12 spectral channels (11 visible light and 1
near-infrared) via sysfs. Runtime PM is implemented to stop
measurements when the device is suspended or torn down. Power is
never cut (PON=1 always) to preserve register values.

Future patches will add configurable gain and integration time,
interrupt support, buffered reads, VIS channel, and flicker
detection.

Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
Changes in v6:
 - Convert ASTEP and ATIME range checks to runtime checks.
 - Move adding suspend action to before setting autosuspend delay.

Changes in v5:
 - Add autosuspend support.
 - Start measurements before configuring runtime PM.
 - Add functions for computing ASTEP and ATIME.
 - Sort registers by addresses.

Changes in v4:
 - Use REGCACHE_MAPLE and add volatile register table.
 - Use PM_RUNTIME_ACQUIRE* when resuming.
 - Use a static array for labels.
 - Various code style fixes.

Changes in v3:
 - Hold a mutex before reading measurements.
 - Add pm_runtime_resume_and_get before reading measurements.
 - Only start measurements after suspend action has been successfully
   registered
 - Check the return value of regmap_read when verifying device ID.

Changes in v2:
 - Adjust the default gain to x256 and integration time to 50.1ms as
 recommended by the datasheet.
 - Use read_label instead of .extend
 - Remove all unused scan_index related constants.
 - Add missing calls to pm_runtime_* methods in probe.
 - Fix various code style issues

 MAINTAINERS                |   1 +
 drivers/iio/light/Kconfig  |  11 +
 drivers/iio/light/Makefile |   1 +
 drivers/iio/light/as7343.c | 464 +++++++++++++++++++++++++++++++++++++
 4 files changed, 477 insertions(+)
 create mode 100644 drivers/iio/light/as7343.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cf4e1635053..236102b3c28e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1435,6 +1435,7 @@ M:	Chang Yu <marcus.yu.56@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
+F:	drivers/iio/light/as7343.c
 
 AMT (Automatic Multicast Tunneling)
 M:	Taehee Yoo <ap420073@gmail.com>
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index ef36824f312f..edbeeba9d873 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -149,6 +149,17 @@ config AS73211
 	 This driver can also be built as a module.  If so, the module
 	 will be called as73211.
 
+config AS7343
+	tristate "AMS AS7343 14-Channel Multi-Spectral Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	 Say Y here to build support for the AMS AS7343 14-channel
+	 multi-spectral sensor.
+
+	 To compile this driver as a module, choose M here: the module will
+	 be called as7343.
+
 config BH1745
 	tristate "ROHM BH1745 colour sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 64e354c49ed8..5d0d33802519 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_APDS9306)		+= apds9306.o
 obj-$(CONFIG_APDS9960)		+= apds9960.o
 obj-$(CONFIG_APDS9999)		+= apds9999.o
 obj-$(CONFIG_AS73211)		+= as73211.o
+obj-$(CONFIG_AS7343)		+= as7343.o
 obj-$(CONFIG_BH1745)		+= bh1745.o
 obj-$(CONFIG_BH1750)		+= bh1750.o
 obj-$(CONFIG_BH1780)		+= bh1780.o
diff --git a/drivers/iio/light/as7343.c b/drivers/iio/light/as7343.c
new file mode 100644
index 000000000000..52e46797ffcb
--- /dev/null
+++ b/drivers/iio/light/as7343.c
@@ -0,0 +1,464 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Support for AMS AS7343 14-channel multi-spectral sensor.
+ * (7-bit I2C slave address 0x39)
+ *
+ * Based on the work of:
+ *   Christian Eggers <ceggers@arri.de> (AS73211 driver)
+ *
+ * Copyright (c) 2026 Chang Yu <marcus.yu.56@gmail.com>
+ *
+ * Datasheet:
+ *   https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
+ *
+ * TODO:
+ *   - Support for configurable gain and integration time
+ *   - Interrupt support
+ *   - Add support for reading the VIS channel
+ *   - Flicker detection
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+
+#include <linux/iio/iio.h>
+
+#define AS7343_ID_REG				0x5a
+
+#define AS7343_ENABLE_REG			0x80
+#define AS7343_ENABLE_PON			BIT(0)
+#define AS7343_ENABLE_SP_EN			BIT(1)
+
+#define AS7343_ATIME_REG			0x81
+#define AS7343_STATUS2_REG			0x90
+#define AS7343_STATUS3_REG			0x91
+#define AS7343_STATUS_REG			0x93
+#define AS7343_ASTATUS_REG			0x94
+
+#define AS7343_DATA_FZ_REG			0x95
+#define AS7343_DATA_FY_REG			0x97
+#define AS7343_DATA_FXL_REG			0x99
+#define AS7343_DATA_NIR_REG			0x9b
+#define AS7343_DATA_F2_REG			0xa1
+#define AS7343_DATA_F3_REG			0xa3
+#define AS7343_DATA_F4_REG			0xa5
+#define AS7343_DATA_F6_REG			0xa7
+#define AS7343_DATA_F1_REG			0xad
+#define AS7343_DATA_F7_REG			0xaf
+#define AS7343_DATA_F8_REG			0xb1
+#define AS7343_DATA_F5_REG			0xb3
+#define AS7343_DATA_FD_L_REG			0xb7
+#define AS7343_DATA_FD_H_REG			0xb8
+
+#define AS7343_STATUS5_REG			0xbb
+#define AS7343_STATUS4_REG			0xbc
+
+#define AS7343_CFG0_REG				0xbf
+#define AS7343_CFG0_REG_BANK			BIT(4)
+
+#define AS7343_CFG1_REG				0xc6
+#define AS7343_CFG1_AGAIN			GENMASK(4, 0)
+#define AS7343_CFG1_AGAIN_X0_5			0
+#define AS7343_CFG1_AGAIN_X1			1
+#define AS7343_CFG1_AGAIN_X2			2
+#define AS7343_CFG1_AGAIN_X4			3
+#define AS7343_CFG1_AGAIN_X8			4
+#define AS7343_CFG1_AGAIN_X16			5
+#define AS7343_CFG1_AGAIN_X32			6
+#define AS7343_CFG1_AGAIN_X64			7
+#define AS7343_CFG1_AGAIN_X128			8
+#define AS7343_CFG1_AGAIN_X256			9
+#define AS7343_CFG1_AGAIN_X512			10
+#define AS7343_CFG1_AGAIN_X1024			11
+#define AS7343_CFG1_AGAIN_X2048			12
+
+#define AS7343_ASTEP_REG			0xd4
+
+#define AS7343_CFG20_REG			0xd6
+#define AS7343_CFG20_AUTO_SMUX			GENMASK(6, 5)
+#define AS7343_CFG20_AUTO_SMUX_READOUT_ALL	3 /* all-channel readout */
+
+#define AS7343_FD_STATUS_REG			0xe3
+#define AS7343_CONTROL_REG			0xfa
+#define AS7343_FIFO_LVL_REG			0xfd
+#define AS7343_FDATA_L_REG			0xfe
+#define AS7343_FDATA_H_REG			0xff
+
+/* AS7343 channel indices. MUST match data register order above. */
+#define AS7343_CHAN_IDX_FZ	0
+#define AS7343_CHAN_IDX_FY	1
+#define AS7343_CHAN_IDX_FXL	2
+#define AS7343_CHAN_IDX_NIR	3
+#define AS7343_CHAN_IDX_F2	4
+#define AS7343_CHAN_IDX_F3	5
+#define AS7343_CHAN_IDX_F4	6
+#define AS7343_CHAN_IDX_F6	7
+#define AS7343_CHAN_IDX_F1	8
+#define AS7343_CHAN_IDX_F7	9
+#define AS7343_CHAN_IDX_F8	10
+#define AS7343_CHAN_IDX_F5	11
+
+#define AS7343_CHAN(_chan)					\
+	{							\
+		.type = IIO_INTENSITY,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+		.address = AS7343_DATA_##_chan##_REG,		\
+		.indexed = 1,					\
+		.channel = AS7343_CHAN_IDX_##_chan,		\
+	}
+
+static const struct iio_chan_spec as7343_channels[] = {
+	AS7343_CHAN(FZ), AS7343_CHAN(FY), AS7343_CHAN(FXL), AS7343_CHAN(NIR),
+	AS7343_CHAN(F2), AS7343_CHAN(F3), AS7343_CHAN(F4),  AS7343_CHAN(F6),
+	AS7343_CHAN(F1), AS7343_CHAN(F7), AS7343_CHAN(F8),  AS7343_CHAN(F5),
+};
+
+/*
+ * Integration time is calculated as (ATIME + 1) * ((ASTEP + 1) * 2.78us).
+ * ATIME must be between 0 and 255, inclusive
+ * ASTEP must be between 0 and 65534, inclusive
+ */
+static inline int as7343_atime_steps(unsigned int step, u8 *atime)
+{
+	if (step < 1 || step > 256)
+		return -EINVAL;
+
+	*atime = step - 1;
+	return 0;
+}
+
+static inline int as7343_astep_x2780ns(unsigned int n, __le16 *astep)
+{
+	u16 val;
+
+	if (n < 1 || n > 65535)
+		return -EINVAL;
+
+	val = n - 1;
+	*astep = cpu_to_le16(val);
+	return 0;
+}
+
+struct as7343_data {
+	struct regmap *regmap;
+	/* Ensures reads don't stomp on each other */
+	struct mutex mutex;
+};
+
+static int as7343_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct as7343_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
+	struct device *dev = regmap_get_device(map);
+	unsigned int unused;
+	__le16 result;
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		/* Wait until integration time passes for all 3 cycles. */
+		msleep(160);
+
+		/*
+		 * Reading ASTATUS latches all data registers to this read.
+		 * We don't care about the returned saturation/gain status for
+		 * now.
+		 */
+		guard(mutex)(&data->mutex);
+
+		ret = regmap_read(map, AS7343_ASTATUS_REG, &unused);
+		if (ret)
+			return ret;
+
+		ret = regmap_bulk_read(map, chan->address,
+				       &result, sizeof(result));
+		if (ret)
+			return ret;
+
+		*val = le16_to_cpu(result);
+		return IIO_VAL_INT;
+	}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Channel names and wavelength ranges as defined in the datasheet
+ * (Figure 7, "AS7343 Optical Channel Summary"). Values are the
+ * minimum and maximum peak wavelength in nanometers.
+ *
+ * F1:  395-415 nm
+ * F2:  415-435 nm
+ * FZ:  440-460 nm
+ * F3:  465-485 nm
+ * F4:  505-525 nm
+ * FY:  545-565 nm
+ * F5:  540-560 nm
+ * FXL: 590-610 nm
+ * F6:  630-650 nm
+ * F7:  680-700 nm
+ * F8:  735-755 nm
+ * NIR: 845-865 nm
+ */
+static const char * const as7343_channel_labels[] = {
+	[AS7343_CHAN_IDX_F1] = "F1: 395-415 nm",
+	[AS7343_CHAN_IDX_F2] = "F2: 415-435 nm",
+	[AS7343_CHAN_IDX_FZ] = "FZ: 440-460 nm",
+	[AS7343_CHAN_IDX_F3] = "F3: 465-485 nm",
+	[AS7343_CHAN_IDX_F4] = "F4: 505-525 nm",
+	[AS7343_CHAN_IDX_FY] = "FY: 545-565 nm",
+	[AS7343_CHAN_IDX_F5] = "F5: 540-560 nm",
+	[AS7343_CHAN_IDX_FXL] = "FXL: 590-610 nm",
+	[AS7343_CHAN_IDX_F6] = "F6: 630-650 nm",
+	[AS7343_CHAN_IDX_F7] = "F7: 680-700 nm",
+	[AS7343_CHAN_IDX_F8] = "F8: 735-755 nm",
+	[AS7343_CHAN_IDX_NIR] = "NIR: 845-865 nm",
+};
+
+static int as7343_read_label(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, char *label)
+{
+	int channel;
+
+	channel = chan->channel;
+	if (channel < 0 || channel >= ARRAY_SIZE(as7343_channel_labels))
+		return -EINVAL;
+
+	return sysfs_emit(label, "%s\n", as7343_channel_labels[channel]);
+}
+
+static const struct iio_info as7343_info = {
+	.read_raw = as7343_read_raw,
+	.read_label = as7343_read_label,
+};
+
+static const struct regmap_range as7343_volatile_ranges[] = {
+	regmap_reg_range(AS7343_ENABLE_REG, AS7343_ENABLE_REG),
+	regmap_reg_range(AS7343_STATUS2_REG, AS7343_DATA_FD_H_REG),
+	regmap_reg_range(AS7343_STATUS5_REG, AS7343_STATUS4_REG),
+	regmap_reg_range(AS7343_FD_STATUS_REG, AS7343_FD_STATUS_REG),
+	regmap_reg_range(AS7343_CONTROL_REG, AS7343_CONTROL_REG),
+	regmap_reg_range(AS7343_FIFO_LVL_REG, AS7343_FDATA_H_REG),
+};
+
+static const struct regmap_access_table as7343_volatile_table = {
+	.yes_ranges = as7343_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(as7343_volatile_ranges),
+};
+
+static const struct regmap_config as7343_regmap_config = {
+	.name = "as7343",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AS7343_FDATA_H_REG,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.cache_type = REGCACHE_MAPLE,
+	.volatile_table = &as7343_volatile_table,
+};
+
+static int as7343_setup_device(struct device *dev, struct as7343_data *data)
+{
+	struct regmap *map = data->regmap;
+	unsigned int val;
+	__le16 astep;
+	u8 atime;
+	int ret;
+
+	/* Need to set REG_BANK to 0 before we can set PON */
+	ret = regmap_update_bits(map, AS7343_CFG0_REG, AS7343_CFG0_REG_BANK,
+				 FIELD_PREP(AS7343_CFG0_REG_BANK, 0));
+	if (ret)
+		return ret;
+
+	/* Set PON and enter IDLE state */
+	ret = regmap_set_bits(map, AS7343_ENABLE_REG, AS7343_ENABLE_PON);
+	if (ret)
+		return ret;
+
+	/* Need to set REG_BANK to 1 before we can access ID */
+	ret = regmap_update_bits(map, AS7343_CFG0_REG, AS7343_CFG0_REG_BANK,
+				 FIELD_PREP(AS7343_CFG0_REG_BANK, 1));
+	if (ret)
+		return ret;
+
+	ret = regmap_read(map, AS7343_ID_REG, &val);
+	if (ret)
+		return ret;
+
+	if (val != 0x81)
+		dev_info(dev, "Unknown device ID: %x\n", val);
+
+	ret = regmap_update_bits(map, AS7343_CFG0_REG, AS7343_CFG0_REG_BANK,
+				 FIELD_PREP(AS7343_CFG0_REG_BANK, 0));
+	if (ret)
+		return ret;
+
+	/* Configure the SMUX to readout all channels */
+	ret = regmap_update_bits(map, AS7343_CFG20_REG, AS7343_CFG20_AUTO_SMUX,
+				 FIELD_PREP(AS7343_CFG20_AUTO_SMUX,
+					    AS7343_CFG20_AUTO_SMUX_READOUT_ALL));
+	if (ret)
+		return ret;
+
+	/*
+	 * Setting a 600 * 2.78us * 30 = 50ms integration time as the default
+	 * for now.
+	 */
+	ret = as7343_astep_x2780ns(600, &astep);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_write(map, AS7343_ASTEP_REG, &astep, sizeof(astep));
+	if (ret)
+		return ret;
+
+	ret = as7343_atime_steps(30, &atime);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(map, AS7343_ATIME_REG, atime);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(map, AS7343_CFG1_REG, AS7343_CFG1_AGAIN,
+				  FIELD_PREP(AS7343_CFG1_AGAIN,
+					     AS7343_CFG1_AGAIN_X256));
+}
+
+static int as7343_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct as7343_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
+
+	return regmap_clear_bits(map, AS7343_ENABLE_REG, AS7343_ENABLE_SP_EN);
+}
+
+static int as7343_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct as7343_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
+
+	return regmap_set_bits(map, AS7343_ENABLE_REG, AS7343_ENABLE_SP_EN);
+}
+
+static void as7343_suspend_action(void *dev)
+{
+	as7343_suspend(dev);
+}
+
+static int as7343_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct as7343_data *data;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, indio_dev);
+
+	regmap = devm_regmap_init_i2c(client, &as7343_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	data = iio_priv(indio_dev);
+	data->regmap = regmap;
+
+	ret = devm_mutex_init(dev, &data->mutex);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "as7343";
+	indio_dev->info = &as7343_info;
+	indio_dev->channels = as7343_channels;
+	indio_dev->num_channels = ARRAY_SIZE(as7343_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return ret;
+
+	ret = as7343_setup_device(dev, data);
+	if (ret)
+		return ret;
+
+	/* Enter ACTIVE statet and start measurements */
+	ret = regmap_set_bits(regmap, AS7343_ENABLE_REG, AS7343_ENABLE_SP_EN);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, as7343_suspend_action, dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to add suspend action\n");
+
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to activate PM runtime\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(as7343_pm_ops,
+				 as7343_suspend, as7343_resume, NULL);
+
+static const struct of_device_id as7343_of_match[] = {
+	{ .compatible = "ams,as7343" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, as7343_of_match);
+
+static const struct i2c_device_id as7343_id[] = {
+	{ .name = "as7343" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, as7343_id);
+
+static struct i2c_driver as7343_driver = {
+	.driver = {
+		.name = "as7343",
+		.of_match_table = as7343_of_match,
+		.pm = pm_ptr(&as7343_pm_ops),
+	},
+	.probe = as7343_probe,
+	.id_table = as7343_id,
+};
+module_i2c_driver(as7343_driver);
+
+MODULE_AUTHOR("Chang Yu <marcus.yu.56@gmail.com>");
+MODULE_DESCRIPTION("AS7343 14 Channel Multi-Spectral Sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.56.0

