Return-Path: <SRS0=1TP6=7Y=wunner.de=lukas@kernel.org>
Message-Id: <c3942be5a25903744b90a014103a50f252d7ff43.1503407738.git.lukas@wunner.de>
In-Reply-To: <cover.1503407738.git.lukas@wunner.de>
References: <cover.1503407738.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 22 Aug 2017 15:33:00 +0200
Subject: [PATCH 1/6] iio: adc: mcp320x: Fix oops on module unload
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mathias Duckeck <m.duckeck@kunbus.de>, Phil Elwell <phil@raspberrypi.org>, Oskar Andero <oskar.andero@gmail.com>, Andrea Galbusera <gizero@gmail.com>, Akinobu Mita <akinobu.mita@gmail.com>, Manfred Schlaegl <manfred.schlaegl@gmx.at>, Michael Welling <mwelling@ieee.org>, Soeren Andersen <san@rosetechnology.dk>, linux-iio@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

The driver calls spi_get_drvdata() in its ->remove hook even though it
has never called spi_set_drvdata().  Stack trace for posterity:

Unable to handle kernel NULL pointer dereference at virtual address 00000220
Internal error: Oops: 5 [#1] SMP ARM
[<8072f564>] (mutex_lock) from [<7f1400d0>] (iio_device_unregister+0x24/0x7c [industrialio])
[<7f1400d0>] (iio_device_unregister [industrialio]) from [<7f15e020>] (mcp320x_remove+0x20/0x30 [mcp320x])
[<7f15e020>] (mcp320x_remove [mcp320x]) from [<8055a8cc>] (spi_drv_remove+0x2c/0x44)
[<8055a8cc>] (spi_drv_remove) from [<805087bc>] (__device_release_driver+0x98/0x134)
[<805087bc>] (__device_release_driver) from [<80509180>] (driver_detach+0xdc/0xe0)
[<80509180>] (driver_detach) from [<8050823c>] (bus_remove_driver+0x5c/0xb0)
[<8050823c>] (bus_remove_driver) from [<80509ab0>] (driver_unregister+0x38/0x58)
[<80509ab0>] (driver_unregister) from [<7f15e69c>] (mcp320x_driver_exit+0x14/0x1c [mcp320x])
[<7f15e69c>] (mcp320x_driver_exit [mcp320x]) from [<801a78d0>] (SyS_delete_module+0x184/0x1d0)
[<801a78d0>] (SyS_delete_module) from [<80108100>] (ret_fast_syscall+0x0/0x1c)

Fixes: f5ce4a7a9291 ("iio: adc: add driver for MCP3204/08 12-bit ADC")
Cc: Oskar Andero <oskar.andero@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/iio/adc/mcp320x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 634717ae12f3..45d043c9a888 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -312,6 +312,7 @@ static int mcp320x_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp320x_info;
+	spi_set_drvdata(spi, indio_dev);
 
 	chip_info = &mcp320x_chip_infos[spi_get_device_id(spi)->driver_data];
 	indio_dev->channels = chip_info->channels;
-- 
2.11.0
