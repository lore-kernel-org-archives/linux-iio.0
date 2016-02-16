Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:53557 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429AbcBPPwx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Feb 2016 10:52:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"Andrew F. Davis" <afd@ti.com>,
	Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: health/afe4403: select REGMAP_SPI
Date: Tue, 16 Feb 2016 16:52:15 +0100
Message-Id: <1455637959-3169264-1-git-send-email-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The newly added afe4403 driver uses the regmap facility to abstract
the I2C and SPI access. However, it fails to ensure that regmap_spi
is actually present:

drivers/iio/built-in.o: In function `afe4403_probe':
:(.text+0x9bf8): undefined reference to `__devm_regmap_init_spi'

This adds a Kconfig select statement like the afe4404 I2C driver
has.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: eec96d1e2d31 ("iio: health: Add driver for the TI AFE4403 heart monitor")
---
 drivers/iio/health/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/health/Kconfig b/drivers/iio/health/Kconfig
index f0c19779ac27..c5f004a8e447 100644
--- a/drivers/iio/health/Kconfig
+++ b/drivers/iio/health/Kconfig
@@ -10,6 +10,7 @@ menu "Heart Rate Monitors"
 config AFE4403
 	tristate "TI AFE4403 Heart Rate Monitor"
 	depends on SPI_MASTER
+	select REGMAP_SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-- 
2.7.0

