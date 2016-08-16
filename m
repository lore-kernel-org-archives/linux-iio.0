Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34645 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbcHPNev (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2016 09:34:51 -0400
Received: by mail-qk0-f179.google.com with SMTP id f123so70475734qkd.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2016 06:34:51 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 15/17] iio: accel: kxsd9: Replace "parent" with "dev"
Date: Tue, 16 Aug 2016 15:33:41 +0200
Message-Id: <1471354423-19186-16-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

What is passed to the .probe() and .remove() functions is
technically the parent of the created IIO device but it becomes
a big confusion for the head to have it named like this since
it is usually clear from context the "dev" refers to the physical
device, and when next adding PM callbacks a clean
"struct device *dev" pointer is passed to these and that makes
it even more confused. Rename "parent" to "dev" like in most
other drivers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/kxsd9.c | 22 +++++++++++-----------
 drivers/iio/accel/kxsd9.h |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index e169f40311af..1b1b7cdbe627 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -335,7 +335,7 @@ static const struct iio_info kxsd9_info = {
 /* Four channels apart from timestamp, scan mask = 0x0f */
 static const unsigned long kxsd9_scan_masks[] = { 0xf, 0 };
 
-int kxsd9_common_probe(struct device *parent,
+int kxsd9_common_probe(struct device *dev,
 		       struct regmap *map,
 		       const char *name)
 {
@@ -343,18 +343,18 @@ int kxsd9_common_probe(struct device *parent,
 	struct kxsd9_state *st;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(parent, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	st->dev = parent;
+	st->dev = dev;
 	st->map = map;
 
 	indio_dev->channels = kxsd9_channels;
 	indio_dev->num_channels = ARRAY_SIZE(kxsd9_channels);
 	indio_dev->name = name;
-	indio_dev->dev.parent = parent;
+	indio_dev->dev.parent = dev;
 	indio_dev->info = &kxsd9_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->available_scan_masks = kxsd9_scan_masks;
@@ -362,11 +362,11 @@ int kxsd9_common_probe(struct device *parent,
 	/* Fetch and turn on regulators */
 	st->regs[0].supply = kxsd9_reg_vdd;
 	st->regs[1].supply = kxsd9_reg_iovdd;
-	ret = devm_regulator_bulk_get(parent,
+	ret = devm_regulator_bulk_get(dev,
 				      ARRAY_SIZE(st->regs),
 				      st->regs);
 	if (ret) {
-		dev_err(parent, "Cannot get regulators\n");
+		dev_err(dev, "Cannot get regulators\n");
 		return ret;
 	}
 
@@ -377,15 +377,15 @@ int kxsd9_common_probe(struct device *parent,
 					 kxsd9_trigger_handler,
 					 NULL);
 	if (ret) {
-		dev_err(parent, "triggered buffer setup failed\n");
+		dev_err(dev, "triggered buffer setup failed\n");
 		goto err_power_down;
 	}
 
-	ret = devm_iio_device_register(parent, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		goto err_cleanup_buffer;
 
-	dev_set_drvdata(parent, indio_dev);
+	dev_set_drvdata(dev, indio_dev);
 
 	return 0;
 
@@ -398,9 +398,9 @@ err_power_down:
 }
 EXPORT_SYMBOL(kxsd9_common_probe);
 
-int kxsd9_common_remove(struct device *parent)
+int kxsd9_common_remove(struct device *dev)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(parent);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct kxsd9_state *st = iio_priv(indio_dev);
 
 	iio_triggered_buffer_cleanup(indio_dev);
diff --git a/drivers/iio/accel/kxsd9.h b/drivers/iio/accel/kxsd9.h
index 19131a7a692c..9c0861f6b838 100644
--- a/drivers/iio/accel/kxsd9.h
+++ b/drivers/iio/accel/kxsd9.h
@@ -4,7 +4,7 @@
 #define KXSD9_STATE_RX_SIZE 2
 #define KXSD9_STATE_TX_SIZE 2
 
-int kxsd9_common_probe(struct device *parent,
+int kxsd9_common_probe(struct device *dev,
 		       struct regmap *map,
 		       const char *name);
-int kxsd9_common_remove(struct device *parent);
+int kxsd9_common_remove(struct device *dev);
-- 
2.7.4

