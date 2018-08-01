Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr730075.outbound.protection.outlook.com ([40.107.73.75]:62784
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389656AbeHAREY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Aug 2018 13:04:24 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <broonie@kernel.org>, <jic23@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH v2 3/6] regmap: Add regmap_pipe_read API
Date: Wed, 1 Aug 2018 18:17:47 +0300
Message-ID: <1533136667-31828-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Crestez Dan Leonard <leonard.crestez@intel.com>

The regmap API usually assumes that bulk read operations will read a
range of registers but some I2C/SPI devices have certain registers for
which a such a read operation will return data from an internal FIFO
instead. Add an explicit API to support bulk read with pipe rather than
range semantics.

Some linux drivers use regmap_bulk_read or regmap_raw_read for such
registers, for example mpu6050 or bmi150 from IIO. This only happens to
work because when caching is disabled a single regmap read op will map
to a single bus read op (as desired). This breaks if caching is enabled and
reg+1 happens to be a cacheable register.

Without regmap support refactoring a driver to enable regmap caching
requires separate I2C and SPI paths. This is exactly what regmap is
supposed to help avoid.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	Included as part of this patch series as the regmap_pipe_read()
	API will be used to read the data from the FIFO.

 drivers/base/regmap/regmap.c | 64 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/regmap.h       |  9 +++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 3bc8488..73bacbd 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2564,7 +2564,69 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 EXPORT_SYMBOL_GPL(regmap_raw_read);
 
 /**
- * regmap_field_read() - Read a value to a single register field
+ * regmap_pipe_read(): Read data from a register with pipe semantics
+ *
+ * @map: Register map to read from
+ * @reg: Register to read from
+ * @val: Pointer to data buffer
+ * @val_len: Length of output buffer in bytes.
+ *
+ * The regmap API usually assumes that bulk bus read operations will read a
+ * range of registers. Some devices have certain registers for which a read
+ * operation read will read from an internal FIFO.
+ *
+ * The target register must be volatile but registers after it can be
+ * completely unrelated cacheable registers.
+ *
+ * This will attempt multiple reads as required to read val_len bytes.
+ *
+ * A value of zero will be returned on success, a negative errno will be
+ * returned in error cases.
+ */
+int regmap_pipe_read(struct regmap *map, unsigned int reg,
+		     void *val, size_t val_len)
+{
+	size_t read_len;
+	int ret;
+
+	if (!map->bus)
+		return -EINVAL;
+	if (!map->bus->read)
+		return -ENOTSUPP;
+	if (val_len % map->format.val_bytes)
+		return -EINVAL;
+	if (!IS_ALIGNED(reg, map->reg_stride))
+		return -EINVAL;
+	if (val_len == 0)
+		return -EINVAL;
+
+	map->lock(map->lock_arg);
+
+	if (!regmap_volatile(map, reg)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	while (val_len) {
+		if (map->max_raw_read && map->max_raw_read < val_len)
+			read_len = map->max_raw_read;
+		else
+			read_len = val_len;
+		ret = _regmap_raw_read(map, reg, val, read_len);
+		if (ret)
+			goto out_unlock;
+		val = ((u8 *)val) + read_len;
+		val_len -= read_len;
+	}
+
+out_unlock:
+	map->unlock(map->lock_arg);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regmap_pipe_read);
+
+/**
+ * regmap_field_read(): Read a value to a single register field
  *
  * @field: Register field to read from
  * @val: Pointer to store read value
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4f38068..91c5cb6 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -946,6 +946,8 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
 int regmap_raw_read(struct regmap *map, unsigned int reg,
 		    void *val, size_t val_len);
+int regmap_pipe_read(struct regmap *map, unsigned int reg,
+		     void *val, size_t val_len);
 int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		     size_t val_count);
 int regmap_update_bits_base(struct regmap *map, unsigned int reg,
@@ -1196,6 +1198,13 @@ static inline int regmap_raw_read(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_pipe_read(struct regmap *map, unsigned int reg,
+				   void *val, size_t val_len)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_bulk_read(struct regmap *map, unsigned int reg,
 				   void *val, size_t val_count)
 {
-- 
2.7.4

