Return-Path: <SRS0=Oeur=RQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A19C43381
	for <linux-iio@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B80213A2
	for <linux-iio@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yP2nxjQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfCMSkV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:40:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53365 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfCMSkU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Mar 2019 14:40:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id e74so339152wmg.3
        for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2019 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QCPTdmFK6cOLG6MFHJiz4CEb2BEdpfF4aAmH9h3POM=;
        b=yP2nxjQjHBlGOaT/JX1rOnnbO6g6gYCGNaUwaB7/aeZw0m65fvp269zHaM8+GMcniC
         omjygLJMYLKz/RqZiWA5eiSWzeDqBSHShfINgc+q+m450tgYFJ3EWvezOqiQVojIbflS
         tas37OzYuRQPV24CodqtlRnqSLM/QwbVuKlBJ1zMI0v0ujRm4eMBeIdbhIoIdLHrkHcI
         HJk8VOWLkfDhFCFWbOBUKuNhXFj95nb+Omv/YX+zBdcLg1a7jQe1RzSzWmniVtnN1SxF
         jaPHwuB+RSYULciJslOw3VfbSb/1ux8XBwZlkT3xccBDTfYJGTpdhUDzbGP7EJYe9Fni
         cjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QCPTdmFK6cOLG6MFHJiz4CEb2BEdpfF4aAmH9h3POM=;
        b=I7wn1lLTxjGpbZgZ1c/N4RcDvYwbhTgh2nXlLwR4mGsZXi2O+kteranNcU6M4EJeYV
         IgE9gE9Q7W8AnAUC135i9IhtVay4Cl1bJqa7dVgalOeU0luMNl1jWT/69vl1/GHuEChT
         oKRn+g9QWddVEVkvUbfgq70dbzwFQlN5196AH0Y2rL1f6uWQUC9/IhCxzMkM8IlcE8H0
         hn4QQpsOxFpL6dxnVtpv5dxzLU6y34EdG4LY51KR2923k3vo/tTdixV4ow/9EyC4Za/H
         j5ft14eHOz0epU8GYbB81GvwwBz245fmudab9uze4hyLnDxdb8iHqv4PUF5IlM3GvC8d
         mXTQ==
X-Gm-Message-State: APjAAAX0laNug9LcXKF+EK0Yv7va1qR1lSRl/2G8OJ2XgGwI6KsSpZzT
        p/gnn99URG4QFr8qjPKdeY92pOZaS481Ng==
X-Google-Smtp-Source: APXvYqxJtDuBcEjnlGp+1+1P17Lf1wpi3JV5+oLynr/DWg6uEn94CxunKVtEh7GDXujEW/Pq6pnrDg==
X-Received: by 2002:a1c:9e97:: with SMTP id h145mr3212380wme.147.1552502417952;
        Wed, 13 Mar 2019 11:40:17 -0700 (PDT)
Received: from arch-late.localdomain ([87.196.73.151])
        by smtp.gmail.com with ESMTPSA id p17sm3829660wmi.35.2019.03.13.11.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:40:17 -0700 (PDT)
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
Subject: [PATCH v3 3/6] iio: gyro: fxas21002c: add i2c driver
Date:   Wed, 13 Mar 2019 18:39:59 +0000
Message-Id: <20190313184002.2501-4-rui.silva@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313184002.2501-1-rui.silva@linaro.org>
References: <20190313184002.2501-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the real driver to talk over i2c and use the fxas21002c core
for the main tasks.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/iio/gyro/Kconfig          |  6 +++
 drivers/iio/gyro/Makefile         |  1 +
 drivers/iio/gyro/fxas21002c_i2c.c | 73 +++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 drivers/iio/gyro/fxas21002c_i2c.c

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index cfd2cf44bac8..71b6552ee06b 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -77,6 +77,8 @@ config FXAS21002C
        tristate "NXP FXAS21002C Gyro Sensor"
        select IIO_BUFFER
        select IIO_TRIGGERED_BUFFER
+       select FXAS21002C_I2C if (I2C)
+       depends on I2C
        help
          Say yes here to build support for NXP FXAS21002C Tri-axis Gyro
          Sensor driver connected via I2C or SPI.
@@ -84,6 +86,10 @@ config FXAS21002C
          This driver can also be built as a module.  If so, the module
          will be called fxas21002c_i2c or fxas21002c_spi.
 
+config FXAS21002C_I2C
+       tristate
+       select REGMAP_I2C
+
 config HID_SENSOR_GYRO_3D
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index 247dc600a602..adc18a5eb283 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_BMG160) += bmg160_core.o
 obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
 obj-$(CONFIG_BMG160_SPI) += bmg160_spi.o
 obj-$(CONFIG_FXAS21002C) += fxas21002c_core.o
+obj-$(CONFIG_FXAS21002C_I2C) += fxas21002c_i2c.o
 
 obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
 
diff --git a/drivers/iio/gyro/fxas21002c_i2c.c b/drivers/iio/gyro/fxas21002c_i2c.c
new file mode 100644
index 000000000000..c248ac5251df
--- /dev/null
+++ b/drivers/iio/gyro/fxas21002c_i2c.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for NXP FXAS21002C Gyroscope - I2C
+ *
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+#include "fxas21002c.h"
+
+static const struct regmap_config fxas21002c_regmap_i2c_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = FXAS21002C_REG_CTRL3,
+};
+
+static int fxas21002c_i2c_probe(struct i2c_client *i2c,
+				const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	const char *name = NULL;
+
+	regmap = devm_regmap_init_i2c(i2c, &fxas21002c_regmap_i2c_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&i2c->dev, "Failed to register i2c regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	if (id)
+		name = id->name;
+
+	return fxas21002c_core_probe(&i2c->dev, regmap, i2c->irq, name);
+}
+
+static int fxas21002c_i2c_remove(struct i2c_client *i2c)
+{
+	fxas21002c_core_remove(&i2c->dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id fxas21002c_i2c_id[] = {
+	{ "fxas21002c", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, fxas21002c_i2c_id);
+
+static const struct of_device_id fxas21002c_i2c_of_match[] = {
+	{ .compatible = "nxp,fxas21002c", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, fxas21002c_i2c_of_match);
+
+static struct i2c_driver fxas21002c_i2c_driver = {
+	.driver = {
+		.name = "fxas21002c_i2c",
+		.pm = &fxas21002c_pm_ops,
+		.of_match_table = of_match_ptr(fxas21002c_i2c_of_match),
+	},
+	.probe		= fxas21002c_i2c_probe,
+	.remove		= fxas21002c_i2c_remove,
+	.id_table	= fxas21002c_i2c_id,
+};
+module_i2c_driver(fxas21002c_i2c_driver);
+
+MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("FXAS21002C I2C Gyro driver");
-- 
2.20.1

