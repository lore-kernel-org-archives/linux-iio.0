Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:33827 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbbD3NQP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2015 09:16:15 -0400
Received: by laat2 with SMTP id t2so43927998laa.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2015 06:16:14 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 02/10] iio: st_sensors: make interrupt optional
Date: Thu, 30 Apr 2015 15:15:47 +0200
Message-Id: <1430399755-26475-2-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some sensors such as magnetometers and pressure sensors doesn't
have interrupts at all, and thus no DRDY setting applies. Make
the assignment of an interrupt optional, and do not call
st_sensors_set_drdy_int_pin() if there is no drdy (data ready)
pin specified.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index edd13d2b4121..5a01093b29a2 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -245,6 +245,16 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
+	/* Sensor does not support interrupts */
+	if (sdata->sensor_settings->drdy_irq.addr == 0) {
+		if (pdata->drdy_int_pin)
+			dev_info(&indio_dev->dev,
+				 "DRDY on pin INT%d specified, but sensor "
+				 "does not support interrupts\n",
+				 pdata->drdy_int_pin);
+		return 0;
+	}
+
 	switch (pdata->drdy_int_pin) {
 	case 1:
 		if (sdata->sensor_settings->drdy_irq.mask_int1 == 0) {
@@ -285,7 +295,7 @@ static struct st_sensors_platform_data *st_sensors_of_probe(struct device *dev,
 	if (!of_property_read_u32(np, "st,drdy-int-pin", &val) && (val <= 2))
 		pdata->drdy_int_pin = (u8) val;
 	else
-		pdata->drdy_int_pin = defdata ? defdata->drdy_int_pin : 1;
+		pdata->drdy_int_pin = defdata ? defdata->drdy_int_pin : 0;
 
 	return pdata;
 }
-- 
1.9.3

