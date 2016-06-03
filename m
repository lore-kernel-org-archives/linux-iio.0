Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36699 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448AbcFCRm5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 13:42:57 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2] iio: stx104: Add GPIO support for the Apex Embedded Systems STX104
Date: Fri,  3 Jun 2016 13:42:42 -0400
Message-Id: <1464975762-24052-1-git-send-email-vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Apex Embedded Systems STX104 device features eight lines of digital
I/O (four digital inputs and four digital outputs). This patch adds GPIO
support for these eight lines of digital I/O via GPIOLIB.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
Changes in v2:
  - Change GPIOLIB Kconfig selection to a dependency for the STX104 Kconfig
    option; STX104 should only be available to systems configured for GPIOLIB

 drivers/iio/dac/Kconfig  |  11 +++--
 drivers/iio/dac/stx104.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 122 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 61d5008..35a3d49 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -246,13 +246,14 @@ config MCP4922
 	  will be called mcp4922.
 
 config STX104
-	tristate "Apex Embedded Systems STX104 DAC driver"
+	tristate "Apex Embedded Systems STX104 driver"
 	depends on ISA
+	depends on GPIOLIB
 	help
-	  Say yes here to build support for the 2-channel DAC on the Apex
-	  Embedded Systems STX104 integrated analog PC/104 card. The base port
-	  addresses for the devices may be configured via the "base" module
-	  parameter array.
+	  Say yes here to build support for the 2-channel DAC and GPIO on the
+	  Apex Embedded Systems STX104 integrated analog PC/104 card. The base
+	  port addresses for the devices may be configured via the base array
+	  module parameter.
 
 config VF610_DAC
 	tristate "Vybrid vf610 DAC driver"
diff --git a/drivers/iio/dac/stx104.c b/drivers/iio/dac/stx104.c
index 174f4b7..dc445cf 100644
--- a/drivers/iio/dac/stx104.c
+++ b/drivers/iio/dac/stx104.c
@@ -14,6 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/gpio/driver.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
 #include <linux/io.h>
@@ -21,6 +22,7 @@
 #include <linux/isa.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/spinlock.h>
 
 #define STX104_NUM_CHAN 2
 
@@ -56,6 +58,20 @@ struct stx104_iio {
 	unsigned base;
 };
 
+/**
+ * struct stx104_gpio - GPIO device private data structure
+ * @chip:	instance of the gpio_chip
+ * @lock:	synchronization lock to prevent I/O race conditions
+ * @base:	base port address of the GPIO device
+ * @out_state:	output bits state
+ */
+struct stx104_gpio {
+	struct gpio_chip chip;
+	spinlock_t lock;
+	unsigned int base;
+	unsigned int out_state;
+};
+
 static int stx104_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
@@ -95,15 +111,74 @@ static const struct iio_chan_spec stx104_channels[STX104_NUM_CHAN] = {
 	STX104_CHAN(1)
 };
 
+static int stx104_gpio_get_direction(struct gpio_chip *chip,
+	unsigned int offset)
+{
+	if (offset < 4)
+		return 1;
+
+	return 0;
+}
+
+static int stx104_gpio_direction_input(struct gpio_chip *chip,
+	unsigned int offset)
+{
+	return 0;
+}
+
+static int stx104_gpio_direction_output(struct gpio_chip *chip,
+	unsigned int offset, int value)
+{
+	return 0;
+}
+
+static int stx104_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
+
+	if (offset >= 4)
+		return -EINVAL;
+
+	return !!(inb(stx104gpio->base) & BIT(offset));
+}
+
+static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
+	int value)
+{
+	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
+	const unsigned int mask = BIT(offset) >> 4;
+	unsigned long flags;
+
+	if (offset < 4)
+		return;
+
+	spin_lock_irqsave(&stx104gpio->lock, flags);
+
+	if (value)
+		stx104gpio->out_state |= mask;
+	else
+		stx104gpio->out_state &= ~mask;
+
+	outb(stx104gpio->out_state, stx104gpio->base);
+
+	spin_unlock_irqrestore(&stx104gpio->lock, flags);
+}
+
 static int stx104_probe(struct device *dev, unsigned int id)
 {
 	struct iio_dev *indio_dev;
 	struct stx104_iio *priv;
+	struct stx104_gpio *stx104gpio;
+	int err;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
 	if (!indio_dev)
 		return -ENOMEM;
 
+	stx104gpio = devm_kzalloc(dev, sizeof(*stx104gpio), GFP_KERNEL);
+	if (!stx104gpio)
+		return -ENOMEM;
+
 	if (!devm_request_region(dev, base[id], STX104_EXTENT,
 		dev_name(dev))) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
@@ -124,14 +199,53 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	outw(0, base[id] + 4);
 	outw(0, base[id] + 6);
 
-	return devm_iio_device_register(dev, indio_dev);
+	err = devm_iio_device_register(dev, indio_dev);
+	if (err) {
+		dev_err(dev, "IIO device registering failed (%d)\n", err);
+		return err;
+	}
+
+	stx104gpio->chip.label = dev_name(dev);
+	stx104gpio->chip.parent = dev;
+	stx104gpio->chip.owner = THIS_MODULE;
+	stx104gpio->chip.base = -1;
+	stx104gpio->chip.ngpio = 8;
+	stx104gpio->chip.get_direction = stx104_gpio_get_direction;
+	stx104gpio->chip.direction_input = stx104_gpio_direction_input;
+	stx104gpio->chip.direction_output = stx104_gpio_direction_output;
+	stx104gpio->chip.get = stx104_gpio_get;
+	stx104gpio->chip.set = stx104_gpio_set;
+	stx104gpio->base = base[id] + 3;
+	stx104gpio->out_state = 0x0;
+
+	spin_lock_init(&stx104gpio->lock);
+
+	dev_set_drvdata(dev, stx104gpio);
+
+	err = gpiochip_add_data(&stx104gpio->chip, stx104gpio);
+	if (err) {
+		dev_err(dev, "GPIO registering failed (%d)\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int stx104_remove(struct device *dev, unsigned int id)
+{
+	struct stx104_gpio *const stx104gpio = dev_get_drvdata(dev);
+
+	gpiochip_remove(&stx104gpio->chip);
+
+	return 0;
 }
 
 static struct isa_driver stx104_driver = {
 	.probe = stx104_probe,
 	.driver = {
 		.name = "stx104"
-	}
+	},
+	.remove = stx104_remove
 };
 
 static void __exit stx104_exit(void)
-- 
2.7.3

