Return-Path: <SRS0=kXWq=JW=huawei.com=jonathan.cameron@kernel.org>
Date: Fri, 6 Jul 2018 18:26:13 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen
	<lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	<jeff.dagenais@gmail.com>
Subject: Re: [PATCH v2] iio: light: introduce si1133
Message-ID: <20180706182613.0000732f@huawei.com>
In-Reply-To: <20180703162838.5jquauqlkfohsod4@mbedesk.sonatest.net>
References: <20180626170109.13437-1-maxime.roussinbelanger@gmail.com>
	<alpine.DEB.2.21.1806272146300.5231@vps.pmeerw.net>
	<20180628143400.tvagraa7tbbh3mic@mbedesk.sonatest.net>
	<20180630173722.2c298b85@archlinux>
	<20180703162838.5jquauqlkfohsod4@mbedesk.sonatest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

On Tue, 3 Jul 2018 12:28:39 -0400
Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com> wrote:

> On Sat, Jun 30, 2018 at 05:37:22PM +0100, Jonathan Cameron wrote:
> > On Thu, 28 Jun 2018 10:34:05 -0400
> > Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com> wrote:
> >  =20
> > > Asked a couple questions about IIO in general.
> > >=20
> > > On Wed, Jun 27, 2018 at 10:02:59PM +0200, Peter Meerwald-Stadler wrot=
e: =20
> > > >=20
> > > > comments below
> > > >    =20
> > > > > Signed-off-by: Maxime Roussin-B=E9langer <maxime.roussinbelanger@=
gmail.com>
> > > > > Reviewed-by: Jean-Francois Dagenais <dagenaisj@sonatest.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > 	- Add ABI documentation
> > > > > 	- Drop part abstraction
> > > > > 	- Clean up error handling style
> > > > >=20
> > > > >  .../ABI/testing/sysfs-bus-iio-light-si1133    |  57 ++
> > > > >  drivers/iio/light/Kconfig                     |  11 +
> > > > >  drivers/iio/light/Makefile                    |   1 +
> > > > >  drivers/iio/light/si1133.c                    | 809 ++++++++++++=
++++++
> > > > >  4 files changed, 878 insertions(+)
> > > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light=
-si1133
> > > > >  create mode 100644 drivers/iio/light/si1133.c
> > > > >=20
> > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-si1133=
 b/Documentation/ABI/testing/sysfs-bus-iio-light-si1133
> > > > > new file mode 100644
> > > > > index 000000000000..4533b5699c87
> > > > > --- /dev/null
> > > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-si1133
> > > > > @@ -0,0 +1,57 @@
> > > > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity0_ir_small_r=
aw   =20
> > > >=20
> > > > do we need the 0?   =20
> > >=20
> > > Hopefully not, comments below. =20
> >=20
> > Given the several channels only distinguished by extended name, yes if =
you
> > might potentially have events at some later date.
> > =20
>=20
> I'm a bit confused on what "events" are. I'm wondering if you are talking=
 about the
> autonomous mode or just the IRQ?

I wasn't really addressing this device, just the concepts around why we nee=
d to
keep indexes.  Events in IIO are thresholds of something or other, reported=
 on
a character device (of a sorts).

> =20
> > > >    =20
> > > > > +KernelVersion:	4.18
> > > > > +Contact:	linux-iio@vger.kernel.org
> > > > > +Description:
> > > > > +		Unit-less infrared intensity. The intensity is measured from 1
> > > > > +		dark photodiode. "small" indicate the surface area capturing
> > > > > +		infrared.
> > > > > +
> > > > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity1_ir_med_raw
> > > > > +KernelVersion:	4.18
> > > > > +Contact:	linux-iio@vger.kernel.org
> > > > > +Description:
> > > > > +		Unit-less infrared intensity. The intensity is measured from 2
> > > > > +		dark photodiode. "med" indicate the surface area capturing   =
=20
> > > >=20
> > > > photodiodes
> > > >    =20
> > > > > +		infrared.
> > > > > +
> > > > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity2_ir_large_r=
aw
> > > > > +KernelVersion:	4.18
> > > > > +Contact:	linux-iio@vger.kernel.org
> > > > > +Description:
> > > > > +		Unit-less infrared intensity. The intensity is measured from 4
> > > > > +		dark photodiode. "large" indicate the surface area capturing  =
 =20
> > > >=20
> > > > photodiodes
> > > >    =20
> > > > > +		infrared.
> > > > > +
> > > > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity11_raw   =20
> > > >=20
> > > > what does 11 mean?   =20
> > >=20
> > > First time using iio subsystem... I think I can remove all the number=
s, but the
> > > number were used to differentiate the different channels with "large"=
, "med"...
> > >=20
> > > Now that I use the "extend_name" field, maybe I can get rid of it? =20
> >=20
> > No.  Potentially causes all sorts of problems if there are events on th=
is part
> > or on some similar part in future.  Extend_name should not be used to m=
ake channels
> > unique.
> >  =20
>=20
> I wasn't using the extend_name to make them unique, but trying to use the=
 iio framework
> to give a name to this property instead of a number that doesn't mean muc=
h. That's how I
> interpreted the documentation for the "extend_name" field.

That is the intent, but the trade off is that it breaks most standard users=
pace.
So we generally try to avoid using them if we can convey the meaning some o=
ther way.
(or if the meaning isn't that important). Basically it's a horrible interfa=
ce we should
never have introduced in the first place (I'm fairly sure it was my fault l=
ong ago!)

>=20
> If it makes it unique, it's probably a coincidence.
It's necessary to maintain uniqueness otherwise you can't create the files.
>=20
>=20
...
