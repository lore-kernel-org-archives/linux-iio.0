Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 2/3] iio: electricalconductivity: add IIO_ELECTRICALCONDUCTIVITY type
Date: Thu, 19 May 2016 18:53:00 -0700
Message-Id: <1463709181-17528-3-git-send-email-mranostay@gmail.com>
In-Reply-To: <1463709181-17528-1-git-send-email-mranostay@gmail.com>
References: <1463709181-17528-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 3 files changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index df44998..adfdf95 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1565,3 +1565,10 @@ Description:
 		* X is in the plane of the propellers, perpendicular to Y axis,
 		  and positive towards the starboard side of the UAV ;
 		* Z is perpendicular to propellers plane and positive upwards.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_electricalconductivity_raw
+KernelVersion:	4.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled no offset etc.) electric conductivity reading that
+		maps to microsiemens per centimeter.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e6319a9..2a85bd8 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -80,6 +80,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_RESISTANCE] = "resistance",
 	[IIO_PH] = "ph",
 	[IIO_UVINDEX] = "uvindex",
+	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index b0916fc..22e5e58 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -39,6 +39,7 @@ enum iio_chan_type {
 	IIO_RESISTANCE,
 	IIO_PH,
 	IIO_UVINDEX,
+	IIO_ELECTRICALCONDUCTIVITY,
 };
 
 enum iio_modifier {
-- 
2.7.4
