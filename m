Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42749 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377Ab3FWV23 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 23 Jun 2013 17:28:29 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] iio: fix typos in dac Kconfig
Date: Sun, 23 Jun 2013 23:28:16 +0200
Message-Id: <1372022900-18670-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index c9c33ce..b9fd4c7 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -15,7 +15,7 @@ config AD5064
 	  module will be called ad5064.
 
 config AD5360
-	tristate "Analog Devices Analog Devices AD5360/61/62/63/70/71/73 DAC driver"
+	tristate "Analog Devices AD5360/61/62/63/70/71/73 DAC driver"
 	depends on SPI
 	help
 	  Say yes here to build support for Analog Devices AD5360, AD5361,
@@ -68,7 +68,7 @@ config AD5446
 	  module will be called ad5446.
 
 config AD5449
-	tristate "Analog Device AD5449 and similar DACs driver"
+	tristate "Analog Devices AD5449 and similar DACs driver"
 	depends on SPI_MASTER
 	help
 	  Say yes here to build support for Analog Devices AD5415, AD5426, AD5429,
@@ -131,7 +131,7 @@ config AD5686
 	  module will be called ad5686.
 
 config AD7303
-	tristate "Analog Devices Analog Devices AD7303 DAC driver"
+	tristate "Analog Devices AD7303 DAC driver"
 	depends on SPI
 	help
 	  Say yes here to build support for Analog Devices AD7303 Digital to Analog
-- 
1.8.3.1

