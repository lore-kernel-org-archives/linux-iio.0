Return-Path: <SRS0=JNQY=FO=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Tue, 20 Feb 2018 10:28:04 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: daniel.baluta@nxp.com, kernel-janitors@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio:dummy: Fix coding style in Kconfig
Message-ID: <20180220132804.fnlsi6ag6h5rrqya@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the checkpatch.pl warning:

drivers/iio/dummy/Kconfig:21: WARNING: please write a paragraph that
describes the config symbol fully
drivers/iio/dummy/Kconfig:29: WARNING: please write a paragraph that
describes the config symbol fully

This patch expands the explanation about IIO_DUMMY_EVGEN by using the
code documentation found in iio/dummy/iio_dummy_evgen.c. In the same
way, the information related to IIO_SIMPLE_DUMMY_BUFFER was extracted
from file iio_simple_dummy_buffer.c. Finally, this patch apply the
coding-style for Kconfig files (Documentation/process/coding-style.rst)

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/iio/dummy/Kconfig | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dummy/Kconfig b/drivers/iio/dummy/Kconfig
index 5a29fbd3c531..4a7127fb2979 100644
--- a/drivers/iio/dummy/Kconfig
+++ b/drivers/iio/dummy/Kconfig
@@ -9,20 +9,24 @@ config IIO_DUMMY_EVGEN
 	tristate
 
 config IIO_SIMPLE_DUMMY
-       tristate "An example driver with no hardware requirements"
-       depends on IIO_SW_DEVICE
-       help
-	 Driver intended mainly as documentation for how to write
-	 a driver. May also be useful for testing userspace code
-	 without hardware.
+	tristate "An example driver with no hardware requirements"
+	depends on IIO_SW_DEVICE
+	help
+	  Driver intended mainly as documentation for how to write
+	  a driver. May also be useful for testing userspace code
+	  without hardware.
 
 if IIO_SIMPLE_DUMMY
 
 config IIO_SIMPLE_DUMMY_EVENTS
-       bool "Event generation support"
-       select IIO_DUMMY_EVGEN
-       help
-         Add some dummy events to the simple dummy driver.
+	bool "Event generation support"
+	select IIO_DUMMY_EVGEN
+	help
+	  Add some dummy events to the simple dummy driver.
+
+	  The purpose of this is to generate 'fake' event interrupts thus
+	  allowing that driver's code to be as close as possible to that
+	  a normal driver talking to hardware.
 
 config IIO_SIMPLE_DUMMY_BUFFER
 	bool "Buffered capture support"
@@ -32,6 +36,8 @@ config IIO_SIMPLE_DUMMY_BUFFER
 	help
 	  Add buffered data capture to the simple dummy driver.
 
+	  Buffer handling elements of industrial I/O reference driver.
+	  Uses the kfifo buffer.
 endif # IIO_SIMPLE_DUMMY
 
 endmenu
-- 
2.16.1
