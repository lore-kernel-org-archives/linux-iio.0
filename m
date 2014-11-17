Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	mranostay@gmail.com
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 1/2] iio: rename proximity sensors in kernel config
Date: Mon, 17 Nov 2014 17:12:48 +0200
Message-Id: <1416237169-10707-2-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1416237169-10707-1-git-send-email-vlad.dogaru@intel.com>
References: <1416237169-10707-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Up till now, there was only a single sensor in the drivers/iio/proximity
directory, and the config subsection was called 'Lightning sensors'.
This will no longer be true once we introduce a general-purpose
proximity sensor.

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/iio/proximity/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 0c8cdf5..a131ead 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -2,7 +2,7 @@
 # Proximity sensors
 #
 
-menu "Lightning sensors"
+menu "Proximity sensors"
 
 config AS3935
 	tristate "AS3935 Franklin lightning sensor"
-- 
1.9.1
