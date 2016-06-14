Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38969 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbcFNRZH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 14 Jun 2016 13:25:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1bCs5I-00023c-Tv
	for linux-iio@vger.kernel.org; Tue, 14 Jun 2016 19:25:05 +0200
Received: from cpe-173-174-74-64.austin.res.rr.com ([173.174.74.64])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Tue, 14 Jun 2016 19:25:04 +0200
Received: from me by cpe-173-174-74-64.austin.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Tue, 14 Jun 2016 19:25:04 +0200
To: linux-iio@vger.kernel.org
From: Daniel Turton <me@danielturton.net>
Subject: Re: [PATCH 0/6] Intel Integrated Sensor Hub Support (ISH)
Date: Tue, 14 Jun 2016 17:16:22 +0000 (UTC)
Message-ID: <loom.20160614T185808-391@post.gmane.org>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Srinivas Pandruvada <srinivas.pandruvada@...> writes:

> 
> Starting from Cherrytrail, multiple generation of Intel processors offers
> on package sensor hub. Several recent tablets, 2-in-1 convertible laptops
> are using ISH instead of external sensor hubs. This resulted in lack of
> support of sensor function like device rotation and auto backlight
> adjustment.

> In addition, depending on the OEM implementation, support of ISH is required
> to support low power sleep states.
> 
> The support of ISH on Linux platforms is not new. Android platforms with
> Intel SoCs had this support for a while submitted by Daniel Drubin. 
> This patcheset is reusing most of those changes with  clean up and
> removing Android platform specific changes.
> 
> The user mode ABI is still same as external sensor hubs using Linux
> IIO. So existing user mode software should still work.
> This series primarily brings in new HID transport used in ISH.
> 
> Thanks to the community members who tested RFC patches and provided
> feedback.
> 
> For users testing on Linux distributions using IIO sensor proxy,
> a short term work around is required till we have debugged this issue.
> In systemd unit file iio-sensor-proxy.service
> In the section "[Unit]" add
> After=multi-user.target
> 
> Daniel Drubin (3):
>   hid: intel_ish-hid: ISH Transport layer
>   hid: intel-ish-hid: ipc layer
>   hid: intel-ish-hid: ISH HID client driver
> 
> Srinivas Pandruvada (3):
>   Documentation: hid: Intel ISH HID document
>   iio: hid-sensors: use asynchronous resume
>   hid: hid-sensor-hub: Add ISH quirk
> 
>  Documentation/hid/intel-ish-hid.txt                |  417 ++++++++
>  drivers/hid/Kconfig                                |    2 +
>  drivers/hid/Makefile                               |    2 +
>  drivers/hid/hid-sensor-hub.c                       |    4 +
>  drivers/hid/intel-ish-hid/Kconfig                  |   27 +
>  drivers/hid/intel-ish-hid/Makefile                 |   20 +
>  drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h        |  220 ++++
>  drivers/hid/intel-ish-hid/ipc/hw-ish.h             |   70 ++
>  drivers/hid/intel-ish-hid/ipc/ipc.c                |  720 +++++++++++++
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c            |  305 ++++++
>  drivers/hid/intel-ish-hid/ipc/utils.h              |   64 ++
>  drivers/hid/intel-ish-hid/ishtp-hid-client.c       |  922 ++++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp-hid.c              |  231 ++++
>  drivers/hid/intel-ish-hid/ishtp-hid.h              |  182 ++++
>  drivers/hid/intel-ish-hid/ishtp/bus.c              |  774 ++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp/bus.h              |  105 ++
>  drivers/hid/intel-ish-hid/ishtp/client.c           | 1129
++++++++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp/client.h           |  194 ++++
>  drivers/hid/intel-ish-hid/ishtp/dma-if.c           |  178 +++
>  drivers/hid/intel-ish-hid/ishtp/hbm.c              |  911 ++++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp/hbm.h              |  319 ++++++
>  drivers/hid/intel-ish-hid/ishtp/init.c             |   94 ++
>  drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h        |  280 +++++
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    |   21 +-
>  include/linux/hid-sensor-hub.h                     |    1 +
>  include/trace/events/intel_ish.h                   |   30 +
>  include/uapi/linux/input.h                         |    1 +
>  27 files changed, 7222 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/hid/intel-ish-hid.txt
>  create mode 100644 drivers/hid/intel-ish-hid/Kconfig
>  create mode 100644 drivers/hid/intel-ish-hid/Makefile
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish.h
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/ipc.c
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/pci-ish.c
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/utils.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid-client.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/dma-if.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/init.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
>  create mode 100644 include/trace/events/intel_ish.h
> 

Hello Srinivas,

Thanks again for releasing this set of patches to get this chipset working.
Unfortunately, I'm still encountering a bit of trouble getting the chipset
to respond on my Lenovo Yoga 460/ Yoga 14. I've applied the newest patches
to Kernel 4.6.0 sources (commit #2dcd0af5, with Ubuntu patches applied), no
errors during compilation, but the system does not yet recognize the chipset.

There were no errors observed during kernel compilation, yet the
"modules.builtin" file that was created made no mention of the driver.
Please let me know if that's something that I can ignore in this case.

There were no mentions of the driver during boot, and only the minimal
mention of device "9d35" during the PCI bus scan at boot. There is also no
mention of at /sys/bus/iio directory after boot. Spoofing different OSes via
the acpi_osi boot option (used "Windows 2015". "Windows 2012", "Linux") made
no change in behavior.


Here's a copy of the current output from lspci:

00:13.0 Non-VGA unclassified device: Intel Corporation Device 9d35 (rev 21)
	Subsystem: Lenovo Device 504c
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at d564b000 (64-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Let me know if there's any other information that I can provide, and I'll be
happy to do so. Thanks for your time!

Daniel Turton

