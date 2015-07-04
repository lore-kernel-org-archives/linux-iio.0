Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH 1/5] iio:light:stk3310: Fix REGMAP_I2C dependency
Date: Sat,  4 Jul 2015 17:56:57 +0200
Message-Id: <04af58f40b1fceec4430f6dbca26b3308655d54f.1436024257.git.knaack.h@gmx.de>
In-Reply-To: <cover.1436024257.git.knaack.h@gmx.de>
References: <cover.1436024257.git.knaack.h@gmx.de>
In-Reply-To: <cover.1436024257.git.knaack.h@gmx.de>
References: <cover.1436024257.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

The stk3310 driver makes use of regmap_i2c, so this dependency needs to be
reflected in Kconfig.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 730fa80..9c8b423 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -212,6 +212,7 @@ config LTR501
 config STK3310
 	tristate "STK3310 ALS and proximity sensor"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	 Say yes here to get support for the Sensortek STK3310 ambient light
 	 and proximity sensor. The STK3311 model is also supported by this
-- 
2.3.6
