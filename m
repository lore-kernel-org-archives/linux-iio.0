Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 6/8] iio: accel: mma9553: check input value for activity period
Date: Wed,  8 Apr 2015 17:37:35 +0300
Message-Id: <1428503857-9081-7-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com>
References: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

When setting the activity period, the value introduced by
the user in sysfs is not checked for validity.

Add a boundary check so that only allowed values are
reported as suuccesfully written to device.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma9553.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 57868fb..96e4708 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -839,6 +839,9 @@ static int mma9553_write_event_value(struct iio_dev *indio_dev,
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
