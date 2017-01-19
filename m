Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34793 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752936AbdASPGI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 10:06:08 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 4/5] gpio: ws16c48: Add set_multiple callback function support
Date: Thu, 19 Jan 2017 10:05:59 -0500
Message-Id: <2b5658acecdc3e8d922ea8e299bd488e6ee18e2d.1484838095.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1484838095.git.vilhelm.gray@gmail.com>
References: <cover.1484838095.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The WinSystems WS16C48 provides registers where 8 lines of GPIO may be
set at a time. This patch add support for the set_multiple callback
function, thus allowing multiple GPIO output lines to be set more
efficiently in groups.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-ws16c48.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index eaa71d440ccf..25e539530c08 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -155,6 +155,46 @@ static void ws16c48_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 }
 
+static void ws16c48_gpio_set_multiple(struct gpio_chip *chip,
+	unsigned long *mask, unsigned long *bits)
+{
+	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
+	unsigned int i;
+	const unsigned int gpio_reg_size = 8;
+	unsigned int port;
+	unsigned int iomask;
+	unsigned int bitmask;
+	unsigned long flags;
+
+	/* set bits are evaluated a gpio register size at a time */
+	for (i = 0; i < chip->ngpio; i += gpio_reg_size) {
+		/* no more set bits in this mask word; skip to the next word */
+		if (!mask[BIT_WORD(i)]) {
+			i = (BIT_WORD(i) + 1) * BITS_PER_LONG - gpio_reg_size;
+			continue;
+		}
+
+		port = i / gpio_reg_size;
+
+		/* mask out GPIO configured for input */
+		iomask = mask[BIT_WORD(i)] & ~ws16c48gpio->io_state[port];
+		bitmask = iomask & bits[BIT_WORD(i)];
+
+		spin_lock_irqsave(&ws16c48gpio->lock, flags);
+
+		/* update output state data and set device gpio register */
+		ws16c48gpio->out_state[port] &= ~iomask;
+		ws16c48gpio->out_state[port] |= bitmask;
+		outb(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
+
+		spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
+
+		/* prepare for next gpio register set */
+		mask[BIT_WORD(i)] >>= gpio_reg_size;
+		bits[BIT_WORD(i)] >>= gpio_reg_size;
+	}
+}
+
 static void ws16c48_irq_ack(struct irq_data *data)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
@@ -329,6 +369,7 @@ static int ws16c48_probe(struct device *dev, unsigned int id)
 	ws16c48gpio->chip.direction_output = ws16c48_gpio_direction_output;
 	ws16c48gpio->chip.get = ws16c48_gpio_get;
 	ws16c48gpio->chip.set = ws16c48_gpio_set;
+	ws16c48gpio->chip.set_multiple = ws16c48_gpio_set_multiple;
 	ws16c48gpio->base = base[id];
 	ws16c48gpio->irq = irq[id];
 
-- 
2.11.0

