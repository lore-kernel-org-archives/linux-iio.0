Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33177 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108AbcBWHYz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Feb 2016 02:24:55 -0500
Received: by mail-pa0-f42.google.com with SMTP id fl4so105757341pad.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Feb 2016 23:24:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: iio_simple_dummy_buffer_dma
From: John Syne <john3909@gmail.com>
In-Reply-To: <56CAF486.4060505@metafoo.de>
Date: Mon, 22 Feb 2016 23:24:52 -0800
Cc: linux-iio@vger.kernel.org
Message-Id: <C2ADEA23-C6EE-4BA8-AD94-57D38A0E0710@gmail.com>
References: <C78F84F2-A2D5-40B2-9291-F27FA95C8F52@gmail.com> <8CFE0549-CA65-4163-917D-5BF55DCC0E4A@gmail.com> <56CAF486.4060505@metafoo.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars,

I patched my kernel with your V1 patch and then applied any fixes from your V2 and V3 patch without removing iio_simple_dummy_buffer_dma.c and associated files. In kconfig I select DMA and KFIFO is not selected. I now get this strange error, but since these are defined in iio_simple_dummy_buffer_dma.c and I see it getting built the makefile shows it as a dependency for iio_dummy.o, this makes no sense to me:

+ Detected build host [Ubuntu 14.04.4 LTS]
+ host: [x86_64]
+ git HEAD commit: [8afc46c38d37aff4fecaefa385c647822251dd25]
-----------------------------
scripts/gcc: Using: arm-linux-gnueabihf-gcc (Linaro GCC 4.9-2015.05) 4.9.3 20150413 (prerelease)
Copyright (C) 2014 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-----------------------------
CROSS_COMPILE=/home/john/Download/GIT/ti-linux-kernel-dev/dl/gcc-linaro-4.9-2015.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-
scripts/kconfig/mconf  Kconfig


*** End of the configuration.
*** Execute 'make' to start the build or try 'make help'.

‘.config’ -> ‘/home/john/Download/GIT/ti-linux-kernel-dev/patches/defconfig’
-----------------------------
make -j8 ARCH=arm LOCALVERSION=-ti-r33 CROSS_COMPILE="/home/john/Download/GIT/ti-linux-kernel-dev/dl/gcc-linaro-4.9-2015.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-"  zImage modules
-----------------------------
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CHK     include/generated/bounds.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CHK     kernel/config_data.h
  DTC     drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dtb
  DTB     drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dtb.S
  AS      drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dtb.o
  LD      drivers/gpu/drm/tilcdc/built-in.o
rm drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dtb drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dtb.S
  CC      drivers/iio/buffer/industrialio-buffer-dma.o
  LD      drivers/iio/dummy/built-in.o
  CC [M]  drivers/iio/dummy/iio_simple_dummy.o
  CC [M]  drivers/iio/buffer/industrialio-buffer-cb.o
  CC [M]  drivers/iio/dummy/iio_simple_dummy_events.o
  CC [M]  drivers/iio/dummy/iio_simple_dummy_buffer_dma.o
  CC [M]  drivers/iio/buffer/industrialio-triggered-buffer.o
  CC [M]  drivers/iio/buffer/kfifo_buf.o
  CC [M]  drivers/iio/dummy/iio_dummy_evgen.o
  LD      drivers/iio/buffer/built-in.o
  LD [M]  drivers/iio/dummy/iio_dummy.o
  LD      drivers/iio/built-in.o
  Kernel: arch/arm/boot/Image is ready
  Building modules, stage 2.
  Kernel: arch/arm/boot/zImage is ready
  MODPOST 1956 modules
ERROR: "iio_dma_buffer_enable" [drivers/iio/dummy/iio_dummy.ko] undefined!
ERROR: "iio_dma_buffer_init" [drivers/iio/dummy/iio_dummy.ko] undefined!
ERROR: "iio_dma_buffer_disable" [drivers/iio/dummy/iio_dummy.ko] undefined!
ERROR: "iio_dma_buffer_set_bytes_per_datum" [drivers/iio/dummy/iio_dummy.ko] undefined!
ERROR: "iio_dma_buffer_set_length" [drivers/iio/dummy/iio_dummy.ko] undefined!
ERROR: "iio_dma_buffer_release" [drivers/iio/dummy/iio_dummy.ko] undefined!
ERROR: "iio_dma_buffer_request_update" [drivers/iio/dummy/iio_dummy.ko] undefined!
ERROR: "iio_dma_buffer_block_done" [drivers/iio/dummy/iio_dummy.ko] undefined!
ERROR: "iio_dma_buffer_block_list_abort" [drivers/iio/dummy/iio_dummy.ko] undefined!
ERROR: "iio_dma_buffer_read" [drivers/iio/dummy/iio_dummy.ko] undefined!
ERROR: "iio_dma_buffer_exit" [drivers/iio/dummy/iio_dummy.ko] undefined!
ERROR: "iio_dma_buffer_data_available" [drivers/iio/dummy/iio_dummy.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2


Regards,
John




> On Feb 22, 2016, at 3:44 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
> On 02/22/2016 05:51 AM, John Syne wrote:
>> BTW, I seem to remember that Lars removed iio_simple_dummy_buffer_dma.c in his V3 patch so this won’t be in the IIO repo, but I don’t know how to test the IIO DMA framework without this file.
>> 
> 
> Hi,
> 
> The patch was dropped for now to avoid conflicts with other ongoing work on
> the dummy driver. The patch will come back in a slightly overhauled version
> soonish.
> 
> As for your problem, make sure that you have the part of the patch which
> updates things so you can choose in Kconfig whether you want to use the DMA
> buffer or the KFIFO buffer. And then select the DMA buffer in your .config.
> 
> - Lars
> 
> 
>> Regards,
>> John
>> 
>> 
>> 
>> 
>>> On Feb 21, 2016, at 8:41 PM, John Syne <john3909@gmail.com> wrote:
>>> 
>>> Hi,
>>> 
>>> I am interested in using the IIO DMA framework and tried to use your dummy driver. 
>>> 
>>> I attempting to get the iio_dummy working with dma and seem to be having sum difficulty.
>>> 
>>> Here is what I have done so far:
>>> 
>>> I’m working on a BeagleBoneBlack running a 4.1 Linux Kernel. I have back ported the latest IIO code from git://git.kernel.org/pub/scm/linux/kernel/git/jic23
>>> 
>>> As a test I tried ti_am335x_adc.ko and enabled in_voltage0_en and then enabled the buffer. Reading from /dev/iio:device0 provided the waveform of the signal generator I had connected to ADC0 on the board. I was even able to run iiod and then connected IIO Oscilloscope which showed the same waveform. I did get a message WARNING: High-speed mode not enabled, but I guess there is no mmap in the driver and that is probably the issue.
>>> 
>>> In linux config, I have enabled the following:
>>> CONFIG_IIO_SIMPLE_DUMMY_EVENTS
>>> CONFIG_IIO_SIMPLE_DUMMY_BUFFER
>>> CONFIG_IIO_SIMPLE_DUMMY_BUFFER_DMA
>>> CONFIG_IIO_BUFFER_CB
>>> CONFIG_IIO_BUFFER_DMA
>>> CONFIG_IIO_BUFFER_DMAENGINE
>>> CONFIG_IIO_KFIFO_BUF
>>> CONFIG_IIO_TRIGGERED_BUFFER
>>> CONFIG_IIO_TRIGGER
>>> CONFIG_IIO_CONSUMERS_PER_TRIGGER 2
>>> 
>>> When I "modprobe iio_dummy”, the following modules are loaded:
>>> 
>>> industrialio
>>> industrialio_buffer_dma
>>> iio_dummy
>>> kfifo_buf
>>> iio_dummy_evgen
>>> 
>>> I then modprobe iio_trig_sysfs which gives me /sys/bus/iio/device/iio_sysfs_trigger. To create a trigger I did:
>>> 
>>>> echo 1 > /sys/bus/iio/device/iio_sysfs_trigger/add_trigger
>>>> cat name /sys/bus/iio/device/trigger0/name
>>>> sysfstrig1
>>>> echo sysfstrig1 > /sys/bus/iio/device/iio:device0/trigger/current_trigger
>>> 
>>> Now to enable a measurement:
>>> 
>>>> echo 1 > /sys/bus/iio/device/iio:device0/scan_elements/in_voltage0_en
>>> 
>>> Finally to enable the buffer:
>>> 
>>>> echo 1 /sys/bus/iio/device/iio:device0/buffer/enable
>>> 
>>> When I read "/dev/iio:device0" I get nothing. Connecting IIO Oscilloscope I get the following error message:
>>> 
>>> WARNING: High-speed mode not enabled
>>> ERROR: Reading from device failed: -110
>>> Client Exited
>>> 
>>> In iio_simple_dummy_buffer_dma.c, I see iio_dummy_dma_source which generates a rect, sine, tri and saw waveforms. Not sure what I need to do to get these waveforms to generate. Is this demo functional?
>>> 
>>> 
>>> Regards,
>>> John
>>> 
>>> 
>>> 
>>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

