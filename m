Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 12/17] iio: accel: mma9553: fix gpio bitnum init value
Date: Mon, 13 Apr 2015 18:40:59 +0300
Message-Id: <1428939664-12503-13-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Initial value of gpio bitnum is set to -1, but
the variable is declared as unsigned.

Use a positive invalid value for initial gpio
bitnum.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma9553.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 9573147..5755977 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -78,6 +78,7 @@
 
 /* Bitnum used for GPIO configuration = bit number in high status byte */
 #define MMA9553_STATUS_TO_BITNUM(bit)	(ffs(bit) - 9)
+#define MMA9553_MAX_BITNUM		MMA9553_STATUS_TO_BITNUM(BIT(16))
 
 #define MMA9553_DEFAULT_SAMPLE_RATE	30	/* Hz */
 
@@ -404,8 +405,8 @@ static int mma9553_init(struct mma9553_data *data)
 	}
 
 
-	data->gpio_bitnum = -1;
 	/* Reset GPIO */
+	data->gpio_bitnum = MMA9553_MAX_BITNUM;
 	ret = mma9553_conf_gpio(data);
 	if (ret < 0)
 		return ret;
-- 
1.9.1
