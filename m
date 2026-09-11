Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1082E5921E2;
	Fri, 11 Sep 2026 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161040; cv=none; b=FOVL/gsIQ/mIsb0nNlQV2vaJtKeGrISBdW41L5ZJW4GNK9OWFjU7e5zuIk3OQNeoKnKHGeK+g6dYE1RDF40mmJuwLpcCQ7ktu2qRuAG+9QUHZXtWFgUJXAkBMoosynYdhTZn1CM18QjLnJv0FTlmYOz8gteksF4wG4nbsEexTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161040; c=relaxed/simple;
	bh=26NCzNcTtvCXIPxX+WLF60tMm+FJGOwyY/aWT+sTAL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOXxVuWSuUgx6MWxdaiqGv9Dc8T/TaJL6RyU23vagygSy5Hq8KWq1ggI02v9C5fOrSYViPj4LF/X8gkVFFyQIbTkxUW9qUFb1N/YbOFqDGBwwvOsMwrdK1CmyKQWG7ngQ4h24jL4Vue4B5JRZiEn7YHkn/xe5uwmIpuJcShlkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hN64bWbH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hN64bWbH"
Received: by linux.microsoft.com (Postfix, from userid 1223)
	id 3A54020B716D; Fri, 11 Sep 2026 14:09:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A54020B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789160996;
	bh=XygGVZarKIQoozcjx3u98JvxiMSx4R8NNbh5D9ZvxF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hN64bWbH2lPooVCLrxCkA/3tPGDKzHA461Ez66gp+354Nza+GTG0tz+6JiSQRaNIR
	 Ov4Pqqbc+nzpcYxVe87rYUNwmmmJQO9yVLIYIqMgRSUxovgdX1qrn6/0MWVOuvJidW
	 TYyofrRg0VNYhYWorJKqqQQl3CyoimWqlE/aFhYc=
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
To: linux-i3c@lists.infradead.org
Cc: meaganlloyd@linux.microsoft.com,
	alexandre.belloni@bootlin.com,
	vitor.soares@toradex.com,
	samagazaryan@google.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	boris.brezillon@collabora.com,
	oleksandr.shulzhenko.viktorovych@intel.com,
	tgopinath@linux.microsoft.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux@roeck-us.net,
	Frank.Li@nxp.com,
	jorge.marques@analog.com,
	pgaj@cadence.com,
	wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org,
	lorenzo@kernel.org,
	enelsonmoore@gmail.com,
	rppt@kernel.org,
	pratyush@kernel.org,
	giovanni.cabiddu@intel.com,
	gabewhigham@gmail.com,
	haren@linux.ibm.com,
	pasha.tatashin@soleen.com,
	jirislaby@kernel.org,
	adrian.ho.yin.ng@altera.com,
	ustc.gu@gmail.com,
	jszhang@kernel.org,
	adrian.hunter@intel.com,
	akhilrajeev@nvidia.com,
	tze.yee.ng@altera.com,
	manikanta.guntupalli@amd.com,
	shubhrajyoti.datta@amd.com,
	jarkko.nikula@linux.intel.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org
Subject: [PATCH 3/3] i3c: add i3cdev character device module for user-space access
Date: Fri, 11 Sep 2026 14:09:35 -0700
Message-ID: <20260911210935.1353126-4-meaganlloyd@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i3cdev driver is a character device driver that allows user-space
to control and interact with I3C devices.

Currently, it has the ability to perform Single Data Rate (SDR)
transfers - basic reads/writes.

With the addition of sysfs driver_override, there is now a
straightforward and direct way to match the i3cdev driver to any i3c
device without stepping on the toes of more specialized drivers that are
loaded automatically.

This is accomplished by the i3cdev driver not having any entries in the
i3c_device_id table. After boot, simply set the driver_override to
"i3cdev" and bind the device manually via the sysfs bind knob. This can
also be automated with udev rules as well.

The character device interface will be exposed at:
/dev/bus/i3c/<bus id>-<Provisional ID>

Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
Assisted-by: Claude:claude-opus-4.8 copilot
---
 Documentation/userspace-api/i3c/i3cdev.rst    | 152 ++++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   7 +
 drivers/i3c/Kconfig                           |  12 +
 drivers/i3c/Makefile                          |   1 +
 drivers/i3c/i3cdev.c                          | 730 ++++++++++++++++++
 include/uapi/linux/i3c/i3cdev.h               |  70 ++
 7 files changed, 973 insertions(+)
 create mode 100644 Documentation/userspace-api/i3c/i3cdev.rst
 create mode 100644 drivers/i3c/i3cdev.c
 create mode 100644 include/uapi/linux/i3c/i3cdev.h

diff --git a/Documentation/userspace-api/i3c/i3cdev.rst b/Documentation/userspace-api/i3c/i3cdev.rst
new file mode 100644
index 000000000000..ad246bf28919
--- /dev/null
+++ b/Documentation/userspace-api/i3c/i3cdev.rst
@@ -0,0 +1,152 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+I3C Device Interface
+====================
+
+This interface allows access to I3C devices from userspace.
+
+As I3C devices adhere to the I3C protocol, simple transfers can be accomplished
+using a generic driver. Currently, this interface supports private Single Data
+Rate (SDR) read and write transfers.
+
+The i3cdev module will not auto-bind to devices. Userspace needs to explicitly
+bind the device to the driver. This is to avoid interfering with the binding of
+specialized drivers.
+
+Once bound, a character device interface will be created at:
+/dev/bus/i3c/<bus id>-<Provisional ID>.
+
+====================
+Usage
+====================
+
+Any discovered I3C devices by the I3C subsystem will have device folders under /sys/bus/i3c/devices/<bus id>-<Provisional ID>.
+To allow binding of a device with i3cdev driver, set the driver_override:
+
+::
+
+    # echo "i3cdev" > /sys/bus/i3c/devices/<bus id>-<Provisional ID>/driver_override
+
+If the i3cdev driver is not yet loaded, load it and it will cause the driver to bind
+to any devices with the override in place.
+
+If the i3cdev driver is already loaded, go ahead and perform a manual bind:
+
+::
+
+    # echo "<bus id>-<Provisional ID>" > /sys/bus/i3c/drivers/i3cdev/bind
+
+Set driver override
+::
+
+    # echo "i3cdev" > /sys/bus/i3c/devices/0-deadbeef001/driver_override
+    # echo "i3cdev" > /sys/bus/i3c/devices/0-deadbeef002/driver_override
+
+Bind the device to the driver
+::
+
+    # echo "0-deadbeef001" > /sys/bus/i3c/drivers/i3cdev/bind
+    # echo "0-deadbeef002" > /sys/bus/i3c/drivers/i3cdev/bind
+
+Observe the resulting character device files under /dev/bus/i3c/
+::
+
+    # ls -ltr /dev/bus/i3c/
+    crw-------    1 root     root      235,   1 Jun 30 17:49 0-deadbeef002
+    crw-------    1 root     root      235,   0 Jun 30 17:49 0-deadbeef001
+
+BASIC CHARACTER DEVICE API
+===============================
+The API supports private Single Data Rate (SDR) read and write transfers.
+Those transaction can be achieved by the following:
+
+``read(file, buffer, sizeof(buffer))``
+  The standard read() operation will work as a simple transaction of private
+  SDR read data followed a stop.
+  Return the number of bytes read on success, and a negative error otherwise.
+
+``write(file, buffer, sizeof(buffer))``
+  The standard write() operation will work as a simple transaction of private
+  SDR write data followed a stop.
+  Return the number of bytes written on success, and a negative error otherwise.
+
+``ioctl(file, I3CDEV_XFER, struct i3cdev_xfers *xfers)``
+  It combines read/write transactions without a stop in between.
+  Return 0 on success, and a negative error otherwise.
+
+C EXAMPLE (PSEUDO CODE)
+=======================
+You need to open (and get a file descriptor) to /dev/bus/i3c/<bus id>-<Provisional ID>,
+do your operations (read, write, ioctl), and then close it.
+
+The following header files should be included in an I3C program::
+
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <i3c/i3cdev.h>
+#include <stdint.h>
+
+These additionally are used by this example::
+
+#include <stdlib.h>
+#include <assert.h>
+
+To work with an I3C device, one must call open and get a file descriptor::
+
+	int fd;
+
+	fd = open("/dev/bus/i3c/0-deadbeef001", O_RDWR);
+	if (fd < 0)
+		exit(EXIT_FAILURE);
+
+Now that the file is open, we can do some operations::
+
+	int ret;
+
+	/* Write function */
+	uint8_t  buf[] = {0x00, 0xde, 0xad, 0xbe, 0xef};
+	ret = write(fd, buf, 5);
+	if (ret != 5) {
+		/* ERROR HANDLING: I3C transaction failed */
+	}
+
+	/*  Read function */
+	ret = read(fd, buf, 4);
+	if (ret < 0) {
+		/* ERROR HANDLING: I3C transaction failed */
+	} else {
+		/* Iterate over buf[] to get the read data */
+	}
+
+	/* IOCTL function */
+	struct i3cdev_xfer xfers[2] = {0}; /* Must zero out for compatibility */
+	struct i3cdev_xfers xfers_metadata = { .nxfers = 2,
+					       .xfers = (uintptr_t) xfers,
+					       .xfer_size = sizeof(struct i3cdev_xfer)
+					     };
+
+	uint8_t tx_buf[] = {0x00, 0xde, 0xad, 0xbe, 0xef};
+	uint8_t rx_buf[10];
+
+	xfers[0].data = (uintptr_t) tx_buf;
+	xfers[0].len = 5;
+	xfers[0].rnw = 0;
+	xfers[1].data = (uintptr_t) rx_buf;
+	xfers[1].len = 10;
+	xfers[1].rnw = 1;
+
+	ret = ioctl(fd, I3CDEV_XFER, (uintptr_t) &xfers_metadata);
+	if (ret < 0) {
+		/* ERROR HANDLING: I3C transaction failed */
+	} else {
+		/* For reads, optionally verify that the response matches expectations */
+		assert(xfers[1].len == xfers[1].actual_len);
+
+		/* For reads, iterate through response data using xfers[i].actual_len */
+	}
+
+The device can be closed when the open file descriptor is no longer required::
+
+	close(fd);
\ No newline at end of file
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 3f0ef1e27eb0..b40f3b3f63a6 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -81,6 +81,7 @@ Code  Seq#    Include File                                             Comments
 0x03  all    linux/hdreg.h
 0x04  D2-DC  linux/umsdos_fs.h                                         Dead since 2.6.11, but don't reuse these.
 0x06  all    linux/lp.h
+0x07  00-9E  linux/i3c/i3cdev.h                                        i3cdev driver for I3C subystem
 0x07  9F-D0  linux/vmw_vmci_defs.h, uapi/linux/vm_sockets.h
 0x09  all    linux/raid/md_u.h
 0x10  00-0F  drivers/char/s390/vmcp.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 81a9a02c919d..5c75a3585d23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12350,6 +12350,13 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
 F:	drivers/i3c/master/dw*
 
+I3C CHARACTER DEVICE DRIVER
+M:	Meagan Lloyd <meaganlloyd@linux.microsoft.com>
+S:	Supported
+F:	Documentation/userspace-api/i3c/i3cdev.rst
+F:	drivers/i3c/i3cdev.c
+F:	include/uapi/linux/i3c/i3cdev.h
+
 I3C SUBSYSTEM
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
 R:	Frank Li <Frank.Li@nxp.com>
diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index 626c54b386d5..630dc776c464 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -20,6 +20,18 @@ menuconfig I3C
 	  will be called i3c.
 
 if I3C
+
+config I3CDEV
+	tristate "I3C device interface"
+	depends on I3C
+	help
+	  Say Y here to include the i3cdev driver. This allows user-space to
+	  explicitly bind I3C devices to the driver in order to expose a
+	  character device interface for the I3C device under /dev/bus/i3c/.
+
+	  This support is also available as a module. If so, the module will
+	  be called i3cdev.
+
 source "drivers/i3c/master/Kconfig"
 endif # I3C
 
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 11982efbc6d9..606d422841b2 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 i3c-y				:= device.o master.o
 obj-$(CONFIG_I3C)		+= i3c.o
+obj-$(CONFIG_I3CDEV)		+= i3cdev.o
 obj-$(CONFIG_I3C)		+= master/
diff --git a/drivers/i3c/i3cdev.c b/drivers/i3c/i3cdev.c
new file mode 100644
index 000000000000..da0e6910a4f7
--- /dev/null
+++ b/drivers/i3c/i3cdev.c
@@ -0,0 +1,730 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Microsoft Corporation
+ *
+ * Author: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
+ *
+ * Based on code from:
+ *     Copyright (c) 2020 Synopsys, Inc. and/or its affiliates.
+ *     Author: Vitor Soares <vitor.soares@synopsys.com>
+ *
+ *     Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#include <linux/cdev.h>
+#include <linux/compat.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/i3c/device.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/i3c/master.h>
+#include <linux/cleanup.h>
+
+#include <uapi/linux/i3c/i3cdev.h>
+
+#define DRV_VERSION                         "1.0.0"
+#define SYSFS_PREFIX                        "i3cdev-"
+#define SYSFS_FORMAT                        SYSFS_PREFIX "%u"
+#define MAX_I3CDEV_DEVS                     256
+#define MAX_XFERS                           256
+#define MAX_TOTAL_DATA_BYTES                256
+
+struct i3cdev_data {
+	struct i3c_device *i3c;
+	struct device dev;
+	struct cdev cdev;
+	dev_t devt;
+	/* serializes in-flight transfers, set-up, and tear-down */
+	struct mutex lock;
+	bool bound;
+	u16 mwl;
+	atomic_t open_fd;
+};
+
+enum i3c_xfer_rnw {
+	I3C_WRITE = 0,
+	I3C_READ = 1,
+};
+
+static DEFINE_IDA(i3cdev_ida);
+static dev_t base_dev_t;
+
+/* Set-up character device path */
+static char *i3cdev_devnode(const struct device *dev, umode_t *mode)
+{
+	const struct i3cdev_data *i3cdev;
+	const char *name;
+
+	i3cdev = container_of_const(dev, struct i3cdev_data, dev);
+	name = dev_name(i3cdev_to_dev(i3cdev->i3c));
+
+	return kasprintf(GFP_KERNEL, "bus/i3c/%s", name);
+}
+
+static const struct class i3cdev_class = {
+	.name = "i3cdev",
+	.devnode = i3cdev_devnode,
+};
+
+/**
+ * exceeds_mwl() - Check if a write exceeds a specified Max Write Length (MWL)
+ * @i3cdev: Pointer to i3cdev_data
+ * @xfer: Pointer to a given i3c_xfer
+ *
+ * Returns: true if @xfer length exceeds MWL, false otherwise.
+ */
+static bool exceeds_mwl(struct i3cdev_data *i3cdev, struct i3c_xfer *xfer)
+{
+	if (i3cdev->mwl && xfer->len > i3cdev->mwl) {
+		dev_dbg(&i3cdev->dev, "Requested len exceeds MWL\n");
+		return true;
+	}
+
+	return false;
+}
+
+static inline bool is_write(struct i3c_xfer *x) { return x->rnw == I3C_WRITE; }
+
+static ssize_t
+i3cdev_read(struct file *file, char __user *buf, size_t count, loff_t *f_pos)
+{
+	struct i3cdev_data *i3cdev = file->private_data;
+	struct i3c_device *i3c = i3cdev->i3c;
+	struct i3c_xfer xfer = {
+		.rnw = I3C_READ
+	};
+	size_t len;
+	char *tmp;
+	int ret;
+
+	if (!i3cdev->bound)
+		return -ENXIO;
+
+	/* File system operation of 0 bytes is effectively a valid, no-op */
+	if (!count)
+		return 0;
+
+	/* Clamp transfer length within driver limits */
+	len = min(count, MAX_TOTAL_DATA_BYTES);
+	xfer.len = len;
+
+	tmp = kzalloc(len, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	xfer.data.in = tmp;
+
+	dev_dbg(&i3cdev->dev, "Reading %zu bytes\n", len);
+
+	scoped_guard(mutex, &i3cdev->lock) {
+		/* .remove was called so don't mess with the device */
+		if (!i3cdev->bound) {
+			ret = -ENXIO;
+			goto out_free_kbuf;
+		}
+
+		ret = i3c_device_do_xfers(i3c, &xfer, 1, I3C_SDR);
+		if (ret)
+			goto out_free_kbuf;
+	}
+
+	dev_dbg(&i3cdev->dev, "Received %u bytes\n", xfer.actual_len);
+
+	/* Guard against a buggy controller driver */
+	if (xfer.actual_len > len) {
+		ret = -EIO;
+		goto out_free_kbuf;
+	}
+
+	ret = copy_to_user(buf, tmp, xfer.actual_len) ? -EFAULT : xfer.actual_len;
+
+out_free_kbuf:
+	kfree(tmp);
+
+	return ret;
+}
+
+static ssize_t
+i3cdev_write(struct file *file, const char __user *buf, size_t count,
+	     loff_t *f_pos)
+{
+	struct i3cdev_data *i3cdev = file->private_data;
+	struct i3c_device *i3c = i3cdev->i3c;
+	struct i3c_xfer xfer = {
+		.rnw = I3C_WRITE
+	};
+	size_t len;
+	char *tmp;
+	int ret;
+
+	if (!i3cdev->bound)
+		return -ENXIO;
+
+	/* File system operation of 0 bytes is effectively a valid, no-op */
+	if (!count)
+		return 0;
+
+	if (exceeds_mwl(i3cdev, &xfer))
+		return -ENXIO;
+
+	/* Clamp transfer length within driver limits */
+	len = min(count, MAX_TOTAL_DATA_BYTES);
+	xfer.len = len;
+
+	tmp = memdup_user(buf, len);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+
+	xfer.data.out = tmp;
+
+	dev_dbg(&i3cdev->dev, "Writing %zu bytes\n", len);
+
+	scoped_guard(mutex, &i3cdev->lock) {
+		/* .remove was called so don't mess with the device */
+		if (!i3cdev->bound) {
+			ret = -ENXIO;
+			goto out_free_kbuf;
+		}
+
+		ret = i3c_device_do_xfers(i3c, &xfer, 1, I3C_SDR);
+		if (ret)
+			goto out_free_kbuf;
+	}
+
+out_free_kbuf:
+	kfree(tmp);
+
+	return !ret ? len : ret;
+}
+
+/* IOCTL Helper Functions */
+
+/**
+ * get_metadata() - Copy i3cdev_xfers (I3CDEV_XFER ioctl input) from user-space
+ * @i3cdev: i3cdev_data object
+ * @uxfers: User-space i3cdev_xfers object
+ * @metadata: Kernel i3cdev_xfers object into which @uxfers will be copied
+ *
+ * Returns: 0 on success, a negative error code otherwise
+ */
+static int get_metadata(struct i3cdev_data *i3cdev,
+			struct i3cdev_xfers __user *uxfers,
+			struct i3cdev_xfers *metadata)
+{
+	if (copy_from_user(metadata, uxfers, sizeof(*metadata)))
+		return -EFAULT;
+
+	if (!metadata->nxfers)
+		return -EINVAL;
+
+	/* Limit and ensure nxfers fits in an int (for i3cdev and the core) */
+	if (metadata->nxfers > MAX_XFERS || metadata->nxfers > INT_MAX) {
+		dev_dbg(&i3cdev->dev,
+			"Number of transfers exceeds driver limit\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * get_user_xfers() - Copy array of i3cdev_xfer objects from user-space
+ * @metadata: Kernel i3cdev_xfers object (I3CDEV_XFER ioctl input)
+ *
+ * Allocates kernel memory and copies the user-space array of i3cdev_xfer
+ * objects into it. On success, the caller must free the memory.
+ *
+ * Returns: a pointer to the kernel's copy of the i3cdev_xfer array on
+ * success, an ERR_PTR otherwise.
+ */
+static struct i3cdev_xfer *get_user_xfers(struct i3cdev_xfers *metadata)
+{
+	struct i3cdev_xfer *k_uxfers, *k_uxfer;
+	u8 *uxfer;
+	int ret;
+
+	k_uxfers = kcalloc(metadata->nxfers, sizeof(*k_uxfers), GFP_KERNEL);
+	if (!k_uxfers)
+		return ERR_PTR(-ENOMEM);
+
+	k_uxfer = k_uxfers;
+	uxfer = u64_to_user_ptr(metadata->xfers);
+	for (int i = 0; i < metadata->nxfers; i++) {
+		ret = copy_struct_from_user(k_uxfer,
+					    sizeof(*k_uxfers),
+					    uxfer,
+					    metadata->xfer_size);
+		if (ret)
+			goto out_free_k_uxfers;
+
+		/* Enforce that padding must be zero */
+		if (memchr_inv(k_uxfer->pad, 0, sizeof(k_uxfer->pad))) {
+			ret = -EINVAL;
+			goto out_free_k_uxfers;
+		}
+
+		uxfer += metadata->xfer_size; /* u8 pointer so use xfer_size */
+		k_uxfer++;		      /* struct i3cdev_xfer pointer */
+	}
+
+	return k_uxfers;
+
+out_free_k_uxfers:
+	kfree(k_uxfers);
+	return ERR_PTR(ret);
+}
+
+/**
+ * ioctl_i3c_xfer_input_checks() - Checks that an anticipated transfer is valid
+ * by itself or in the context of an array of i3c_xfer objects.
+ * @i3cdev: i3cdev_data object
+ * @xfer: i3c_xfer object
+ * @prior_bytes: Number of bytes in the i3c_xfer array prior to this transfer
+ *
+ * Returns: 0 on success, a negative error code otherwise
+ */
+static int
+ioctl_i3c_xfer_input_checks(struct i3cdev_data *i3cdev,
+			    struct i3c_xfer *xfer,
+			    unsigned long prior_bytes)
+{
+	/* I3C core will error on a transfer of 0 bytes */
+	if (!xfer->len) {
+		dev_dbg(&i3cdev->dev, "Invalid transfer of zero bytes\n");
+		return -EINVAL;
+	}
+
+	if (xfer->rnw > 1) {
+		dev_dbg(&i3cdev->dev, "Invalid rnw encoding\n");
+		return -EINVAL;
+	}
+
+	if ((prior_bytes + xfer->len) > MAX_TOTAL_DATA_BYTES) {
+		dev_dbg(&i3cdev->dev, "Byte count exceeds driver limit\n");
+		return -EINVAL;
+	}
+
+	if (is_write(xfer) && exceeds_mwl(i3cdev, xfer))
+		return -ENXIO;
+
+	return 0;
+}
+
+/**
+ * i3cdev_prepare_xfers_from_user() - Prepare the i3c_xfer array
+ * @i3cdev: i3cdev_data object
+ * @metadata: Kernel's copy of i3cdev_xfers (ioctl I3CDEV_XFER input)
+ * @k_uxfers: Kernel's copy of the i3cdev_xfer array
+ * @i3c_xfers: i3c_xfer array that will be sent to the I3C core
+ * @nbufs: In/out variable representing the number of successfully allocated
+ * i3c_xfer data buffers. Use this to walk the array when freeing the memory.
+ *
+ * Returns: 0 on success, a negative error code otherwise
+ */
+static int
+i3cdev_prepare_xfers_from_user(struct i3cdev_data *i3cdev,
+			       struct i3cdev_xfers *metadata,
+			       struct i3cdev_xfer *k_uxfers,
+			       struct i3c_xfer *i3c_xfers,
+			       int *nbufs)
+{
+	int ret;
+	unsigned long total_bytes = 0;
+	void __user *udata;
+	void *data;
+
+	*nbufs = 0;
+
+	/* Prepare i3c_xfer objs to send via the I3C core */
+	for (int i = 0; i < metadata->nxfers; i++) {
+		/* Copy fields from i3cdev_xfer -> i3c_xfer */
+		i3c_xfers[i].rnw = k_uxfers[i].rnw;
+		i3c_xfers[i].len = k_uxfers[i].len;
+
+		ret = ioctl_i3c_xfer_input_checks(i3cdev, &i3c_xfers[i],
+						  total_bytes);
+		if (!ret)
+			total_bytes += i3c_xfers[i].len;
+		else
+			return ret;
+
+		if (is_write(&i3c_xfers[i])) {
+			/* Copy the data to transmit to kernel-space */
+			udata = u64_to_user_ptr(k_uxfers[i].data);
+			data = memdup_user(udata, i3c_xfers[i].len);
+		} else {
+			/* Prepare a buffer for the resulting read data */
+			data = kzalloc(i3c_xfers[i].len, GFP_KERNEL);
+			if (!data)
+				data = ERR_PTR(-ENOMEM);
+		}
+
+		if (IS_ERR(data))
+			return PTR_ERR(data);
+
+		/* Track allocated data buffers for freeing */
+		(*nbufs)++;
+
+		if (is_write(&i3c_xfers[i]))
+			i3c_xfers[i].data.out = data;
+		else
+			i3c_xfers[i].data.in = data;
+	}
+
+	return 0;
+}
+
+/**
+ * print_i3c_err() - Prints the I3C error encountered during the prior
+ * call to the core's transfer function.
+ * @i3cdev: i3cdev_data object
+ * @metadata: Kernel's copy of i3cdev_xfers (ioctl I3CDEV_XFER input)
+ * @i3c_xfers: i3c_xfer array that was sent to the I3C core
+ *
+ * Returns: void
+ */
+static void print_i3c_err(struct i3cdev_data *i3cdev,
+			  struct i3cdev_xfers *metadata,
+			  struct i3c_xfer *i3c_xfers)
+{
+	for (int i = 0; i < metadata->nxfers; i++) {
+		/* Valid errors, e.g. M0 (now called C0) start at 1 */
+		if (i3c_xfers[i].err > 0) {
+			dev_warn(&i3cdev->dev,
+				 "I3C error encountered: C%u\n",
+				 i3c_xfers[i].err - 1);
+			return;
+		}
+	}
+}
+
+/**
+ * i3cdev_copy_results_to_user() - Copy results to user-space
+ * @metadata: Kernel's copy of i3cdev_xfers (ioctl I3CDEV_XFER input)
+ * @k_uxfers: Kernel's copy of i3cdev_xfer array
+ * @i3c_xfers: i3c_xfer array that was sent to the I3C core
+ *
+ * Returns: 0 on success, a negative error code otherwise
+ */
+static int
+i3cdev_copy_results_to_user(struct i3cdev_xfers *metadata,
+			    struct i3cdev_xfer *k_uxfers,
+			    struct i3c_xfer *i3c_xfers)
+{
+	u8 __user *uxfer, *uactual_len;
+	void __user *udata;
+	__u16 nbytes;
+
+	uxfer = u64_to_user_ptr(metadata->xfers);
+	for (int i = 0; i < metadata->nxfers; i++, uxfer += metadata->xfer_size) {
+		if (is_write(&i3c_xfers[i])) {
+			continue;
+		} else {
+			udata = u64_to_user_ptr(k_uxfers[i].data);
+			nbytes = i3c_xfers[i].actual_len;
+
+			/* Guard against a buggy controller driver */
+			if (nbytes > k_uxfers[i].len)
+				return -EIO;
+
+			/* Copy over the read response data */
+			if (copy_to_user(udata, i3c_xfers[i].data.in, nbytes))
+				return -EFAULT;
+
+			/* Copy over actual_len */
+			uactual_len = uxfer + offsetof(struct i3cdev_xfer, actual_len);
+			if (copy_to_user(uactual_len, &nbytes, sizeof(__u16)))
+				return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * i3cdev_ioctl_do_xfers() - Implementing function of the I3CDEV_XFER IOCTL
+ * @i3cdev: i3cdev_data object
+ * @uxfers: User-space pointer to I3CDEV_XFER IOCTL input (struct i3cdev_xfers)
+ *
+ * Performs the requested SDR transfers and copies the results to user-space.
+ *
+ * Returns: 0 on success, negative error code otherwise.
+ */
+static int
+i3cdev_ioctl_do_xfers(struct i3cdev_data *i3cdev,
+		      struct i3cdev_xfers __user *uxfers)
+{
+	struct i3c_device *i3c = i3cdev->i3c;
+	struct i3cdev_xfers metadata;
+	struct i3cdev_xfer *k_uxfers;
+	struct i3c_xfer *i3c_xfers;
+	int nbufs;
+	int ret;
+
+	ret = get_metadata(i3cdev, uxfers, &metadata);
+	if (ret)
+		return ret;
+
+	k_uxfers = get_user_xfers(&metadata);
+	if (IS_ERR(k_uxfers))
+		return PTR_ERR(k_uxfers);
+
+	i3c_xfers = kcalloc(metadata.nxfers, sizeof(*i3c_xfers), GFP_KERNEL);
+	if (!i3c_xfers) {
+		ret = -ENOMEM;
+		goto out_free_k_uxfers;
+	}
+
+	/* Prepare i3c_xfer objs to send via the I3C core */
+	ret = i3cdev_prepare_xfers_from_user(i3cdev, &metadata, k_uxfers,
+					     i3c_xfers, &nbufs);
+	if (ret)
+		goto out_free_i3c_xfers;
+
+	scoped_guard(mutex, &i3cdev->lock) {
+		/* .remove was called so don't mess with the device */
+		if (!i3cdev->bound) {
+			ret = -ENXIO;
+			goto out_free_i3c_xfers;
+		}
+		ret = i3c_device_do_xfers(i3c, i3c_xfers,
+					  metadata.nxfers, I3C_SDR);
+		if (ret) {
+			print_i3c_err(i3cdev, &metadata, i3c_xfers);
+			goto out_free_i3c_xfers;
+		}
+	}
+
+	ret = i3cdev_copy_results_to_user(&metadata, k_uxfers, i3c_xfers);
+
+out_free_i3c_xfers:
+	for (int i = 0; i < nbufs; i++)
+		kfree(i3c_xfers[i].data.in);
+	kfree(i3c_xfers);
+
+out_free_k_uxfers:
+	kfree(k_uxfers);
+
+	return ret;
+}
+
+static long
+i3cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct i3cdev_data *i3cdev = file->private_data;
+	void __user *udata = (void __user *)arg;
+	int ret;
+
+	if (!i3cdev->bound)
+		return -ENXIO;
+
+	dev_dbg(&i3cdev->dev, "ioctl, cmd=0x%02x, arg=0x%02lx\n", cmd, arg);
+
+	switch (cmd) {
+	case I3CDEV_XFER:
+		ret = i3cdev_ioctl_do_xfers(i3cdev, udata);
+		break;
+	default:
+		return -ENOTTY;
+	}
+
+	return ret;
+}
+
+static int i3cdev_open(struct inode *inode, struct file *file)
+{
+	struct i3cdev_data *i3cdev;
+
+	i3cdev = container_of_const(inode->i_cdev, struct i3cdev_data, cdev);
+
+	/* Let probe finish cdev_device_add */
+	scoped_guard(mutex, &i3cdev->lock)
+		if (!i3cdev->bound)
+			return -ENXIO;
+
+	/*
+	 * Some devices have pointer or page registers where programming
+	 * it can change what an address refers to, avoid this by allowing
+	 * only one process to interact with the device.
+	 */
+	if (atomic_cmpxchg_relaxed(&i3cdev->open_fd, 0, 1))
+		return -EBUSY;
+
+	file->private_data = i3cdev;
+
+	return 0;
+}
+
+static int i3cdev_release(struct inode *inode, struct file *file)
+{
+	struct i3cdev_data *i3cdev = file->private_data;
+
+	atomic_set(&i3cdev->open_fd, 0);
+
+	return 0;
+}
+
+static const struct file_operations i3cdev_fops = {
+	.owner = THIS_MODULE,
+	.read = i3cdev_read,
+	.write = i3cdev_write,
+	.unlocked_ioctl	= i3cdev_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.open = i3cdev_open,
+	.release = i3cdev_release,
+};
+
+/* ------------------------------------------------------------------------- */
+
+static void free_i3cdev_data(struct device *d)
+{
+	struct i3cdev_data *i3cdev = container_of(d, struct i3cdev_data, dev);
+	struct device *i3c_device_dev = i3cdev_to_dev(i3cdev->i3c);
+
+	kfree(i3cdev);
+	/* Release the reference to the underlying device */
+	put_device(i3c_device_dev);
+}
+
+static int i3cdev_probe(struct i3c_device *i3c)
+{
+	struct i3cdev_data *i3cdev;
+	struct device *i3c_device_dev = i3cdev_to_dev(i3c);
+	int minor, ret;
+	struct i3c_device_info info;
+
+	i3cdev = kzalloc_obj(*i3cdev);
+	if (!i3cdev)
+		return -ENOMEM;
+
+	minor = ida_alloc_range(&i3cdev_ida, MINOR(base_dev_t),
+				MAX_I3CDEV_DEVS - 1, GFP_KERNEL);
+	if (minor < 0) {
+		dev_err(i3c_device_dev, "Not able to reserve a minor\n");
+		kfree(i3cdev);
+		return minor;
+	}
+
+	i3cdev->devt = MKDEV(MAJOR(base_dev_t), minor);
+
+	i3cdev->i3c = i3c;
+	i3cdev_set_drvdata(i3c, i3cdev);
+	/* Pin the underlying device as long as i3cdev lives */
+	get_device(i3c_device_dev);
+
+	i3c_device_get_info(i3c, &info);
+	i3cdev->mwl = info.max_write_len;
+
+	mutex_init(&i3cdev->lock);
+	atomic_set(&i3cdev->open_fd, 0);
+
+	i3cdev->dev.parent = i3c_device_dev;
+	i3cdev->dev.devt = i3cdev->devt;
+	i3cdev->dev.class = &i3cdev_class;
+	i3cdev->dev.release = free_i3cdev_data;
+	ret = dev_set_name(&i3cdev->dev, SYSFS_FORMAT, MINOR(i3cdev->devt));
+	if (ret)
+		goto error_free_ida;
+
+	device_initialize(&i3cdev->dev);
+
+	cdev_init(&i3cdev->cdev, &i3cdev_fops);
+	i3cdev->cdev.owner = THIS_MODULE;
+
+	scoped_guard(mutex, &i3cdev->lock) {
+		ret = cdev_device_add(&i3cdev->cdev, &i3cdev->dev);
+		if (ret)
+			goto error_cleanup;
+
+		i3cdev->bound = true;
+	}
+
+	return 0;
+
+error_cleanup:
+	put_device(&i3cdev->dev);
+
+error_free_ida:
+	ida_free(&i3cdev_ida, minor);
+
+	return ret;
+}
+
+static void i3cdev_remove(struct i3c_device *i3c)
+{
+	struct i3cdev_data *i3cdev;
+
+	i3cdev = i3cdev_get_drvdata(i3c);
+
+	/* via the lock, allow any work impacting the system to complete */
+	scoped_guard(mutex, &i3cdev->lock) {
+		/* signal to fops that the device is no longer managed */
+		i3cdev->bound = false;
+		cdev_device_del(&i3cdev->cdev, &i3cdev->dev);
+	}
+
+	ida_free(&i3cdev_ida, MINOR(i3cdev->devt));
+	put_device(&i3cdev->dev);
+}
+
+static const struct i3c_device_id i3cdev_ids[] = {
+	{ /* Sentinel */ },
+};
+
+static struct i3c_driver i3cdev_driver = {
+	.probe = i3cdev_probe,
+	.remove = i3cdev_remove,
+	.id_table = i3cdev_ids,
+	.driver = {
+		.name = "i3cdev",
+	}
+};
+
+static int __init i3cdev_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&base_dev_t, 0,
+				  MAX_I3CDEV_DEVS, "i3cdev");
+	if (ret)
+		return ret;
+
+	ret = class_register(&i3cdev_class);
+	if (ret)
+		goto err_unreg_chrdev_region;
+
+	ret = i3c_driver_register(&i3cdev_driver);
+	if (ret)
+		goto err_unregister_class;
+
+	return 0;
+
+err_unregister_class:
+	class_unregister(&i3cdev_class);
+
+err_unreg_chrdev_region:
+	unregister_chrdev_region(base_dev_t, MAX_I3CDEV_DEVS);
+
+	return ret;
+}
+module_init(i3cdev_init);
+
+static void __exit i3cdev_exit(void)
+{
+	i3c_driver_unregister(&i3cdev_driver);
+	class_unregister(&i3cdev_class);
+	unregister_chrdev_region(base_dev_t, MAX_I3CDEV_DEVS);
+	ida_destroy(&i3cdev_ida);
+}
+module_exit(i3cdev_exit);
+
+MODULE_AUTHOR("Meagan Lloyd <meaganlloyd@linux.microsoft.com>");
+MODULE_DESCRIPTION("I3C Character Device Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
diff --git a/include/uapi/linux/i3c/i3cdev.h b/include/uapi/linux/i3c/i3cdev.h
new file mode 100644
index 000000000000..ed72d7455f31
--- /dev/null
+++ b/include/uapi/linux/i3c/i3cdev.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2026 Microsoft Corporation
+ *
+ * Author: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
+ *
+ * Based on code from:
+ *     Copyright (c) 2020 Synopsys, Inc. and/or its affiliates.
+ *     Author: Vitor Soares <vitor.soares@synopsys.com>
+ *
+ *     Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#ifndef _UAPI_I3C_DEV_H_
+#define _UAPI_I3C_DEV_H_
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/**
+ * Reserved ioctl encoding for i3cdev
+ * Code 0x7, Seq# 0x0-0x9E
+ */
+#define I3CDEV_IOCTL_ID	0x07
+
+/**
+ * struct i3cdev_xfer - I3C transfer (read/write)
+ *
+ * This struct more-or-less mirrors the kernel's 'struct i3c_xfer'.
+ * Currently, only Single Data Rate (SDR) transfers are supported.
+ *
+ * @data: Pointer to userspace buffer. For writes, this will be the
+ * bytes to send to the Target. For reads, this buffer will be
+ * populated with the read response from the Target.
+ * @actual_len: Where the kernel will report the number of processed
+ * bytes. For reads, this reflects the number of response bytes in the
+ * @data buffer. For SDR writes, the user shouldn't use this member
+ * as it's neither supported nor useful.
+ * @len: Length of input @data buffer in bytes.
+ * @rnw: Transfer direction. 1 for a read, 0 for a write
+ * @pad: Used to eliminate implicit, undefined-value padding. Zero
+ * these bytes without referencing this field (for compatibility).
+ */
+struct i3cdev_xfer {
+	__u64 data;
+	__u16 actual_len; /* output */
+	__u16 len;
+	union {
+		__u8 rnw; /* SDR */
+		__u8 cmd; /* Not currently supported (HDR) */
+	};
+	__u8 pad[3];
+};
+
+/**
+ * struct i3cdev_xfers - I3C transfers
+ * @nxfers: Number of i3cdev_xfer objs in @xfers
+ * @xfers: Pointer to an array of i3cdev_xfer objs
+ * @xfer_size: sizeof(struct i3cdev_xfer)
+ */
+struct i3cdev_xfers {
+	__u64 nxfers;
+	__u64 xfers;
+	__u64 xfer_size;
+};
+
+#define I3CDEV_XFER \
+	_IOWR(I3CDEV_IOCTL_ID, 0, struct i3cdev_xfers)
+
+#endif
-- 
2.49.0

