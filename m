Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:51421 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753845AbdC1KKm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2017 06:10:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: sun4i: add THERMAL dependency
Date: Tue, 28 Mar 2017 12:07:23 +0200
Message-Id: <20170328100855.3982514-1-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

With CONFIG_THERMAL=m and CONFIG_SUN4I_GPADC=y, we get a link error
from calling devm_thermal_zone_of_sensor_register:

drivers/iio/built-in.o: In function `sun4i_gpadc_probe':
:(.text+0x1c284): undefined reference to `devm_thermal_zone_of_sensor_register'

This adds a Kconfig dependency to ensure we can only have the ADC
driver as built-in when this function is also built-in, or when
we see the empty stub implementation. When the thermal code is
a module, we can still build the adc driver as a module, too.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d0af51d7bcac..7ccbad70a617 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -562,6 +562,7 @@ config SUN4I_GPADC
 	tristate "Support for the Allwinner SoCs GPADC"
 	depends on IIO
 	depends on MFD_SUN4I_GPADC
+	depends on THERMAL || !THERMAL_OF
 	help
 	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
 	  GPADC. This ADC provides 4 channels which can be used as an ADC or as
-- 
2.9.0

