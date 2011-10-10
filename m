Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E92FD7F.2040404@cam.ac.uk>
Date: Mon, 10 Oct 2011 15:13:19 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: unknown race somewhere in device registration or removal.
References: <4E92DF7A.4070604@cam.ac.uk>
In-Reply-To: <4E92DF7A.4070604@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/10/11 13:05, Jonathan Cameron wrote:
> Repeatedly hammer insert and removal of devices
> triggers a segfault.
> 
> For example:
> 
> [  205.589608] [<c00d54a0>] (remove_files.isra.1+0x20/0x30) from [<c00d5548>] (sysfs_remove_group+0x98/0xfc)
> [  205.599226] [<c00d5548>] (sysfs_remove_group+0x98/0xfc) from [<c014e468>] (device_remove_groups+0x1c/0x2c)
> [  205.608876] [<c014e468>] (device_remove_groups+0x1c/0x2c) from [<c014e648>] (device_remove_attrs+0x18/0x54)
> [  205.618603] [<c014e648>] (device_remove_attrs+0x18/0x54) from [<c014e790>] (device_del+0x10c/0x170)
> [  205.627636] [<c014e790>] (device_del+0x10c/0x170) from [<c014e800>] (device_unregister+0xc/0x18)
> [  205.636482] [<c014e800>] (device_unregister+0xc/0x18) from [<bf0c6a3c>] (li
> s3l02dq_remove+0xe4/0xf4 [lis3l02dq])
> [  205.646705] [<bf0c6a3c>] (lis3l02dq_remove+0xe4/0xf4 [lis3l02dq]) from [<c016534c>] (spi_drv_remove+0x18/0x1c)
> [  205.656717] [<c016534c>] (spi_drv_remove+0x18/0x1c) from [<c0150c44>] (__device_release_driver+0x7c/0xc0)
> [  205.666272] [<c0150c44>] (__device_release_driver+0x7c/0xc0) from [<c015123c>] (driver_detach+0x8c/0xb4)
> [  205.675731] [<c015123c>] (driver_detach+0x8c/0xb4) from [<c0150b18>] (bus_remove_driver+0x8c/0xb8)
> [  205.684716] [<c0150b18>] (bus_remove_driver+0x8c/0xb8) from [<c00559f8>] (sys_delete_module+0x1f0/0x284)
> [  205.694232] [<c00559f8>] (sys_delete_module+0x1f0/0x284) from [<c000dee0>] (ret_fast_syscall+0x0/0x38)
> [  205.703523] Code: e1a00005 e3a01000 e5932000 ebfff410 (e4943004) 
> [  205.715681] ---[ end trace b2c6bfc400ca8dce ]---
> 
> trying to track it down now.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Hmm.  The cause is a nasty issue to do with the fact we don't unwind the registration of devices
in the exact reverse of the way we register them. E.g .we don't have a split between device_unregister
and device_free unlike allocate and register.

This means there are a few elements created by other core functions that do not have a correct place
to be freed.  These include some of the attribute groups.  Hence we will have to spit the unregister
up into unregister which does reverse of register and free which actually frees the struct iio_dev
etc.

Sorry all about this, I really ought to have realised the problem was there when we first moved
to doing the sysfs groups registrations using the dev->groups approach.

This is going to involve a couple of changes to every driver unfortunately.

I'll put the set together, but could really do with some testing on as many parts as possible.
It's still not working quite right so this may take a little while to pin down the fall out.

To test, just set up a tight probe remove loop and wait and see if it segfaults on you.

Jonathan
