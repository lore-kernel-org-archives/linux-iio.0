Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dogaru,
 Vlad" <vlad.dogaru@intel.com>, "Baluta, Daniel" <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald" <pmeerw@pmeerw.net>
Subject: RE: [PATCH 4/8] iio: core: Introduce IO_CHAN_INFO_CALIBWEIGHT
Date: Mon, 29 Dec 2014 15:05:48 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F199F7B06@irsmsx105.ger.corp.intel.com>
References: <1419029879-12024-1-git-send-email-irina.tirdea@intel.com>
 <1419029879-12024-5-git-send-email-irina.tirdea@intel.com>
 <549D632E.4000004@kernel.org>
In-Reply-To: <549D632E.4000004@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 26 December, 2014 15:31
> To: Tirdea, Irina; linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Dogaru, Vlad; Baluta, Daniel; Hartmut K=
naack; Lars-Peter Clausen; Peter Meerwald
> Subject: Re: [PATCH 4/8] iio: core: Introduce IO_CHAN_INFO_CALIBWEIGHT
>=20
> On 19/12/14 22:57, Irina Tirdea wrote:
> > Some devices need the weight of the user to compute other
> > parameters. One of this devices is Freescale's MMA9553L
> > (http://www.freescale.com/files/sensors/doc/ref_manual/MMA9553LSWRM.pdf=
)
> > that needs the weight of the user to compute the number of calories bur=
nt.
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio |    7 +++++++
> >  drivers/iio/industrialio-core.c         |    1 +
> >  include/linux/iio/iio.h                 |    1 +
> >  3 files changed, 9 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/AB=
I/testing/sysfs-bus-iio
> > index 07acef7..e480175 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -351,6 +351,13 @@ Description:
> >  		to compute the stride length, distance, speed and activity
> >  		type.
> >
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_steps_calibweight
> > +KernelVersion:	3.19
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Weight of the user (in kg). It is needed by some pedometers
> > +		to compute the calories burnt by the user.
> How about grams?  Nice to keep to SI units going forward (I appreciate we
> have broken that for what seemed like good reasons at the time) in one
> or two places, but it makes it much harder to define consistent interface=
s in the
> long run.

According to SI [1] kg is the base unit for mass, so this was the obvious f=
irst choice.
I have nothing against using grams, but it is not clear to me why using gra=
ms would make it easier to define consistent interfaces in the long run.
I am probably missing something, so could you please clarify this?

Thanks,
Irina

[1] http://www.bipm.org/en/measurement-units/

> J
> > +
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale_available
> >  What:		/sys/.../iio:deviceX/in_voltageX_scale_available
> >  What:		/sys/.../iio:deviceX/in_voltage-voltage_scale_available
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio=
-core.c
> > index 5e50aca..4c435c8 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -124,6 +124,7 @@ static const char * const iio_chan_info_postfix[] =
=3D {
> >  	[IIO_CHAN_INFO_INT_TIME] =3D "integration_time",
> >  	[IIO_CHAN_INFO_ENABLE] =3D "en",
> >  	[IIO_CHAN_INFO_CALIBHEIGHT] =3D "calibheight",
> > +	[IIO_CHAN_INFO_CALIBWEIGHT] =3D "calibweight",
> >  };
> >
> >  /**
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 878d861..752a929 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -40,6 +40,7 @@ enum iio_chan_info_enum {
> >  	IIO_CHAN_INFO_INT_TIME,
> >  	IIO_CHAN_INFO_ENABLE,
> >  	IIO_CHAN_INFO_CALIBHEIGHT,
> > +	IIO_CHAN_INFO_CALIBWEIGHT,
> >  };
> >
> >  enum iio_shared_by {
> >
