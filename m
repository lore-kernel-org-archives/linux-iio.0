Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: jlbec@evilplan.org,
	lars@metafoo.de,
	knaack.h@gmx.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	octavian.purdila@intel.com,
	daniel.baluta@intel.com,
	pebolle@tiscali.nl,
	patrick.porlan@intel.com,
	adriana.reus@intel.com
Subject: [PATCH v3 3/3] iio: Documentation: Add documentation for IIO configfs
Date: Mon,  6 Apr 2015 17:18:09 +0300
Message-Id: <1428329889-18335-4-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1428329889-18335-1-git-send-email-daniel.baluta@intel.com>
References: <1428329889-18335-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
Changes since v2:
	* fix some whitespace issues reported by Paul

Changes since v1:
	* addressed feedback for v1:
		* https://lkml.org/lkml/2015/3/25/648
	* adapted to match the changes in patches 1 and 2
	* fixed some typos and clarified further work

 Documentation/iio/iio_configfs.txt | 83 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/iio/iio_configfs.txt

diff --git a/Documentation/iio/iio_configfs.txt b/Documentation/iio/iio_configfs.txt
new file mode 100644
index 0000000..ace7b54
--- /dev/null
+++ b/Documentation/iio/iio_configfs.txt
@@ -0,0 +1,83 @@
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
+Under /config/iio/triggers we will create trigger types. For the moment
+we have "hrtimer" trigger type and we plan to add at least one more type,
+the "sysfs" trigger type.
+
+3.1 Trigger types
+
+Represent a specific type of trigger. For now we have an implementation
+for "hrtimer" trigger type.
+
+3.2. Trigger creation and destruction
+
+As simply as:
+
+$ mkdir /config/triggers/hrtimer/my_trigger
+
+Creating my_trigger directory will result in creation of "my_trigger"
+trigger of "hrtimer" type.  Destruction happens when my_trigger directory
+is removed.
+
+Each trigger can have one or more attributes specific to the trigger type.
+
+3.3 "hrtimer" trigger types attributes
+
+"hrtimer" trigger type has only one attribute:
+
+$ ls /config/triggers/hrtimer/my_trigger
+delay
+
+delay - represents the amount of time in nanoseconds between two
+consecutive iio_trigger_poll calls. By default it is set to 100000000,
+that is the equivalent of a 100Hz frequency.
+
+3.4. Adding a new trigger type
+
+In order to add a new trigger type, one needs to:
+
+* [iio_configfs_trigger.h]
+	** add a new IIO_TRIGGER_TYPE
+* [iio-trig-<type>.c]
+	** declare and initialize a structure of type
+	iio_configfs_trigger_type
+	** implement needed iio_configfs_trigger_ops
+	** register/unregister the new trigger
+	type with the IIO configfs core
+* [industrialiio-configfs.c]
+	** create a new group type and add it in the default group of
+	   trigger types.
+	** create new attributes and them to the IIO configfs core.
+
+4. Further work
+
+* add "sysfs" trigger type
-- 
1.9.1
