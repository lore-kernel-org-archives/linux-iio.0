Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/6] staging:iio:Documentation fixes
Date: Wed,  5 May 2010 23:25:41 +0100
Message-Id: <1273098346-4184-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1273098346-4184-1-git-send-email-jic23@cam.ac.uk>
References: <1273098346-4184-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/sysfs-class-iio |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-class-iio b/drivers/staging/iio/Documentation/sysfs-class-iio
index 7238582..ff19f6e 100644
--- a/drivers/staging/iio/Documentation/sysfs-class-iio
+++ b/drivers/staging/iio/Documentation/sysfs-class-iio
@@ -66,7 +66,7 @@ KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		If known for a device, offset to be added to in[m]_raw prior
-		to scaling by volt[m]_scale in order to obtain voltage in
+		to scaling by in[_name][m]_scale in order to obtain voltage in
 		millivolts.  Not present if the offset is always 0 or unknown.
 		If m is not present, then voltage offset applies to all in
 		channels. May be writable if a variable offset is controlled
@@ -111,8 +111,8 @@ KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		If known for a device, scale to be applied to volt[m]_raw post
-		addition of volt[m]_offset in order to obtain the measured voltage
-		in millivolts.  If shared across all in channels then m is not present.
+		addition of in[_name][m]_offset in order to obtain the measured
+		voltage	in millivolts.  If shared across all in channels then			m is not present.
 
 What:		/sys/.../device[n]/in[m]-in[o]_raw
 KernelVersion:	2.6.35
-- 
1.7.0.4
