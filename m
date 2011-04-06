Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: linux-iio@vger.kernel.org, drivers@analog.com, jic23@cam.ac.uk,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Cliff Cai <cliff.cai@analog.com>
Subject: [PATCH 2/3] IIO: Documentation: Add ABI documentatio for gyro quadrature correction
Date: Wed, 6 Apr 2011 11:42:48 +0200
Message-ID: <1302082969-3404-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1302082969-3404-1-git-send-email-michael.hennerich@analog.com>
References: <1302082969-3404-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

From: Cliff Cai <cliff.cai@analog.com>

Add ABI documentation for gyro quadrature correction.

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index 4915aee..49047ad 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -698,3 +698,10 @@ Description:
 		with all _en attributes to establish which channels are present,
 		and the relevant _type attributes to establish the data storage
 		format.
+
+What:		/sys/bus/iio/devices/deviceX/gyro_z_quadrature_correction_raw
+KernelVersion:	2.6.38
+Contact:	linux-iio@xxxxxxxxxxxxxxx
+Description:
+		This attribute is used to read the amount of quadrature error
+		present in the device at a given time.
--
1.6.0.2
