Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:58303 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbaEILob (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 9 May 2014 07:44:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-iio@vger.kernel.org,
	Josh Wu <josh.wu@atmel.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 2/2] iio:adc: at91 requires the input subsystem
Date: Fri, 09 May 2014 13:43:57 +0200
Message-ID: <4163305.otOGv8yVK1@wuerfel>
In-Reply-To: <536CA78C.5070603@atmel.com>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de> <1399560990-1402858-13-git-send-email-arnd@arndb.de> <536CA78C.5070603@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Friday 09 May 2014 12:01:48 Nicolas Ferre wrote:
> On 08/05/2014 16:56, Arnd Bergmann :
> > Building the at91 adc driver with CONFIG_INPUT disabled results in this
> > build error:
> > 
> > ERROR: "input_event" [drivers/iio/adc/at91_adc.ko] undefined!
> > ERROR: "input_unregister_device" [drivers/iio/adc/at91_adc.ko] undefined!
> > ERROR: "input_free_device" [drivers/iio/adc/at91_adc.ko] undefined!
> > ERROR: "input_register_device" [drivers/iio/adc/at91_adc.ko] undefined!
> > ERROR: "input_set_abs_params" [drivers/iio/adc/at91_adc.ko] undefined!
> > ERROR: "input_allocate_device" [drivers/iio/adc/at91_adc.ko] undefined!
> > 
> > To make sure we can build random configurations, this turns on CONFIG_INPUT
> > whenever CONFIG_AT91_ADC is enabled.
> 
> Isn't it a "select" instead of "depends" that is required then?

It seems I fixed the patch at some point but didn't update the message.

In general, we should not mix 'depends on' and 'select' for the same symbol,
since that causes extra confusion.

In case of CONFIG_INPUT, almost all the users do 'depends on INPUT', with
a few exceptions that seem to be done in error.
Updated patch below.

	Arnd

8<----

>From 4679d63b24a681d9c6afcfdde266bae0f940e90b Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 9 Apr 2014 17:18:10 +0200
Subject: [PATCH] [SUBMITTED] iio:adc: at91 requires the input subsystem

Building the at91 adc driver with CONFIG_INPUT disabled results in this
build error:

ERROR: "input_event" [drivers/iio/adc/at91_adc.ko] undefined!
ERROR: "input_unregister_device" [drivers/iio/adc/at91_adc.ko] undefined!
ERROR: "input_free_device" [drivers/iio/adc/at91_adc.ko] undefined!
ERROR: "input_register_device" [drivers/iio/adc/at91_adc.ko] undefined!
ERROR: "input_set_abs_params" [drivers/iio/adc/at91_adc.ko] undefined!
ERROR: "input_allocate_device" [drivers/iio/adc/at91_adc.ko] undefined!

To make sure we can build random configurations, this adds a Kconfig
dependency on CONFIG_INPUT, as we do for other similar drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-iio@vger.kernel.org
Cc: Josh Wu <josh.wu@atmel.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>

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

