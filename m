Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33685 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdAaVGO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2017 16:06:14 -0500
Date: Tue, 31 Jan 2017 16:06:01 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8
Message-ID: <20170131210601.GA8301@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The LSI/CSI LS7266R1 chip provides programmable output via the FLG pins.
When interrupts are enabled on the ACCES 104-QUAD-8, they occur whenever
FLG1 is active. Four functions are available for the FLG1 signal:
/Carry, /Compare, /Carry/Borrow, and Index.

	/Carry:
		Interrupt generated on active low Carry signal. Carry
		signal toggles every time the respective channel's
		counter overflows.

	/Compare:
		Interrupt generated on active low Compare signal.
		Compare signal toggles every time respective channel's
		preset register is equal to the respective channel's
		counter.

	/Carry/Borrow:
		Interrupt generated on active low Carry signal and
		active low Borrow signal. Carry signal toggles every
		time the respective channel's counter overflows. Borrow
		signal toggles every time the respective channel's
		counter underflows.

	Index:
		Interrupt generated on active high Index signal.

The irq_trig_func sysfs attribute is introduced to allow the selection
of the desired IRQ trigger function per channel. Interrupts push events
via the thresh_en event sysfs attribute.

This patch adds IRQ support for the ACCES 104-QUAD-8. The interrupt line
numbers for the devices may be configured via the irq array module
parameter.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
Changes in v2:
  - Rebased to merge in bug fix updates to 104-quad-8.c
  - Changed mag_en to thresh_en to match nature of attribute
  - Updated kernel version number in documentation for new attributes

I apologize for the delay in response to the original patch submission;
for some reason my mail server never received Jonathan's original reply.

Jonathan, have you given some thought about how events should be
supported in this case? I agree that the interface right now is very
device specific, so it would be very nice get it more general for the
benefit of future drivers. Let me know what you have planned and I can
make changes accordingly.

I went ahead and changed the mag_en attribute to a thresh_en (direction
left as IIO_EV_DIR_NONE). Would it be better to have direction set to
IIO_EV_DIR_EITHER for this attribute? As you could tell, the direction
of the event depends on the configuration chosen (/Carry, /Compare,
/Carry/Borrow, or Index).

By the way, the forward slashes in front of the FLG1 signal function
names are suppose to represent inversion bars on top of the signal names
(in order to point out that the signals are active low). I can remove
those forward slashes from the documentation if they are confusing.

William Breathitt Gray

 .../ABI/testing/sysfs-bus-iio-counter-104-quad-8   |  37 +++++-
 drivers/iio/counter/104-quad-8.c                   | 129 ++++++++++++++++++++-
 drivers/iio/counter/Kconfig                        |   6 +-
 3 files changed, 163 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
index ba676520b953..7d4599ae253b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
+++ b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
@@ -51,6 +51,31 @@ Description:
 			not freeze at the bundary points, but counts
 			continuously throughout.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_countY_irq_trig_func
+KernelVersion:	4.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		IRQ trigger function for channel Y. Four IRQ trigger functions
+		are available: /Carry, /Compare, /Carry/Borrow, and Index.
+
+		/Carry:
+			Interrupt generated on active low Carry signal. Carry
+			signal toggles every time channel Y counter overflows.
+
+		/Compare:
+			Interrupt generated on active low Compare signal.
+			Compare signal toggles every time channel Y preset
+			register is equal to channel Y counter.
+
+		/Carry/Borrow:
+			Interrupt generated on active low Carry signal and
+			active low Borrow signal. Carry signal toggles every
+			time channel Y counter overflows. Borrow signal toggles
+			every time channel Y counter underflows.
+
+		Index:
+			Interrupt generated on active high Index signal.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_countY_noise_error
 KernelVersion:	4.9
 Contact:	linux-iio@vger.kernel.org
@@ -93,7 +118,17 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Whether to set channel Y counter with channel Y preset value
 		when channel Y index input is active, or continuously count.
-		Valid attribute values are boolean.
+		Valid attribute values are boolean. This attribute is ignored
+		when channel Y IRQs are disabled.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_countY_thresh_en
+KernelVersion:	4.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Event generated when a channel Y IRQ occurs. Channel Y IRQs are
+		triggered as configured by the channel Y irq_trig_func
+		attribute. Channel Y IRQs are disabled when this attribute is
+		set to 0.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_index_polarity
 KernelVersion:	4.9
diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
index a5913e97945e..ccfd952b8fd9 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -16,10 +16,12 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/interrupt.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -33,6 +35,10 @@ static unsigned int num_quad8;
 module_param_array(base, uint, &num_quad8, 0);
 MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
 
+static unsigned int irq[max_num_isa_dev(QUAD8_EXTENT)];
+module_param_array(irq, uint, NULL, 0000);
+MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 interrupt line numbers");
+
 #define QUAD8_NUM_COUNTERS 8
 
 /**
@@ -43,6 +49,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
  * @quadrature_scale:	array of quadrature mode scale configurations
  * @ab_enable:		array of A and B inputs enable configurations
  * @preset_enable:	array of set_to_preset_on_index attribute configurations
+ * @irq_trig_func:	array of IRQ trigger function attribute configurations
  * @synchronous_mode:	array of index function synchronous mode configurations
  * @index_polarity:	array of index function polarity configurations
  * @base:		base port address of the IIO device
@@ -54,6 +61,7 @@ struct quad8_iio {
 	unsigned int quadrature_scale[QUAD8_NUM_COUNTERS];
 	unsigned int ab_enable[QUAD8_NUM_COUNTERS];
 	unsigned int preset_enable[QUAD8_NUM_COUNTERS];
+	unsigned int irq_trig_func[QUAD8_NUM_COUNTERS];
 	unsigned int synchronous_mode[QUAD8_NUM_COUNTERS];
 	unsigned int index_polarity[QUAD8_NUM_COUNTERS];
 	unsigned int base;
@@ -150,7 +158,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 
 		priv->ab_enable[chan->channel] = val;
 
-		ior_cfg = val | priv->preset_enable[chan->channel] << 1;
+		ior_cfg = val | priv->preset_enable[chan->channel] << 1 |
+			priv->irq_trig_func[chan->channel] << 3;
 
 		/* Load I/O control configuration */
 		outb(0x40 | ior_cfg, base_offset + 1);
@@ -184,10 +193,39 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int quad8_read_event_config(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+	const unsigned int irq_enabled = inb(priv->base + 0x12);
+
+	return !!(irq_enabled & BIT(chan->channel));
+}
+
+static int quad8_write_event_config(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, int state)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+	unsigned int irq_enabled = inb(priv->base + 0x12);
+
+	if (state)
+		irq_enabled |= BIT(chan->channel);
+	else
+		irq_enabled &= ~BIT(chan->channel);
+
+	outb(irq_enabled, priv->base + 0x12);
+
+	return 0;
+}
+
 static const struct iio_info quad8_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = quad8_read_raw,
-	.write_raw = quad8_write_raw
+	.write_raw = quad8_write_raw,
+	.read_event_config = quad8_read_event_config,
+	.write_event_config = quad8_write_event_config
 };
 
 static ssize_t quad8_read_preset(struct iio_dev *indio_dev, uintptr_t private,
@@ -256,7 +294,8 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
 	priv->preset_enable[chan->channel] = preset_enable;
 
 	ior_cfg = priv->ab_enable[chan->channel] |
-		(unsigned int)preset_enable << 1;
+		(unsigned int)preset_enable << 1 |
+		priv->irq_trig_func[chan->channel] << 3;
 
 	/* Load I/O control configuration to Input / Output Control Register */
 	outb(0x40 | ior_cfg, base_offset);
@@ -264,6 +303,44 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
 	return len;
 }
 
+static const char *const quad8_irq_trig_func_modes[] = {
+	"/Carry",
+	"/Compare",
+	"/Carry/Borrow",
+	"Index"
+};
+
+static int quad8_set_irq_trig_func(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned int irq_trig_func)
+{
+	struct quad8_iio *const priv = iio_priv(indio_dev);
+	const unsigned int ior_cfg = priv->ab_enable[chan->channel] |
+		priv->preset_enable[chan->channel] << 1 | irq_trig_func << 3;
+	const int base_offset = priv->base + 2 * chan->channel + 1;
+
+	priv->irq_trig_func[chan->channel] = irq_trig_func;
+
+	/* Load I/O control configuration to Input/Output Control Register */
+	outb(0x40 | ior_cfg, base_offset);
+
+	return 0;
+}
+
+static int quad8_get_irq_trig_func(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+
+	return priv->irq_trig_func[chan->channel];
+}
+
+static const struct iio_enum quad8_irq_trig_func_enum = {
+	.items = quad8_irq_trig_func_modes,
+	.num_items = ARRAY_SIZE(quad8_irq_trig_func_modes),
+	.set = quad8_set_irq_trig_func,
+	.get = quad8_get_irq_trig_func
+};
+
 static const char *const quad8_noise_error_states[] = {
 	"No excessive noise is present at the count inputs",
 	"Excessive noise is present at the count inputs"
@@ -480,6 +557,8 @@ static const struct iio_chan_spec_ext_info quad8_count_ext_info[] = {
 		.read = quad8_read_set_to_preset_on_index,
 		.write = quad8_write_set_to_preset_on_index
 	},
+	IIO_ENUM("irq_trig_func", IIO_SEPARATE, &quad8_irq_trig_func_enum),
+	IIO_ENUM_AVAILABLE("irq_trig_func", &quad8_irq_trig_func_enum),
 	IIO_ENUM("noise_error", IIO_SEPARATE, &quad8_noise_error_enum),
 	IIO_ENUM_AVAILABLE("noise_error", &quad8_noise_error_enum),
 	IIO_ENUM("count_direction", IIO_SEPARATE, &quad8_count_direction_enum),
@@ -500,12 +579,22 @@ static const struct iio_chan_spec_ext_info quad8_index_ext_info[] = {
 	{}
 };
 
+static const struct iio_event_spec quad8_event[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_NONE,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE)
+	}
+};
+
 #define QUAD8_COUNT_CHAN(_chan) {					\
 	.type = IIO_COUNT,						\
 	.channel = (_chan),						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 		BIT(IIO_CHAN_INFO_ENABLE) | BIT(IIO_CHAN_INFO_SCALE),	\
 	.ext_info = quad8_count_ext_info,				\
+	.event_spec = quad8_event,					\
+	.num_event_specs = ARRAY_SIZE(quad8_event),			\
 	.indexed = 1							\
 }
 
@@ -528,12 +617,35 @@ static const struct iio_chan_spec quad8_channels[] = {
 	QUAD8_COUNT_CHAN(7), QUAD8_INDEX_CHAN(7)
 };
 
+static irqreturn_t quad8_irq_handler(int irq, void *indio_dev)
+{
+	const struct quad8_iio *const priv = iio_priv(indio_dev);
+	unsigned long irq_status;
+	unsigned long channel;
+
+	irq_status = inb(priv->base + 0x10);
+	if (!irq_status)
+		return IRQ_NONE;
+
+	for_each_set_bit(channel, &irq_status, QUAD8_NUM_COUNTERS)
+		iio_push_event(indio_dev,
+			IIO_UNMOD_EVENT_CODE(IIO_COUNT, channel,
+				IIO_EV_TYPE_THRESH, IIO_EV_DIR_NONE),
+			iio_get_time_ns(indio_dev));
+
+	/* Clear pending interrupts on device */
+	outb(0x10, priv->base + 0x11);
+
+	return IRQ_HANDLED;
+}
+
 static int quad8_probe(struct device *dev, unsigned int id)
 {
 	struct iio_dev *indio_dev;
 	struct quad8_iio *priv;
 	int i, j;
 	unsigned int base_offset;
+	int err;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
 	if (!indio_dev)
@@ -555,6 +667,8 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	priv = iio_priv(indio_dev);
 	priv->base = base[id];
 
+	/* Reset Index/Interrupt Register */
+	outb(0x00, base[id] + 0x12);
 	/* Reset all counters and disable interrupt function */
 	outb(0x01, base[id] + 0x11);
 	/* Set initial configuration for all counters */
@@ -576,8 +690,13 @@ static int quad8_probe(struct device *dev, unsigned int id)
 		/* Disable index function; negative index polarity */
 		outb(0x60, base_offset + 1);
 	}
-	/* Enable all counters */
-	outb(0x00, base[id] + 0x11);
+	/* Enable all counters and enable interrupt function */
+	outb(0x10, base[id] + 0x11);
+
+	err = devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
+		dev_name(dev), indio_dev);
+	if (err)
+		return err;
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
index 44627f6e4861..2cea823126fe 100644
--- a/drivers/iio/counter/Kconfig
+++ b/drivers/iio/counter/Kconfig
@@ -15,10 +15,10 @@ config 104_QUAD_8
 	  Performing a write to a counter's IIO_CHAN_INFO_RAW sets the counter and
 	  also clears the counter's respective error flag. Although the counters
 	  have a 25-bit range, only the lower 24 bits may be set, either directly
-	  or via a counter's preset attribute. Interrupts are not supported by
-	  this driver.
+	  or via a counter's preset attribute.
 
 	  The base port addresses for the devices may be configured via the base
-	  array module parameter.
+	  array module parameter. The interrupt line numbers for the devices may
+	  be configured via the irq array module parameter.
 
 endmenu
-- 
2.11.0

