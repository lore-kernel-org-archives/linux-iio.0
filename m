Return-Path: <tiberiu.a.breana@intel.com>
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: RE: [PATCH v2 0/5] stk3310 fixes and cleanup
Date: Fri, 10 Jul 2015 08:02:07 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F402216EFD3@IRSMSX109.ger.corp.intel.com>
References: <cover.1436398691.git.knaack.h@gmx.de>
In-Reply-To: <cover.1436398691.git.knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> -----Original Message-----
> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
> Sent: Friday, July 10, 2015 12:51 AM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Breana, Tiberiu
> A
> Subject: [PATCH v2 0/5] stk3310 fixes and cleanup
>=20
> Changes in V2:
>   * move interrupt setup before device registration, as pointed out by
>     Jonathan and confirmed by Tiberiu Breana
>   * incooperate a check for negative-only values of the provided irq
>     number, as requested by Tiberiu Breana
>=20
> Hartmut Knaack (5):
>   iio:light:stk3310: move device register to end of probe
>   iio:light:stk3310: make endianness independent of host
>   iio:light:stk3310: add more error handling
>   iio:light:stk3310: use correct names and type for state
>   iio:light:stk3310: adjust indentation
>=20
>  drivers/iio/light/stk3310.c | 97 ++++++++++++++++++++++++++++++--------
> -------
>  1 file changed, 64 insertions(+), 33 deletions(-)
>=20
> --
> 2.4.3

+1

Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
