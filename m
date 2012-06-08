Return-Path: <leed.aguilar@ti.com>
From: Leed Aguilar <leed.aguilar@ti.com>
To: <linux-iio@vger.kernel.org>
CC: <leed.aguilar@ti.com>, Jonathan Cameron <jic23@kernel.org>,
        Michael
 Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>
Subject: [PATCH] staging:iio:adc: use kstrtol() and kstrtoul() when possible
Date: Fri, 8 Jun 2012 18:51:30 -0400
Message-ID: <1339195890-27082-1-git-send-email-leed.aguilar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Correct the following checkpatch.pl warnings:

WARNING: strict_strtol is obsolete, use kstrtol instead
WARNING: strict_strtoul is obsolete, use kstrtoul instead

Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7192.c       |    2 +-
 drivers/staging/iio/adc/ad7280a.c      |    2 +-
 drivers/staging/iio/adc/ad7606_core.c  |    4 ++--
 drivers/staging/iio/adc/ad7793.c       |    2 +-
 drivers/staging/iio/adc/ad7816.c       |    4 ++--
 drivers/staging/iio/adc/ad799x_core.c  |    4 ++--
 drivers/staging/iio/adc/adt7310.c      |   12 ++++++------
 drivers/staging/iio/adc/adt7410.c      |   12 ++++++------
 drivers/staging/iio/adc/max1363_core.c |    2 +-
 9 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index fd920b0..80202f2 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -671,7 +671,7 @@ static ssize_t ad7192_write_frequency(struct device *dev,
 	unsigned long lval;
 	int div, ret;
 
-	ret = strict_strtoul(buf, 10, &lval);
+	ret = kstrtoul(buf, 10, &lval);
 	if (ret)
 		return ret;
 
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 592b4e7..4d41f3e 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -636,7 +636,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
 	long val;
 	int ret;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 9ff38a8..0e95e5e 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -126,7 +126,7 @@ static ssize_t ad7606_store_range(struct device *dev,
 	struct ad7606_state *st = iio_priv(indio_dev);
 	unsigned long lval;
 
-	if (strict_strtoul(buf, 10, &lval))
+	if (kstrtoul(buf, 10, &lval))
 		return -EINVAL;
 	if (!(lval == 5000 || lval == 10000)) {
 		dev_err(dev, "range is not supported\n");
@@ -173,7 +173,7 @@ static ssize_t ad7606_store_oversampling_ratio(struct device *dev,
 	unsigned long lval;
 	int ret;
 
-	if (strict_strtoul(buf, 10, &lval))
+	if (kstrtoul(buf, 10, &lval))
 		return -EINVAL;
 
 	ret = ad7606_oversampling_get_index(lval);
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 93f2391..42ab56b 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -547,7 +547,7 @@ static ssize_t ad7793_write_frequency(struct device *dev,
 	}
 	mutex_unlock(&indio_dev->mlock);
 
-	ret = strict_strtol(buf, 10, &lval);
+	ret = kstrtol(buf, 10, &lval);
 	if (ret)
 		return ret;
 
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 52b720e..ab22ba3 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -175,7 +175,7 @@ static ssize_t ad7816_store_channel(struct device *dev,
 	unsigned long data;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &data);
+	ret = kstrtoul(buf, 10, &data);
 	if (ret)
 		return -EINVAL;
 
@@ -290,7 +290,7 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
 	u8 data;
 	int ret;
 
-	ret = strict_strtol(buf, 10, &value);
+	ret = kstrtol(buf, 10, &value);
 
 	if (chip->channel_id > AD7816_CS_MAX) {
 		dev_err(dev, "Invalid oti channel id %d.\n", chip->channel_id);
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 72bece7..a1b107d 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -208,7 +208,7 @@ static ssize_t ad799x_write_frequency(struct device *dev,
 	int ret, i;
 	u8 t;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 
@@ -319,7 +319,7 @@ static ssize_t ad799x_write_channel_config(struct device *dev,
 	long val;
 	int ret;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index caf57c1..7c6d1e1 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -270,7 +270,7 @@ static ssize_t adt7310_store_resolution(struct device *dev,
 	u16 config;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &data);
+	ret = kstrtoul(buf, 10, &data);
 	if (ret)
 		return -EINVAL;
 
@@ -498,7 +498,7 @@ static ssize_t adt7310_set_fault_queue(struct device *dev,
 	int ret;
 	u8 config;
 
-	ret = strict_strtoul(buf, 10, &data);
+	ret = kstrtoul(buf, 10, &data);
 	if (ret || data > 3)
 		return -EINVAL;
 
@@ -549,7 +549,7 @@ static inline ssize_t adt7310_set_t_bound(struct device *dev,
 
 	pos = strchr(buf, '.');
 
-	ret = strict_strtol(buf, 10, &tmp1);
+	ret = kstrtol(buf, 10, &tmp1);
 
 	if (ret || tmp1 > 127 || tmp1 < -128)
 		return -EINVAL;
@@ -561,7 +561,7 @@ static inline ssize_t adt7310_set_t_bound(struct device *dev,
 			if (len > ADT7310_T16_VALUE_FLOAT_OFFSET)
 				len = ADT7310_T16_VALUE_FLOAT_OFFSET;
 			pos[len] = 0;
-			ret = strict_strtol(pos, 10, &tmp2);
+			ret = kstrtol(pos, 10, &tmp2);
 
 			if (!ret)
 				tmp2 = (tmp2 / 78125) * 78125;
@@ -569,7 +569,7 @@ static inline ssize_t adt7310_set_t_bound(struct device *dev,
 			if (len > ADT7310_T13_VALUE_FLOAT_OFFSET)
 				len = ADT7310_T13_VALUE_FLOAT_OFFSET;
 			pos[len] = 0;
-			ret = strict_strtol(pos, 10, &tmp2);
+			ret = kstrtol(pos, 10, &tmp2);
 
 			if (!ret)
 				tmp2 = (tmp2 / 625) * 625;
@@ -683,7 +683,7 @@ static inline ssize_t adt7310_set_t_hyst(struct device *dev,
 	unsigned long data;
 	u8 t_hyst;
 
-	ret = strict_strtol(buf, 10, &data);
+	ret = kstrtoul(buf, 10, &data);
 
 	if (ret || data > ADT7310_T_HYST_MASK)
 		return -EINVAL;
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index dff3e8c..95bbae6 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -239,7 +239,7 @@ static ssize_t adt7410_store_resolution(struct device *dev,
 	u16 config;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &data);
+	ret = kstrtoul(buf, 10, &data);
 	if (ret)
 		return -EINVAL;
 
@@ -466,7 +466,7 @@ static ssize_t adt7410_set_fault_queue(struct device *dev,
 	int ret;
 	u8 config;
 
-	ret = strict_strtoul(buf, 10, &data);
+	ret = kstrtoul(buf, 10, &data);
 	if (ret || data > 3)
 		return -EINVAL;
 
@@ -517,7 +517,7 @@ static inline ssize_t adt7410_set_t_bound(struct device *dev,
 
 	pos = strchr(buf, '.');
 
-	ret = strict_strtol(buf, 10, &tmp1);
+	ret = kstrtol(buf, 10, &tmp1);
 
 	if (ret || tmp1 > 127 || tmp1 < -128)
 		return -EINVAL;
@@ -529,7 +529,7 @@ static inline ssize_t adt7410_set_t_bound(struct device *dev,
 			if (len > ADT7410_T16_VALUE_FLOAT_OFFSET)
 				len = ADT7410_T16_VALUE_FLOAT_OFFSET;
 			pos[len] = 0;
-			ret = strict_strtol(pos, 10, &tmp2);
+			ret = kstrtol(pos, 10, &tmp2);
 
 			if (!ret)
 				tmp2 = (tmp2 / 78125) * 78125;
@@ -537,7 +537,7 @@ static inline ssize_t adt7410_set_t_bound(struct device *dev,
 			if (len > ADT7410_T13_VALUE_FLOAT_OFFSET)
 				len = ADT7410_T13_VALUE_FLOAT_OFFSET;
 			pos[len] = 0;
-			ret = strict_strtol(pos, 10, &tmp2);
+			ret = kstrtol(pos, 10, &tmp2);
 
 			if (!ret)
 				tmp2 = (tmp2 / 625) * 625;
@@ -651,7 +651,7 @@ static inline ssize_t adt7410_set_t_hyst(struct device *dev,
 	unsigned long data;
 	u8 t_hyst;
 
-	ret = strict_strtol(buf, 10, &data);
+	ret = kstrtoul(buf, 10, &data);
 
 	if (ret || data > ADT7410_T_HYST_MASK)
 		return -EINVAL;
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 4a95d78..c1ab497 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -514,7 +514,7 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
 	unsigned long val;
 	bool found = false;
 
-	ret = strict_strtoul(buf, 10, &val);
+	ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		return -EINVAL;
 	for (i = 0; i < ARRAY_SIZE(max1363_monitor_speeds); i++)
-- 
1.7.1
