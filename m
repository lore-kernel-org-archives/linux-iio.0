Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33670 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932435AbdAJSvO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2017 13:51:14 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, gnurou@gmail.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 2/3] gpio: pc104: Mask PC/104 drivers via PC104 Kconfig option
Date: Tue, 10 Jan 2017 13:51:06 -0500
Message-Id: <d45bf9e0428c7885e37f157f9fe222f82594b87c.1484073325.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1484073324.git.vilhelm.gray@gmail.com>
References: <cover.1484073324.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

PC/104 drivers should be hidden on machines which do not support PC/104
devices. This patch adds the PC104 Kconfig option as a dependency for
the relevant PC/104 device driver Kconfig options.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d5d36549ecc1..ad7084d98c60 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -539,7 +539,7 @@ menu "Port-mapped I/O GPIO drivers"
 
 config GPIO_104_DIO_48E
 	tristate "ACCES 104-DIO-48E GPIO support"
-	depends on ISA_BUS_API
+	depends on PC104 && ISA_BUS_API
 	select GPIOLIB_IRQCHIP
 	help
 	  Enables GPIO support for the ACCES 104-DIO-48E series (104-DIO-48E,
@@ -549,7 +549,7 @@ config GPIO_104_DIO_48E
 
 config GPIO_104_IDIO_16
 	tristate "ACCES 104-IDIO-16 GPIO support"
-	depends on ISA_BUS_API
+	depends on PC104 && ISA_BUS_API
 	select GPIOLIB_IRQCHIP
 	help
 	  Enables GPIO support for the ACCES 104-IDIO-16 family (104-IDIO-16,
@@ -560,7 +560,7 @@ config GPIO_104_IDIO_16
 
 config GPIO_104_IDI_48
 	tristate "ACCES 104-IDI-48 GPIO support"
-	depends on ISA_BUS_API
+	depends on PC104 && ISA_BUS_API
 	select GPIOLIB_IRQCHIP
 	help
 	  Enables GPIO support for the ACCES 104-IDI-48 family (104-IDI-48A,
@@ -580,7 +580,7 @@ config GPIO_F7188X
 
 config GPIO_GPIO_MM
 	tristate "Diamond Systems GPIO-MM GPIO support"
-	depends on ISA_BUS_API
+	depends on PC104 && ISA_BUS_API
 	help
 	  Enables GPIO support for the Diamond Systems GPIO-MM and GPIO-MM-12.
 
-- 
2.11.0

