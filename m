Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/12] staging:iio:documentation trivial typo fix
Date: Fri, 12 Aug 2011 16:55:38 +0100
Message-Id: <1313164538-1769-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
References: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

---
 drivers/staging/iio/Documentation/sysfs-bus-iio |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index 467c49a..5f99f88 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -2,7 +2,7 @@ What:		/sys/bus/iio/devices/deviceX
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Hardware chip or device accessed by on communication port.
+		Hardware chip or device accessed by one communication port.
 		Corresponds to a grouping of sensor channels. X is the IIO
 		index of the device.
 
-- 
1.7.3.4
