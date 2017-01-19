Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33249 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752714AbdASPGH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 10:06:07 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 1/5] gpio: 104-dio-48e: Add set_multiple callback function support
Date: Thu, 19 Jan 2017 10:05:27 -0500
Message-Id: <0f0f83b416aa42968e0cf66f5290a390d5fb2d8b.1484838095.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1484838095.git.vilhelm.gray@gmail.com>
References: <cover.1484838095.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ACCES 104-DIO-48E series provides registers where 8 lines of GPIO
may be set at a time. This patch add support for the set_multiple
callback function, thus allowing multiple GPIO output lines to be set
more efficiently in groups.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-104-dio-48e.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index fcf776971ca9..7bc891f1d11a 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -204,6 +204,44 @@ static void dio48e_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	spin_unlock_irqrestore(&dio48egpio->lock, flags);
 }
 
+static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
+	unsigned long *mask, unsigned long *bits)
+{
+	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
+	unsigned int i;
+	const unsigned int gpio_reg_size = 8;
+	unsigned int port;
+	unsigned int out_port;
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
+		out_port = (port > 2) ? port + 1 : port;
+		bitmask = mask[BIT_WORD(i)] & bits[BIT_WORD(i)];
+
+		spin_lock_irqsave(&dio48egpio->lock, flags);
+
+		/* update output state data and set device gpio register */
+		dio48egpio->out_state[port] &= ~mask[BIT_WORD(i)];
+		dio48egpio->out_state[port] |= bitmask;
+		outb(dio48egpio->out_state[port], dio48egpio->base + out_port);
+
+		spin_unlock_irqrestore(&dio48egpio->lock, flags);
+
+		/* prepare for next gpio register set */
+		mask[BIT_WORD(i)] >>= gpio_reg_size;
+		bits[BIT_WORD(i)] >>= gpio_reg_size;
+	}
+}
+
 static void dio48e_irq_ack(struct irq_data *data)
 {
 }
@@ -328,6 +366,7 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	dio48egpio->chip.direction_output = dio48e_gpio_direction_output;
 	dio48egpio->chip.get = dio48e_gpio_get;
 	dio48egpio->chip.set = dio48e_gpio_set;
+	dio48egpio->chip.set_multiple = dio48e_gpio_set_multiple;
 	dio48egpio->base = base[id];
 	dio48egpio->irq = irq[id];
 
-- 
2.11.0

