Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH 2/7] iio:light:Kconfig: fix typo in description
Date: Wed, 17 Jun 2015 00:17:01 +0200
Message-Id: <56c6ad5c63292495b1dc3e3e78f626789ff4ea9f.1434492557.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434492557.git.knaack.h@gmx.de>
References: <cover.1434492557.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434492557.git.knaack.h@gmx.de>
References: <cover.1434492557.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Fix the typo in the module description for the CM3323.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/light/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index e6198b7..554f8ee 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -86,7 +86,7 @@ config CM3323
 	depends on I2C
 	tristate "Capella CM3323 color light sensor"
 	help
-	 Say Y here if you want to build a driver for Capela CM3323
+	 Say Y here if you want to build a driver for Capella CM3323
 	 color sensor.
 
 	 To compile this driver as a module, choose M here: the module will
-- 
2.3.6
