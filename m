Return-Path: <hns@goldelico.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 4/9] drivers:input:tsc2007: add iio interface to read external ADC input and temperature
From: H. Nikolaus Schaller <hns@goldelico.com>
In-Reply-To: <14C9094D-F93F-4604-BD5B-B67B236638A8@jic23.retrosnub.co.uk>
Date: Tue, 22 Nov 2016 15:00:00 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
 Sebastian Reichel <sre@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,
 Michael Welling <mwelling@ieee.org>,
 =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Igor Grinberg <grinberg@compulab.co.il>,
 "Andrew F. Davis" <afd@ti.com>,
 Mark Brown <broonie@kernel.org>,
 linux-input@vger.kernel.org,
 devicetree <devicetree@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-omap <linux-omap@vger.kernel.org>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 linux-iio@vger.kernel.org,
 kernel@pyra-handheld.com
Message-Id: <8978FA47-2C5E-4BA6-9E99-BBC4C40A48B9@goldelico.com>
References: <cover.1478890925.git.hns@goldelico.com> <6c64bb0331ad05840a2886bef6c3cfa64c866cb6.1478890925.git.hns@goldelico.com> <fc901399-0bde-d936-b9e2-4c591549eb55@kernel.org> <b4d79a26-4353-9860-a884-49c751bbe617@kernel.org> <20161119183849.GD20446@dtor-ws> <14C9094D-F93F-4604-BD5B-B67B236638A8@jic23.retrosnub.co.uk>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Dmitry and Jonathan,

> Am 19.11.2016 um 21:09 schrieb Jonathan Cameron =
<jic23@jic23.retrosnub.co.uk>:
>=20
>=20
>=20
>>>=20
>>> The IS_ENABLED macro takes care of both cases.
>>=20
>> No it doesn't. Have you tried building the driver into the kernel =
with
>> IIO as a module?

I have tried and it indeed fails to compile.

> Fair point. Is there a clean way of handling this?
>>=20

This seems to basically work and I have included it in [PATCH v8]:

obj-$(CONFIG_TOUCHSCREEN_TSC2004)	+=3D tsc2004.o
obj-$(CONFIG_TOUCHSCREEN_TSC2005)	+=3D tsc2005.o
tsc2007-y				:=3D tsc2007_core.o
ifeq ($(CONFIG_IIO),y)
tsc2007-y				+=3D tsc2007_iio.o
endif
ifeq ($(CONFIG_IIO),m)
tsc2007-y				+=3D tsc2007_iio.o
endif
obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+=3D tsc2007.o
obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+=3D ucb1400_ts.o
obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001)	+=3D wacom_w8001.o

but still has a problem because it is not possible to
reference functions from the iio core with CONFIG_IIO=3Dm
from a driver built into the kernel:

drivers/built-in.o: In function `tsc2007_iio_unconfigure':
=
/Users/hns/Sources/System/Kernel/Linux/src/master/drivers/input/touchscree=
n/tsc2007_iio.c:148: undefined reference to `iio_device_unregister'
drivers/built-in.o: In function `tsc2007_iio_configure':
=
/Users/hns/Sources/System/Kernel/Linux/src/master/drivers/input/touchscree=
n/tsc2007_iio.c:115: undefined reference to `devm_iio_device_alloc'
=
/Users/hns/Sources/System/Kernel/Linux/src/master/drivers/input/touchscree=
n/tsc2007_iio.c:133: undefined reference to `iio_device_register'

So it would mean that we have to dynamically locate
and bind iio_device_(un)register and devm_iio_device_alloc.

BR and thanks,
Nikolaus
