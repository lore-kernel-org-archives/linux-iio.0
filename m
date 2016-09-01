Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35916 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753163AbcIAJpX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Sep 2016 05:45:23 -0400
Received: by mail-lf0-f41.google.com with SMTP id g62so56215860lfe.3
        for <linux-iio@vger.kernel.org>; Thu, 01 Sep 2016 02:45:23 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 15/15 v2] iio: accel: kxsd9: Support reading a mounting matrix
Date: Thu,  1 Sep 2016 11:44:49 +0200
Message-Id: <1472723089-25113-15-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
References: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds support for the mounting matrix to the KXSD9 driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase on the rest of the series.
---
 drivers/iio/accel/kxsd9.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index a28163b76e12..9af60ac70738 100644
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

