Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.stresser.de ([88.198.198.115]:37796 "EHLO mail.stresser.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751234AbeCGKFR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Mar 2018 05:05:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.stresser.de (Postfix) with ESMTP id 5E3C04380065
        for <linux-iio@vger.kernel.org>; Wed,  7 Mar 2018 10:57:56 +0100 (CET)
Received: from _ (frachter.heine.tech [46.4.84.91])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stresser.de (Postfix) with ESMTPSA id 2AC2A4380063
        for <linux-iio@vger.kernel.org>; Wed,  7 Mar 2018 10:57:55 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 07 Mar 2018 10:57:55 +0100
From: Michael Nosthoff <posted@heine.so>
To: linux-iio@vger.kernel.org
Subject: ad7793: sysfs: cannot create duplicate filename sampling_frequency
Message-ID: <7eba3630b84c0b366ef7da2bcdec5da8@heine.so>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I'm running a Sitara based system which utilizes a AD7792 ADC via the
ad7793 IIO driver.
I recently started to move our kernel from 4.9 to 4.14 and ran into the
following error when initializing the driver:

[    3.064265] ------------[ cut here ]------------
[    3.064281] WARNING: CPU: 1 PID: 1 at fs/sysfs/dir.c:31 
sysfs_warn_dup+0x68/0x78
[    3.064285] sysfs: cannot create duplicate filename 
'/devices/platform/44000000.ocp/4809a000.spi/spi_master/spi2/spi2.0/iio:device0/sampling_frequency'
[    3.064287] Modules linked in:
[    3.064297] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 
4.14.23-01865-g1e22765 #195
[    3.064301] Hardware name: Generic DRA74X (Flattened Device Tree)
[    3.064321] [<c0210084>] (unwind_backtrace) from [<c020b840>] 
(show_stack+0x10/0x14)
[    3.064334] [<c020b840>] (show_stack) from [<c09e3d50>] 
(dump_stack+0x7c/0x90)
[    3.064348] [<c09e3d50>] (dump_stack) from [<c0235e4c>] 
(__warn+0xec/0x104)
[    3.064358] [<c0235e4c>] (__warn) from [<c0235e9c>] 
(warn_slowpath_fmt+0x38/0x48)
[    3.064366] [<c0235e9c>] (warn_slowpath_fmt) from [<c03bbf8c>] 
(sysfs_warn_dup+0x68/0x78)
[    3.064376] [<c03bbf8c>] (sysfs_warn_dup) from [<c03bbca0>] 
(sysfs_add_file_mode_ns+0x148/0x194)
[    3.064384] [<c03bbca0>] (sysfs_add_file_mode_ns) from [<c03bc5ec>] 
(internal_create_group+0xf8/0x2e8)
[    3.064392] [<c03bc5ec>] (internal_create_group) from [<c03bcb70>] 
(sysfs_create_groups+0x44/0x80)
[    3.064402] [<c03bcb70>] (sysfs_create_groups) from [<c0601a74>] 
(device_add+0x2f4/0x588)
[    3.064414] [<c0601a74>] (device_add) from [<c0356c88>] 
(cdev_device_add+0x4c/0x80)
[    3.064427] [<c0356c88>] (cdev_device_add) from [<c07c1410>] 
(iio_device_register+0x4d4/0x6d8)
[    3.064438] [<c07c1410>] (iio_device_register) from [<c07c6e64>] 
(ad7793_probe+0x1f0/0x48c)
[    3.064449] [<c07c6e64>] (ad7793_probe) from [<c067481c>] 
(spi_drv_probe+0x7c/0xa8)
[    3.064460] [<c067481c>] (spi_drv_probe) from [<c06043b0>] 
(driver_probe_device+0x238/0x2e8)
[    3.064470] [<c06043b0>] (driver_probe_device) from [<c0604504>] 
(__driver_attach+0xa4/0xa8)
[    3.064478] [<c0604504>] (__driver_attach) from [<c060291c>] 
(bus_for_each_dev+0x4c/0x9c)
[    3.064487] [<c060291c>] (bus_for_each_dev) from [<c0603928>] 
(bus_add_driver+0x18c/0x210)
[    3.064496] [<c0603928>] (bus_add_driver) from [<c0604b60>] 
(driver_register+0x78/0xf4)
[    3.064504] [<c0604b60>] (driver_register) from [<c0201b3c>] 
(do_one_initcall+0x44/0x168)
[    3.064516] [<c0201b3c>] (do_one_initcall) from [<c1000de8>] 
(kernel_init_freeable+0x148/0x1d4)
[    3.064526] [<c1000de8>] (kernel_init_freeable) from [<c09f6e70>] 
(kernel_init+0x8/0x108)
[    3.064534] [<c09f6e70>] (kernel_init) from [<c0207a98>] 
(ret_from_fork+0x14/0x3c)
[    3.064543] ---[ end trace ad59e170138815c0 ]---
[    3.064815] ad7793: probe of spi2.0 failed with error -17

I did some digging and came to the conclusion that there is basically a 
conflict
between the different ways to handle the 'sampling_frequency' 
declaration.

The driver utilizes this way

static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
		ad7793_read_frequency,
		ad7793_write_frequency);

to define the handling. But in the header "ad_sigma_delta.h"

.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)

is used.

I was not able to find a documentation on this but I'm guessing that 
these both
ways are mutual exclusive?

The problem seems to be introduced with commit a13e831f which changes 
the
mentioned header (which is shared between multiple AD devices) in 
combination
with the staging ad7192 driver.

 From a quick look the other drivers using this header don't use the
__AD_SD_CHANNEL macro so they don't run into this problem.

So a fix would be to either revert that commit or to update the ad7793 
driver
accordingly. If this would be of interest I would supply a patch.

Regards,
Michael

