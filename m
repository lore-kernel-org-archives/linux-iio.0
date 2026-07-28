Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E88D420497
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279491; cv=none; b=Yqrk885SlubX5+D1dtEDpi8usjm4LzV66CQQWYPbyp/S0g2uc/gjpi7ZMC5Lb5Vj3zlBR+/BwTil/tqhTDMBijTirfbarhg6SY00+0CQULllnOxdLJ0mTsYfOKZCuaN1WqY5HnOkFN6Wr09PHjBkfVzpKHT+d8feZT7AtVKwvnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279491; c=relaxed/simple;
	bh=u8sqJFwDMCgRXeJu9/AxLtYBFuVF587TRulRfeDXXMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJH9bjJt3lu6dnFfq5gKvZ4LuTB1Z7bdy/okHqGu5HjyLz8YayZD3dXGt5/GR8zR/97y0bhUYUJQvrwN1gaulg/IqL51A9g5yckq4ZOFiLqUrzCC6JbF2rr0EWNmZn1/tODV+AhXJXDIidxK+TnIgmPMmjRnDlAh3CuiAWulmgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbPwQtSY; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbPwQtSY"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6ab08d289d1so276849eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 15:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785279489; x=1785884289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X7cKInG3LvCx702WPltJ7pIgcjx5mq1L90Yz6/fhnzA=;
        b=GbPwQtSYMBKCUpKO46bPt+1eHi4TIuVv1Uykh4sjaLy/h5eePqto3F8NiZ4vjoqHIt
         XHg+4KhNaqJIi9ZyL4mKw7gIlZZHA7mwljLJY9m1knwJYh9fwJDneIg8ZAlzL0TxxQ+p
         +zDiso04Fmqk2vEoha+ztTACvFW7I6SwZe+y95ZayF6BsvrDjWAEljmn/4lPCMNpjXyd
         /AlKImwYdZ7WWQn75tLU2tcEvW42l/JXXeOTbnYknMbt5aJqq+BB6z2EP1HBaRGrEYc4
         myB4NFcDfxqoUb3VsU2BHInnFDM7gIKJDmr7wNnSA47oNlJQ+WwFh9XhvUYQgDgxx108
         HtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279489; x=1785884289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X7cKInG3LvCx702WPltJ7pIgcjx5mq1L90Yz6/fhnzA=;
        b=lXtlrwNJjneUs9jiOk/6iFCCcVUWNRFdhK7H5P+mH4u4hRUlYo6bnBGClz3wmqdPKR
         K5QZZTzxPCpIYxquVCmB91fFmWWliBZDwwGt729KeWkXm1cpqV63JHHBINiVSiRu0G2S
         7XkJpFKKnYCfluA1+x//oQYnoESuhvlq9Uu1tYrwJCOjwgdqbolbZAqvlHZsQ1/DNz9w
         EC5sJwi6j0ufQQwxGCeDe5qOTaHtS/QJiB8EwL6URcbJUbpRNKKbZsMbq+g5M0ZivZQ/
         6V3ZCYtq9kD7VC+9NJWhig9e3jS1NP74GDs7717cfsgICjZQtxmtqHRod7VnEQGOrtlz
         fMZg==
X-Gm-Message-State: AOJu0YynQ5HbuQRQayrrXMCPRw9lRfZ8U77XcpRAV64j2/k9IotZqQBc
	T6lMT2R/cbSRjBR+i5uo4L2UZLlE9AWpTYm2DECVbBc2mjbrFyYcYIbwhXsxdw==
X-Gm-Gg: AR+sD133K7ERprDIVXvt1QICjqD6z2tOxuY8GKzWnxDm3DR447co9CXHC9/j3MlXqXL
	1PsgVTOqsxhlItkwitseJluVhltVzlKhdBqtQebte//qPmn39C+VCcZiM9943iCteEaJIlDcBD7
	cPTmIBrqMf+HuMMXsT9RfI3l0ZxcuYVa4u3cO/T8gBE2MTSACIxr/75RBN2iaRCRvPepwYporkG
	U4UBCauO/lSzDfWwIVthdQQ/EE0fFKUqAANJfO5OGoL/weuxKnZjK5RkpITdIoGv22e1pcJ4lXf
	LTtClv1ZFzlYhrrEuADZmZl/cFwi02Ng5InSustPMYw/KgiGx0e/4wtwAPygfpEUOFTIWuXiZjs
	U1SjdKkr93gnejtF7P0yqIR0BHKog13Xrm/KkU2OqTVIqHse/saW8rzNRl9jntWkRzHmdR+XEFk
	nPfmtnMOjXgF7gRXcj7uHL+w==
X-Received: by 2002:a05:6820:4b18:b0:6a3:2c5e:2b37 with SMTP id 006d021491bc7-6ac96cfc022mr2383248eaf.72.1785279489303;
        Tue, 28 Jul 2026 15:58:09 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:9162:e42b:cb94:2d55])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4588646ade0sm990277fac.5.2026.07.28.15.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 15:58:08 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V21 4/9] iio: imu: inv_icm42607: Add SPI For icm42607
Date: Tue, 28 Jul 2026 17:55:35 -0500
Message-ID: <20260728225542.174825-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728225542.174825-1-macroalpha82@gmail.com>
References: <20260728225542.174825-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add SPI driver support for InvenSense ICM-42607 devices.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/imu/inv_icm42607/Kconfig          |  12 ++
 drivers/iio/imu/inv_icm42607/Makefile         |   3 +
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 106 ++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c

diff --git a/drivers/iio/imu/inv_icm42607/Kconfig b/drivers/iio/imu/inv_icm42607/Kconfig
index 083c212087ab..23f461f57afc 100644
--- a/drivers/iio/imu/inv_icm42607/Kconfig
+++ b/drivers/iio/imu/inv_icm42607/Kconfig
@@ -16,3 +16,15 @@ config INV_ICM42607_I2C
 
 	  This driver can be built as a module. The module will be called
 	  inv-icm42607-i2c.
+
+config INV_ICM42607_SPI
+	tristate "InvenSense ICM-42607 SPI driver"
+	depends on SPI_MASTER
+	select INV_ICM42607
+	select REGMAP_SPI
+	help
+	  This driver supports the InvenSense ICM-42607 motion tracking
+	  device over SPI.
+
+	  This driver can be built as a module. The module will be called
+	  inv-icm42607-spi.
diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
index 32046e2727d7..be109102e203 100644
--- a/drivers/iio/imu/inv_icm42607/Makefile
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -5,3 +5,6 @@ inv-icm42607-y += inv_icm42607_core.o
 
 obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
 inv-icm42607-i2c-y += inv_icm42607_i2c.o
+
+obj-$(CONFIG_INV_ICM42607_SPI) += inv-icm42607-spi.o
+inv-icm42607-spi-y += inv_icm42607_spi.o
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
new file mode 100644
index 000000000000..eb04036a6712
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "inv_icm42607.h"
+
+static int inv_icm42607_spi_bus_setup(struct inv_icm42607_state *st)
+{
+	unsigned int val;
+	int ret;
+
+	/* Only support 4-wire mode for now. */
+	ret = regmap_set_bits(st->map, INV_ICM42607_REG_DEVICE_CONFIG,
+				      INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE);
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
+				INV_ICM42607_INTF_CONFIG1_I3C_DDR_EN |
+				INV_ICM42607_INTF_CONFIG1_I3C_SDR_EN);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(INV_ICM42607_DRIVE_CONFIG3_SPI_MASK,
+			 INV_ICM42607_SLEW_RATE_2NS);
+	ret = regmap_update_bits(st->map, INV_ICM42607_REG_DRIVE_CONFIG3,
+				 INV_ICM42607_DRIVE_CONFIG3_SPI_MASK, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK,
+			 INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS);
+
+	return regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
+				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK,
+				  val);
+}
+
+static int inv_icm42607_probe(struct spi_device *spi)
+{
+	const struct inv_icm42607_hw *hw;
+	struct device *dev = &spi->dev;
+	struct regmap *regmap;
+
+	hw = spi_get_device_match_data(spi);
+	if (!hw)
+		return dev_err_probe(dev, -ENODATA, "Failed to get SPI data\n");
+
+	if (spi->mode & SPI_3WIRE)
+		return dev_err_probe(dev, -ENODEV, "SPI 3-wire mode not supported\n");
+
+	regmap = devm_regmap_init_spi(spi, &inv_icm42607_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register spi regmap\n");
+
+	return inv_icm42607_core_probe(regmap, hw, inv_icm42607_spi_bus_setup);
+}
+
+static const struct spi_device_id inv_icm42607_spi_id_table[] = {
+	{
+		.name = "icm42607",
+		.driver_data = (kernel_ulong_t)&inv_icm42607_hw_data,
+	}, {
+		.name = "icm42607p",
+		.driver_data = (kernel_ulong_t)&inv_icm42607p_hw_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, inv_icm42607_spi_id_table);
+
+static const struct of_device_id inv_icm42607_of_matches[] = {
+	{
+		.compatible = "invensense,icm42607",
+		.data = &inv_icm42607_hw_data,
+	},
+	{
+		.compatible = "invensense,icm42607p",
+		.data = &inv_icm42607p_hw_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);
+
+static struct spi_driver inv_icm42607_driver = {
+	.driver = {
+		.name = "inv-icm42607-spi",
+		.of_match_table = inv_icm42607_of_matches,
+	},
+	.id_table = inv_icm42607_spi_id_table,
+	.probe = inv_icm42607_probe,
+};
+module_spi_driver(inv_icm42607_driver);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-42607 SPI driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_ICM42607");
-- 
2.43.0

