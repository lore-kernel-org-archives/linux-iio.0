Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36251 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933191AbbLOP02 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Dec 2015 10:26:28 -0500
Received: by mail-wm0-f54.google.com with SMTP id n186so170152358wmn.1
        for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2015 07:26:28 -0800 (PST)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Titinger <mtitinger@baylibre.com>
Subject: [PATCH] iio: ina2xx: fix channel order in software buffer
Date: Tue, 15 Dec 2015 16:26:22 +0100
Message-Id: <1450193182-18179-1-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <566C5613.3040101@kernel.org>
References: <566C5613.3040101@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

POWER and CURRENT were swapped out in the buffer:
was current2 and power3, correct order is power2 and current3.

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>

---

Hi Jon,

we just found this while testing with the buffered mode.
My apologies for missing this bug ealier.

Cheers,
Marc.

---

 drivers/iio/adc/ina2xx-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 98939ba..91e1f2b 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -427,8 +427,8 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
 static const struct iio_chan_spec ina2xx_channels[] = {
 	INA2XX_CHAN_VOLTAGE(0, INA2XX_SHUNT_VOLTAGE),
 	INA2XX_CHAN_VOLTAGE(1, INA2XX_BUS_VOLTAGE),
-	INA2XX_CHAN(IIO_CURRENT, 2, INA2XX_CURRENT),
-	INA2XX_CHAN(IIO_POWER, 3, INA2XX_POWER),
+	INA2XX_CHAN(IIO_POWER, 2, INA2XX_POWER),
+	INA2XX_CHAN(IIO_CURRENT, 3, INA2XX_CURRENT),
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
-- 
1.9.1

