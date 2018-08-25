Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45539 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbeHYMjN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Aug 2018 08:39:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so5568117pfo.12
        for <linux-iio@vger.kernel.org>; Sat, 25 Aug 2018 02:00:55 -0700 (PDT)
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] Revert "iio: temperature: maxim_thermocouple: add MAX31856 part"
Date: Sat, 25 Aug 2018 02:00:48 -0700
Message-Id: <20180825090048.17438-1-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This reverts commit 535fba29b3e1afef4ba201b3c69a6992583ec0bd.

Seems the submitter (er me, hang head in shame) didn't look at the datasheet
enough to see that the registers are quite different.

This needs to be reverted because a) would never work b) to open it  be added
to a Maxim RTDs (Resistance Temperature Detectors) under development by author

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index 54e383231d1e..c31b9633f32d 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -258,7 +258,6 @@ static int maxim_thermocouple_remove(struct spi_device *spi)
 static const struct spi_device_id maxim_thermocouple_id[] = {
 	{"max6675", MAX6675},
 	{"max31855", MAX31855},
-	{"max31856", MAX31855},
 	{},
 };
 MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
-- 
2.17.1
