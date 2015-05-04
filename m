Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: jlbec@evilplan.org,
	lars@metafoo.de,
	knaack.h@gmx.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	octavian.purdila@intel.com,
	pebolle@tiscali.nl,
	patrick.porlan@intel.com,
	adriana.reus@intel.com,
	constantin.musca@intel.com,
	marten@intuitiveaerial.com,
	daniel.baluta@intel.com
Subject: [PATCH v5 4/4] iio: Documentation: Add IIO configfs documentation
Date: Mon,  4 May 2015 13:50:04 +0300
Message-Id: <1430736604-22119-5-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1430736604-22119-1-git-send-email-daniel.baluta@intel.com>
References: <1430736604-22119-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 Documentation/ABI/testing/configfs-iio | 26 ++++++++++++++
 Documentation/iio/iio_configfs.txt     | 63 ++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 Documentation/ABI/testing/configfs-iio
 create mode 100644 Documentation/iio/iio_configfs.txt

diff --git a/Documentation/ABI/testing/configfs-iio b/Documentation/ABI/testing/configfs-iio
new file mode 100644
index 0000000..a143135
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-iio
@@ -0,0 +1,26 @@
+What:		/config/iio
+Date:		May 2015
+KernelVersion:	4.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This represents Industrial IO configuration entry point
+		directory. It contains sub-groups corresponding to IIO
+		objects.
+
+What:		/config/iio/triggers
+Date:		May 2015
+KernelVersion:	4.2
+Description:
+		Industrial IO software triggers directory.
+
+What:		/config/iio/triggers/hrtimer-name
+Date:		May 2015
+KernelVersion:	4.2
+Description:
+		High resolution timer instance.
+
+What:		/config/iio/triggers/hrtimer-name/sampling_frequency
+Date:		May 2015
+KernelVersion:	4.2
+Description:
+		Sampling frequency for this hrtimer instance.
diff --git a/Documentation/iio/iio_configfs.txt b/Documentation/iio/iio_configfs.txt
new file mode 100644
index 0000000..456f7a5
--- /dev/null
+++ b/Documentation/iio/iio_configfs.txt
@@ -0,0 +1,63 @@
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
-- 
1.9.1
