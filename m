Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Michael Hennerich
	<michael.hennerich@analog.com>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:dac:ad5446: Add support for the AD5662
Date: Tue, 15 Nov 2011 16:34:50 +0100
Message-ID: <1321371290-23280-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The AD5662 is compatible to the AD5660, but uses an external reference instead
of an internal.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index 0e8983a..a71defb 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -47,7 +47,7 @@ config AD5446
 	help
 	  Say yes here to build support for Analog Devices AD5444, AD5446,
 	  AD5512A, AD5542A, AD5543, AD5553, AD5601, AD5611, AD5620, AD5621,
-	  AD5640, AD5660 DACs.
+	  AD5640, AD5660, AD5662 DACs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5446.
-- 
1.7.7.1
