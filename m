Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-045.synserver.de ([212.40.185.45]:1179 "EHLO
	smtp-out-045.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab3JLNyF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 09:54:05 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Marek Vasut <marex@denx.de>
Subject: [PATCH v2 2/3] staging:iio:mxs-lradc: Select STMP_DEVICE
Date: Sat, 12 Oct 2013 15:55:58 +0200
Message-Id: <1381586159-31120-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1381586159-31120-1-git-send-email-lars@metafoo.de>
References: <1381586159-31120-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The MXS ADC driver uses the stmp_reset_block() which is only provided when the
STMP_DEVICE Kconfig symbol is selected. Hence the driver should select this
symbol. So far this has not been a problem since the driver depends on ARCH_MXS,
which already selects STMP_DEVICE, but will become necessary once we allow the
driver to be built when COMPILE_TEST is selected.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>
---
New in v2
---
 drivers/staging/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index cabc7a3..52d92a1 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -114,6 +114,7 @@ config LPC32XX_ADC
 config MXS_LRADC
 	tristate "Freescale i.MX23/i.MX28 LRADC"
 	depends on ARCH_MXS
+	select STMP_DEVICE
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-- 
1.8.0

