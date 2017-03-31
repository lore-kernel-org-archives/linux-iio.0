Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35661 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933203AbdCaQqx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2017 12:46:53 -0400
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: health: afe440x: Remove code in comments
Date: Fri, 31 Mar 2017 22:16:42 +0530
Message-Id: <1490978804-25549-2-git-send-email-singhalsimran0@gmail.com>
In-Reply-To: <1490978804-25549-1-git-send-email-singhalsimran0@gmail.com>
References: <1490978804-25549-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commenting out code is a bad idea.
As comments are for explaining what code is about.

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/health/afe440x.h | 58 --------------------------------------------
 1 file changed, 58 deletions(-)

diff --git a/drivers/iio/health/afe440x.h b/drivers/iio/health/afe440x.h
index 1a0f247..71e2f0e 100644
--- a/drivers/iio/health/afe440x.h
+++ b/drivers/iio/health/afe440x.h
@@ -88,56 +88,11 @@
 #define AFE440X_CONTROL0_WRITE		0x0
 #define AFE440X_CONTROL0_READ		0x1
 
-#define AFE440X_INTENSITY_CHAN(_index, _mask)			\
-	{							\
-		.type = IIO_INTENSITY,				\
-		.channel = _index,				\
-		.address = _index,				\
-		.scan_index = _index,				\
-		.scan_type = {					\
-				.sign = 's',			\
-				.realbits = 24,			\
-				.storagebits = 32,		\
-				.endianness = IIO_CPU,		\
-		},						\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
-			_mask,					\
-		.indexed = true,				\
-	}
-
-#define AFE440X_CURRENT_CHAN(_index)				\
-	{							\
-		.type = IIO_CURRENT,				\
-		.channel = _index,				\
-		.address = _index,				\
-		.scan_index = -1,				\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
-			BIT(IIO_CHAN_INFO_SCALE),		\
-		.indexed = true,				\
-		.output = true,					\
-	}
-
 struct afe440x_val_table {
 	int integer;
 	int fract;
 };
 
-#define AFE440X_TABLE_ATTR(_name, _table)				\
-static ssize_t _name ## _show(struct device *dev,			\
-			      struct device_attribute *attr, char *buf)	\
-{									\
-	ssize_t len = 0;						\
-	int i;								\
-									\
-	for (i = 0; i < ARRAY_SIZE(_table); i++)			\
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ", \
-				 _table[i].integer,			\
-				 _table[i].fract);			\
-									\
-	buf[len - 1] = '\n';						\
-									\
-	return len;							\
-}									\
 static DEVICE_ATTR_RO(_name)
 
 struct afe440x_attr {
@@ -147,17 +102,4 @@ struct afe440x_attr {
 	unsigned int table_size;
 };
 
-#define to_afe440x_attr(_dev_attr)				\
-	container_of(_dev_attr, struct afe440x_attr, dev_attr)
-
-#define AFE440X_ATTR(_name, _field, _table)			\
-	struct afe440x_attr afe440x_attr_##_name = {		\
-		.dev_attr = __ATTR(_name, (S_IRUGO | S_IWUSR),	\
-				   afe440x_show_register,	\
-				   afe440x_store_register),	\
-		.field = _field,				\
-		.val_table = _table,				\
-		.table_size = ARRAY_SIZE(_table),		\
-	}
-
 #endif /* _AFE440X_H */
-- 
2.7.4

