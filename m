Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:56984 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753AbaGHLGz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Jul 2014 07:06:55 -0400
Message-ID: <53BBD0C7.4050003@gmx.de>
Date: Tue, 08 Jul 2014 13:06:47 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/6] staging:iio:ad7291 remove double define
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove second instance of definition of AD7291_BITS.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 7194bd1..c08b258 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -73,8 +73,6 @@
 #define AD7291_T_VALUE_FLOAT_OFFSET	2
 #define AD7291_T_VALUE_FLOAT_MASK	0x2
 
-#define AD7291_BITS			12
-
 struct ad7291_chip_info {
 	struct i2c_client	*client;
 	struct regulator	*reg;
