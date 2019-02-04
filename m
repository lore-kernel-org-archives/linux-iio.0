Return-Path: <SRS0=dQzZ=QL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC22C282CC
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 17:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B144D2087C
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 17:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYObJGOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfBDRAc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:00:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39945 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfBDRAb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Feb 2019 12:00:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so654659wmf.5
        for <linux-iio@vger.kernel.org>; Mon, 04 Feb 2019 09:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5f8oMTPzqMVYaxal2igosMLVQNNuQ7nNTfzq//5p9Iw=;
        b=aYObJGOhZohn7H47dJU7KBgYnT5NmbtMXBE1lpevT+oKYzTmH21o4e7NqzOlpzyoON
         iOdadJpCNyDfZQfj+bYpZVkYLjcKtk9wMWzAweYO75oYp++ktnu7pEMtsMUkcy4I66Aq
         uYC2p1rHW3+UK21ps119uCA5d0EAdHNTuanzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5f8oMTPzqMVYaxal2igosMLVQNNuQ7nNTfzq//5p9Iw=;
        b=gpou0eB0l4MFEA+eiPoul22TwT2L9vvs3WIgfRR1Mve8x/YmVsvascwkf4KlS0Gbz6
         +sVGEh/eLWAYtFCrLNIUCCSGL8k6KkwUTm8fwWXc/YyXZ8jBDRcd7FR3kZQVoh0XF7vp
         DwBQyXmll5PgJ9uWH614l+A2OI3jS61fv8AGZl+ZozmCDvSe3LUbVFumvOY781Z7eOxr
         I80fKM8JRqcb7vEGuvqNdO66lcv3w07Ffr5X4SMd6acMls7RSPrRPYtEdm6jy82xNfPf
         irujOaTwF+IfyCsSEmlU4UiWrTlnHscwhBgpS8dJ4pv/xP/X01pCKhspEs+Z3NH623v7
         +pGw==
X-Gm-Message-State: AHQUAubK60jQzsWA3TAb4pyqDxKOUuuYnsP9Bjynf8JSbvdCCf3ehKSv
        ZuJ30uHklFjy0LV/DljdEUE1bw==
X-Google-Smtp-Source: AHgI3IZ7pyjPkWSslwJE669H1HCH6z3mbJovYvICN8Gs6PTpzdzyHva+hiHc52ycxzvaQ7E1aX/KIQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr249233wmi.61.1549299629980;
        Mon, 04 Feb 2019 09:00:29 -0800 (PST)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id i186sm19352297wmd.19.2019.02.04.09.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:00:29 -0800 (PST)
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH 3/5] iio: gyro: fxas2100x: add i2c driver
Date:   Mon,  4 Feb 2019 17:00:10 +0000
Message-Id: <20190204170012.13617-4-rui.silva@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204170012.13617-1-rui.silva@linaro.org>
References: <20190204170012.13617-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This add the real driver to talk over i2c and use the fxas2100x core
for the main tasks.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/iio/gyro/Kconfig         |  6 +++
 drivers/iio/gyro/Makefile        |  1 +
 drivers/iio/gyro/fxas2100x_i2c.c | 73 ++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 drivers/iio/gyro/fxas2100x_i2c.c

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index c168aa63de3b..1f9bfc51febb 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -77,6 +77,8 @@ config FXAS2100X
 	tristate "NXP FXAS2100X Gyro Sensor"
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select FXAS2100X_I2C if (I2C)
+	depends on (I2C || SPI_MASTER)
 	help
 	  Say yes here to build support for NXP FXAS2100X family Tri-axis Gyro
 	  Sensor driver connected via I2C or SPI.
@@ -84,6 +86,10 @@ config FXAS2100X
 	  This driver can also be built as a module.  If so, the module
 	  will be called fxas2100x_i2c or fxas2100x_spi.
 
+config FXAS2100X_I2C
+	tristate
+	select REGMAP_I2C
+
 config HID_SENSOR_GYRO_3D
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index 9e2395185a6e..8b1540ddbbce 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_BMG160) += bmg160_core.o
 obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
 obj-$(CONFIG_BMG160_SPI) += bmg160_spi.o
 obj-$(CONFIG_FXAS2100X) += fxas2100x_core.o
+obj-$(CONFIG_FXAS2100X_I2C) += fxas2100x_i2c.o
 
 obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
 
diff --git a/drivers/iio/gyro/fxas2100x_i2c.c b/drivers/iio/gyro/fxas2100x_i2c.c
new file mode 100644
index 000000000000..af4e8af6d301
--- /dev/null
+++ b/drivers/iio/gyro/fxas2100x_i2c.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for NXP FXAS2100x Gyroscope - I2C
+ *
+ * Copyright (C) 2018 Linaro Ltd.
+ *
+ */
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+#include "fxas2100x.h"
+
+static const struct regmap_config fxas2100x_regmap_i2c_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = FXAS2100X_REG_CTRL3,
+};
+
+static int fxas2100x_i2c_probe(struct i2c_client *i2c,
+			       const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	const char *name = NULL;
+
+	regmap = devm_regmap_init_i2c(i2c, &fxas2100x_regmap_i2c_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&i2c->dev, "Failed to register i2c regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	if (id)
+		name = id->name;
+
+	return fxas2100x_core_probe(&i2c->dev, regmap, i2c->irq, name);
+}
+
+static int fxas2100x_i2c_remove(struct i2c_client *i2c)
+{
+	fxas2100x_core_remove(&i2c->dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id fxas2100x_i2c_id[] = {
+	{ "fxas2100x", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, fxas2100x_i2c_id);
+
+static const struct of_device_id fxas2100x_i2c_of_match[] = {
+	{ .compatible = "nxp,fxas2100x", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, fxas2100x_i2c_of_match);
+
+static struct i2c_driver fxas2100x_i2c_driver = {
+	.driver = {
+		.name = "fxas2100x_i2c",
+		.pm = &fxas2100x_pm_ops,
+		.of_match_table = of_match_ptr(fxas2100x_i2c_of_match),
+	},
+	.probe		= fxas2100x_i2c_probe,
+	.remove		= fxas2100x_i2c_remove,
+	.id_table	= fxas2100x_i2c_id,
+};
+module_i2c_driver(fxas2100x_i2c_driver);
+
+MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("FXAS2100X I2C Gyro driver");
-- 
2.20.1

