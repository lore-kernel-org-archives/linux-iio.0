Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:46585 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbcABNE4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Jan 2016 08:04:56 -0500
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: add HAS_IOMEM dependency to VF610_ADC
Date: Sat,  2 Jan 2016 14:04:40 +0100
Message-Id: <1451739880-14178-2-git-send-email-vegard.nossum@oracle.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Ran into this on UML:

drivers/built-in.o: In function `vf610_adc_probe':
drivers/iio/adc/vf610_adc.c:744: undefined reference to `devm_ioremap_resource'

devm_ioremap_resource() is defined only when HAS_IOMEM is selected.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7868c74..1e7aded 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -372,6 +372,7 @@ config TWL6030_GPADC
 config VF610_ADC
 	tristate "Freescale vf610 ADC driver"
 	depends on OF
+	depends on HAS_IOMEM
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-- 
1.9.1

