Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: daniel.baluta@intel.com,
	irina.tirdea@intel.com
Subject: [RFC PATCH 2/8] iio: core: Introduce IIO_ACTIVITY channel
Date: Thu,  2 Oct 2014 16:43:53 +0300
Message-Id: <1412257439-15683-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1412257439-15683-1-git-send-email-daniel.baluta@intel.com>
References: <1412257439-15683-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This channel will be used for exposing information about
some activity composite sensors including:
	* motion (running, jogging, walking, still).
	* step counter
	* step detector

This will offer an interface for Android composite sensors
defined here:
http://source.android.com/devices/sensors/composite_sensors.html

This sensors are supported by Freescale's MMA9553 device.
http://freescale.com/files/sensors/doc/ref_manual/MMA9553LSWRM.pdf

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index af3e76d..67e8561 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -70,6 +70,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CCT] = "cct",
 	[IIO_PRESSURE] = "pressure",
 	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
+	[IIO_ACTIVITY] = "activity",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 4a2af8a..d58769a 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -30,6 +30,7 @@ enum iio_chan_type {
 	IIO_CCT,
 	IIO_PRESSURE,
 	IIO_HUMIDITYRELATIVE,
+	IIO_ACTIVITY,
 };
 
 enum iio_modifier {
-- 
1.9.1
