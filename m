Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:61440 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbaEHO46 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 8 May 2014 10:56:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-iio@vger.kernel.org, Josh Wu <josh.wu@atmel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 2/2] iio:adc: at91 requires the input subsystem
Date: Thu,  8 May 2014 16:56:24 +0200
Message-Id: <1399560990-1402858-13-git-send-email-arnd@arndb.de>
In-Reply-To: <1399560990-1402858-1-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Building the at91 adc driver with CONFIG_INPUT disabled results in this
build error:

ERROR: "input_event" [drivers/iio/adc/at91_adc.ko] undefined!
ERROR: "input_unregister_device" [drivers/iio/adc/at91_adc.ko] undefined!
ERROR: "input_free_device" [drivers/iio/adc/at91_adc.ko] undefined!
ERROR: "input_register_device" [drivers/iio/adc/at91_adc.ko] undefined!
ERROR: "input_set_abs_params" [drivers/iio/adc/at91_adc.ko] undefined!
ERROR: "input_allocate_device" [drivers/iio/adc/at91_adc.ko] undefined!

To make sure we can build random configurations, this turns on CONFIG_INPUT
whenever CONFIG_AT91_ADC is enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-iio@vger.kernel.org
Cc: Josh Wu <josh.wu@atmel.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 90f596d..a80d236 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -110,6 +110,7 @@ config AD799X
 config AT91_ADC
 	tristate "Atmel AT91 ADC"
 	depends on ARCH_AT91
+	depends on INPUT
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select SYSFS
-- 
1.8.3.2

