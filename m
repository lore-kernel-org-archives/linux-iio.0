Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24051 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbcABNE4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Jan 2016 08:04:56 -0500
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: add IIO_TRIGGER dependency to STK8BA50
Date: Sat,  2 Jan 2016 14:04:39 +0100
Message-Id: <1451739880-14178-1-git-send-email-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Ran into this on UML:

drivers/iio/accel/stk8ba50.c: In function ‘stk8ba50_data_rdy_trigger_set_state’:
drivers/iio/accel/stk8ba50.c:163:9: error: implicit declaration of function ‘iio_trigger_get_drvdata’ [-Werror=implicit-function-declaration]

iio_trigger_get_drvdata() is defined only when IIO_TRIGGER is selected.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/accel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 969428d..16cc5c6 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -173,6 +173,7 @@ config STK8312
 config STK8BA50
 	tristate "Sensortek STK8BA50 3-Axis Accelerometer Driver"
 	depends on I2C
+	depends on IIO_TRIGGER
 	help
 	  Say yes here to get support for the Sensortek STK8BA50 3-axis
 	  accelerometer.
-- 
1.9.1

