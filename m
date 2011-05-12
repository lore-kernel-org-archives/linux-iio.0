Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <jic23@cam.ac.uk>, <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>, <randy.dunlap@oracle.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: adc: ad7780: Add missing GPIOLIB dependency
Date: Thu, 12 May 2011 15:38:24 +0200
Message-ID: <1305207504-6617-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Reported-by: Randy Dunlap <randy.dunlap@oracle.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 4159389..0a19cee 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -145,6 +145,7 @@ config AD7887
 config AD7780
 	tristate "Analog Devices AD7780 AD7781 ADC driver"
 	depends on SPI
+	depends on GPIOLIB
 	help
 	  Say yes here to build support for Analog Devices
 	  AD7780 and AD7781 SPI analog to digital convertors (ADC).
--
1.6.0.2
