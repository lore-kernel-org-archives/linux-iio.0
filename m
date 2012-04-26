Return-Path: <rst@work-microwave.de>
From: Roland Stigge <stigge@antcom.de>
To: jic23@cam.ac.uk, gregkh@linuxfoundation.org, michael.hennerich@analog.com,
        rdunlap@xenotime.net, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kevin.wells@nxp.com,
        srinivas.bakki@nxp.com
Cc: Roland Stigge <stigge@antcom.de>
Subject: [PATCH RESEND v5] iio: lpc32xx-adc: Remove driver conflict due to device tree
Date: Thu, 26 Apr 2012 22:10:51 +0200
Message-Id: <1335471051-3648-1-git-send-email-stigge@antcom.de>
List-ID: <linux-iio@vger.kernel.org>

Previously, the touchscreen and ADC drivers of the LPC32xx SoC had a Kconfig
conflict declared because they use the same hardware. Upon the introduction of
device tree support in both drivers, the conflict must be removed to enable
the same kernel to support different hardware (configured via the device tree).

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---

Applies to v3.4-rc4

I separated this patch out from the series of LPC32xx conversion since most of
the other patches are already integrated into the respective subsystem's -next
branches.

 drivers/staging/iio/adc/Kconfig |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- linux-2.6.orig/drivers/staging/iio/adc/Kconfig
+++ linux-2.6/drivers/staging/iio/adc/Kconfig
@@ -195,11 +195,13 @@ config MAX1363_RING_BUFFER
 
 config LPC32XX_ADC
 	tristate "NXP LPC32XX ADC"
-	depends on ARCH_LPC32XX && !TOUCHSCREEN_LPC32XX
+	depends on ARCH_LPC32XX
 	help
 	  Say yes here to build support for the integrated ADC inside the
 	  LPC32XX SoC. Note that this feature uses the same hardware as the
-	  touchscreen driver, so you can only select one of the two drivers
-	  (lpc32xx_adc or lpc32xx_ts). Provides direct access via sysfs.
+	  touchscreen driver, so you should either select only one of the two
+	  drivers (lpc32xx_adc or lpc32xx_ts) or, in the OpenFirmware case,
+	  activate only one via device tree selection.  Provides direct access
+	  via sysfs.
 
 endmenu
