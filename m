Return-Path: <SRS0=Dxs2=DK=gmail.com=vilhelm.gray@kernel.org>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: benjamin.gaignard@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 11/11] counter: 104-quad-8: Add Quadrature Counter interface support
Date: Thu, 14 Dec 2017 15:53:10 -0500
Message-Id: <829bbfda7538536075c816ccf15686d7d66a85c4.1513266127.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1513266127.git.vilhelm.gray@gmail.com>
References: <cover.1513266127.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for the Quadrature Counter interface to the
104-QUAD-8 driver. The existing 104-QUAD-8 device interface should not
be affected by this patch; all changes are intended as supplemental
additions as perceived by the user.

Quadrature Counter Counts are created for the eight quadrature channel
counts, and their respective quadrature A and B signals are associated
via the respective quad_counter_count structure.

The new Quadrature Counter interface sysfs attributes are intended to
expose the same functionality and data available via the existing
104-QUAD-8 IIO device interface; the Quadrature Counter interface serves
to provide the respective functionality and data in a standard way
expected of quadrature counter devices.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/counter/104-quad-8.c | 257 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 247 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
index b56985078d8c..3a82503525f5 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/iio/counter.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
 #include <linux/io.h>
@@ -24,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 #define QUAD8_EXTENT 32
@@ -37,6 +39,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
 
 /**
  * struct quad8_iio - IIO device private data structure
+ * @counter:		instance of the quad_counter_device
  * @preset:		array of preset values
  * @count_mode:		array of count mode configurations
  * @quadrature_mode:	array of quadrature mode configurations
@@ -48,6 +51,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
  * @base:		base port address of the IIO device
  */
 struct quad8_iio {
+	struct quad_counter_device counter;
 	unsigned int preset[QUAD8_NUM_COUNTERS];
 	unsigned int count_mode[QUAD8_NUM_COUNTERS];
 	unsigned int quadrature_mode[QUAD8_NUM_COUNTERS];
@@ -527,24 +531,233 @@ static const struct iio_chan_spec quad8_channels[] = {
 	QUAD8_COUNT_CHAN(7), QUAD8_INDEX_CHAN(7)
 };
 
+static int quad8_signal_read(struct quad_counter_device *counter,
+	struct quad_counter_signal *signal,
+	enum quad_counter_signal_level *level)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	unsigned int state;
+
+	/* Only Index signal levels can be read */
+	if (signal->id < 16)
+		return -EINVAL;
+
+	state = inb(priv->base + 0x16) & BIT(signal->id - 16);
+
+	*level = (state) ? QUAD_COUNTER_SIGNAL_HIGH : QUAD_COUNTER_SIGNAL_LOW;
+
+	return 0;
+}
+
+static int quad8_count_read(struct quad_counter_device *counter,
+	struct quad_counter_count *count, long *val)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id;
+	unsigned int flags;
+	unsigned int borrow;
+	unsigned int carry;
+	int i;
+
+	flags = inb(base_offset + 1);
+	borrow = flags & BIT(0);
+	carry = !!(flags & BIT(1));
+
+	/* Borrow XOR Carry effectively doubles count range */
+	*val = (borrow ^ carry) << 24;
+
+	/* Reset Byte Pointer; transfer Counter to Output Latch */
+	outb(0x11, base_offset + 1);
+
+	for (i = 0; i < 3; i++)
+		*val |= (long)inb(base_offset) << (8 * i);
+
+	return 0;
+}
+
+static int quad8_count_write(struct quad_counter_device *counter,
+	struct quad_counter_count *count, long val)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id;
+	int i;
+
+	/* Only 24-bit values are supported */
+	if (val > 0xFFFFFF)
+		return -EINVAL;
+
+	/* Reset Byte Pointer */
+	outb(0x01, base_offset + 1);
+
+	/* Counter can only be set via Preset Register */
+	for (i = 0; i < 3; i++)
+		outb(val >> (8 * i), base_offset);
+
+	/* Transfer Preset Register to Counter */
+	outb(0x08, base_offset + 1);
+
+	/* Reset Byte Pointer */
+	outb(0x01, base_offset + 1);
+
+	/* Set Preset Register back to original value */
+	val = priv->preset[count->id];
+	for (i = 0; i < 3; i++)
+		outb(val >> (8 * i), base_offset);
+
+	/* Reset Borrow, Carry, Compare, and Sign flags */
+	outb(0x02, base_offset + 1);
+	/* Reset Error flag */
+	outb(0x06, base_offset + 1);
+
+	return 0;
+}
+
+static int quad8_function_get(struct quad_counter_device *counter,
+	struct quad_counter_count *count,
+	enum quad_counter_function *function)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const int id = count->id;
+	const unsigned int quadrature_mode = priv->quadrature_mode[id];
+	const unsigned int scale = priv->quadrature_scale[id];
+
+	if (quadrature_mode)
+		switch (scale) {
+		case 0:
+			*function = QUAD_COUNTER_FUNCTION_QUADRATURE_X1;
+			break;
+		case 1:
+			*function = QUAD_COUNTER_FUNCTION_QUADRATURE_X2;
+			break;
+		case 2:
+			*function = QUAD_COUNTER_FUNCTION_QUADRATURE_X4;
+			break;
+		}
+	else
+		*function = QUAD_COUNTER_FUNCTION_PULSE_DIRECTION;
+
+	return 0;
+}
+
+static int quad8_function_set(struct quad_counter_device *counter,
+	struct quad_counter_count *count, enum quad_counter_function function)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const int id = count->id;
+	unsigned int *const quadrature_mode = priv->quadrature_mode + id;
+	unsigned int *const scale = priv->quadrature_scale + id;
+	unsigned int mode_cfg = priv->count_mode[id] << 1;
+	unsigned int *const synchronous_mode = priv->synchronous_mode + id;
+	const unsigned int idr_cfg = priv->index_polarity[id] << 1;
+	const int base_offset = priv->base + 2 * id + 1;
+
+	if (function == QUAD_COUNTER_FUNCTION_PULSE_DIRECTION) {
+		*quadrature_mode = 0;
+
+		/* Quadrature scaling only available in quadrature mode */
+		*scale = 0;
+
+		/* Synchronous function not supported in non-quadrature mode */
+		if (*synchronous_mode) {
+			*synchronous_mode = 0;
+			/* Disable synchronous function mode */
+			outb(0x60 | idr_cfg, base_offset);
+		}
+	} else {
+		*quadrature_mode = 1;
+
+		switch (function) {
+		case QUAD_COUNTER_FUNCTION_QUADRATURE_X1:
+			*scale = 0;
+			mode_cfg |= 0x8;
+			break;
+		case QUAD_COUNTER_FUNCTION_QUADRATURE_X2:
+			*scale = 1;
+			mode_cfg |= 0x10;
+			break;
+		case QUAD_COUNTER_FUNCTION_QUADRATURE_X4:
+			*scale = 2;
+			mode_cfg |= 0x18;
+			break;
+		}
+	}
+
+	/* Load mode configuration to Counter Mode Register */
+	outb(0x20 | mode_cfg, base_offset);
+
+	return 0;
+}
+
+static int quad8_direction_get(struct quad_counter_device *counter,
+	struct quad_counter_count *count,
+	enum quad_counter_direction *direction)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	unsigned int ud_flag;
+	const unsigned int flag_addr = priv->base + 2 * count->id + 1;
+
+	/* U/D flag: nonzero = up, zero = down */
+	ud_flag = inb(flag_addr) & BIT(5);
+
+	*direction = (ud_flag) ? QUAD_COUNTER_DIRECTION_FORWARD :
+		QUAD_COUNTER_DIRECTION_BACKWARD;
+
+	return 0;
+}
+
+#define QUAD8_COUNT(_id, _cntname, _siganame, _sigbname) {	\
+	.id = _id,						\
+	.name = _cntname,					\
+	.signal_a = {						\
+		.id = 2 * _id,					\
+		.name = _siganame				\
+	},							\
+	.signal_b = {						\
+		.id = 2 * _id + 1,				\
+		.name = _sigbname				\
+	}							\
+}
+
+static const struct quad_counter_count quad8_counts[] = {
+	QUAD8_COUNT(0, "Channel 1 Count", "Channel 1 Quadrature A",
+		"Channel 1 Quadrature B"),
+	QUAD8_COUNT(1, "Channel 2 Count", "Channel 2 Quadrature A",
+		"Channel 2 Quadrature B"),
+	QUAD8_COUNT(2, "Channel 3 Count", "Channel 3 Quadrature A",
+		"Channel 3 Quadrature B"),
+	QUAD8_COUNT(3, "Channel 4 Count", "Channel 4 Quadrature A",
+		"Channel 4 Quadrature B"),
+	QUAD8_COUNT(4, "Channel 5 Count", "Channel 5 Quadrature A",
+		"Channel 5 Quadrature B"),
+	QUAD8_COUNT(5, "Channel 6 Count", "Channel 6 Quadrature A",
+		"Channel 6 Quadrature B"),
+	QUAD8_COUNT(6, "Channel 7 Count", "Channel 7 Quadrature A",
+		"Channel 7 Quadrature B"),
+	QUAD8_COUNT(7, "Channel 8 Count", "Channel 8 Quadrature A",
+		"Channel 8 Quadrature B")
+};
+
 static int quad8_probe(struct device *dev, unsigned int id)
 {
 	struct iio_dev *indio_dev;
-	struct quad8_iio *priv;
+	struct quad_counter_count *counts;
+	struct quad8_iio *quad8iio;
 	int i, j;
 	unsigned int base_offset;
+	int err;
 
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	if (!devm_request_region(dev, base[id], QUAD8_EXTENT,
-		dev_name(dev))) {
+	if (!devm_request_region(dev, base[id], QUAD8_EXTENT, dev_name(dev))) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
 			base[id], base[id] + QUAD8_EXTENT);
 		return -EBUSY;
 	}
 
+	/* Allocate IIO device; this also allocates driver data structure */
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*quad8iio));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	/* Initialize IIO device */
 	indio_dev->info = &quad8_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = ARRAY_SIZE(quad8_channels);
@@ -552,8 +765,26 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	indio_dev->name = dev_name(dev);
 	indio_dev->dev.parent = dev;
 
-	priv = iio_priv(indio_dev);
-	priv->base = base[id];
+	/* Instantiate Quadrature Counter Counts */
+	counts = devm_kmemdup(dev, quad8_counts, sizeof(quad8_counts),
+		GFP_KERNEL);
+	if (!counts)
+		return -ENOMEM;
+
+	/* Initialize Quadrature Counter device and driver data */
+	quad8iio = iio_priv(indio_dev);
+	quad8iio->counter.name = dev_name(dev);
+	quad8iio->counter.parent = dev;
+	quad8iio->counter.signal_read = quad8_signal_read;
+	quad8iio->counter.count_read = quad8_count_read;
+	quad8iio->counter.count_write = quad8_count_write;
+	quad8iio->counter.function_get = quad8_function_get;
+	quad8iio->counter.function_set = quad8_function_set;
+	quad8iio->counter.direction_get = quad8_direction_get;
+	quad8iio->counter.counts = counts;
+	quad8iio->counter.num_counts = ARRAY_SIZE(quad8_counts);
+	quad8iio->counter.priv = quad8iio;
+	quad8iio->base = base[id];
 
 	/* Reset all counters and disable interrupt function */
 	outb(0x01, base[id] + 0x11);
@@ -579,7 +810,13 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	/* Enable all counters */
 	outb(0x00, base[id] + 0x11);
 
-	return devm_iio_device_register(dev, indio_dev);
+	/* Register IIO device */
+	err = devm_iio_device_register(dev, indio_dev);
+	if (err)
+		return err;
+
+	/* Register Quadrature Counter device */
+	return devm_quad_counter_register(dev, &quad8iio->counter);
 }
 
 static struct isa_driver quad8_driver = {
-- 
2.15.1
