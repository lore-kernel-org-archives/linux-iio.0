Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:55632 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173AbcBPO4F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Feb 2016 09:56:05 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: pressure: ms5611: select IIO_BUFFER
Date: Tue, 16 Feb 2016 15:55:07 +0100
Message-Id: <1455634525-2023774-1-git-send-email-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ms5611 driver started using the IIO_TRIGGERED_BUFFER infrastructure
which in turn depend on IIO_BUFFER, and it produces a build error now
if that is not enabled:

warning: (... && MS5611 && ...) selects IIO_TRIGGERED_BUFFER which has unmet direct dependencies (IIO && IIO_BUFFER)
buffer/industrialio-triggered-buffer.c: In function 'iio_triggered_buffer_setup':
buffer/industrialio-triggered-buffer.c:58:2: error: implicit declaration of function 'iio_device_attach_buffer' [-Werror=implicit-function-declaration]
pressure/ms5611_core.c: In function 'ms5611_trigger_handler':
pressure/ms5611_core.c:193:2: error: implicit declaration of function 'iio_push_to_buffers_with_timestamp' [-Werror=implicit-function-declaration]

This adds the second select.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 713bbb4efb9d ("iio: pressure: ms5611: Add triggered buffer support")
---
 drivers/iio/pressure/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index f15f66d6f527..31c0e1fd2202 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -69,6 +69,7 @@ config MPL3115
 
 config MS5611
 	tristate "Measurement Specialties MS5611 pressure sensor driver"
+	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here to build support for the Measurement Specialties
-- 
2.7.0

