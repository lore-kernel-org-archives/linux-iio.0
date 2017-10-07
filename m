Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:42025 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752812AbdJGXxW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Oct 2017 19:53:22 -0400
To: LKML <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Cc: Jack Andersen <jackoalan@gmail.com>,
        kbuild test robot <fengguang.wu@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] iio: adc: dln2-adc: fix build error
Message-ID: <af332f59-daae-1140-cb89-ebc179b0d2f4@infradead.org>
Date: Sat, 7 Oct 2017 16:53:20 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

The dln2-adc driver uses interface(s) that are controlled by the
IIO_TRIGGERED_BUFFER Kconfig symbol, so the driver needs to select
that symbol to prevent the build error.

drivers/iio/adc/dln2-adc.o: In function `dln2_adc_probe':
dln2-adc.c:(.text+0x528): undefined reference to `devm_iio_triggered_buffer_setup'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: Jack Andersen <jackoalan@gmail.com>
---
 drivers/iio/adc/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- lnx-414-rc3.orig/drivers/iio/adc/Kconfig
+++ lnx-414-rc3/drivers/iio/adc/Kconfig
@@ -243,6 +243,8 @@ config DA9150_GPADC
 config DLN2_ADC
 	tristate "Diolan DLN-2 ADC driver support"
 	depends on MFD_DLN2
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Diolan DLN-2 ADC.
 


