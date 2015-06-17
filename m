Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH v2 6/7] iio:light:cm3323: make use of GENMASK
Date: Thu, 18 Jun 2015 00:32:04 +0200
Message-Id: <4c312fabbb090163d1b071e489441e3d02a842dd.1434578207.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434578207.git.knaack.h@gmx.de>
References: <cover.1434578207.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434578207.git.knaack.h@gmx.de>
References: <cover.1434578207.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Use GENMASK to define the integration time bitmask.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/light/cm3323.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 2c49ec2..1fc9f78 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -29,7 +29,7 @@
 
 #define CM3323_CONF_SD_BIT	BIT(0) /* sensor disable */
 #define CM3323_CONF_AF_BIT	BIT(1) /* auto/manual force mode */
-#define CM3323_CONF_IT_MASK	(BIT(4) | BIT(5) | BIT(6))
+#define CM3323_CONF_IT_MASK	GENMASK(6, 4)
 #define CM3323_CONF_IT_SHIFT	4
 
 #define CM3323_INT_TIME_AVAILABLE "0.04 0.08 0.16 0.32 0.64 1.28"
-- 
2.3.6
