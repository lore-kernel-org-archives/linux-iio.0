Return-Path: <vilhelm.gray@gmail.com>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 2/2] iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8
Date: Wed, 21 Sep 2016 16:16:13 -0400
Message-Id: <427c24c70ea0f5cfc38b0219d95eaae30ad89bef.1474487854.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1474487854.git.vilhelm.gray@gmail.com>
References: <cover.1474487854.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The ACCES 104-QUAD-8 is a general purpose quadrature encoder
counter/interface board. The 104-QUAD-8 is capable of monitoring the
outputs of eight encoders via four on-board LSI/CSI LS7266R1 24-bit
dual-axis quadrature counter chips. Core functions handled by the
LS7266R1, such as direction and total count, are available.

Performing a write to a counter's IIO_CHAN_INFO_RAW sets the counter and
also clears the counter's respective error flag. Although the counters
have a 25-bit range, only the lower 24 bits may be set, either directly
or via IIO_CHAN_INFO_PRESET. Interrupts are not supported by this
driver.

This driver adds IIO support for the ACCES 104-QUAD-8 and ACCES
104-QUAD-4. The base port addresses for the devices may be configured
via the base array module parameter.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-iio-counter-104-quad-8   | 124 +++++
 MAINTAINERS                                        |   6 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/counter/104-quad-8.c                   | 582 +++++++++++++++++++++
 drivers/iio/counter/Kconfig                        |  24 +
 drivers/iio/counter/Makefile                       |   7 +
 7 files changed, 745 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
 create mode 100644 drivers/iio/counter/104-quad-8.c
 create mode 100644 drivers/iio/counter/Kconfig
 create mode 100644 drivers/iio/counter/Makefile

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
new file mode 100644
index 0000000..d1b3f15
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
@@ -0,0 +1,124 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_count_ab_enable_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_direction_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_mode_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_count_noise_error_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_count_preset_enable_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_index_index_polarity_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_index_synchronous_mode_available
+KernelVersion:	4.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective counter
+		configuration are listed in this file.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_countY_ab_enable
+KernelVersion:	4.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Enable or disable the encoder A and B inputs for channel Y.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_direction
+KernelVersion:	4.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates whether the counter for
+		channel Y is counting up or down.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_mode
+KernelVersion:	4.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count mode for channel Y. Four count modes are available:
+		normal, range limit, non-recycle, and modulo-n. The preset value
+		for channel Y is used by the count mode where required.
+
+		Normal:
+			Counting is continuous in either direction.
+
+		Range Limit:
+			An upper or lower limit is set, mimicking limit switches
+			in the mechanical counterpart. The upper limit is set to
+			the preset value, while the lower limit is set to 0. The
+			counter freezes at count = preset when counting up, and
+			at count = 0 when counting down. At either of these
+			limits, the counting is resumed only when the count
+			direction is reversed.
+
+		Non-recycle:
+			Counter is disabled whenever a 24-bit count overflow or
+			underflow takes place. The counter is re-enabled when a
+			new count value is loaded to the counter via a preset
+			operation or write to raw.
+
+		Modulo-N:
+			A count boundary is set between 0 and the preset value.
+			The counter is reset to 0 at count = preset when
+			counting up, while the counter is set to the preset
+			value at count = 0 when counting down; the counter does
+			not freeze at the bundary points, but counts continously
+			throughout.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_countY_noise_error
+KernelVersion:	4.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates whether excessive noise is
+		present at the channel Y count inputs in quadrature clock mode;
+		irrelevant in non-quadrature clock mode.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_countY_preset_enable
+KernelVersion:	4.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether to set channel Y counter with channel Y preset value
+		when channel Y index input is active, or continously count.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_countY_quadrature_mode
+KernelVersion:	4.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configure channel Y counter for non-quadrature or quadrature
+		clock mode. Selecting non-quadrature clock mode will disable
+		synchronous load mode. In quadrature clock mode, the channel Y
+		scale attribute selects the encoder phase division
+		(1 = full-cycle, 2 = half-cycle, 4 = quarter-cycle) processed by
+		the channel Y counter.
+
+		Non-quadrature:
+			The filter and decoder circuit are bypassed. Encoder A
+			input serves as the count input and B as the UP/DOWN
+			direction control input, with B = 1 selecting UP Count
+			mode and B = 0 selecting Down Count mode.
+
+		Quadrature:
+			Encoder A and B inputs are digitally filtered and
+			decoded for UP/DN clock.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_index_polarity
+KernelVersion:	4.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Active level of channel Y index input; irrelevant in
+		non-synchronous load mode.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_synchronous_mode
+KernelVersion:	4.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configure channel Y counter for non-synchronous or synchronous
+		load mode. Synchronous load mode cannot be selected in
+		non-quadrature clock mode.
+
+		Non-synchronous:
+			A logic low level is the active level at this index
+			input. The index function (as configured via
+			preset_enable) is performed directly on the active
+			level of the index input.
+
+		Synchronous:
+			Intended for interfacing with encoder Index output in
+			quadrature clock mode. The active level is configured
+			via index_polarity. The index function (as configured
+			via preset_enable) is performed synchronously with the
+			quadrature clock on the active level of the index input.
diff --git a/MAINTAINERS b/MAINTAINERS
index 1b65477..2780a3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -255,6 +255,12 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-104-idio-16.c
 
+ACCES 104-QUAD-8 IIO DRIVER
+M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/counter/104-quad-8.c
+
 ACENIC DRIVER
 M:	Jes Sorensen <jes@trained-monkey.org>
 L:	linux-acenic@sunsite.dk
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 6743b18..574d1fb 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -73,6 +73,7 @@ source "drivers/iio/adc/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
 source "drivers/iio/chemical/Kconfig"
 source "drivers/iio/common/Kconfig"
+source "drivers/iio/counter/Kconfig"
 source "drivers/iio/dac/Kconfig"
 source "drivers/iio/dummy/Kconfig"
 source "drivers/iio/frequency/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 87e4c43..77b2000 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -18,6 +18,7 @@ obj-y += amplifiers/
 obj-y += buffer/
 obj-y += chemical/
 obj-y += common/
+obj-y += counter/
 obj-y += dac/
 obj-y += dummy/
 obj-y += gyro/
diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
new file mode 100644
index 0000000..9a287f9
--- /dev/null
+++ b/drivers/iio/counter/104-quad-8.c
@@ -0,0 +1,582 @@
+/*
+ * IIO driver for the ACCES 104-QUAD-8
+ * Copyright (C) 2016 William Breathitt Gray
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * This driver supports the ACCES 104-QUAD-8 and ACCES 104-QUAD-4.
+ */
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/isa.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#define QUAD8_EXTENT 32
+
+static unsigned int base[max_num_isa_dev(QUAD8_EXTENT)];
+static unsigned int num_quad8;
+module_param_array(base, uint, &num_quad8, 0);
+MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
+
+#define QUAD8_NUM_COUNTERS 8
+
+/**
+ * struct quad8_iio - IIO device private data structure
+ * @preset:		array of preset values
+ * @count_mode:		array of count mode configurations
+ * @quadrature_mode:	array of quadrature mode configurations
+ * @quadrature_scale:	array of quadrature mode scale configurations
+ * @ab_enable:		array of A and B inputs enable configurations
+ * @preset_enable:	array of preset enable configurations
+ * @synchronous_mode:	array of index function synchronous mode configurations
+ * @index_polarity:	array of index function polarity configurations
+ * @base:		base port address of the IIO device
+ */
+struct quad8_iio {
+	unsigned int preset[QUAD8_NUM_COUNTERS];
+	unsigned int count_mode[QUAD8_NUM_COUNTERS];
+	unsigned int quadrature_mode[QUAD8_NUM_COUNTERS];
+	unsigned int quadrature_scale[QUAD8_NUM_COUNTERS];
+	unsigned int ab_enable[QUAD8_NUM_COUNTERS];
+	unsigned int preset_enable[QUAD8_NUM_COUNTERS];
+	unsigned int synchronous_mode[QUAD8_NUM_COUNTERS];
+	unsigned int index_polarity[QUAD8_NUM_COUNTERS];
+	unsigned int base;
+};
+
+static int quad8_read_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const int base_offset = priv->base + 2 * chan->channel;
+	unsigned int flags;
+	unsigned int borrow;
+	unsigned int carry;
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type == IIO_INDEX) {
+			*val = !!(inb(priv->base + 0x16) & BIT(chan->channel));
+			return IIO_VAL_INT;
+		}
+
+		flags = inb(base_offset);
+		borrow = flags & BIT(0);
+		carry = !!(flags & BIT(1));
+
+		/* Borrow XOR Carry effectively doubles count range */
+		*val = (borrow ^ carry) << 24;
+
+		/* Reset Byte Pointer; transfer Counter to Output Latch */
+		outb(0x11, base_offset + 1);
+
+		for (i = 0; i < 3; i++)
+			*val |= (unsigned int)inb(base_offset) << (8 * i);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PRESET:
+		*val = priv->preset[chan->channel];
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1 << priv->quadrature_scale[chan->channel];
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int quad8_write_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const int base_offset = priv->base + 2 * chan->channel;
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type == IIO_INDEX)
+			return -EINVAL;
+
+		/* Only 24-bit values are supported */
+		if ((unsigned int)val > 0xFFFFFF)
+			return -EINVAL;
+
+		/* Reset Byte Pointer */
+		outb(0x01, base_offset + 1);
+
+		/* Counter can only be set via Preset Register */
+		for (i = 0; i < 3; i++)
+			outb(val >> (8 * i), base_offset);
+
+		/* Transfer Preset Register to Counter */
+		outb(0x08, base_offset + 1);
+
+		/* Reset Byte Pointer */
+		outb(0x01, base_offset + 1);
+
+		/* Set Preset Register back to original value */
+		val = priv->preset[chan->channel];
+		for (i = 0; i < 3; i++)
+			outb(val >> (8 * i), base_offset);
+
+		/* Reset Borrow, Carry, Compare, and Sign flags */
+		outb(0x02, base_offset + 1);
+		/* Reset Error flag */
+		outb(0x06, base_offset + 1);
+
+		return 0;
+	case IIO_CHAN_INFO_PRESET:
+		/* Only 24-bit values are supported */
+		if ((unsigned int)val > 0xFFFFFF)
+			return -EINVAL;
+
+		priv->preset[chan->channel] = val;
+
+		/* Reset Byte Pointer */
+		outb(0x01, base_offset + 1);
+
+		/* Set Preset Register */
+		for (i = 0; i < 3; i++)
+			outb(val >> (8 * i), base_offset);
+
+		return 0;
+	case IIO_CHAN_INFO_SCALE:
+		/* Quadrature scaling only available in quadrature mode */
+		if (!priv->quadrature_mode[chan->channel] && val != 1)
+			return -EINVAL;
+
+		/* Only three gain states (x1, x2, x4) */
+		switch (val) {
+		case 1:
+			priv->quadrature_scale[chan->channel] = 0;
+			break;
+		case 2:
+			priv->quadrature_scale[chan->channel] = 1;
+			break;
+		case 4:
+			priv->quadrature_scale[chan->channel] = 2;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info quad8_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = quad8_read_raw,
+	.write_raw = quad8_write_raw
+};
+
+static const char *const quad8_noise_error_states[] = {
+	"No excessive noise is present at the count inputs",
+	"Excessive noise is present at the count inputs"
+};
+
+static int quad8_get_noise_error(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	return !!(inb(base_offset) & BIT(4));
+}
+
+static const struct iio_enum quad8_noise_error_enum = {
+	.items = quad8_noise_error_states,
+	.num_items = ARRAY_SIZE(quad8_noise_error_states),
+	.get = quad8_get_noise_error
+};
+
+static const char *const quad8_count_direction_states[] = {
+	"down",
+	"up"
+};
+
+static int quad8_get_count_direction(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	return !!(inb(base_offset) & BIT(5));
+}
+
+static const struct iio_enum quad8_count_direction_enum = {
+	.items = quad8_count_direction_states,
+	.num_items = ARRAY_SIZE(quad8_count_direction_states),
+	.get = quad8_get_count_direction
+};
+
+static const char *const quad8_count_modes[] = {
+	"normal",
+	"range limit",
+	"non-recycle",
+	"modulo-n"
+};
+
+static int quad8_set_count_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned int count_mode)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	unsigned int mode_cfg = count_mode << 1;
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	priv->count_mode[chan->channel] = count_mode;
+
+	/* Add quadrature mode configuration */
+	if (priv->quadrature_mode[chan->channel])
+		mode_cfg |= (priv->quadrature_scale[chan->channel] + 1) << 3;
+
+	/* Load mode configuration to Counter Mode Register */
+	outb(0x20 | mode_cfg, base_offset);
+
+	return 0;
+}
+
+static int quad8_get_count_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+
+	return priv->count_mode[chan->channel];
+}
+
+static const struct iio_enum quad8_count_mode_enum = {
+	.items = quad8_count_modes,
+	.num_items = ARRAY_SIZE(quad8_count_modes),
+	.set = quad8_set_count_mode,
+	.get = quad8_get_count_mode
+};
+
+static const char *const quad8_synchronous_modes[] = {
+	"non-synchronous",
+	"synchronous"
+};
+
+static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned int synchronous_mode)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const unsigned int idr_cfg = synchronous_mode |
+		priv->index_polarity[chan->channel] << 1;
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	/* Index function must be non-synchronous in non-quadrature mode */
+	if (synchronous_mode && !priv->quadrature_mode[chan->channel])
+		return -EINVAL;
+
+	priv->synchronous_mode[chan->channel] = synchronous_mode;
+
+	/* Load Index Control configuration to Index Control Register */
+	outb(0x40 | idr_cfg, base_offset);
+
+	return 0;
+}
+
+static int quad8_get_synchronous_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+
+	return priv->synchronous_mode[chan->channel];
+}
+
+static const struct iio_enum quad8_synchronous_mode_enum = {
+	.items = quad8_synchronous_modes,
+	.num_items = ARRAY_SIZE(quad8_synchronous_modes),
+	.set = quad8_set_synchronous_mode,
+	.get = quad8_get_synchronous_mode
+};
+
+static const char *const quad8_quadrature_modes[] = {
+	"non-quadrature",
+	"quadrature"
+};
+
+static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned int quadrature_mode)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	unsigned int mode_cfg = priv->count_mode[chan->channel] << 1;
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	if (quadrature_mode)
+		mode_cfg |= (priv->quadrature_scale[chan->channel] + 1) << 3;
+	else {
+		/* Quadrature scaling only available in quadrature mode */
+		priv->quadrature_scale[chan->channel] = 0;
+
+		/* Index function must be non-synchronous in non-quadrature mode */
+		if (priv->synchronous_mode[chan->channel])
+			quad8_set_synchronous_mode(indio_dev, chan, 0);
+	}
+
+	priv->quadrature_mode[chan->channel] = quadrature_mode;
+
+	/* Load mode configuration to Counter Mode Register */
+	outb(0x20 | mode_cfg, base_offset);
+
+	return 0;
+}
+
+static int quad8_get_quadrature_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+
+	return priv->quadrature_mode[chan->channel];
+}
+
+static const struct iio_enum quad8_quadrature_mode_enum = {
+	.items = quad8_quadrature_modes,
+	.num_items = ARRAY_SIZE(quad8_quadrature_modes),
+	.set = quad8_set_quadrature_mode,
+	.get = quad8_get_quadrature_mode
+};
+
+static const char *const quad8_ab_enable_modes[] = {
+	"disabled",
+	"enabled"
+};
+
+static int quad8_set_ab_enable(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned int ab_enable)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const unsigned int ior_cfg = ab_enable |
+		priv->preset_enable[chan->channel] << 1;
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	priv->ab_enable[chan->channel] = ab_enable;
+
+	/* Load I/O control configuration to Input / Output Control Register */
+	outb(0x40 | ior_cfg, base_offset);
+
+	return 0;
+}
+
+static int quad8_get_ab_enable(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+
+	return priv->ab_enable[chan->channel];
+}
+
+static const struct iio_enum quad8_ab_enable_enum = {
+	.items = quad8_ab_enable_modes,
+	.num_items = ARRAY_SIZE(quad8_ab_enable_modes),
+	.set = quad8_set_ab_enable,
+	.get = quad8_get_ab_enable
+};
+
+static const char *const quad8_preset_enable_modes[] = {
+	"Preset counter on index active",
+	"Continuously count"
+};
+
+static int quad8_set_preset_enable(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned int preset_enable)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const unsigned int ior_cfg = priv->ab_enable[chan->channel] |
+		preset_enable << 1;
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	priv->preset_enable[chan->channel] = preset_enable;
+
+	/* Load I/O control configuration to Input / Output Control Register */
+	outb(0x40 | ior_cfg, base_offset);
+
+	return 0;
+}
+
+static int quad8_get_preset_enable(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+
+	return priv->preset_enable[chan->channel];
+}
+
+static const struct iio_enum quad8_preset_enable_enum = {
+	.items = quad8_preset_enable_modes,
+	.num_items = ARRAY_SIZE(quad8_preset_enable_modes),
+	.set = quad8_set_preset_enable,
+	.get = quad8_get_preset_enable
+};
+
+static const char *const quad8_index_polarity_modes[] = {
+	"negative",
+	"positive"
+};
+
+static int quad8_set_index_polarity(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned int index_polarity)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const unsigned int idr_cfg = priv->synchronous_mode[chan->channel] |
+		index_polarity << 1;
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	priv->index_polarity[chan->channel] = index_polarity;
+
+	/* Load Index Control configuration to Index Control Register */
+	outb(0x40 | idr_cfg, base_offset);
+
+	return 0;
+}
+
+static int quad8_get_index_polarity(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+
+	return priv->index_polarity[chan->channel];
+}
+
+static const struct iio_enum quad8_index_polarity_enum = {
+	.items = quad8_index_polarity_modes,
+	.num_items = ARRAY_SIZE(quad8_index_polarity_modes),
+	.set = quad8_set_index_polarity,
+	.get = quad8_get_index_polarity
+};
+
+static const struct iio_chan_spec_ext_info quad8_count_ext_info[] = {
+	IIO_ENUM("noise_error", IIO_SEPARATE, &quad8_noise_error_enum),
+	IIO_ENUM_AVAILABLE("noise_error", &quad8_noise_error_enum),
+	IIO_ENUM("count_direction", IIO_SEPARATE, &quad8_count_direction_enum),
+	IIO_ENUM_AVAILABLE("count_direction", &quad8_count_direction_enum),
+	IIO_ENUM("count_mode", IIO_SEPARATE, &quad8_count_mode_enum),
+	IIO_ENUM_AVAILABLE("count_mode", &quad8_count_mode_enum),
+	IIO_ENUM("quadrature_mode", IIO_SEPARATE, &quad8_quadrature_mode_enum),
+	IIO_ENUM_AVAILABLE("quadrature_mode", &quad8_quadrature_mode_enum),
+	IIO_ENUM("ab_enable", IIO_SEPARATE, &quad8_ab_enable_enum),
+	IIO_ENUM_AVAILABLE("ab_enable", &quad8_ab_enable_enum),
+	IIO_ENUM("preset_enable", IIO_SEPARATE, &quad8_preset_enable_enum),
+	IIO_ENUM_AVAILABLE("preset_enable", &quad8_preset_enable_enum),
+	{}
+};
+
+static const struct iio_chan_spec_ext_info quad8_index_ext_info[] = {
+	IIO_ENUM("synchronous_mode", IIO_SEPARATE, &quad8_synchronous_mode_enum),
+	IIO_ENUM_AVAILABLE("synchronous_mode", &quad8_synchronous_mode_enum),
+	IIO_ENUM("index_polarity", IIO_SEPARATE, &quad8_index_polarity_enum),
+	IIO_ENUM_AVAILABLE("index_polarity", &quad8_index_polarity_enum),
+	{}
+};
+
+#define QUAD8_COUNT_CHAN(_chan) {					\
+	.type = IIO_COUNT,						\
+	.channel = (_chan),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+		BIT(IIO_CHAN_INFO_PRESET) | BIT(IIO_CHAN_INFO_SCALE),	\
+	.ext_info = quad8_count_ext_info,				\
+	.indexed = 1							\
+}
+
+#define QUAD8_INDEX_CHAN(_chan) {			\
+	.type = IIO_INDEX,				\
+	.channel = (_chan),				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	.ext_info = quad8_index_ext_info,		\
+	.indexed = 1					\
+}
+
+static const struct iio_chan_spec quad8_channels[] = {
+	QUAD8_COUNT_CHAN(0), QUAD8_INDEX_CHAN(0),
+	QUAD8_COUNT_CHAN(1), QUAD8_INDEX_CHAN(1),
+	QUAD8_COUNT_CHAN(2), QUAD8_INDEX_CHAN(2),
+	QUAD8_COUNT_CHAN(3), QUAD8_INDEX_CHAN(3),
+	QUAD8_COUNT_CHAN(4), QUAD8_INDEX_CHAN(4),
+	QUAD8_COUNT_CHAN(5), QUAD8_INDEX_CHAN(5),
+	QUAD8_COUNT_CHAN(6), QUAD8_INDEX_CHAN(6),
+	QUAD8_COUNT_CHAN(7), QUAD8_INDEX_CHAN(7)
+};
+
+static int quad8_probe(struct device *dev, unsigned int id)
+{
+	struct iio_dev *indio_dev;
+	struct quad8_iio *priv;
+	int i, j;
+	unsigned int base_offset;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	if (!devm_request_region(dev, base[id], QUAD8_EXTENT,
+		dev_name(dev))) {
+		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
+			base[id], base[id] + QUAD8_EXTENT);
+		return -EBUSY;
+	}
+
+	indio_dev->info = &quad8_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->num_channels = ARRAY_SIZE(quad8_channels);
+	indio_dev->channels = quad8_channels;
+	indio_dev->name = dev_name(dev);
+
+	priv = iio_priv(indio_dev);
+	priv->base = base[id];
+
+	/* Reset all counters and disable interrupt function */
+	outb(0x01, base[id] + 0x11);
+	/* Set initial configuration for all counters */
+	for (i = 0; i < QUAD8_NUM_COUNTERS; i++) {
+		base_offset = base[id] + 2 * i;
+		/* Reset Byte Pointer */
+		outb(0x01, base_offset + 1);
+		/* Reset Preset Register */
+		for (j = 0; j < 3; j++)
+			outb(0x00, base_offset);
+		/* Reset Borrow, Carry, Compare, and Sign flags */
+		outb(0x04, base_offset + 1);
+		/* Reset Error flag */
+		outb(0x06, base_offset + 1);
+		/* Binary encoding; Normal count; non-quadrature mode */
+		outb(0x20, base_offset + 1);
+		/* Disable A and B inputs; preset on index; FLG1 as Carry */
+		outb(0x40, base_offset + 1);
+		/* Disable index function; negative index polarity */
+		outb(0x60, base_offset + 1);
+	}
+	/* Enable all counters */
+	outb(0x00, base[id] + 0x11);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static struct isa_driver quad8_driver = {
+	.probe = quad8_probe,
+	.driver = {
+		.name = "104-quad-8"
+	}
+};
+
+module_isa_driver(quad8_driver, num_quad8);
+
+MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
+MODULE_DESCRIPTION("ACCES 104-QUAD-8 IIO driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
new file mode 100644
index 0000000..0ed8f46
--- /dev/null
+++ b/drivers/iio/counter/Kconfig
@@ -0,0 +1,24 @@
+#
+# Counter devices
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Counters"
+
+config 104_QUAD_8
+	tristate "ACCES 104-QUAD-8 driver"
+	depends on X86 && ISA_BUS_API
+	help
+	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
+	  encoder counter/interface device family (104-QUAD-8, 104-QUAD-4).
+
+	  Performing a write to a counter's IIO_CHAN_INFO_RAW sets the counter and
+	  also clears the counter's respective error flag. Although the counters
+	  have a 25-bit range, only the lower 24 bits may be set, either directly
+	  or via IIO_CHAN_INFO_PRESET. Interrupts are not supported by this
+	  driver.
+
+	  The base port addresses for the devices may be configured via the base
+	  array module parameter.
+
+endmenu
diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
new file mode 100644
index 0000000..007e884
--- /dev/null
+++ b/drivers/iio/counter/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for IIO counter devices
+#
+
+# When adding new entries keep the list in alphabetical order
+
+obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
-- 
2.7.3
