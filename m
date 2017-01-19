Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33334 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbdASPGI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 10:06:08 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 2/5] gpio: 104-idio-16: Add set_multiple callback function support
Date: Thu, 19 Jan 2017 10:05:37 -0500
Message-Id: <d8301960672e52f7f157e050f5c8be63810ff34e.1484838095.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1484838095.git.vilhelm.gray@gmail.com>
References: <cover.1484838095.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ACCES 104-IDIO-16 series provides registers where 8 lines of GPIO
may be set at a time. This patch add support for the set_multiple
callback function, thus allowing multiple GPIO output lines to be set
more efficiently in groups.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-104-idio-16.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index 6787b8fcf0d8..a57900fd0dc7 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -116,6 +116,25 @@ static void idio_16_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	spin_unlock_irqrestore(&idio16gpio->lock, flags);
 }
 
+static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
+	unsigned long *mask, unsigned long *bits)
+{
+	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
+	unsigned long flags;
+
+	spin_lock_irqsave(&idio16gpio->lock, flags);
+
+	idio16gpio->out_state &= ~*mask;
+	idio16gpio->out_state |= *mask & *bits;
+
+	if (*mask & 0xFF)
+		outb(idio16gpio->out_state, idio16gpio->base);
+	if ((*mask >> 8) & 0xFF)
+		outb(idio16gpio->out_state >> 8, idio16gpio->base + 4);
+
+	spin_unlock_irqrestore(&idio16gpio->lock, flags);
+}
+
 static void idio_16_irq_ack(struct irq_data *data)
 {
 }
@@ -219,6 +238,7 @@ static int idio_16_probe(struct device *dev, unsigned int id)
 	idio16gpio->chip.direction_output = idio_16_gpio_direction_output;
 	idio16gpio->chip.get = idio_16_gpio_get;
 	idio16gpio->chip.set = idio_16_gpio_set;
+	idio16gpio->chip.set_multiple = idio_16_gpio_set_multiple;
 	idio16gpio->base = base[id];
 	idio16gpio->irq = irq[id];
 	idio16gpio->out_state = 0xFFFF;
-- 
2.11.0

