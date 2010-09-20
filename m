Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 22/22] staging:iio:sysfs abi documentation. Add _type and _index attrs
Date: Mon, 20 Sep 2010 15:13:07 +0100
Message-Id: <1284991987-12407-23-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Also remove no unused precision attr.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |   40 ++++++++++++++++-------
 1 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index c137020..62becc0 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -266,24 +266,41 @@ Description:
 		Directory containing interfaces for elements that will be captured
 		for a single triggered sample set in the buffer.
 
-What:		/sys/.../device[n]/buffer/scan_elements/[m]_accel_x0_en
+What:		/sys/.../device[n]/buffer/scan_elements/accel_x0_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Scan element control for triggered data capture. m implies the
-		ordering within the buffer. Next the type is specified with
-		modifier and channel number as per the sysfs single channel
-		access above.
+		Scan element control for triggered data capture.
 
-What:		/sys/.../device[n]/buffer/scan_elements/accel[_x0]_precision
+What:		/sys/.../device[n]/buffer/scan_elements/accel[_x0]_type
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Scan element precision within the buffer. Note that the
-		data alignment must restrictions must be read from within
-		buffer to work out full data alignment for data read
-		via buffer_access chrdev. _x0 dropped if shared across all
-		acceleration channels.
+		Description of the scan element data storage within the buffer
+		and hence the form in which it is read from userspace.
+		Form is [s|u]bits/storagebits.  s or u specifies if signed
+		(2's complement) or unsigned. bits is the number of bits of
+		data and storagebits is the space (after padding) that it
+		occupies in the buffer.  Note that some devices will have
+		additional information in the unused bits so to get a clean
+		value, the bits value must be used to mask the buffer output
+		value appropriately.  The storagebits value also specifies the
+		data alignment.  So s48/64 will be a signed 48 bit integer
+		stored in a 64 bit location aligned to a a64 bit boundary.
+		For other storage combinations this attribute will be extended
+		appropriately.
+
+What:		/sys/.../device[n]/buffer/scan_elements/accel[_x0]_index
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		A single positive integer specifying the position of this
+		scan element in the buffer. Note these are not dependant on
+		what is enabled and may not be contiguous. Thus for userspace
+		to establish the full layout these must be used in conjunction
+		with all _en attributes to establish which channels are present,
+		and the relevant _type attributes to establish the data storage
+		format.
 
 What:		/sys/.../device[n]/buffer/scan_elements/accel[_x0]_shift
 KernelVersion:	2.6.37
@@ -291,4 +308,3 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		A bit shift (to right) that must be applied prior to
 		extracting the bits specified by accel[_x0]_precision.
-
-- 
1.7.2.2
