Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: trigger: Use standard attr for sampling frequency
Date: Wed, 11 Mar 2015 18:36:17 +0200
Message-Id: <1426091777-30592-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

As written in Documentation/ABI/testing/sysfs-bus-iio the trigger
attribute for sampling frequency should be sampling_frequency.

Fix this for iio-trig-periodic-rtc module in order to prepare it
for moving out of staging.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
Jonathan, this module is very useful for devices that do not have
an interrupt pin.

We are working on drivers for such devices and would be very nice to
move this driver in advance to the IIO non-staging location.

What do you say?

 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index 89df1d3..f1cfe2d 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -87,12 +87,12 @@ error_ret:
 	return ret;
 }
 
-static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(sampling_frequency, S_IRUGO | S_IWUSR,
 	    iio_trig_periodic_read_freq,
 	    iio_trig_periodic_write_freq);
 
 static struct attribute *iio_trig_prtc_attrs[] = {
-	&dev_attr_frequency.attr,
+	&dev_attr_sampling_frequency.attr,
 	NULL,
 };
 
-- 
1.9.1
