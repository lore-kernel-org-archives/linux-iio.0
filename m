Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 3/4] iio: core: Introduce IIO_CHAN_INFO_OVERSAMPLING_RATIO
Date: Thu, 23 Apr 2015 21:34:07 +0300
Message-Id: <1429814048-22808-4-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1429814048-22808-1-git-send-email-irina.tirdea@intel.com>
References: <1429814048-22808-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Some magnetometers can perform a number of repetitions in HW
for each measurement to increase accuracy. One example is
Bosch BMC150:
http://ae-bst.resource.bosch.com/media/products/dokumente/bmc150/BST-BMC150-DS000-04.pdf.

Introduce an interface to set the oversampling ratio
for these devices.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 12 ++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/linux/iio/iio.h                 |  1 +
 3 files changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 866b4ec..e46c71f 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1375,3 +1375,15 @@ Description:
 		The emissivity ratio of the surface in the field of view of the
 		contactless temperature sensor.  Emissivity varies from 0 to 1,
 		with 1 being the emissivity of a black body.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_oversampling_ratio
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_oversampling_ratio
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_z_oversampling_ratio
+KernelVersion:	4.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Hardware applied number of measurements for acquiring one
+		data point. The HW will do <type>[_name]_oversampling_ratio
+		measurements and return the average value as output data. Each
+		value resulted from <type>[_name]_oversampling_ratio measurements
+		is considered as one sample for <type>[_name]_sampling_frequency.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 7c98bc1..dfa81db 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -129,6 +129,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_DEBOUNCE_COUNT] = "debounce_count",
 	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
 	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
+	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
 };
 
 /**
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index b1e46ae..058441d 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -44,6 +44,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_DEBOUNCE_COUNT,
 	IIO_CHAN_INFO_DEBOUNCE_TIME,
 	IIO_CHAN_INFO_CALIBEMISSIVITY,
+	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
 };
 
 enum iio_shared_by {
-- 
1.9.1
