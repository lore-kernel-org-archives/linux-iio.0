Return-Path: <cristina.opriceana@gmail.com>
Date: Wed, 12 Aug 2015 14:29:41 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Documentation: iio-trig-sysfs: Add remove_trigger
 attribute ABI
Message-ID: <8d4239f13743401a9adf67fc919c552c5f42537a.1439378363.git.cristina.opriceana@gmail.com>
References: <cover.1439378363.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1439378363.git.cristina.opriceana@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds the documentation ABI for the remove_trigger
attribute, provided by the iio-trig-sysfs stand-alone driver.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
index 887aa92..6de6e6b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
+++ b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
@@ -20,3 +20,14 @@ Description:
 		into the associated file, which will serve as the id of the
 		trigger. If the trigger with the specified id is already present
 		in the system, an invalid argument message will be returned.
+
+What:		/sys/bus/iio/devices/iio_sysfs_trigger/remove_trigger
+KernelVersion:	2.6.39
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to unregister and delete a previously
+		created trigger from the list of available triggers. In order to
+		achieve this, one should write a positive integer into the
+		associated file, representing the id of the trigger that needs
+		to be removed. If the trigger can't be found, an invalid
+		argument message will be returned to the user.
-- 
1.9.1
