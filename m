Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [RFC] iio: ppm: Add IIO_PPM channel type
Date: Wed, 26 Aug 2015 23:45:30 -0700
Message-Id: <1440657930-14871-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

There are air quality sensors that report data back in parts per million
of VOC (Volatile Organic Compounds) which are usually indexed from CO2
or another common pollutant.

This patchset adds an IIO_PPM type because no other channels types fit
this use case.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 3 files changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 42d360f..79366a3 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1459,3 +1459,10 @@ Description:
 		measurements and return the average value as output data. Each
 		value resulted from <type>[_name]_oversampling_ratio measurements
 		is considered as one sample for <type>[_name]_sampling_frequency.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_ppm_raw
+KernelVersion:	4.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled no offset etc.) parts per million measure reading
+		of data like CO2 or VOC (Volatile Organic Compounds) substances.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index b3fcc2c..65285c7 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -75,6 +75,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_ENERGY] = "energy",
 	[IIO_DISTANCE] = "distance",
 	[IIO_VELOCITY] = "velocity",
+	[IIO_PPM] = "ppm",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 2f8b117..7113f9b 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -35,6 +35,7 @@ enum iio_chan_type {
 	IIO_ENERGY,
 	IIO_DISTANCE,
 	IIO_VELOCITY,
+	IIO_PPM,
 };
 
 enum iio_modifier {
-- 
1.9.1
