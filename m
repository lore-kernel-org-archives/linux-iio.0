Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34150 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbdA3RQw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 12:16:52 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] iio: stx104: Add support for GPIO names
Date: Mon, 30 Jan 2017 12:16:04 -0500
Message-Id: <20170130171604.11266-1-vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch sets the gpio_chip names option with an array of GPIO line
names that match the manual documentation for the Apex Embedded Systems
STX104. This should make it easier for users to identify which GPIO line
corresponds to a respective GPIO pin on the device.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/adc/stx104.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index c56ff286695d..04b94fcd5acf 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -266,6 +266,11 @@ static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	spin_unlock_irqrestore(&stx104gpio->lock, flags);
 }
 
+#define STX104_NGPIO 8
+static const char *stx104_names[STX104_NGPIO] = {
+	"DIN0", "DIN1", "DIN2", "DIN3", "DOUT0", "DOUT1", "DOUT2", "DOUT3"
+};
+
 static int stx104_probe(struct device *dev, unsigned int id)
 {
 	struct iio_dev *indio_dev;
@@ -324,7 +329,8 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	stx104gpio->chip.parent = dev;
 	stx104gpio->chip.owner = THIS_MODULE;
 	stx104gpio->chip.base = -1;
-	stx104gpio->chip.ngpio = 8;
+	stx104gpio->chip.ngpio = STX104_NGPIO;
+	stx104gpio->chip.names = stx104_names;
 	stx104gpio->chip.get_direction = stx104_gpio_get_direction;
 	stx104gpio->chip.direction_input = stx104_gpio_direction_input;
 	stx104gpio->chip.direction_output = stx104_gpio_direction_output;
-- 
2.11.0

