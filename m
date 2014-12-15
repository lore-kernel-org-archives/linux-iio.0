Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6887 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755AbaLOPRH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 15 Dec 2014 10:17:07 -0500
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH] iio: mma9551: fix sparse warning
Date: Mon, 15 Dec 2014 17:16:51 +0200
Message-Id: <1418656611-13496-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

sparse warnings: (new ones prefixed by >>)

>> drivers/iio/accel/mma9551.c:554:57: sparse: mixing different enum types
   drivers/iio/accel/mma9551.c:554:57:     int enum mma9551_tilt_axis  versus
   drivers/iio/accel/mma9551.c:554:57:     int enum mma9551_gpio_pin
>> drivers/iio/accel/mma9551.c:576:57: sparse: mixing different enum types
   drivers/iio/accel/mma9551.c:576:57:     int enum mma9551_tilt_axis  versus
   drivers/iio/accel/mma9551.c:576:57:     int enum mma9551_gpio_pin

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
---
 drivers/iio/accel/mma9551.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 1be125b..6563e26 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -551,7 +551,8 @@ static int mma9551_config_incli_event(struct iio_dev *indio_dev,
 		return 0;
 
 	if (state == 0) {
-		ret = mma9551_gpio_config(data->client, mma_axis,
+		ret = mma9551_gpio_config(data->client,
+					  (enum mma9551_gpio_pin)mma_axis,
 					  MMA9551_APPID_NONE, 0, 0);
 		if (ret < 0)
 			return ret;
@@ -573,7 +574,8 @@ static int mma9551_config_incli_event(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
-		ret = mma9551_gpio_config(data->client, mma_axis,
+		ret = mma9551_gpio_config(data->client,
+					  (enum mma9551_gpio_pin)mma_axis,
 					  MMA9551_APPID_TILT, bitnum, 0);
 		if (ret < 0)
 			return ret;
-- 
1.9.1

