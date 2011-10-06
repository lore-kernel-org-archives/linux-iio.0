Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	Device-drivers-devel@blackfin.uclinux.org,
	johnlm@apollo.lv,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:documentation: document filter_low_pass_3db_frequency.
Date: Thu,  6 Oct 2011 16:40:11 +0100
Message-Id: <1317915611-26144-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <4E8C1798.2070003@cam.ac.uk>
References: <4E8C1798.2070003@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Add the sysfs ABI docs for all current instances of this
parameter.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index 0d6823d..46a995d 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -276,6 +276,16 @@ Description:
 		If a discrete set of scale values are available, they
 		are listed in this attribute.
 
+What:		/sys/.../in_accel_filter_low_pass_3db_frequency
+What:		/sys/.../in_magn_filter_low_pass_3db_frequency
+What:		/sys/.../in_anglvel_filter_low_pass_3db_frequency
+KernelVersion:	3.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If a known or controllable low pass filter is applied
+		to the underlying data channel, then this parameter
+		gives the 3dB frequency of the filter in Hz.
+
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
-- 
1.7.3.4
