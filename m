Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39071 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756887AbcGJOVp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2016 10:21:45 -0400
Subject: Re: [PATCH v3 0/6] Intel Integrated Sensor Hub Support (ISH)
To: Atri Bhattacharya <badshah400@aim.com>, linux-iio@vger.kernel.org
References: <1467831078-2530-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1467914542.1847.2.camel@aim.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <aae263b4-16dd-7503-9426-8e7059136ed6@kernel.org>
Date: Sun, 10 Jul 2016 15:21:43 +0100
MIME-Version: 1.0
In-Reply-To: <1467914542.1847.2.camel@aim.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/16 19:02, Atri Bhattacharya wrote:
> Dear Srinivas,
> Seems like patch number 2 (of 6) is missing from this patchset.
> 
> Cheers!
> 
For what it is worth it made it to me and the to list looks to be
the same as the other patches in the series...

Jonathan
> On Wed, 2016-07-06 at 11:51 -0700, Srinivas Pandruvada wrote:
>> Change log
>> v3:
>> - Rebased to linux-next as there are some new bus ids are added to
>> linux-next
>> - Documentation changes suggested by Jonathan
>> - The PCI device name for BXTP is changed to APL
>> - Added module parameter to enable DMA as some older FW
>> have issues in DMA support.
>> - On resume just restart to resume faster insted of reset for
>> S3 compliant platforms
>>
>> Thanks to Grant Likely and Atri Bhattacharya for test. 
>> I will add Tested-by to commits for the final version of the patches.
>>
>> v2:
>> - Overview in documentation show analogy with usbhid implementation
>> - sparse errors for statics. Also pointed by Jiri
>> - Clearly marking exported function header file. Clean up all exports
>> unused inteface functions
>> - Changed to tristate from boolean as pointed by Jiri:
>> this required remove/unload functions
>> - Prevent crash when ISH enabled on non supported platform
>> - Break client.c to smaller part by seprating buffer allocations
>> - move bus register/unregister to ishtp module
>> - There is only one config symbol INTEL_ISH_HID, removed silent
>> config for TRANSPORT and IPC
>>
>>
>> Starting from Cherrytrail, multiple generation of Intel processors
>> offers
>> on package sensor hub. Several recent tablets, 2-in-1 convertible
>> laptops
>> are using ISH instead of external sensor hubs. This resulted in lack
>> of
>> support of sensor function like device rotation and auto backlight
>> adjustment.
>> In addition, depending on the OEM implementation, support of ISH is
>> required
>> to support low power sleep states.
>>
>> The support of ISH on Linux platforms is not new. Android platforms
>> with
>> Intel SoCs had this support for a while submitted by Daniel Drubin. 
>> This patcheset is reusing most of those changes with  clean up and
>> removing Android platform specific changes.
>>
>> The user mode ABI is still same as external sensor hubs using Linux
>> IIO. So existing user mode software should still work.
>> This series primarily brings in new HID transport used in ISH.
>>
>> Thanks to the community members who tested RFC patches and provided
>> feedback.
>>
>> For users testing on Linux distributions using IIO sensor proxy,
>> a short term work around is required till we have debugged this
>> issue.
>> In systemd unit file iio-sensor-proxy.service
>> In the section "[Unit]" add
>> After=multi-user.target
>>
>> Daniel Drubin (3):
>>   hid: intel_ish-hid: ISH Transport layer
>>   hid: intel-ish-hid: ipc layer
>>   hid: intel-ish-hid: ISH HID client driver
>>
>> Srinivas Pandruvada (3):
>>   Documentation: hid: Intel ISH HID document
>>   iio: hid-sensors: use asynchronous resume
>>   hid: hid-sensor-hub: Add ISH quirk
>>
>>  Documentation/hid/intel-ish-hid.txt                | 454 ++++++++++
>>  drivers/hid/Kconfig                                |   2 +
>>  drivers/hid/Makefile                               |   2 +
>>  drivers/hid/hid-sensor-hub.c                       |   4 +
>>  drivers/hid/intel-ish-hid/Kconfig                  |  17 +
>>  drivers/hid/intel-ish-hid/Makefile                 |  22 +
>>  drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h        | 220 +++++
>>  drivers/hid/intel-ish-hid/ipc/hw-ish.h             |  71 ++
>>  drivers/hid/intel-ish-hid/ipc/ipc.c                | 719
>> ++++++++++++++++
>>  drivers/hid/intel-ish-hid/ipc/pci-ish.c            | 332 ++++++++
>>  drivers/hid/intel-ish-hid/ipc/utils.h              |  64 ++
>>  drivers/hid/intel-ish-hid/ishtp-hid-client.c       | 935
>> +++++++++++++++++++++
>>  drivers/hid/intel-ish-hid/ishtp-hid.c              | 234 ++++++
>>  drivers/hid/intel-ish-hid/ishtp-hid.h              | 182 ++++
>>  drivers/hid/intel-ish-hid/ishtp/bus.c              | 794
>> +++++++++++++++++
>>  drivers/hid/intel-ish-hid/ishtp/bus.h              | 113 +++
>>  drivers/hid/intel-ish-hid/ishtp/client-buffers.c   | 214 +++++
>>  drivers/hid/intel-ish-hid/ishtp/client.c           | 935
>> +++++++++++++++++++++
>>  drivers/hid/intel-ish-hid/ishtp/client.h           | 182 ++++
>>  drivers/hid/intel-ish-hid/ishtp/dma-if.c           | 178 ++++
>>  drivers/hid/intel-ish-hid/ishtp/hbm.c              | 912
>> ++++++++++++++++++++
>>  drivers/hid/intel-ish-hid/ishtp/hbm.h              | 321 +++++++
>>  drivers/hid/intel-ish-hid/ishtp/init.c             |  93 ++
>>  drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h        | 277 ++++++
>>  .../iio/common/hid-sensors/hid-sensor-trigger.c    |  21 +-
>>  include/linux/hid-sensor-hub.h                     |   1 +
>>  include/trace/events/intel_ish.h                   |  30 +
>>  include/uapi/linux/input.h                         |   1 +
>>  28 files changed, 7329 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/hid/intel-ish-hid.txt
>>  create mode 100644 drivers/hid/intel-ish-hid/Kconfig
>>  create mode 100644 drivers/hid/intel-ish-hid/Makefile
>>  create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h
>>  create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish.h
>>  create mode 100644 drivers/hid/intel-ish-hid/ipc/ipc.c
>>  create mode 100644 drivers/hid/intel-ish-hid/ipc/pci-ish.c
>>  create mode 100644 drivers/hid/intel-ish-hid/ipc/utils.h
>>  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid-client.c
>>  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.c
>>  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.h
>>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.c
>>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.h
>>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/client-buffers.c
>>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.c
>>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.h
>>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/dma-if.c
>>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.c
>>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.h
>>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/init.c
>>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
>>  create mode 100644 include/trace/events/intel_ish.h
>>

