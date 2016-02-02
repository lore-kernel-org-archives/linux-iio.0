Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iio: chemical: select IRQ_WORK for ATLAS ph sensor
Date: Tue, 02 Feb 2016 15:36:39 +0100
Message-ID: <5127664.OXcBoKUPQO@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

The newly added atlas-ph-sensor driver uses irq_work_queue, which
may not always be enabled:

ERROR: "irq_work_queue" [drivers/iio/chemical/atlas-ph-sensor.ko] undefined!

This adds a 'select' statement to Kconfig to ensure it's there
when we need it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 27dec00ecf2d ("iio: chemical: add Atlas pH-SM sensor support")

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index ce7cd1370f74..f73290f84c90 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -10,6 +10,7 @@ config ATLAS_PH_SENSOR
 	select REGMAP_I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select IRQ_WORK
 	help
 	 Say Y here to build I2C interface support for the Atlas
 	 Scientific OEM pH-SM sensor.
