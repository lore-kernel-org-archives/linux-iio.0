Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:55289
	"EHLO VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755202Ab1ELLq7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 May 2011 07:46:59 -0400
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>,
	<randy.dunlap@oracle.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: adc: ad7780: Add missing GPIOLIB dependency
Date: Thu, 12 May 2011 13:36:00 +0200
Message-ID: <1305200160-2217-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Reported-by: Randy Dunlap <randy.dunlap@oracle.com>
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


