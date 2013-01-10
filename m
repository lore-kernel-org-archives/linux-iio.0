Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Fengguang Wu <fengguang.wu@intel.com>
Subject: [PATCH] iio: fix Kconfig for max1363
Date: Thu, 10 Jan 2013 18:29:50 +0100
Message-Id: <1357838990-32503-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <20130110101642.GA18411@localhost>
References: <20130110101642.GA18411@localhost>
List-ID: <linux-iio@vger.kernel.org>

ERROR: "iio_triggered_buffer_setup" [drivers/iio/adc/max1363.ko] undefined!
ERROR: "iio_triggered_buffer_cleanup" [drivers/iio/adc/max1363.ko] undefined!

add select IIO_TRIGGERED_BUFFER

IIO_TRIGGERED_BUFFER in turn selects IIO_TRIGGER and IIO_KFIFO_BUF, so drop those
MAX1363_RING_BUFFER is not used anymore

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Fengguang Wu <fengguang.wu@intel.com>
---
 drivers/iio/adc/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index fe822a1..e372257 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -100,10 +100,8 @@ config LP8788_ADC
 config MAX1363
 	tristate "Maxim max1363 ADC driver"
 	depends on I2C
-	select IIO_TRIGGER
-	select MAX1363_RING_BUFFER
 	select IIO_BUFFER
-	select IIO_KFIFO_BUF
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for many Maxim i2c analog to digital
 	  converters (ADC). (max1361, max1362, max1363, max1364, max1036,
-- 
1.8.0.3
