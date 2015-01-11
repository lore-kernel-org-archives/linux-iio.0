Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dogaru,
 Vlad" <vlad.dogaru@intel.com>, "Baluta, Daniel" <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald" <pmeerw@pmeerw.net>
Subject: RE: [PATCH 3/8] iio: core: Introduce SPEED channel type
Date: Sun, 11 Jan 2015 13:47:29 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F199FDDDD@irsmsx105.ger.corp.intel.com>
References: <1419029879-12024-1-git-send-email-irina.tirdea@intel.com>
 <1419029879-12024-4-git-send-email-irina.tirdea@intel.com>
 <549D6274.8030601@kernel.org>
 <1F3AC3675D538145B1661F571FE1805F199F7B6F@irsmsx105.ger.corp.intel.com>
 <54A522AB.1020401@kernel.org>
In-Reply-To: <54A522AB.1020401@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 01 January, 2015 12:34
> To: Tirdea, Irina; linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Dogaru, Vlad; Baluta, Daniel; Hartmut K=
naack; Lars-Peter Clausen; Peter Meerwald
> Subject: Re: [PATCH 3/8] iio: core: Introduce SPEED channel type
>=20
> On 29/12/14 18:13, Tirdea, Irina wrote:
> >
> >
> >> -----Original Message-----
> >> From: Jonathan Cameron [mailto:jic23@kernel.org]
> >> Sent: 26 December, 2014 15:28
> >> To: Tirdea, Irina; linux-iio@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org; Dogaru, Vlad; Baluta, Daniel; Hartmu=
t Knaack; Lars-Peter Clausen; Peter Meerwald
> >> Subject: Re: [PATCH 3/8] iio: core: Introduce SPEED channel type
> >>
> >> On 19/12/14 22:57, Irina Tirdea wrote:
> >>> Some devices export the current speed value of the user.
> >>>
> >>> One of this devices is Freescale's MMA9553L
> >>> (http://www.freescale.com/files/sensors/doc/ref_manual/MMA9553LSWRM.p=
df)
> >>> that computes the speed of the user based on the number of steps and
> >>> stride length.
> >>>
> >>> Introduce a new channel type SPEED to export these values.
> >>>
> >> A fun question raised by this is whether we are going to end up with
> >> both speed and velocity (depending on whether it is signed or not).
> >> I suppose there isn't much to be done about that though and this looks=
 fine
> >> to me (as does the previous one).
> >
> > We might be able to unify speed and velocity if we use modifiers.
> >
> > I am not sure how a device would export velocity information, but I
> > assume it would be similar to acceleration (since we are talking
> > about a vector as well). In this case we would need one channel type
> > IIO_VELOCITY with modifiers for the 3 axes (IIO_MOD_X, IIO_MOD_Y,
> > IIO_MOD_Z). We can further compute speed as the magnitude or the norm
> > of the velocity vector (root of the sum squared values for x, y, z),
> > so we can export it as an additional modifier IIO_MOD_NORM.
> Good, except for the last bit. We already have IIO_MOD_ROOT_SUM_SQUARED_X=
_Y so
> should add IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z for 3D devices and use that.  A=
 little
> confusing perhaps for people just looking for a speed though.  Meh. Most
> people will use this through a library anyway so that can wrap up the
> measurement as speed if it wants to.
> Note resulting attribute names will end up as the somewhat convoluted
>=20
> in_velocity_sqrt(x^2+y^2+z^2)_*
>=20
> I suppose that's clear enough...
Yes, IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z would fit better. I will also add ABI d=
ocumentation to make it easier for people looking for speed.

> >
> > The pedometer only gives speed information without keeping track of
> > the direction, so in this case we will have one channel IIO_VELOCITY
> > with one modifier IIO_MOD_NORM.
> >
> > Would this be a better approach than just exporting IIO_SPEED?>
> Saves us some confusion later, so yes I prefer this.
> > Thanks,
> > Irina
> >
> >>> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> >>> ---
> >>>  Documentation/ABI/testing/sysfs-bus-iio |    9 +++++++++
> >>>  drivers/iio/industrialio-core.c         |    1 +
> >>>  include/linux/iio/types.h               |    1 +
> >>>  3 files changed, 11 insertions(+)
> >>>
> >>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/=
ABI/testing/sysfs-bus-iio
> >>> index a5c1dcc..07acef7 100644
> >>> --- a/Documentation/ABI/testing/sysfs-bus-iio
> >>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> >>> @@ -295,6 +295,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_rot_fr=
om_north_true_tilt_comp_scale
> >>>  What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_scale
> >>>  What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_scale
> >>>  What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_scale
> >>> +What:		/sys/bus/iio/devices/iio:deviceX/in_speed_scale
> >>>  KernelVersion:	2.6.35
> >>>  Contact:	linux-iio@vger.kernel.org
> >>>  Description:
> >>> @@ -1146,6 +1147,14 @@ Description:
> >>>  		present, output should be considered as processed with the
> >>>  		unit in milliamps.
> >>>
> >>> +What:		/sys/.../iio:deviceX/in_speed_input
> >>> +What:		/sys/.../iio:deviceX/in_speed_raw
> >>> +KernelVersion:	3.19
> >>> +Contact:	linux-iio@vger.kernel.org
> >>> +Description:
> >>> +		This attribute is used to read the current speed value of the user=
.
> >>> +		Units after application of scale are m/s.
> >>> +
> >>>  What:		/sys/.../iio:deviceX/in_steps_en
> >>>  KernelVersion:	3.19
> >>>  Contact:	linux-iio@vger.kernel.org
> >>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrial=
io-core.c
> >>> index 4a10d31..5e50aca 100644
> >>> --- a/drivers/iio/industrialio-core.c
> >>> +++ b/drivers/iio/industrialio-core.c
> >>> @@ -74,6 +74,7 @@ static const char * const iio_chan_type_name_spec[]=
 =3D {
> >>>  	[IIO_STEPS] =3D "steps",
> >>>  	[IIO_CALORIES] =3D "calories",
> >>>  	[IIO_DISTANCE] =3D "distance",
> >>> +	[IIO_SPEED] =3D "speed",
> >>>  };
> >>>
> >>>  static const char * const iio_modifier_names[] =3D {
> >>> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> >>> index b98f751..c848f45 100644
> >>> --- a/include/linux/iio/types.h
> >>> +++ b/include/linux/iio/types.h
> >>> @@ -34,6 +34,7 @@ enum iio_chan_type {
> >>>  	IIO_STEPS,
> >>>  	IIO_CALORIES,
> >>>  	IIO_DISTANCE,
> >>> +	IIO_SPEED,
> >>>  };
> >>>
> >>>  enum iio_modifier {
> >>>
> >
