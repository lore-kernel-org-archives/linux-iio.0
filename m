Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/2] iio: core: add _bias channel information
Date: Thu, 15 Sep 2011 17:04:53 +0200
Message-ID: <1316099094-10931-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |   16 ++++++++++++++++
 drivers/staging/iio/iio.h                       |    2 ++
 drivers/staging/iio/industrialio-core.c         |    1 +
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index 1d52c96..12e70be 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -201,6 +201,22 @@ Description:
 		for variation between different instances of the part, typically
 		adjusted by using some hardware supported calibration procedure.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_bias
+KernelVersion:	3.1.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If known for a device, offset/bias to be added to <type>[Y]_raw
+		post to scaling by <type>[Y]_scale in order to obtain value in
+		the <type> units as specified in <type>[y]_raw documentation.
+		Not present if the bias/offset is always 0 or unknown.
+		If Y is not present, then the bias/offset applies to all in
+		channels of <type>. May be writable if a variable offset bias
+		can be applied on the device. Note that this is different to
+		calibbias which is for devices (or drivers) that apply offsets
+		to compensate for variation between different instances of the
+		part, typically adjusted by using some hardware supported
+		calibration procedure.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_scale
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 8ef04f8..06527ba 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -83,6 +83,8 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE,
 	IIO_CHAN_INFO_AVERAGE_RAW_SHARED,
 	IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE,
+	IIO_CHAN_INFO_BIAS_SHARED,
+	IIO_CHAN_INFO_BIAS_SEPARATE,
 };
 
 enum iio_endian {
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index fd4aada..5e9a65d 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -86,6 +86,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED/2]
 	= "quadrature_correction_raw",
 	[IIO_CHAN_INFO_AVERAGE_RAW_SHARED/2] = "mean_raw",
+	[IIO_CHAN_INFO_BIAS_SHARED/2] = "bias",
 };
 
 /**
-- 
1.7.0.4
