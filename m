Return-Path: <Cliff.Cai@analog.com>
From: <cliff.cai@analog.com>
To: gregkh@suse.de
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@cam.ac.uk,
        device-drivers-devel@blackfin.uclinux.org,
        Cliff Cai <cliff.cai@analog.com>
Subject: [PATCH 2/2] Add ABI document for gyro quadrature correction
Date: Fri, 25 Mar 2011 12:05:58 +0800
Message-ID: <1301025958-2175-2-git-send-email-cliff.cai@analog.com>
In-Reply-To: <1301025958-2175-1-git-send-email-cliff.cai@analog.com>
References: <1301025958-2175-1-git-send-email-cliff.cai@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Cliff Cai <cliff.cai@analog.com>

Add ABI document for gyro quadrature correction.

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index 4915aee..824a56c 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -698,3 +698,10 @@ Description:
 		with all _en attributes to establish which channels are present,
 		and the relevant _type attributes to establish the data storage
 		format.
+
+What:		/sys/bus/iio/devices/deviceX/gyro_z_quadrature_correction_raw
+KernelVersion:	2.6.38
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to read the amount of quadrature error
+		present in the device at a given time.
-- 
1.7.1
