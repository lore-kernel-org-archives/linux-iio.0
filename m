Return-Path: <SRS0=4BFU=KZ=analog.com=StefanSerban.Popa@kernel.org>
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <broonie@kernel.org>
CC: Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
	<mark.rutland@arm.com>, <davem@davemloft.net>, <mchehab+samsung@kernel.org>,
	<gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
	<robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Crestez Dan
 Leonard" <leonard.crestez@intel.com>
Subject: [PATCH v6 3/6] regmap: Add regmap_noinc_read API
Date: Fri, 10 Aug 2018 11:46:20 +0300
Message-ID: <1533890783-13456-4-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Crestez Dan Leonard <leonard.crestez@intel.com>

The regmap API usually assumes that bulk read operations will read a
range of registers but some I2C/SPI devices have certain registers for
which a such a read operation will return data from an internal FIFO
instead. Add an explicit API to support bulk read without range semantics.

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
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/base/regmap/internal.h |  3 ++
 drivers/base/regmap/regmap.c   | 79 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/regmap.h         | 19 ++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 53785e0..a6bf34d63 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -94,10 +94,12 @@ struct regmap {
 	bool (*readable_reg)(struct device *dev, unsigned int reg);
 	bool (*volatile_reg)(struct device *dev, unsigned int reg);
 	bool (*precious_reg)(struct device *dev, unsigned int reg);
+	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
 	const struct regmap_access_table *wr_table;
 	const struct regmap_access_table *rd_table;
 	const struct regmap_access_table *volatile_table;
 	const struct regmap_access_table *precious_table;
+	const struct regmap_access_table *rd_noinc_table;
 
 	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
@@ -181,6 +183,7 @@ bool regmap_writeable(struct regmap *map, unsigned int reg);
 bool regmap_readable(struct regmap *map, unsigned int reg);
 bool regmap_volatile(struct regmap *map, unsigned int reg);
 bool regmap_precious(struct regmap *map, unsigned int reg);
+bool regmap_readable_noinc(struct regmap *map, unsigned int reg);
 
 int _regmap_write(struct regmap *map, unsigned int reg,
 		  unsigned int val);
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 3bc8488..0360a90 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -168,6 +168,17 @@ bool regmap_precious(struct regmap *map, unsigned int reg)
 	return false;
 }
 
+bool regmap_readable_noinc(struct regmap *map, unsigned int reg)
+{
+	if (map->readable_noinc_reg)
+		return map->readable_noinc_reg(map->dev, reg);
+
+	if (map->rd_noinc_table)
+		return regmap_check_range_table(map, reg, map->rd_noinc_table);
+
+	return true;
+}
+
 static bool regmap_volatile_range(struct regmap *map, unsigned int reg,
 	size_t num)
 {
@@ -766,10 +777,12 @@ struct regmap *__regmap_init(struct device *dev,
 	map->rd_table = config->rd_table;
 	map->volatile_table = config->volatile_table;
 	map->precious_table = config->precious_table;
+	map->rd_noinc_table = config->rd_noinc_table;
 	map->writeable_reg = config->writeable_reg;
 	map->readable_reg = config->readable_reg;
 	map->volatile_reg = config->volatile_reg;
 	map->precious_reg = config->precious_reg;
+	map->readable_noinc_reg = config->readable_noinc_reg;
 	map->cache_type = config->cache_type;
 
 	spin_lock_init(&map->async_lock);
@@ -1285,6 +1298,7 @@ int regmap_reinit_cache(struct regmap *map, const struct regmap_config *config)
 	map->readable_reg = config->readable_reg;
 	map->volatile_reg = config->volatile_reg;
 	map->precious_reg = config->precious_reg;
+	map->readable_noinc_reg = config->readable_noinc_reg;
 	map->cache_type = config->cache_type;
 
 	regmap_debugfs_init(map, config->name);
@@ -2564,7 +2578,70 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 EXPORT_SYMBOL_GPL(regmap_raw_read);
 
 /**
- * regmap_field_read() - Read a value to a single register field
+ * regmap_noinc_read(): Read data from a register without incrementing the
+ *			register number
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
+int regmap_noinc_read(struct regmap *map, unsigned int reg,
+		      void *val, size_t val_len)
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
+	if (!regmap_volatile(map, reg) || !regmap_readable_noinc(map, reg)) {
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
+EXPORT_SYMBOL_GPL(regmap_noinc_read);
+
+/**
+ * regmap_field_read(): Read a value to a single register field
  *
  * @field: Register field to read from
  * @val: Pointer to store read value
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4f38068..19df946 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -268,6 +268,13 @@ typedef void (*regmap_unlock)(void *);
  *                field is NULL but precious_table (see below) is not, the
  *                check is performed on such table (a register is precious if
  *                it belongs to one of the ranges specified by precious_table).
+ * @readable_noinc_reg: Optional callback returning true if the register
+ *			supports multiple read operations without incrementing
+ *			the register number. If this field is NULL but
+ *			rd_noinc_table (see below) is not, the check is
+ *			performed on such table (a register is no increment
+ *			readable if it belongs to one of the ranges specified
+ *			by rd_noinc_table).
  * @disable_locking: This regmap is either protected by external means or
  *                   is guaranteed not be be accessed from multiple threads.
  *                   Don't use any locking mechanisms.
@@ -295,6 +302,7 @@ typedef void (*regmap_unlock)(void *);
  * @rd_table:     As above, for read access.
  * @volatile_table: As above, for volatile registers.
  * @precious_table: As above, for precious registers.
+ * @rd_noinc_table: As above, for no increment readable registers.
  * @reg_defaults: Power on reset values for registers (for use with
  *                register cache support).
  * @num_reg_defaults: Number of elements in reg_defaults.
@@ -344,6 +352,7 @@ struct regmap_config {
 	bool (*readable_reg)(struct device *dev, unsigned int reg);
 	bool (*volatile_reg)(struct device *dev, unsigned int reg);
 	bool (*precious_reg)(struct device *dev, unsigned int reg);
+	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
 
 	bool disable_locking;
 	regmap_lock lock;
@@ -360,6 +369,7 @@ struct regmap_config {
 	const struct regmap_access_table *rd_table;
 	const struct regmap_access_table *volatile_table;
 	const struct regmap_access_table *precious_table;
+	const struct regmap_access_table *rd_noinc_table;
 	const struct reg_default *reg_defaults;
 	unsigned int num_reg_defaults;
 	enum regcache_type cache_type;
@@ -946,6 +956,8 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
 int regmap_raw_read(struct regmap *map, unsigned int reg,
 		    void *val, size_t val_len);
+int regmap_noinc_read(struct regmap *map, unsigned int reg,
+		      void *val, size_t val_len);
 int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		     size_t val_count);
 int regmap_update_bits_base(struct regmap *map, unsigned int reg,
@@ -1196,6 +1208,13 @@ static inline int regmap_raw_read(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_noinc_read(struct regmap *map, unsigned int reg,
+				    void *val, size_t val_len)
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
