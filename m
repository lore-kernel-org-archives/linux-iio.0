Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28322 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755294AbbDTOBT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 20 Apr 2015 10:01:19 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: jlbec@evilplan.org, lars@metafoo.de, knaack.h@gmx.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	octavian.purdila@intel.com, pebolle@tiscali.nl,
	patrick.porlan@intel.com, adriana.reus@intel.com,
	constantin.musca@intel.com, marten@intuitiveaerial.com
Subject: [PATCH v4 4/4] iio: Documentation: Add IIO configfs documentation
Date: Mon, 20 Apr 2015 17:02:43 +0300
Message-Id: <1429538563-23430-5-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1429538563-23430-1-git-send-email-daniel.baluta@intel.com>
References: <1429538563-23430-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 Documentation/iio/iio_configfs.txt | 67 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/iio/iio_configfs.txt

diff --git a/Documentation/iio/iio_configfs.txt b/Documentation/iio/iio_configfs.txt
new file mode 100644
index 0000000..1aa66d1
--- /dev/null
+++ b/Documentation/iio/iio_configfs.txt
@@ -0,0 +1,67 @@
+Industrial IIO configfs support
+
+1. Overview
+
+Configfs is a filesystem-based manager of kernel objects. IIO uses some
+objects that could be easily configured using configfs (e.g.: devices,
+triggers).
+
+See Documentation/filesystems/configfs/configfs.txt for more information
+about how configfs works.
+
+2. Usage
+
+In order to use configfs support in IIO we need to select it at compile
+time via CONFIG_IIO_CONFIGFS config option.
+
+Then, mount the configfs filesystem (usually under /config directory):
+
+$ mkdir /config
+$ mount -t configfs none /config
+
+At this point, all default IIO groups will be created and can be accessed
+under /config/iio. Next chapters will describe available IIO configuration
+objects.
+
+3. Software triggers
+
+One of the IIO default configfs groups is the "triggers" groups. It is
+automagically accessible when the configfs is mounted and can be found
+under /config/iio/triggers.
+
+Software triggers are created under /config/iio/triggers directory. A sofware
+trigger name MUST be of the following form:
+	* <trigger-type>-<trigger-name>:
+Where:
+	* <trigger-type>, specifies the interrupt source (e.g: hrtimer)
+	* <trigger-name>, spefcifies the IIO device trigger name
+
+We support now to following interrupt sources (trigger types):
+	* hrtimer, uses high resolution timers as interrupt source
+
+3.1 Software triggers creation and destruction
+
+As simply as:
+
+$ mkdir /config/triggers/<trigger-type>-<trigger-name>
+$ rmdir /config/triggers/<trigger-type>-<trigger-name>
+e.g:
+
+$ mkdir /config/triggers/hrtimer-instance1
+$ rmdir /config/triggers/hrtimer-instance1
+
+Each trigger can have one or more attributes specific to the trigger type.
+
+3.2 "hrtimer" trigger types attributes
+
+"hrtimer" trigger type has only one attribute:
+
+$ ls /config/triggers/hrtimer-instance1
+sampling_frequency
+
+sampling_frequency - represents the period in Hz between two consecutive
+iio_trigger_poll calls. By default it is set to 100Hz.
+
+4. Further work
+
+* add "sysfs" trigger type
-- 
1.9.1

