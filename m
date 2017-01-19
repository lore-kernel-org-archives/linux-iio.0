Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34289 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752894AbdASPGI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 10:06:08 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 3/5] gpio: gpio-mm: Add set_multiple callback function support
Date: Thu, 19 Jan 2017 10:05:48 -0500
Message-Id: <a8c5e07542db7c2e9a930b1a9658f74234184365.1484838095.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1484838095.git.vilhelm.gray@gmail.com>
References: <cover.1484838095.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Diamond Systems GPIO-MM series provides registers where 8 lines of
GPIO may be set at a time. This patch add support for the set_multiple
callback function, thus allowing multiple GPIO output lines to be set
more efficiently in groups.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-gpio-mm.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 1e7def9449ce..093489556c54 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -192,6 +192,44 @@ static void gpiomm_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 }
 
+static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
+	unsigned long *mask, unsigned long *bits)
+{
+	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
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
+		spin_lock_irqsave(&gpiommgpio->lock, flags);
+
+		/* update output state data and set device gpio register */
+		gpiommgpio->out_state[port] &= ~mask[BIT_WORD(i)];
+		gpiommgpio->out_state[port] |= bitmask;
+		outb(gpiommgpio->out_state[port], gpiommgpio->base + out_port);
+
+		spin_unlock_irqrestore(&gpiommgpio->lock, flags);
+
+		/* prepare for next gpio register set */
+		mask[BIT_WORD(i)] >>= gpio_reg_size;
+		bits[BIT_WORD(i)] >>= gpio_reg_size;
+	}
+}
+
 static int gpiomm_probe(struct device *dev, unsigned int id)
 {
 	struct gpiomm_gpio *gpiommgpio;
@@ -218,6 +256,7 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 	gpiommgpio->chip.direction_output = gpiomm_gpio_direction_output;
 	gpiommgpio->chip.get = gpiomm_gpio_get;
 	gpiommgpio->chip.set = gpiomm_gpio_set;
+	gpiommgpio->chip.set_multiple = gpiomm_gpio_set_multiple;
 	gpiommgpio->base = base[id];
 
 	spin_lock_init(&gpiommgpio->lock);
-- 
2.11.0

