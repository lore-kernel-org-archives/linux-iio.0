Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Baluta <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v3 2/3] iio: Documentation: Fix calibheight unit
Date: Tue, 27 Jan 2015 20:41:53 +0200
Message-Id: <1422384114-23392-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1422384114-23392-1-git-send-email-irina.tirdea@intel.com>
References: <1422384114-23392-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Change calibheight unit from centimeters to meters
to follow iio guidelines of using SI units.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index b4ea9c5..588620e 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -347,7 +347,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_steps_calibheight
 KernelVersion:	3.19
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Height of the user (in centimeters) used by some pedometers
+		Height of the user (in meters) used by some pedometers
 		to compute the stride length, distance, speed and activity
 		type.
 
-- 
1.9.1
