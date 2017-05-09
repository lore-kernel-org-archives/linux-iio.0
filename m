Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:39974 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752850AbdEIH6V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 May 2017 03:58:21 -0400
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH] iio: adc: max9611: Fix attribute measure unit
Date: Tue,  9 May 2017 09:57:57 +0200
Message-Id: <1494316677-26324-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The power and current "shunt-resistor" attribute's 'show' function
displays the resistor value in milli-Ohms, while the ABI description
specifies it should be displayed in Ohms. Fix it.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/iio/adc/max9611.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index ec82106..4580ebd 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -438,10 +438,10 @@ static ssize_t max9611_shunt_resistor_show(struct device *dev,
 	struct max9611_dev *max9611 = iio_priv(dev_to_iio_dev(dev));
 	unsigned int i, r;
 
-	i = max9611->shunt_resistor_uohm / 1000;
-	r = max9611->shunt_resistor_uohm % 1000;
+	i = max9611->shunt_resistor_uohm / 1000000;
+	r = max9611->shunt_resistor_uohm % 1000000;
 
-	return sprintf(buf, "%u.%03u\n", i, r);
+	return sprintf(buf, "%u.%06u\n", i, r);
 }
 
 static IIO_DEVICE_ATTR(in_power_shunt_resistor, 0444,
-- 
2.7.4

