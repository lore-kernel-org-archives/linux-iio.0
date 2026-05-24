Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8A33A032
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779655882; cv=none; b=BiSKtRQeuYnCqQ6rVsdUv0d4lzTi+1s9ATc3Powc8lxJIfUJr0n3GisKDLdqyh0+ERmrMXgqcXea1kvBAIJ6psCegrdzXNRfcgLwWBTOIk557Np+8gQBTzwbY3Wmo1IN7MKNV3cugIwsMgbYw1U4qwsSBpsnmzmrocjUTJbMZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779655882; c=relaxed/simple;
	bh=a0y3u1aPpUKxSCqwvC3og7k4GM3ybGRRWue8C++NMxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nfnd0qfqKPim73C+PYzIt8ZzpDV135AKvYZExgNutzgTa7sTD8yugdBVI7QD0S7nV/xa210WC0zZ+OA8avzPZb+0YbkkJlNBuhwroilniku+zjK1t4OUABrR2qmpUwUKYlQnVupHqVwgZaq+4Ya9oTFkJJEbIrmXIbxzP1Kcdfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5oMP41f; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5oMP41f"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4903d5c67bfso16560905e9.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 13:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779655878; x=1780260678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZYukWs50JDrczpkdtbgeT5C+Oa4LhoAPBL76df221I=;
        b=j5oMP41f5YU2SxhW8m3qleFI67GZTAkk82qAM7qxd+k+KDiy95UQm5PSQoy83fLFhh
         Bu5TyhnPKq1ahOrhBNQGv6+dl34I375+grMSXHdWl74s16bgCliMkfZwmWhpibYcs47v
         igiufGYJ5ZeYWYdRevVLnLLwRzhGST11jzN+raIqSWKG2zmkPhWYURpFPXXvhg0SZ9rG
         3+LVRog2vGTkYRQAQ0YmILe6zMJZu4uRJXOz+HLk18nNxPGEYbvYfA2BPGRzFupcZsL9
         +bZmFR6kWMceMk9HyVlGVJUeblRXlZizHyf1hJ/MBCI/LmulhefNmQgB6WwAGcEpcPLO
         BMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779655878; x=1780260678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tZYukWs50JDrczpkdtbgeT5C+Oa4LhoAPBL76df221I=;
        b=d0c0CZUyvblmACye3qiOdCavNhBK4433D/lfxRfBRwsostKgK9+unARQ4mhLEN6PhN
         NOAIvDdu/wfhAgTTyvB/Ow4B7HaiHQXbF3N07mxTBEyorpznoDxiKH/hPpjiUQTTRLsQ
         NKLDax15GS9szxyN78H0hAQoFH95jHRFzIl6Kv0Y0XWRMcj2QfW1Kb1P9GZpsfglrF1u
         17UKRu5+WE7SxmFVs0b9MQsKtnt9okrgKUvwuuloFnhIeUMEAKKaWTvO/Yw4t2ROLN5Q
         A6AeBRD2vMr4ehilfia3zAdXL8I3JZhd802JimSul31DA4wNEISuRcHL1NQS3qrmtikG
         sVkg==
X-Forwarded-Encrypted: i=1; AFNElJ+ZR3qiabweUyZ5ivu9lg6RhqnqYs3gjn/fPfYhcsxEzBQ9PY/LtuVoNjVtXumfJ18F2KAGy5e/v24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3kX5Pvqjztn6X8OB2vMZe3xSA2XnF4k4Bd3yCATjdIa7b2Kr
	Q4L9lM4+GdlswvYMD9CbebVwcrXJXODny9s96BZX83VhggFXmhNoN1Ae
X-Gm-Gg: Acq92OGJJeaTQiVa55vhyN2mXJ4dX16+eeBjfPNf9quHcLmMaNyXsvkH9FxjI5jCcxt
	USvHbhvsAl7DL9k3OIXWc/cN8YbclVtaTDGOzfx2WL9kvQGbX3yFvPjj6vGLJCICCaBF5OrhR2G
	aiX/u3DDet0+wjt5FfgihjXytaqsrrYFEeg6gQ/6IKi9kFZxHcBnuuaRHK3knk1Wpi6ZVcnd5jl
	2+MTqenU5W9hViDRMBSEFb2LEgeqpdcFaBWC45XUbvsKO5QvwdM1t08RiXDVAPxXd3AsDfvuZqe
	DYhMrmFz4HeDxk/AAL1gyCRvhRWdoe9oVI8iGiZkHgVIKS4O+2h37Nu3Ps1h53xK6npiIXW3vMa
	h31gacJqZn+EicM35zmpAc8Tnb8WYjVzm2ez+8ewkLFhpACrHc/9Tcq8zH46g1d9O9284Jk8lFl
	tnJAolSxDD2q/GIbM=
X-Received: by 2002:a05:600c:3542:b0:490:4334:d5ed with SMTP id 5b1f17b1804b1-4904334d66bmr183193305e9.14.1779655877933;
        Sun, 24 May 2026 13:51:17 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d6ebf0sm22738588f8f.34.2026.05.24.13.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 13:51:17 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	jdelvare@suse.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/4] iio: flow: add Sensirion SLF3x liquid flow sensor driver
Date: Sun, 24 May 2026 22:49:38 +0200
Message-ID: <20260524205112.26638-4-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260524205112.26638-1-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wadim Mueller <wadim.mueller@cmblu.de>

Add an IIO driver for the Sensirion SLF3S family of digital
liquid-flow sensors.  The supported sub-types (SLF3S-0600F,
SLF3S-4000B) share the same register map and command set and are
distinguished only by the flow scale; the variant is detected at
probe time from the product-information register.

The driver exposes two IIO channels:
  - in_volumeflow_raw / in_volumeflow_scale (litres per second)
  - in_temp_raw       / in_temp_scale       (milli-degC)

Continuous measurement mode is started in probe and stopped via
devm-action; read_raw() fetches the most recent sample on demand.

Signed-off-by: Wadim Mueller <wadim.mueller@cmblu.de>
---
 drivers/iio/Kconfig       |   1 +
 drivers/iio/Makefile      |   1 +
 drivers/iio/flow/Kconfig  |  22 ++++
 drivers/iio/flow/Makefile |   7 +
 drivers/iio/flow/slf3x.c  | 264 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 295 insertions(+)
 create mode 100644 drivers/iio/flow/Kconfig
 create mode 100644 drivers/iio/flow/Makefile
 create mode 100644 drivers/iio/flow/slf3x.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 661127aed..652557a5b 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -92,6 +92,7 @@ source "drivers/iio/common/Kconfig"
 source "drivers/iio/dac/Kconfig"
 source "drivers/iio/dummy/Kconfig"
 source "drivers/iio/filter/Kconfig"
+source "drivers/iio/flow/Kconfig"
 source "drivers/iio/frequency/Kconfig"
 source "drivers/iio/gyro/Kconfig"
 source "drivers/iio/health/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index cb80ef837..f03a4100c 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -29,6 +29,7 @@ obj-y += dac/
 obj-y += dummy/
 obj-y += gyro/
 obj-y += filter/
+obj-y += flow/
 obj-y += frequency/
 obj-y += health/
 obj-y += humidity/
diff --git a/drivers/iio/flow/Kconfig b/drivers/iio/flow/Kconfig
new file mode 100644
index 000000000..355857a6b
--- /dev/null
+++ b/drivers/iio/flow/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Liquid / gas flow sensor drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Flow sensors"
+
+config SENSIRION_SLF3X
+	tristate "Sensirion SLF3x liquid flow sensor"
+	depends on I2C
+	select CRC8
+	help
+	  Say yes here to build support for the Sensirion SLF3S family of
+	  digital liquid-flow sensors (SLF3S-0600F, SLF3S-4000B, ...).
+	  The driver reports the volumetric flow rate and the embedded
+	  temperature reading via the standard IIO interface.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called slf3x.
+
+endmenu
diff --git a/drivers/iio/flow/Makefile b/drivers/iio/flow/Makefile
new file mode 100644
index 000000000..9eb9bdde0
--- /dev/null
+++ b/drivers/iio/flow/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for industrial I/O flow sensor drivers
+#
+
+# When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_SENSIRION_SLF3X) += slf3x.o
diff --git a/drivers/iio/flow/slf3x.c b/drivers/iio/flow/slf3x.c
new file mode 100644
index 000000000..e4ee1a04a
--- /dev/null
+++ b/drivers/iio/flow/slf3x.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sensirion SLF3x liquid flow sensor driver.
+ *
+ * Copyright (C) 2026 CMBlu Energy
+ * Author: Wadim Mueller <wadim.mueller@cmblu.de>
+ */
+
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/unaligned.h>
+
+#define SLF3X_CRC8_POLY		0x31
+#define SLF3X_CRC8_INIT		0xff
+
+#define SLF3X_PRODUCT_ID_LEN	18
+#define SLF3X_FAMILY_BYTE	1
+#define SLF3X_SUBTYPE_BYTE	3
+
+#define SLF3X_FAMILY_ID		0x03
+
+#define SLF3X_MEAS_LEN		9
+#define SLF3X_MEAS_DELAY_US	12000
+
+/* Temperature LSB is 1/200 °C; IIO_TEMP scale is in mC/LSB => 5. */
+#define SLF3X_TEMP_SCALE	5
+
+static const u8 slf3x_cmd_prep_pid[]	= { 0x36, 0x7c };
+static const u8 slf3x_cmd_read_pid[]	= { 0xe1, 0x02 };
+static const u8 slf3x_cmd_start_water[]	= { 0x36, 0x08 };
+static const u8 slf3x_cmd_stop[]	= { 0x3f, 0xf9 };
+
+DECLARE_CRC8_TABLE(slf3x_crc_table);
+
+struct slf3x_variant {
+	u8 sub_type;
+	const char *name;
+	/*
+	 * Flow scale exposed via IIO_CHAN_INFO_SCALE in litres per second
+	 * per LSB, encoded as IIO_VAL_FRACTIONAL (num / den).  The encoding
+	 * comes from the Sensirion datasheet's "scale factor" (ticks per
+	 * ml/min) combined with the 1 ml/min = 1/60000 l/s conversion.
+	 */
+	int scale_num;
+	int scale_den;
+};
+
+static const struct slf3x_variant slf3x_variants[] = {
+	{ .sub_type = 0x03, .name = "slf3s-0600f",
+	  .scale_num = 1, .scale_den = 6000000 },
+	{ .sub_type = 0x05, .name = "slf3s-4000b",
+	  .scale_num = 1, .scale_den = 1666680000 },
+};
+
+struct slf3x_data {
+	struct i2c_client *client;
+	const struct slf3x_variant *variant;
+};
+
+static int slf3x_verify_crc(const u8 *block)
+{
+	return crc8(slf3x_crc_table, block, 2, SLF3X_CRC8_INIT) == block[2] ?
+		       0 :
+		       -EIO;
+}
+
+static int slf3x_write_cmd(struct i2c_client *client, const u8 *cmd)
+{
+	int ret = i2c_master_send(client, cmd, 2);
+
+	if (ret == 2)
+		return 0;
+	return ret < 0 ? ret : -EIO;
+}
+
+static int slf3x_read_product_info(struct slf3x_data *sf)
+{
+	struct i2c_client *client = sf->client;
+	u8 buf[SLF3X_PRODUCT_ID_LEN];
+	int ret, i;
+
+	ret = slf3x_write_cmd(client, slf3x_cmd_prep_pid);
+	if (ret)
+		return ret;
+
+	ret = slf3x_write_cmd(client, slf3x_cmd_read_pid);
+	if (ret)
+		return ret;
+
+	ret = i2c_master_recv(client, buf, sizeof(buf));
+	if (ret != sizeof(buf))
+		return ret < 0 ? ret : -EIO;
+
+	for (i = 0; i < SLF3X_PRODUCT_ID_LEN; i += 3) {
+		if (slf3x_verify_crc(&buf[i])) {
+			dev_err(&client->dev,
+				"product-info CRC mismatch at byte %d\n", i);
+			return -EIO;
+		}
+	}
+
+	if (buf[SLF3X_FAMILY_BYTE] != SLF3X_FAMILY_ID) {
+		dev_err(&client->dev,
+			"unexpected device family 0x%02x\n",
+			buf[SLF3X_FAMILY_BYTE]);
+		return -ENODEV;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(slf3x_variants); i++) {
+		if (buf[SLF3X_SUBTYPE_BYTE] == slf3x_variants[i].sub_type) {
+			sf->variant = &slf3x_variants[i];
+			return 0;
+		}
+	}
+
+	dev_err(&client->dev, "unsupported SLF3x sub-type 0x%02x\n",
+		buf[SLF3X_SUBTYPE_BYTE]);
+	return -ENODEV;
+}
+
+static int slf3x_read_sample(struct slf3x_data *sf, s16 *flow, s16 *temp)
+{
+	u8 buf[SLF3X_MEAS_LEN];
+	int ret, i;
+
+	ret = i2c_master_recv(sf->client, buf, sizeof(buf));
+	if (ret != sizeof(buf))
+		return ret < 0 ? ret : -EIO;
+
+	for (i = 0; i < SLF3X_MEAS_LEN; i += 3) {
+		if (slf3x_verify_crc(&buf[i]))
+			return -EIO;
+	}
+
+	*flow = (s16)get_unaligned_be16(&buf[0]);
+	*temp = (s16)get_unaligned_be16(&buf[3]);
+	return 0;
+}
+
+static const struct iio_chan_spec slf3x_channels[] = {
+	{
+		.type = IIO_VOLUMEFLOW,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static int slf3x_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan, int *val,
+			  int *val2, long mask)
+{
+	struct slf3x_data *sf = iio_priv(indio_dev);
+	s16 flow, temp;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = slf3x_read_sample(sf, &flow, &temp);
+		if (ret)
+			return ret;
+		*val = (chan->type == IIO_VOLUMEFLOW) ? flow : temp;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_VOLUMEFLOW) {
+			*val = sf->variant->scale_num;
+			*val2 = sf->variant->scale_den;
+			return IIO_VAL_FRACTIONAL;
+		}
+		*val = SLF3X_TEMP_SCALE;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info slf3x_info = {
+	.read_raw = slf3x_read_raw,
+};
+
+static void slf3x_stop_meas(void *data)
+{
+	struct slf3x_data *sf = data;
+
+	slf3x_write_cmd(sf->client, slf3x_cmd_stop);
+}
+
+static int slf3x_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct slf3x_data *sf;
+	int ret;
+
+	ret = devm_regulator_get_enable_optional(dev, "vdd");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to enable vdd\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*sf));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	sf = iio_priv(indio_dev);
+	sf->client = client;
+	crc8_populate_msb(slf3x_crc_table, SLF3X_CRC8_POLY);
+
+	ret = slf3x_read_product_info(sf);
+	if (ret)
+		return dev_err_probe(dev, ret, "product info read failed\n");
+
+	ret = slf3x_write_cmd(client, slf3x_cmd_start_water);
+	if (ret)
+		return dev_err_probe(dev, ret, "start measurement failed\n");
+
+	usleep_range(SLF3X_MEAS_DELAY_US, SLF3X_MEAS_DELAY_US + 1000);
+
+	ret = devm_add_action_or_reset(dev, slf3x_stop_meas, sf);
+	if (ret)
+		return ret;
+
+	indio_dev->name = sf->variant->name;
+	indio_dev->channels = slf3x_channels;
+	indio_dev->num_channels = ARRAY_SIZE(slf3x_channels);
+	indio_dev->info = &slf3x_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id slf3x_id[] = {
+	{ "slf3s" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, slf3x_id);
+
+static const struct of_device_id slf3x_of_match[] = {
+	{ .compatible = "sensirion,slf3s" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, slf3x_of_match);
+
+static struct i2c_driver slf3x_driver = {
+	.driver = {
+		.name = "slf3x",
+		.of_match_table = slf3x_of_match,
+	},
+	.probe = slf3x_probe,
+	.id_table = slf3x_id,
+};
+module_i2c_driver(slf3x_driver);
+
+MODULE_AUTHOR("Wadim Mueller <wadim.mueller@cmblu.de>");
+MODULE_DESCRIPTION("Sensirion SLF3x liquid flow sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.52.0

