Return-Path: <SRS0=J723=E3=it-klinger.de=ak@kernel.org>
Date: Thu, 1 Feb 2018 21:49:24 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: srf08: fix link error "devm_iio_triggered_buffer_setup"
 undefined
Message-ID: <20180201204924.GA26839@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Functions for triggered buffer support are needed by this module.
If they are not defined accidentally by another driver, there's an error
thrown out while linking.

Add a select of IIO_BUFFER and IIO_TRIGGERED_BUFFER in the Kconfig file.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index fcb1c4ba5e41..f726f9427602 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -68,6 +68,8 @@ config SX9500
 
 config SRF08
 	tristate "Devantech SRF02/SRF08/SRF10 ultrasonic ranger sensor"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	depends on I2C
 	help
 	  Say Y here to build a driver for Devantech SRF02/SRF08/SRF10
-- 
2.1.4


-- 
