Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [RFC PATCH 3/3] Documentation: iio: Add IIO software devices docs
Date: Wed, 20 Apr 2016 18:45:26 +0300
Message-Id: <1461167126-23399-4-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1461167126-23399-1-git-send-email-daniel.baluta@intel.com>
References: <1461167126-23399-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 Documentation/ABI/testing/configfs-iio | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-iio b/Documentation/ABI/testing/configfs-iio
index 2483756..84b6bd1 100644
--- a/Documentation/ABI/testing/configfs-iio
+++ b/Documentation/ABI/testing/configfs-iio
@@ -19,3 +19,16 @@ KernelVersion:	4.4
 Description:
 		High resolution timers directory. Creating a directory here
 		will result in creating a hrtimer trigger in the IIO subsystem.
+
+What:		/config/iio/devices
+Date:		April 2016
+KernelVersion:	4.7
+Description:
+		Industrial IO software devices directory.
+
+What:		/config/iio/triggers/dummy
+Date:		April 2016
+KernelVersion:	4.7
+Description:
+		Dummy IIO devices directory. Creating a directory here will result
+		in creating a dummy IIO device in the IIO subystem.
-- 
2.5.0
