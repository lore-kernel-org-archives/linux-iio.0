Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37916 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeERSX3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 May 2018 14:23:29 -0400
Date: Fri, 18 May 2018 20:23:25 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 11/12] staging: iio: ad2s1200: Add copyright
Message-ID: <8e02a6b4147ebceee1412ee521b4f4be6886cdaa.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1526667118.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add David Veenstra as a copyright holders and as an author,
for all of the staging clean ups of the ad2s1200 driver.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
Changes in v4:
 - Introduced in this version.

 drivers/staging/iio/resolver/ad2s1200.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 10d6d79dce79..28e618af9939 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -2,6 +2,7 @@
  * ad2s1200.c simple support for the ADI Resolver to Digital Converters:
  * AD2S1200/1205
  *
+ * Copyright (c) 2018-2018 David Veenstra <davidjulianveenstra@gmail.com>
  * Copyright (c) 2010-2010 Analog Devices Inc.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -203,6 +204,7 @@ static struct spi_driver ad2s1200_driver = {
 };
 module_spi_driver(ad2s1200_driver);
 
+MODULE_AUTHOR("David Veenstra <davidjulianveenstra@gmail.com>");
 MODULE_AUTHOR("Graff Yang <graff.yang@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices AD2S1200/1205 Resolver to Digital SPI driver");
 MODULE_LICENSE("GPL v2");
-- 
2.17.0

