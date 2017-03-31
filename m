Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35740 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933203AbdCaQrA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2017 12:47:00 -0400
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: health: afe4403: Remove all unused functions
Date: Fri, 31 Mar 2017 22:16:44 +0530
Message-Id: <1490978804-25549-4-git-send-email-singhalsimran0@gmail.com>
In-Reply-To: <1490978804-25549-1-git-send-email-singhalsimran0@gmail.com>
References: <1490978804-25549-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The functions afe440x_show_register and afe440x_store_register are never
used anywhere in the kernel. So, remove their definitions.
Grepped to find occurences.

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/health/afe4403.c | 51 --------------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 6bb23a4..3059014 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -136,57 +136,6 @@ static const struct afe440x_val_table afe4403_cap_table[] = {
 };
 AFE440X_TABLE_ATTR(in_intensity_capacitance_available, afe4403_cap_table);
 
-static ssize_t afe440x_show_register(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct afe4403_data *afe = iio_priv(indio_dev);
-	struct afe440x_attr *afe440x_attr = to_afe440x_attr(attr);
-	unsigned int reg_val;
-	int vals[2];
-	int ret;
-
-	ret = regmap_field_read(afe->fields[afe440x_attr->field], &reg_val);
-	if (ret)
-		return ret;
-
-	if (reg_val >= afe440x_attr->table_size)
-		return -EINVAL;
-
-	vals[0] = afe440x_attr->val_table[reg_val].integer;
-	vals[1] = afe440x_attr->val_table[reg_val].fract;
-
-	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, vals);
-}
-
-static ssize_t afe440x_store_register(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf, size_t count)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct afe4403_data *afe = iio_priv(indio_dev);
-	struct afe440x_attr *afe440x_attr = to_afe440x_attr(attr);
-	int val, integer, fract, ret;
-
-	ret = iio_str_to_fixpoint(buf, 100000, &integer, &fract);
-	if (ret)
-		return ret;
-
-	for (val = 0; val < afe440x_attr->table_size; val++)
-		if (afe440x_attr->val_table[val].integer == integer &&
-		    afe440x_attr->val_table[val].fract == fract)
-			break;
-	if (val == afe440x_attr->table_size)
-		return -EINVAL;
-
-	ret = regmap_field_write(afe->fields[afe440x_attr->field], val);
-	if (ret)
-		return ret;
-
-	return count;
-}
-
 static AFE440X_ATTR(in_intensity1_resistance, F_RF_LED, afe4403_res_table);
 static AFE440X_ATTR(in_intensity1_capacitance, F_CF_LED, afe4403_cap_table);
 
-- 
2.7.4

