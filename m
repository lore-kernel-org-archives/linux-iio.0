Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25622 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbcFKMOx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 11 Jun 2016 08:14:53 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org, jic23@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, chaya.golan@intel.com,
	daniel.drubin@intel.com, A.Bhattacharya@ulg.ac.be,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/6] Intel Integrated Sensor Hub Support (ISH)
Date: Sat, 11 Jun 2016 05:13:33 -0700
Message-Id: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Starting from Cherrytrail, multiple generation of Intel processors offers
on package sensor hub. Several recent tablets, 2-in-1 convertible laptops
are using ISH instead of external sensor hubs. This resulted in lack of
support of sensor function like device rotation and auto backlight
adjustment.
In addition, depending on the OEM implementation, support of ISH is required
to support low power sleep states.

The support of ISH on Linux platforms is not new. Android platforms with
Intel SoCs had this support for a while submitted by Daniel Drubin. 
This patcheset is reusing most of those changes with  clean up and
removing Android platform specific changes.

The user mode ABI is still same as external sensor hubs using Linux
IIO. So existing user mode software should still work.
This series primarily brings in new HID transport used in ISH.

Thanks to the community members who tested RFC patches and provided
feedback.

For users testing on Linux distributions using IIO sensor proxy,
a short term work around is required till we have debugged this issue.
In systemd unit file iio-sensor-proxy.service
In the section "[Unit]" add
After=multi-user.target

Daniel Drubin (3):
  hid: intel_ish-hid: ISH Transport layer
  hid: intel-ish-hid: ipc layer
  hid: intel-ish-hid: ISH HID client driver

Srinivas Pandruvada (3):
  Documentation: hid: Intel ISH HID document
  iio: hid-sensors: use asynchronous resume
  hid: hid-sensor-hub: Add ISH quirk

 Documentation/hid/intel-ish-hid.txt                |  417 ++++++++
 drivers/hid/Kconfig                                |    2 +
 drivers/hid/Makefile                               |    2 +
 drivers/hid/hid-sensor-hub.c                       |    4 +
 drivers/hid/intel-ish-hid/Kconfig                  |   27 +
 drivers/hid/intel-ish-hid/Makefile                 |   20 +
 drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h        |  220 ++++
 drivers/hid/intel-ish-hid/ipc/hw-ish.h             |   70 ++
 drivers/hid/intel-ish-hid/ipc/ipc.c                |  720 +++++++++++++
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |  305 ++++++
 drivers/hid/intel-ish-hid/ipc/utils.h              |   64 ++
 drivers/hid/intel-ish-hid/ishtp-hid-client.c       |  922 ++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp-hid.c              |  231 ++++
 drivers/hid/intel-ish-hid/ishtp-hid.h              |  182 ++++
 drivers/hid/intel-ish-hid/ishtp/bus.c              |  774 ++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/bus.h              |  105 ++
 drivers/hid/intel-ish-hid/ishtp/client.c           | 1129 ++++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/client.h           |  194 ++++
 drivers/hid/intel-ish-hid/ishtp/dma-if.c           |  178 +++
 drivers/hid/intel-ish-hid/ishtp/hbm.c              |  911 ++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/hbm.h              |  319 ++++++
 drivers/hid/intel-ish-hid/ishtp/init.c             |   94 ++
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h        |  280 +++++
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   21 +-
 include/linux/hid-sensor-hub.h                     |    1 +
 include/trace/events/intel_ish.h                   |   30 +
 include/uapi/linux/input.h                         |    1 +
 27 files changed, 7222 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/hid/intel-ish-hid.txt
 create mode 100644 drivers/hid/intel-ish-hid/Kconfig
 create mode 100644 drivers/hid/intel-ish-hid/Makefile
 create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h
 create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish.h
 create mode 100644 drivers/hid/intel-ish-hid/ipc/ipc.c
 create mode 100644 drivers/hid/intel-ish-hid/ipc/pci-ish.c
 create mode 100644 drivers/hid/intel-ish-hid/ipc/utils.h
 create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid-client.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.h
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.h
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.h
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/dma-if.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.h
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/init.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
 create mode 100644 include/trace/events/intel_ish.h

-- 
2.5.5

