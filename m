Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36413 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752714AbdASPPj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 10:15:39 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 5/5] iio: stx104: Add GPIO set_multiple callback function support
Date: Thu, 19 Jan 2017 10:06:16 -0500
Message-Id: <53039e49d1421a6f070c691988eb22ef0987eba4.1484838095.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1484838095.git.vilhelm.gray@gmail.com>
References: <cover.1484838095.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Apex Embedded Systems STX104 series provides a digital output
register where 4 lines may be set at a time. This patch add support for
the set_multiple callback function, thus allowing multiple digital
output lines to be set more efficiently in groups.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/adc/stx104.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 7e3645749eaf..6971293909f7 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -266,6 +266,28 @@ static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	spin_unlock_irqrestore(&stx104gpio->lock, flags);
 }
 
+static void stx104_gpio_set_multiple(struct gpio_chip *chip,
+	unsigned long *mask, unsigned long *bits)
+{
+	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
+	unsigned long flags;
+
+	/* verify masked GPIO are output */
+	if (!(*mask & 0xF0))
+		return;
+
+	*mask >>= 4;
+	*bits >>= 4;
+
+	spin_lock_irqsave(&stx104gpio->lock, flags);
+
+	stx104gpio->out_state &= ~*mask;
+	stx104gpio->out_state |= *mask & *bits;
+	outb(stx104gpio->out_state, stx104gpio->base);
+
+	spin_unlock_irqrestore(&stx104gpio->lock, flags);
+}
+
 static int stx104_probe(struct device *dev, unsigned int id)
 {
 	struct iio_dev *indio_dev;
@@ -330,6 +352,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	stx104gpio->chip.direction_output = stx104_gpio_direction_output;
 	stx104gpio->chip.get = stx104_gpio_get;
 	stx104gpio->chip.set = stx104_gpio_set;
+	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
 	stx104gpio->base = base[id] + 3;
 	stx104gpio->out_state = 0x0;
 
-- 
2.11.0

