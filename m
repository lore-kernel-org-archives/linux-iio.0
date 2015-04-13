Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 07/17] iio: accel: mma9553: check for error in reading initial activity and stepcnt
Date: Mon, 13 Apr 2015 18:40:54 +0300
Message-Id: <1428939664-12503-8-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

When configuring gpio, we need to read initial values for activity and
step count. This function may fail due to i2c read errors.

Check the error code returned by mma9553_read_activity_stepcnt
and return the appropriate error in gpio config function.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Reported-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma9553.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 365a109..6f0a14b 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -363,9 +363,12 @@ static int mma9553_conf_gpio(struct mma9553_data *data)
 		return 0;
 
 	/* Save initial values for activity and stepcnt */
-	if (activity_enabled || ev_step_detect->enabled)
-		mma9553_read_activity_stepcnt(data, &data->activity,
-					      &data->stepcnt);
+	if (activity_enabled || ev_step_detect->enabled) {
+		ret = mma9553_read_activity_stepcnt(data, &data->activity,
+						    &data->stepcnt);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = mma9551_gpio_config(data->client,
 				  MMA9553_DEFAULT_GPIO_PIN,
-- 
1.9.1
