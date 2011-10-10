Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:55022 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab1JJMFO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2011 08:05:14 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:42500)
	by ppsw-51.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1RDEbZ-0001aI-XI (Exim 4.72) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Mon, 10 Oct 2011 13:05:13 +0100
Message-ID: <4E92DF7A.4070604@cam.ac.uk>
Date: Mon, 10 Oct 2011 13:05:14 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: unknown race somewhere in device registration or removal.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Repeatedly hammer insert and removal of devices
triggers a segfault.

For example:

[  205.589608] [<c00d54a0>] (remove_files.isra.1+0x20/0x30) from [<c00d5548>] (sysfs_remove_group+0x98/0xfc)
[  205.599226] [<c00d5548>] (sysfs_remove_group+0x98/0xfc) from [<c014e468>] (device_remove_groups+0x1c/0x2c)
[  205.608876] [<c014e468>] (device_remove_groups+0x1c/0x2c) from [<c014e648>] (device_remove_attrs+0x18/0x54)
[  205.618603] [<c014e648>] (device_remove_attrs+0x18/0x54) from [<c014e790>] (device_del+0x10c/0x170)
[  205.627636] [<c014e790>] (device_del+0x10c/0x170) from [<c014e800>] (device_unregister+0xc/0x18)
[  205.636482] [<c014e800>] (device_unregister+0xc/0x18) from [<bf0c6a3c>] (li
s3l02dq_remove+0xe4/0xf4 [lis3l02dq])
[  205.646705] [<bf0c6a3c>] (lis3l02dq_remove+0xe4/0xf4 [lis3l02dq]) from [<c016534c>] (spi_drv_remove+0x18/0x1c)
[  205.656717] [<c016534c>] (spi_drv_remove+0x18/0x1c) from [<c0150c44>] (__device_release_driver+0x7c/0xc0)
[  205.666272] [<c0150c44>] (__device_release_driver+0x7c/0xc0) from [<c015123c>] (driver_detach+0x8c/0xb4)
[  205.675731] [<c015123c>] (driver_detach+0x8c/0xb4) from [<c0150b18>] (bus_remove_driver+0x8c/0xb8)
[  205.684716] [<c0150b18>] (bus_remove_driver+0x8c/0xb8) from [<c00559f8>] (sys_delete_module+0x1f0/0x284)
[  205.694232] [<c00559f8>] (sys_delete_module+0x1f0/0x284) from [<c000dee0>] (ret_fast_syscall+0x0/0x38)
[  205.703523] Code: e1a00005 e3a01000 e5932000 ebfff410 (e4943004) 
[  205.715681] ---[ end trace b2c6bfc400ca8dce ]---

trying to track it down now.
