Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 1/8] iio:magnetometer:bmc150_magn: add regmap dependency
Date: Fri, 17 Jul 2015 10:52:24 +0200
Message-Id: <b09e8e6a55526102daf53f85c2b8079c497abad5.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

bmc150_magn makes use of REGMAP_I2C, so select it to build always without
errors.

Fixes: c91746a2361d ("iio: magn: Add support for BMC150 magnetometer")

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/magnetometer/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index dcadfc4f0661..efb9350b0d76 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -90,6 +90,7 @@ config IIO_ST_MAGN_SPI_3AXIS
 config BMC150_MAGN
 	tristate "Bosch BMC150 Magnetometer Driver"
 	depends on I2C
+	select REGMAP_I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-- 
2.4.3
