Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33145 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756037AbbKROi7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Nov 2015 09:38:59 -0500
Received: by wmec201 with SMTP id c201so281778248wme.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2015 06:38:58 -0800 (PST)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: daniel.baluta@intel.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [RFC 5/9] iio: Documentation: Add IIO configfs documentation
Date: Wed, 18 Nov 2015 15:38:31 +0100
Message-Id: <1447857515-23935-6-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <1447857515-23935-1-git-send-email-mtitinger@baylibre.com>
References: <1447857515-23935-1-git-send-email-mtitinger@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Daniel Baluta <daniel.baluta@intel.com>

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Acked-by: Crt Mori <cmo@melexis.com>
---
 Documentation/ABI/testing/configfs-iio | 21 ++++++++
 Documentation/iio/iio_configfs.txt     | 93 ++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 Documentation/ABI/testing/configfs-iio
 create mode 100644 Documentation/iio/iio_configfs.txt

diff --git a/Documentation/ABI/testing/configfs-iio b/Documentation/ABI/testing/configfs-iio
new file mode 100644
index 0000000..2483756
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-iio
@@ -0,0 +1,21 @@
+What:		/config/iio
+Date:		October 2015
+KernelVersion:	4.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This represents Industrial IO configuration entry point
+		directory. It contains sub-groups corresponding to IIO
+		objects.
+
+What:		/config/iio/triggers
+Date:		October 2015
+KernelVersion:	4.4
+Description:
+		Industrial IO software triggers directory.
+
+What:		/config/iio/triggers/hrtimers
+Date:		October 2015
+KernelVersion:	4.4
+Description:
+		High resolution timers directory. Creating a directory here
+		will result in creating a hrtimer trigger in the IIO subsystem.
diff --git a/Documentation/iio/iio_configfs.txt b/Documentation/iio/iio_configfs.txt
new file mode 100644
index 0000000..f0add35
--- /dev/null
+++ b/Documentation/iio/iio_configfs.txt
@@ -0,0 +1,93 @@
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
+One of the IIO default configfs groups is the "triggers" group. It is
+automagically accessible when the configfs is mounted and can be found
+under /config/iio/triggers.
+
+IIO software triggers implementation offers support for creating multiple
+trigger types. A new trigger type is usually implemented as a separate
+kernel module following the interface in include/linux/iio/sw_trigger.h:
+
+/*
+ * drivers/iio/trigger/iio-trig-sample.c
+ * sample kernel module implementing a new trigger type
+ */
+#include <linux/iio/sw_trigger.h>
+
+
+static struct iio_sw_trigger *iio_trig_sample_probe(const char *name)
+{
+	/*
+	 * This allocates and registers an IIO trigger plus other
+	 * trigger type specific initialization.
+	 */
+}
+
+static int iio_trig_hrtimer_remove(struct iio_sw_trigger *swt)
+{
+	/*
+	 * This undoes the actions in iio_trig_sample_probe
+	 */
+}
+
+static const struct iio_sw_trigger_ops iio_trig_sample_ops = {
+	.probe		= iio_trig_sample_probe,
+	.remove		= iio_trig_sample_remove,
+};
+
+static struct iio_sw_trigger_type iio_trig_sample = {
+	.name = "trig-sample",
+	.owner = THIS_MODULE,
+	.ops = &iio_trig_sample_ops,
+};
+
+module_iio_sw_trigger_driver(iio_trig_sample);
+
+Each trigger type has its own directory under /config/iio/triggers. Loading
+iio-trig-sample module will create 'trig-sample' trigger type directory
+/config/iio/triggers/trig-sample.
+
+We support the following interrupt sources (trigger types):
+	* hrtimer, uses high resolution timers as interrupt source
+
+3.1 Hrtimer triggers creation and destruction
+
+Loading iio-trig-hrtimer module will register hrtimer trigger types allowing
+users to create hrtimer triggers under /config/iio/triggers/hrtimer.
+
+e.g:
+
+$ mkdir /config/triggers/hrtimer/instance1
+$ rmdir /config/triggers/hrtimer/instance1
+
+Each trigger can have one or more attributes specific to the trigger type.
+
+3.2 "hrtimer" trigger types attributes
+
+"hrtimer" trigger type doesn't have any configurable attribute from /config dir.
+It does introduce the sampling_frequency attribute to trigger directory.
-- 
1.9.1

