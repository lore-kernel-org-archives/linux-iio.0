Return-Path: <bigeasy@linutronix.de>
Date: Wed, 28 Aug 2013 12:31:34 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Cc: jic23@cam.ac.uk, lee.jones@linaro.org, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH] iio: am335x-iio-adc: select triggered buffer
Message-ID: <20130828103134.GA14111@linutronix.de>
References: <1377470724-15710-1-git-send-email-zubair.lutfullah@gmail.com>
 <1377470724-15710-3-git-send-email-zubair.lutfullah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1377470724-15710-3-git-send-email-zubair.lutfullah@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

"triggered buffer" isn't selected so we end up with:
|ERROR: "iio_triggered_buffer_setup" [drivers/iio/adc/ti_am335x_adc.ko] undefined!

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Please merge this into _this_ patch, it is still required.

 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 09371cb..cfa2039 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -167,6 +167,7 @@ config TI_ADC081C
 config TI_AM335X_ADC
 	tristate "TI's AM335X ADC driver"
 	depends on MFD_TI_AM335X_TSCADC
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Texas Instruments ADC
 	  driver which is also a MFD client.
-- 
1.8.4.rc3
