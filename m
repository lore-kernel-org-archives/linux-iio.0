Return-Path: <SRS0=vZAf=X5=linux-m68k.org=geert@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Mugunthan V N <mugunthanvnm@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] iio: adc: TI_AM335X_ADC should depend on HAS_DMA
Date: Wed, 14 Dec 2016 13:30:24 +0100
Message-Id: <1481718624-7238-1-git-send-email-geert@linux-m68k.org>
List-ID: <linux-iio@vger.kernel.org>

If NO_DMA=y:

    ERROR: "bad_dma_ops" [drivers/iio/adc/ti_am335x_adc.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 38bc319904c4c299..9c8b558ba19ecb03 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -561,7 +561,7 @@ config TI_ADS8688
 
 config TI_AM335X_ADC
 	tristate "TI's AM335X ADC driver"
-	depends on MFD_TI_AM335X_TSCADC
+	depends on MFD_TI_AM335X_TSCADC && HAS_DMA
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
 	help
-- 
1.9.1
