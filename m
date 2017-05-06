Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34326 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdEFB2e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 May 2017 21:28:34 -0400
Received: by mail-pf0-f174.google.com with SMTP id e64so9699988pfd.1
        for <linux-iio@vger.kernel.org>; Fri, 05 May 2017 18:28:34 -0700 (PDT)
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: temperature: maxim_thermocouple: add MAX31856 part
Date: Fri,  5 May 2017 18:28:28 -0700
Message-Id: <20170506012828.22949-1-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

MAX31856 is register equivalent to the MAX31855 but suppports J, N, R,
S, T, E and B type thermocouples in addition to K-type.

Data conversion for the various types happens transparently to the driver
via probe type detection, and a LUT on the sensor.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index 557214202eff..d70e2e53d6a7 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -267,6 +267,7 @@ static int maxim_thermocouple_remove(struct spi_device *spi)
 static const struct spi_device_id maxim_thermocouple_id[] = {
 	{"max6675", MAX6675},
 	{"max31855", MAX31855},
+	{"max31856", MAX31855},
 	{},
 };
 MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
-- 
2.11.0

