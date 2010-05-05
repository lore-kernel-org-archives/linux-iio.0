Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/6] staging:iio:Documentation update to add incli and switch to magn
Date: Wed,  5 May 2010 23:25:44 +0100
Message-Id: <1273098346-4184-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1273098346-4184-1-git-send-email-jic23@cam.ac.uk>
References: <1273098346-4184-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/sysfs-class-iio |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-class-iio b/drivers/staging/iio/Documentation/sysfs-class-iio
index ff19f6e..714b4c5 100644
--- a/drivers/staging/iio/Documentation/sysfs-class-iio
+++ b/drivers/staging/iio/Documentation/sysfs-class-iio
@@ -143,7 +143,16 @@ Description:
 		Data converted by application of offset then scale to
 		radians per second. Has all the equivalent parameters as per in[m].
 
-What:		/sys/.../device[n]/mag[_x|_y|_z][m]_raw
+What:		/sys/.../device[n]/incli[_x|_y|_z][m]_raw
+KernelVersion:	2.6.35
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Inclination raw reading about axis x, y or z (may be arbitarily
+		assigned) channel m (not present if only one inclinometer at
+		this orientation).  Data converted by application of offset
+		and scale to Degrees.
+
+What:		/sys/.../device[n]/magn[_x|_y|_z][m]_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
1.7.0.4
