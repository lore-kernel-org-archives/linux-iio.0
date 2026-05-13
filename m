Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B7E38D018
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665596; cv=none; b=W7VPVGonBY0I9hL7E7aoJutg+eIa4EVmr2ztaJzGu2yf2Xt2MRFOYB37nPWH+gbE29Fm4OrH+YLJvG9xugrYPoqO0THMKT11iH6LJRxJJWcXol1oYOAwndXBwPq71GwXSdksUB1r0E746KtcysIVIVM/vvKeoFMCaH+G+LZ7gVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665596; c=relaxed/simple;
	bh=pO2Gj0v2j/36f3z1q/IxyG4uyJpEwZsOyGHqPuWLmFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=arOnDES+4D2JGQ+AXKaFy0Bc1WoHOMcYnEJSJ8veNC3UHDAQzYIgYuI0s+MxSyO3+hxL+IZua1fgjTXw2vfYGInYo5ePfxODViFd4Hk2Grq4YRYdN5sQ1rAa+yVDFzb7Eoaedti9tqcTrnZuoh0Hgv50LpZxtFtFDUEKUc3vVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/mGninc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/mGninc"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4830b67aa6bso7327645e9.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778665587; x=1779270387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv5NWoKadJwa5peeIuFPciCVZufaAVsLKsWJ1tkRxdc=;
        b=r/mGnincyXT9sUm0kDt3/04SX8Xq5Rmc9zdGQGrA3/y7pQNgrTbcHODKh4hqSjO9tv
         ZdLU3evlPVXto1dmpc5AHaYDGismYnPLH6vBfhsOmTwmlDaBS9KkS9rDcPX/pC/jwwsf
         JiSBKGlqYD9Roy8gcBnp6EO57f0hOfWCYoj/OQcwcPQ0mFyZL22ikE+D0GOyLjFpwQPF
         ac1fiZVRojAVpXR8ojSgLwbKvHUI1GXOzurBOzfkEr29wlk24eFQeQX5WoJp9BeAUJ4a
         lJbRZ68fvtRK4XgMWVoq/84/jflP0f/JMPGtrCfpDpD1RFO9sw4USwvsv62tQ9YUKl+e
         hMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778665587; x=1779270387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv5NWoKadJwa5peeIuFPciCVZufaAVsLKsWJ1tkRxdc=;
        b=sdRoSRE6yTQm7eZMr8AOG9Q6kE5/DmXhmXGPlIok3SRejpa2/0J3vbUKFwgwZCD7Ol
         Uu3b1JdtnIotcq2cs5QdtJqAnLFfBEFSP1F6h5ck6CD51KWsy84cM3K0+m4sayxFCusN
         QCoiGKQgrn0EK7LLNQYJ/OXtVNE9rBHeHbu66ImzUsSdJjoPy0GXhI+p83vM2Jcs5xIw
         V6HuJBYMx3/Et8oEcd6WhiYcvYtGHggEm3HbkK8jIfmBHOmumCi2lt55hwUm6lQaPIZF
         Caalzv2yaSoxzvi0Vlz3xVStKl5Q3UxXt6Q+Cr2I0nAGxhOy5r+652TmT/OJtfuLVq1F
         4jFw==
X-Forwarded-Encrypted: i=1; AFNElJ+w4/J/J6o8lRd/M0f/ohZcZBbBrM8ZITCsN17f7zl8PHhkNeGMZvsEToInLUrQ/Rtuwr9PUsexT/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YypJAVq4kVd8j0U/PoBKbcsrmUkyucdnASV49jabGdhskfTulnA
	6eTKWlCC8mpq9VAeRphegPWATuk6t9vFQmZOcxj6cghZU/yx1/ws7IVK
X-Gm-Gg: Acq92OG+Uw/FziJK8zNLSmjsI9eFboW+3NrrxGQ8KcyIO/RJOphAEn6B599NUT2X3ID
	s4d6Ty9QYTwMeOX4lqPEkv0uRBER5oecCFhOfmyGxXVKMfrpZXaIKtoX9cXSgJGns8qcOeJoWHo
	4ELcSHw6W7NqdaSXiK6OOkEIJ25XuJagcBa1g/rTi3fPe4/oKhwli8uDIDKdzL7NdpZEjh1Zvxh
	2m6OZfXULENewPO9mfATQEO7elsvu3CAKTQ/bEWJsuVSYdJUbra5UNurlKOj7qhZzaqaweqSsTR
	1TFEIfI95MYsHvOjuywq65lHhRd8KAgN2ryrL0TG3HG771UyWqQt2aeqxXumXJ/S3afY1UF871q
	5dr8Mdlu/SQtsvlhYIsIr2M8i07ZP1xZHfCzM7pMWBV9KhhuEoSezQ1MAKPVlstLQiWXpFoQn20
	zbJPBoadrUWNJ36rlzeJtyYddMFsVxhrIAMLUdx+hX1YU=
X-Received: by 2002:a05:600c:3109:b0:489:1fa8:b895 with SMTP id 5b1f17b1804b1-48fc9a09508mr17704875e9.2.1778665586497;
        Wed, 13 May 2026 02:46:26 -0700 (PDT)
Received: from localhost.localdomain ([94.158.58.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d27d31sm100167475e9.8.2026.05.13.02.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:46:26 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: arthur.becker@sentec.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: light: veml6040: add suspend/resume support
Date: Wed, 13 May 2026 14:45:36 +0500
Message-Id: <20260513094536.8038-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VEML6040 RGBW light sensor stays in auto-measurement mode at all
times once probed, drawing its full active current (~200 uA per
Vishay VEML6040 datasheet, Doc# 84276 Rev. 1.7). On system suspend
there is no need to keep the sensor running.

Add system sleep PM callbacks that toggle the SD (shutdown) bit in
CONF register 00H to put the chip into shutdown on suspend and back
into normal operation on resume. The bit semantics are documented in
the datasheet Tables 2-1 and 2-2.

The existing veml6040_shutdown_action() is unchanged; it still runs
on module unload to leave the chip shut down.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/light/veml6040.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iio/light/veml6040.c b/drivers/iio/light/veml6040.c
index f563f9f0e..ffd0a2a70 100644
--- a/drivers/iio/light/veml6040.c
+++ b/drivers/iio/light/veml6040.c
@@ -13,6 +13,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 
 /* VEML6040 Configuration Registers
@@ -201,6 +202,32 @@ static void veml6040_shutdown_action(void *data)
 			   VEML6040_CONF_SD_MSK, VEML6040_CONF_SD_MSK);
 }
 
+/*
+ * Per Vishay VEML6040 datasheet (Doc# 84276 Rev. 1.7), Table 2-1 and
+ * Table 2-2, the SD bit in CONF register 00H controls chip shutdown:
+ * SD = 1 disables the color sensor, SD = 0 re-enables it.
+ */
+static int veml6040_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct veml6040_data *data = iio_priv(indio_dev);
+
+	return regmap_update_bits(data->regmap, VEML6040_CONF_REG,
+				  VEML6040_CONF_SD_MSK, VEML6040_CONF_SD_MSK);
+}
+
+static int veml6040_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct veml6040_data *data = iio_priv(indio_dev);
+
+	return regmap_update_bits(data->regmap, VEML6040_CONF_REG,
+				  VEML6040_CONF_SD_MSK, 0);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(veml6040_pm_ops, veml6040_suspend,
+				veml6040_resume);
+
 static int veml6040_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -271,6 +298,7 @@ static struct i2c_driver veml6040_driver = {
 	.driver = {
 		.name = "veml6040",
 		.of_match_table = veml6040_of_match,
+		.pm = pm_sleep_ptr(&veml6040_pm_ops),
 	},
 };
 module_i2c_driver(veml6040_driver);
-- 
2.43.0

