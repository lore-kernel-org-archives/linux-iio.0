Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34439 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab3IYThE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2013 15:37:04 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: zubair.lutfullah@gmail.com, lars@metafoo.de,
	fengguang.wu@intel.com, Russ.Dill@ti.com, kbuild-all@01.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio:ti_am335x_adc ensure that IIO_KFIFO_BUF is not selected witout IIO_BUFFER
Date: Wed, 25 Sep 2013 21:37:21 +0100
Message-Id: <1380141441-9133-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This avoids build problems such iio_push_to_buffers* not being defined.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8b88518..2209f28 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -177,6 +177,7 @@ config TI_ADC081C
 config TI_AM335X_ADC
 	tristate "TI's AM335X ADC driver"
 	depends on MFD_TI_AM335X_TSCADC
+	select IIO_BUFFER
 	select IIO_KFIFO_BUF
 	help
 	  Say yes here to build support for Texas Instruments ADC
-- 
1.8.4

