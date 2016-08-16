Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36487 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbcHPNf0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2016 09:35:26 -0400
Received: by mail-qk0-f180.google.com with SMTP id l2so70478092qkf.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2016 06:34:55 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 17/17] iio: accel: kxsd9: Support reading a mounting matrix
Date: Tue, 16 Aug 2016 15:33:43 +0200
Message-Id: <1471354423-19186-18-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds support for the mounting matrix to the KXSD9 driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/kxsd9.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index ce866ef1ab70..0c0d456cff8a 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -68,12 +68,14 @@
  * struct kxsd9_state - device related storage
  * @dev: pointer to the parent device
  * @map: regmap to the device
+ * @orientation: mounting matrix, flipped axis etc
  * @regs: regulators for this device, VDD and IOVDD
  * @scale: the current scaling setting
  */
 struct kxsd9_state {
 	struct device *dev;
 	struct regmap *map;
+	struct iio_mount_matrix orientation;
 	struct regulator_bulk_data regs[2];
 	u8 scale;
 };
@@ -258,6 +260,20 @@ static const struct iio_buffer_setup_ops kxsd9_buffer_setup_ops = {
 	.postdisable = kxsd9_buffer_postdisable,
 };
 
+static const struct iio_mount_matrix *
+kxsd9_get_mount_matrix(const struct iio_dev *indio_dev,
+		       const struct iio_chan_spec *chan)
+{
+	struct kxsd9_state *st = iio_priv(indio_dev);
+
+	return &st->orientation;
+}
+
+static const struct iio_chan_spec_ext_info kxsd9_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, kxsd9_get_mount_matrix),
+	{ },
+};
+
 #define KXSD9_ACCEL_CHAN(axis, index)						\
 	{								\
 		.type = IIO_ACCEL,					\
@@ -266,6 +282,7 @@ static const struct iio_buffer_setup_ops kxsd9_buffer_setup_ops = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
 					BIT(IIO_CHAN_INFO_OFFSET),	\
+		.ext_info = kxsd9_ext_info,				\
 		.address = KXSD9_REG_##axis,				\
 		.scan_index = index,					\
 		.scan_type = {                                          \
@@ -403,6 +420,13 @@ int kxsd9_common_probe(struct device *dev,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->available_scan_masks = kxsd9_scan_masks;
 
+	/* Read the mounting matrix, if present */
+	ret = of_iio_read_mount_matrix(dev,
+				       "mount-matrix",
+				       &st->orientation);
+	if (ret)
+		return ret;
+
 	/* Fetch and turn on regulators */
 	st->regs[0].supply = kxsd9_reg_vdd;
 	st->regs[1].supply = kxsd9_reg_iovdd;
-- 
2.7.4

