Return-Path: <SRS0=+kYT=6V=huawei.com=jonathan.cameron@kernel.org>
Date: Tue, 18 Jul 2017 18:20:03 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "=?ISO-8859-1?Q?Br=FCns,?= Stefan" <Stefan.Bruens@rwth-aachen.de>
CC: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/2] iio: Documentation: Add ina2xx shunt_resistor
 attribute documentation
Message-ID: <20170718182003.00004555@huawei.com>
In-Reply-To: <10350930.kllyJhgabW@sbruens-linux>
References: <20170716233410.22880-1-stefan.bruens@rwth-aachen.de>
	<2351a045a0564f5bb2af6c652d1fa5e3@rwthex-w2-b.rwth-ad.de>
	<20170717215357.6452f0f5@kernel.org>
	<10350930.kllyJhgabW@sbruens-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

On Mon, 17 Jul 2017 21:44:19 +0000
"Br=FCns, Stefan" <Stefan.Bruens@rwth-aachen.de> wrote:

> On Montag, 17. Juli 2017 22:53:57 CEST Jonathan Cameron wrote:
> > On Mon, 17 Jul 2017 01:34:10 +0200
> >=20
> > Stefan Br=FCns <stefan.bruens@rwth-aachen.de> wrote: =20
> > > The ina2xx driver appeared in the Linux kernel version 4.5, but provi=
ded
> > > no documentation. Contrary to other uses of resistance in IIO, ina2xx=
 uses
> > > microohms instead of ohms in the sysfs attribute.
> > >=20
> > > Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de> =20
> >=20
> > This has me confused.  The documentation is already
> > there and lists it as being in ohms. =20
>=20
> Which obviously, from reading the source code, is wrong - it uses microoh=
ms.
Hmm. Not good
>=20
> Also, the current Description contains IMHO irrelevant stuff:
> "The value of the shunt resistor may be known only at runtime fom an
>  eeprom content read by a client application."
>=20
> > Ah, subtle filename difference.  Docs in are
> > Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc =20
>=20
> Well spotted ...
>=20
> > This attribute effectively exists for other parts
> > as well now. =20
>=20
> My grep foo failed me here, the only parts I could find are the MAX9611 (=
which=20
> specifies and uses ohms) and the INA2xx.
>=20
> adc/qcom-spmi-iadc.c allows to read the RSENSE value from device tree=20
> (specified in microohms), but does not expose it via sysfs.
>=20
> Can you point me to other devices?
You found it - just the one other part be it with several different shunt
related entries.

Now this is a problem as the ABI has to be consistent.  So one of these
drivers is buggy, and right now I'm thinking it is this one given the docs
are consistent.  The whole 'micro/milli' units was an ill  judged
attempt to try and be consistent with hwmon (we rapidly ran into issues
generalizing but by then were were stuck with a few odd units).

Recent policy has been the basic SI units if at all possible.
>=20
> Slightly off-topic: Some attributes in iio are read from device-tree (e.g=
.=20
> shunt resistor values), should the iio documentation point to the dt bind=
ings?=20
> Currently, only mount_matrix in sysfs-bus-iio vaguely mentions device-tre=
e.
>=20
The ABI docs probably shouldn't as it's an implementation detail.
However, if it's particularly useful for some reason I don't see any
real problem with doing so.

Jonathan

> Kind regards,
>=20
> Stefan
>=20
> > > ---
> > >=20
> > >  Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ina2x=
x-adc
> > >=20
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc
> > > b/Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc new file mode
> > > 100644
> > > index 000000000000..9525098f6822
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc
> > > @@ -0,0 +1,7 @@
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor
> > > +Date:		December 2015
> > > +KernelVersion:	4.5
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description: 	The value of the shunt resistor connected to the V_IN+=
  =20
> and
> > > V_IN- +		inputs, used to compute the current flowing through the shunt
> > > and +		the corresponding power. In microohms. =20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
