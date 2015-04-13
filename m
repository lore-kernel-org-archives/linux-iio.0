Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 02/17] iio: accel: mma9553: check input value for activity period
Date: Mon, 13 Apr 2015 18:40:49 +0300
Message-Id: <1428939664-12503-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

When setting the activity period, the value introduced by
the user in sysfs is not checked for validity.

Add a boundary check so that only allowed values are
reported as successfully written to device.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Reported-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma9553.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 607dbfc..03120fb 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -54,6 +54,7 @@
 #define MMA9553_MASK_CONF_STEPCOALESCE		GENMASK(7, 0)
 
 #define MMA9553_REG_CONF_ACTTHD			0x0E
+#define MMA9553_MAX_ACTTHD			GENMASK(15, 0)
 
 /* Pedometer status registers (R-only) */
 #define MMA9553_REG_STATUS			0x00
@@ -869,6 +870,9 @@ static int mma9553_write_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_INFO_PERIOD:
 		switch (chan->type) {
 		case IIO_ACTIVITY:
+			if (val < 0 || val > MMA9553_ACTIVITY_THD_TO_SEC(
+			    MMA9553_MAX_ACTTHD))
+				return -EINVAL;
 			mutex_lock(&data->mutex);
 			ret = mma9553_set_config(data, MMA9553_REG_CONF_ACTTHD,
 						 &data->conf.actthd,
-- 
1.9.1
