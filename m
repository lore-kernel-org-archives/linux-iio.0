Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-009.synserver.de ([212.40.185.9]:1135 "EHLO
	smtp-out-169.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754623AbcBHRCG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2016 12:02:06 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Marc Andre <marc.andre@netline.ch>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] iio:ad5064: List support LTC devices in Kconfig
Date: Mon,  8 Feb 2016 18:01:48 +0100
Message-Id: <1454950910-26049-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1454950910-26049-1-git-send-email-lars@metafoo.de>
References: <1454950910-26049-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

List the newly support LTC devices in the Kconfig entry for the AD5064
driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 5dc7150..a56b52d 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -11,7 +11,8 @@ config AD5064
 	help
 	  Say yes here to build support for Analog Devices AD5024, AD5025, AD5044,
 	  AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5629R, AD5648, AD5666, AD5668,
-	  AD5669R Digital to Analog Converter.
+	  AD5669R, LTC2606, LTC2607, LTC2609, LTC2616, LTC2617, LTC2619, LTC2626,
+	  LTC2627, LTC2629 Digital to Analog Converter.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5064.
-- 
2.1.4

