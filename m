Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from [195.159.176.226] ([195.159.176.226]:45923 "EHLO
	blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbcHGRT1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2016 13:19:27 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1bWRUq-0007Tr-Nz
	for linux-iio@vger.kernel.org; Sun, 07 Aug 2016 19:04:20 +0200
To: linux-iio@vger.kernel.org
From: Atri Bhattacharya <badshah400@aim.com>
Subject: Re: [PATCH v4 0/7] Intel Integrated Sensor Hub Support (ISH)
Date: Sun, 07 Aug 2016 19:03:47 +0200
Message-ID: <1470589427.32229.2.camel@aim.com>
References: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Srinivas,

Apparently Patch 2 in the series didn't make it to the list again:
http://marc.info/?l=linux-iio&r=1&b=201608&w=2

Best wishes.

On Sun, 2016-08-07 at 02:25 -0700, Srinivas Pandruvada wrote:
> Change log
> v4:
> - Replace Bus PM suspend/resume callbacks to pm_ops calls to support
> callbacks from hibernate as pointer by Rafael
> - Fix kernel doc style comments: Now every function has kernel doc
> header
> - All checkpatch errors are resolved
> - Function returning just a single value with no users of return
> value to void
> - reference_count in struct ishtp_cl_device changed to bool as
> pointed by Ooi, Joyce
> - auto module load glue logic as suggested by Ooi, Joyce
> - Fix possible kernel warnings during module removal in ishtp
> - Remove devices during ish-pci module removal
> - Add Original-author tag
> - Add MAINTAINER entry
> 
> v3:
> - Rebased to linux-next as there are some new bus ids are added to
> linux-next
> - Documentation changes suggested by Jonathan
> - The PCI device name for BXTP is changed to APL
> - Added module parameter to enable DMA as some older FW
> have issues in DMA support.
> - On resume just restart to resume faster insted of reset for
> S3 compliant platforms
> 
> Thanks to Grant Likely and Atri Bhattacharya, Rann Bar and Ooi Joyce
> for test. 
> I will add Tested-by to commits for the final version of the patches.
> 
> v2:
> - Overview in documentation show analogy with usbhid implementation
> - sparse errors for statics. Also pointed by Jiri
> - Clearly marking exported function header file. Clean up all exports
> unused inteface functions
> - Changed to tristate from boolean as pointed by Jiri:
> this required remove/unload functions
> - Prevent crash when ISH enabled on non supported platform
> - Break client.c to smaller part by seprating buffer allocations
> - move bus register/unregister to ishtp module
> - There is only one config symbol INTEL_ISH_HID, removed silent
> config for TRANSPORT and IPC
> 
> 
> Starting from Cherrytrail, multiple generation of Intel processors
> offers
> on package sensor hub. Several recent tablets, 2-in-1 convertible
> laptops
> are using ISH instead of external sensor hubs. This resulted in lack
> of
> support of sensor function like device rotation and auto backlight
> adjustment.
> In addition, depending on the OEM implementation, support of ISH is
> required
> to support low power sleep states.
> 
> The support of ISH on Linux platforms is not new. Android platforms
> with
> Intel SoCs had this support for a while submitted by Daniel Drubin. 
> This patcheset is reusing most of those changes with  clean up and
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
> a short term work around is required till we have debugged this
> issue.
> In systemd unit file iio-sensor-proxy.service
> In the section "[Unit]" add
> After=multi-user.target
> 
> Srinivas Pandruvada (7):
>   Documentation: hid: Intel ISH HID document
>   hid: intel_ish-hid: ISH Transport layer
>   hid: intel-ish-hid: ipc layer
>   hid: intel-ish-hid: ISH HID client driver
>   iio: hid-sensors: use asynchronous resume
>   hid: hid-sensor-hub: Add ISH quirk
>   MAINTAINERS: Add Intel ISH
> 
>  Documentation/hid/intel-ish-hid.txt                |  454 +++++++++
>  MAINTAINERS                                        |    7 +
>  drivers/hid/Kconfig                                |    2 +
>  drivers/hid/Makefile                               |    2 +
>  drivers/hid/hid-sensor-hub.c                       |    4 +
>  drivers/hid/intel-ish-hid/Kconfig                  |   17 +
>  drivers/hid/intel-ish-hid/Makefile                 |   22 +
>  drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h        |  220 ++++
>  drivers/hid/intel-ish-hid/ipc/hw-ish.h             |   71 ++
>  drivers/hid/intel-ish-hid/ipc/ipc.c                |  882
> ++++++++++++++++
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c            |  333 +++++++
>  drivers/hid/intel-ish-hid/ipc/utils.h              |   64 ++
>  drivers/hid/intel-ish-hid/ishtp-hid-client.c       |  978
> ++++++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp-hid.c              |  246 +++++
>  drivers/hid/intel-ish-hid/ishtp-hid.h              |  182 ++++
>  drivers/hid/intel-ish-hid/ishtp/bus.c              |  791
> +++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp/bus.h              |  114 +++
>  drivers/hid/intel-ish-hid/ishtp/client-buffers.c   |  258 +++++
>  drivers/hid/intel-ish-hid/ishtp/client.c           | 1054
> ++++++++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp/client.h           |  182 ++++
>  drivers/hid/intel-ish-hid/ishtp/dma-if.c           |  175 ++++
>  drivers/hid/intel-ish-hid/ishtp/hbm.c              | 1032
> +++++++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp/hbm.h              |  321 ++++++
>  drivers/hid/intel-ish-hid/ishtp/init.c             |  115 +++
>  drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h        |  277 +++++
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    |   21 +-
>  include/linux/hid-sensor-hub.h                     |    1 +
>  include/trace/events/intel_ish.h                   |   30 +
>  include/uapi/linux/input.h                         |    1 +
>  29 files changed, 7855 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/hid/intel-ish-hid.txt
>  create mode 100644 drivers/hid/intel-ish-hid/Kconfig
>  create mode 100644 drivers/hid/intel-ish-hid/Makefile
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish.h
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/ipc.c
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/pci-ish.c
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/utils.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid-client.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/client-buffers.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/dma-if.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/init.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
>  create mode 100644 include/trace/events/intel_ish.h
> 
-- 
Atri Bhattacharya
Sun  7 Aug 19:02:13 CEST 2016

Sent from openSUSE Tumbleweed (20160805) (x86_64) on my laptop.

