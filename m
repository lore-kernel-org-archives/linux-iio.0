Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:44930 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab3JVEtv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Oct 2013 00:49:51 -0400
Message-ID: <526603EB.3060504@infradead.org>
Date: Mon, 21 Oct 2013 21:49:47 -0700
From: Randy Dunlap <rdunlap@infradead.org>
MIME-Version: 1.0
To: Jim Davis <jim.epost@gmail.com>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	Marek Vasut <marex@denx.de>
Subject: [PATCH -next] staging/iio/adc: MXS_LRADC depends on INPUT
References: <CA+r1Zhjo08EEoHsWkeDDKoc8Le6eDq4fZxZaa1Jc8cfOLsLsMg@mail.gmail.com>
In-Reply-To: <CA+r1Zhjo08EEoHsWkeDDKoc8Le6eDq4fZxZaa1Jc8cfOLsLsMg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

mxs-lradc.c uses many input_() functions so it should
depend on INPUT to fix build errors.

drivers/built-in.o: In function `mxs_lradc_ts_unregister':
drivers/staging/iio/adc/mxs-lradc.c:905: undefined reference to `input_unregister_device'
drivers/staging/iio/adc/mxs-lradc.c:905: undefined reference to `input_unregister_device'
drivers/built-in.o: In function `input_report_abs':
include/linux/input.h:399: undefined reference to `input_event'
include/linux/input.h:399: undefined reference to `input_event'
include/linux/input.h:399: undefined reference to `input_event'
drivers/built-in.o: In function `input_report_key':
include/linux/input.h:389: undefined reference to `input_event'
drivers/built-in.o: In function `input_sync':
include/linux/input.h:414: undefined reference to `input_event'
drivers/built-in.o:include/linux/input.h:389: more undefined references to `input_event' follow

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/staging/iio/adc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- next-2013-1021.orig/drivers/staging/iio/adc/Kconfig
+++ next-2013-1021/drivers/staging/iio/adc/Kconfig
@@ -114,6 +114,7 @@ config LPC32XX_ADC
 config MXS_LRADC
 	tristate "Freescale i.MX23/i.MX28 LRADC"
 	depends on ARCH_MXS || COMPILE_TEST
+	depends on INPUT
 	select STMP_DEVICE
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
