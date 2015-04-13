Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 08/17] iio: accel: mma9553: return 0 as indication of success
Date: Mon, 13 Apr 2015 18:40:55 +0300
Message-Id: <1428939664-12503-9-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Use return 0 instead of return ret to mark
clearly the success return path.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma9553.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 6f0a14b..0f30006 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -792,7 +792,7 @@ static int mma9553_write_event_config(struct iio_dev *indio_dev,
 
 	mutex_unlock(&data->mutex);
 
-	return ret;
+	return 0;
 
 err_conf_gpio:
 	if (state) {
-- 
1.9.1
