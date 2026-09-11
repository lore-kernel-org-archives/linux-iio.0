Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C013F927B;
	Fri, 11 Sep 2026 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161032; cv=none; b=HXgkzjxLKaO6u4811kkIu77/a+d2moPUhLR4e9cc2OaLj8gisZGi2F+xulOGEm8G1zgk7b1iPMoqwazTtGV4vM/x2IekBsLpQF3dFNCybeAdDRLvkeJsOhxBzbSHwx4TjGi2JpTaZHggiVPR6JIsTT3iBTYw8Dr2Pak37sG2uPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161032; c=relaxed/simple;
	bh=0iINUGSDQ0Mrto36jzZm49BkosYjKrXgLDl3kcWJdpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RpzM7Hi/iC7mrP65pFvxmQbLx/dFBudGXeMAw8PxBOPjGilwETVsm2NPgHYQCR+xuifQGhcw4PtS0e/MvYY4bHaCXwFhDsoVn0ub2NYAwyM6MuqyBtVLqbV4X7qKCBg1YUK1A5ngZuel+VNSB6h5M2vTFbRSNTiDAlj/r7J7c2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XwmygFmu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XwmygFmu"
Received: by linux.microsoft.com (Postfix, from userid 1223)
	id 9116720B7166; Fri, 11 Sep 2026 14:09:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9116720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789160988;
	bh=THnrSOejQfaU28Paks7cQy0EHvgqxbuZFWhp6Jm3Ero=;
	h=From:To:Cc:Subject:Date:From;
	b=XwmygFmujO2UbAZ1RmnH0Ql9C1sNKBELIeu5ztEkbxAPK7vO2PC/JBRFOb2TrqXwy
	 pJ7Mj4mXbO5VTmCCM7QuTkga7DYPjT27bt/6Etjh68VhvYyRGLsv33uUR0UTshvubi
	 B/NCR72QiQVEPMVPV8DlO2RBeycywq9s8yv+4Wrs=
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
Subject: [PATCH 0/3] I3C character device driver using driver_override
Date: Fri, 11 Sep 2026 14:09:32 -0700
Message-ID: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a rework and revival option for Vitor Soares' I3C character
device driver patch series from 2020 [1] that I've been exploring for a
few months.  Recently there was a revival posted to the list [2], so I
wanted to share this design option as well.

In [1] and [2], the i3cdev driver automatically attaches and detaches
depending whether another driver has attached/not. In [1], Boris was
suggesting we explore a more straightforward and traditional binding
method aligning with the Linux driver model. At the time, there wasn't
a way to auto-bind while keeping manual binding possible as they shared
the same match() hook. Now with the new driver_override feature, the
auto-binding of i3cdev on boot can be avoided if the i3cdev driver has
an empty match ID table. After boot, where specialized drivers would have
already bound, user-space can explicitly opt-in by setting the
driver_override sysfs file with 'i3cdev' and manually binding via sysfs
(or by simply loading the driver if it's loadable). This can also be
easily automated with udev rules that run whenever the I3C core exposes
a new device.

One downside of the automatic attach/de-attach is that if a different
driver is loaded later, the first driver could have altered something
on the device, breaking any assumptions of the subsequent driver.

My series builds on [1] through:
0. Addressing code review feedback in [1] from Greg, Boris, and Randy.
1. Using actual_len for accurate read response reporting. The kernel
will report actual_len received from the core to user-space via the
uapi i3cdev_xfer struct.
2. Placing limits on the number of transfers and bytes in requests to
prevent unlimited-sized transfers or kernel memory allocation
3. Checking inputs and descriptive return codes as guard-rails
for user-space and to ease use of the i3cdev driver
4. Checking on MWL to ensure that we respect device limits
5. Proper lifetime management of i3cdev_data and underlying device
6. Addressing dangling fops in the event we have an open file descriptor
when a device gets unbound.
7. Fast-path locking to ensure transfers complete before a device is
unbound.
8. Allowing only one file descriptor per I3C device to avoid bugs
around multiple processes interacting with the device and altering
the device underneath the other. For example, without this, one process
could change the device's page or address pointer register underneath
the other process.
9. copy_struct_from_user to ensure struct i3cdev_xfer could be extended
in a compatible way. This is to be forward-looking towards potential
HDR mode expansion and code reuse.
10. Reserving the IOCTL number formally
11. Updating the Documentation to be a syntax correct example program
template.
12. Preserving /dev/bus/i3c/<bus id>-<Provisional ID> naming while
allowing sysfs path to be neatly named i3cdev-<minor>. This avoids
repeated <bus id>-<Provisional ID> in the sysfs paths which can be
confusing/circular-looking.
    e.g. /sys/bus/i3c/devices/0-deadbeef001/i3cdev/0-deadbeef001 ->
         /sys/bus/i3c/devices/0-deadbeef001/i3cdev/i3cdev-0
13. Updating all naming references related to i3c_priv_xfer to align
with new i3c_xfer struct
14. Updating the MAINTAINERS file for the new pieces of code

Note that i3c-tools [3] or a fork of it will need small updates:
1. Update include/uapi/linux/i3c/i3cdev.h to match updated uapi structs
2. In i3ctransfer.c, use actual_len for reads

I've added MODULE_VERSION("1.0.0") in the i3cdev driver, so i3c-tools
could use that to determine whether to use the old out-of-tree uapi or this one.

[1] https://lore.kernel.org/linux-i3c/cover.1582069402.git.vitor.soares@synopsys.com/
[2] https://lore.kernel.org/linux-i3c/ap_1-gFF7S821xJT@ninjato/T/#m9107c1785a4a16b1b3cb84c3269d17fac35819c8
[3] https://github.com/vitor-soares-snps/i3c-tools

Meagan Lloyd (3):
  i3c: master: enable driver_override for I3C
  i3c: set i3c_xfer.actual_len in controller drivers
  i3c: add i3cdev character device module for user-space access

 Documentation/userspace-api/i3c/i3cdev.rst    | 152 ++++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   7 +
 drivers/hwmon/lm75.c                          |   7 +-
 drivers/hwmon/tmp108.c                        |   2 +
 drivers/i3c/Kconfig                           |  12 +
 drivers/i3c/Makefile                          |   1 +
 drivers/i3c/i3cdev.c                          | 730 ++++++++++++++++++
 drivers/i3c/master.c                          |   6 +
 drivers/i3c/master/adi-i3c-master.c           |   5 +-
 drivers/i3c/master/dw-i3c-master.c            |   4 +-
 drivers/i3c/master/i3c-master-cdns.c          |   5 +-
 drivers/i3c/master/mipi-i3c-hci/core.c        |   5 +-
 drivers/i3c/master/renesas-i3c.c              |   3 +
 drivers/iio/adc/ad4062.c                      |  10 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c   |   3 +
 include/uapi/linux/i3c/i3cdev.h               |  70 ++
 17 files changed, 1016 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/userspace-api/i3c/i3cdev.rst
 create mode 100644 drivers/i3c/i3cdev.c
 create mode 100644 include/uapi/linux/i3c/i3cdev.h


base-commit: cab40cfc9e116acd4d60f95b4b1264cab78f3803
-- 
2.49.0

