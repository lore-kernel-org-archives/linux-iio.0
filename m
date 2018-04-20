Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32955 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeDTT2g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Apr 2018 15:28:36 -0400
Date: Fri, 20 Apr 2018 21:28:32 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org, pmeerw@pmeerw.net
Cc: robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: [PATCH v2 01/13] staging: iio: ad2s1200: Remove unneeded include
Message-ID: <08612b1148da933e8ac8ca190250db4c58f6a682.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524247563.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patches removes unneeded slab.h header.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
Changes in v2:
  - Introduced in this version.

drivers/staging/iio/resolver/ad2s1200.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index aa62c64e9bc4..5d7ed0034422 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -13,7 +13,6 @@
 #include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/spi/spi.h>
-#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
-- 
2.16.2

