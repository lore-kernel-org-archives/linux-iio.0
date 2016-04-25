Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19620 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932581AbcDYNMg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 25 Apr 2016 09:12:36 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH v2 3/3] Documentation: iio: Add IIO software devices docs
Date: Mon, 25 Apr 2016 16:15:53 +0300
Message-Id: <1461590153-22308-4-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1461590153-22308-1-git-send-email-daniel.baluta@intel.com>
References: <1461590153-22308-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 Documentation/ABI/testing/configfs-iio | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-iio b/Documentation/ABI/testing/configfs-iio
index 2483756..aebda53 100644
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
+What:		/config/iio/devices/dummy
+Date:		April 2016
+KernelVersion:	4.7
+Description:
+		Dummy IIO devices directory. Creating a directory here will result
+		in creating a dummy IIO device in the IIO subystem.
-- 
2.5.0

