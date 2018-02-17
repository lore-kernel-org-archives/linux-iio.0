Return-Path: <SRS0=G9Sh=FL=richardman.com=richard@kernel.org>
From: Richard Lai <richard@richardman.com>
To: 
Cc: Richard Lai <richard@richardman.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: chemical: ccs811: Corrected firmware boot/application mode transition
Date: Sat, 17 Feb 2018 16:28:24 +0000
Message-Id: <1518885013-1852-1-git-send-email-richard@richardman.com>
In-Reply-To: <20180217142513.323bbe82@archlinux>
References: <20180217142513.323bbe82@archlinux>
List-ID: <linux-iio@vger.kernel.org>

CCS811 has different I2C register maps in boot and application mode. When
CCS811 is in boot mode, register APP_START (0xF4) is used to transit the
firmware state from boot to application mode. However, APP_START is not a
valid register location when CCS811 is in application mode (refer to
"CCS811 Bootloader Register Map" and "CCS811 Application Register Map" in
CCS811 datasheet). The driver should not attempt to perform a write to
APP_START while CCS811 is in application mode, as this is not a valid or
documented register location.

When prob function is being called, the driver assumes the CCS811 sensor
is in boot mode, and attempts to perform a write to APP_START. Although
CCS811 powers-up in boot mode, it may have already been transited to
application mode by previous instances, e.g. unload and reload device
driver by the system, or explicitly by user. Depending on the system
design, CCS811 sensor may be permanently connected to system power source
rather than power controlled by GPIO, hence it is possible that the sensor
is never power reset, thus the firmware could be in either boot or
application mode at any given time when driver prob function is being
called.

This patch checks the STATUS register before attempting to send a write to
APP_START. Only if the firmware is not in application mode and has valid
firmware application loaded, then it will continue to start transiting the
firmware boot to application mode.

Signed-off-by: Richard Lai <richard@richardman.com>
---
Changes in v2:
- Removed unnecessary macros introduced in previous patch

 drivers/iio/chemical/ccs811.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 840a6cb..6ad8a42 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -129,6 +129,9 @@ static int ccs811_start_sensor_application(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	if ((ret & CCS811_STATUS_FW_MODE_APPLICATION))
+		return 0;
+
 	if ((ret & CCS811_STATUS_APP_VALID_MASK) !=
 	    CCS811_STATUS_APP_VALID_LOADED)
 		return -EIO;
-- 
2.7.4
