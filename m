Return-Path: <tiberiu.a.breana@intel.com>
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>, "lm-sensors@vger.kernel.org"
	<lm-sensors@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "Baluta, Daniel" <daniel.baluta@intel.com>
Subject: RE: [PATCH 0/2] Add support for MAX31722/MAX31723 temperature
 sensors
Date: Tue, 15 Mar 2016 12:58:14 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F4023568DEC@IRSMSX109.ger.corp.intel.com>
References: <1457530252-4984-1-git-send-email-tiberiu.a.breana@intel.com>
 <56E08834.40704@kernel.org>
In-Reply-To: <56E08834.40704@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hello Guenter, hwmon,

We have a dilemma as to wether this device driver belongs in IIO or hwmon:
https://datasheets.maximintegrated.com/en/ds/MAX31722-MAX31723.pdf

Could you please give us your opinion on this?
Thanks,

Tiberiu

> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-
> owner@vger.kernel.org] On Behalf Of Jonathan Cameron
> Sent: Wednesday, March 9, 2016 10:32 PM
> To: Breana, Tiberiu A <tiberiu.a.breana@intel.com>; linux-
> iio@vger.kernel.org
> Subject: Re: [PATCH 0/2] Add support for MAX31722/MAX31723
> temperature sensors
>=20
> On 09/03/16 13:30, Tiberiu Breana wrote:
> > This patch set adds support for the MAX31722/MAX31723 temperature
> > sensors / thermostats.
> > Patch 1 adds basic support and power management.
> > Patch 2 adds threshold interrupt support.
> >
> > Tiberiu Breana (2):
> >   iio: temperature: Add support for MAX31722/MAX31723 temperature
> >     sensors
> >   iio: temperature: Add threshold interrupt support for max31722
> >
> >  drivers/iio/temperature/Kconfig    |  12 +
> >  drivers/iio/temperature/Makefile   |   1 +
> >  drivers/iio/temperature/max31722.c | 673
> > +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 686 insertions(+)
> >  create mode 100644 drivers/iio/temperature/max31722.c
> >
> Hi Tiberiu,
>=20
> When proposing a temperature sensor driver, we need some additional
> justification for why it is suited for IIO rather than the more focused (=
and in
> someways simpler) hwmon.
>=20
> So far we have had thermophiles that don't fit in as devices typically us=
ed for
> hardware monitoring. Also in there are a few drivers which are for parts
> where they are a cut down version of a more complex sensor (the
> measurement specialties parts are either pressure sensors or humidty
> sensors at least in terms of what they share interfaces with)
>=20
> Also, please cc the hwmon maintainers (and probably list) as we want thei=
r
> agreement.
>=20
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in t=
he body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
