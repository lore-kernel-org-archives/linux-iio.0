Return-Path: <mika.westerberg@linux.intel.com>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] iio: humidity: am2315: Select IIO_TRIGGERED_BUFFER to prevent build errors
Date: Thu, 18 Aug 2016 17:05:18 +0300
Message-Id: <1471529118-81255-1-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Commit 0d96d5ead3f7 ("iio: humidity: Add triggered buffer support for
AM2315") added support for triggered buffers but those are only available
when IIO_TRIGGERED_BUFFER is selected. Currently we get warnings like:

  drivers/iio/humidity/am2315.c: In function ‘am2315_trigger_handler’:
  drivers/iio/humidity/am2315.c:186:2: error: implicit declaration of function
    ‘iio_push_to_buffers_with_timestamp’ [-Werror=implicit-function-declaration]
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: some warnings being treated as errors
  scripts/Makefile.build:289: recipe for target 'drivers/iio/humidity/am2315.o' failed

Furthermore linking the kernel executable fails because triggered buffer
functions are never build.

Fix this by selecting IIO_TRIGGERED_BUFFER and IIO_BUFFER when the driver is
enabled.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/iio/humidity/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 738a86d9e4a9..d04124345992 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -6,6 +6,8 @@ menu "Humidity sensors"
 config AM2315
     tristate "Aosong AM2315 relative humidity and temperature sensor"
     depends on I2C
+    select IIO_BUFFER
+    select IIO_TRIGGERED_BUFFER
     help
       If you say yes here you get support for the Aosong AM2315
       relative humidity and ambient temperature sensor.
-- 
2.8.1
