Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 10/17] iio: accel: mma9553: use GENMASK
Date: Mon, 13 Apr 2015 18:40:57 +0300
Message-Id: <1428939664-12503-11-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Use GENMASK instead of BIT or direct value to
define a mask.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma9553.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index a6b74de..47cb14b 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -63,8 +63,8 @@
 #define MMA9553_MASK_STATUS_STEPCHG		BIT(13)
 #define MMA9553_MASK_STATUS_ACTCHG		BIT(12)
 #define MMA9553_MASK_STATUS_SUSP		BIT(11)
-#define MMA9553_MASK_STATUS_ACTIVITY		(BIT(10) | BIT(9) | BIT(8))
-#define MMA9553_MASK_STATUS_VERSION		0x00FF
+#define MMA9553_MASK_STATUS_ACTIVITY		GENMASK(10, 8)
+#define MMA9553_MASK_STATUS_VERSION		GENMASK(7, 0)
 
 #define MMA9553_REG_STEPCNT			0x02
 #define MMA9553_REG_DISTANCE			0x04
-- 
1.9.1
