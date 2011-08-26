Return-Path: <pthomas8589@gmail.com>
MIME-Version: 1.0
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177143006BAC41@LIMKCMBX1.ad.analog.com>
References: <1313593455-29706-1-git-send-email-michael.hennerich@analog.com>
	<4E4BDEBC.3090606@cam.ac.uk>
	<CAD56B7cP+b3EbpvwfnqMdU9oWJVWw-HG66SgQeY6EX3tFEaRiw@mail.gmail.com>
	<544AC56F16B56944AEC3BD4E3D59177143006BA839@LIMKCMBX1.ad.analog.com>
	<CAD56B7ea7kqEkjDo=4xH8e00Ss=CA1cANjr_Mo8vw+mo8NrvGA@mail.gmail.com>
	<544AC56F16B56944AEC3BD4E3D59177143006BAC41@LIMKCMBX1.ad.analog.com>
Date: Thu, 25 Aug 2011 23:41:05 -0700
Message-ID: <CAD56B7dxi-YE24BCtMEXuUoMCvnB=gLt4KxRpEO6J0pFHXXAcQ@mail.gmail.com>
Subject: Re: [PATCH] IIO: ADC: New driver for AD7190/AD7192/AD7195 4 Channel
 SPI ADC
From: Paul Thomas <pthomas8589@gmail.com>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

I was just trying to test this driver with the IRQ, and I get this
after a ctrl^c after a hung modprobe. I also get a "ad7192 spi1.1:
device ID query failed (0x3)", but it looks like the id isn't used.
Also this is with the ad7194 instead of the ad7192. I'm using
.irq=AT91SAM9260_ID_IRQ0 which works well for the mcp251x driver,
although with that device it's a dedicated interrupt line.

thanks,
Paul

WARNING: at kernel/irq/manage.c:421 enable_irq+0x38/0x70()
Unbalanced enable for IRQ 29
Modules linked in: ad7192(C+) ring_sw(C) at91_mci
[<c00145dc>] (unwind_backtrace+0x0/0xf4) from [<c001fa40>]
(warn_slowpath_common+0x4c/0x64)
[<c001fa40>] (warn_slowpath_common+0x4c/0x64) from [<c001faec>]
(warn_slowpath_fmt+0x30/0x40)
[<c001faec>] (warn_slowpath_fmt+0x30/0x40) from [<c00509b4>]
(enable_irq+0x38/0x70)
[<c00509b4>] (enable_irq+0x38/0x70) from [<bf00a73c>]
(ad7192_calibrate_all+0xd8/0x1d0 [ad7192])
[<bf00a73c>] (ad7192_calibrate_all+0xd8/0x1d0 [ad7192]) from
[<bf00b4b8>] (ad7192_probe+0x534/0x688 [ad7192])
[<bf00b4b8>] (ad7192_probe+0x534/0x688 [ad7192]) from [<c018ba7c>]
(spi_drv_probe+0x1c/0x24)
[<c018ba7c>] (spi_drv_probe+0x1c/0x24) from [<c01617cc>]
(driver_probe_device+0x80/0x1a8)
[<c01617cc>] (driver_probe_device+0x80/0x1a8) from [<c0161980>]
(__driver_attach+0x8c/0x90)
[<c0161980>] (__driver_attach+0x8c/0x90) from [<c016100c>]
(bus_for_each_dev+0x60/0x8c)
[<c016100c>] (bus_for_each_dev+0x60/0x8c) from [<c0160924>]
(bus_add_driver+0x180/0x248)
[<c0160924>] (bus_add_driver+0x180/0x248) from [<c0161f88>]
(driver_register+0x70/0x15c)
[<c0161f88>] (driver_register+0x70/0x15c) from [<c00086fc>]
(do_one_initcall+0x2c/0x168)
[<c00086fc>] (do_one_initcall+0x2c/0x168) from [<c004c4bc>]
(sys_init_module+0xf4/0x1300)
[<c004c4bc>] (sys_init_module+0xf4/0x1300) from [<c000f260>]
(ret_fast_syscall+0x0/0x2c)
---[ end trace 5a487e730da2977b ]---
