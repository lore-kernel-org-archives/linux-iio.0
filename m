Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4752 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751947AbcJEOqy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 5 Oct 2016 10:46:54 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ti-adc081c: Select IIO_TRIGGERED_BUFFER to prevent build errors
Date: Wed,  5 Oct 2016 17:46:50 +0300
Message-Id: <20161005144650.50634-1-mika.westerberg@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit 08e05d1fce5c ("ti-adc081c: Initial triggered buffer support") added
triggered buffer support but that also requires CONFIG_IIO_TRIGGERED_BUFFER,
otherwise we get errors from linker such as:

  drivers/built-in.o: In function `adc081c_remove':
  drivers/iio/adc/ti-adc081c.c:225: undefined reference to `iio_triggered_buffer_cleanup'

Fix these by explicitly selecting both CONFIG_IIO_TRIGGERED_BUFFER and
CONFIG_IIO_BUFFER in Kconfig for the driver.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 767577298ee3..375ba57bdfcd 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -400,6 +400,8 @@ config ROCKCHIP_SARADC
 config TI_ADC081C
 	tristate "Texas Instruments ADC081C/ADC101C/ADC121C family"
 	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for Texas Instruments ADC081C,
 	  ADC101C and ADC121C ADC chips.
-- 
2.9.3

