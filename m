Return-Path: <tiberiu.a.breana@intel.com>
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>, "lm-sensors@lm-sensors.org"
	<lm-sensors@lm-sensors.org>
CC: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "Baluta, Daniel" <daniel.baluta@intel.com>
Subject: RE: [PATCH 0/2] Add support for MAX31722/MAX31723 temperature
 sensors
Date: Tue, 15 Mar 2016 13:16:56 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F4023568E0D@IRSMSX109.ger.corp.intel.com>
References: <1457530252-4984-1-git-send-email-tiberiu.a.breana@intel.com>
 <56E08834.40704@kernel.org>,<4586F61A4A291F4DA44D32824E7C0F4023568DEC@IRSMSX109.ger.corp.intel.com>
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F4023568DEC@IRSMSX109.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Forwarding to the proper list address.=0A=
________________________________________=0A=
From: linux-iio-owner@vger.kernel.org [linux-iio-owner@vger.kernel.org] on =
behalf of Breana, Tiberiu A [tiberiu.a.breana@intel.com]=0A=
Sent: Tuesday, March 15, 2016 2:58 PM=0A=
To: linux@roeck-us.net; lm-sensors@vger.kernel.org=0A=
Cc: Jonathan Cameron; linux-iio@vger.kernel.org; Baluta, Daniel=0A=
Subject: RE: [PATCH 0/2] Add support for MAX31722/MAX31723 temperature sens=
ors=0A=
=0A=
Hello Guenter, hwmon,=0A=
=0A=
We have a dilemma as to wether this device driver belongs in IIO or hwmon:=
=0A=
https://datasheets.maximintegrated.com/en/ds/MAX31722-MAX31723.pdf=0A=
=0A=
Could you please give us your opinion on this?=0A=
Thanks,=0A=
=0A=
Tiberiu=0A=
=0A=
> -----Original Message-----=0A=
> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-=0A=
> owner@vger.kernel.org] On Behalf Of Jonathan Cameron=0A=
> Sent: Wednesday, March 9, 2016 10:32 PM=0A=
> To: Breana, Tiberiu A <tiberiu.a.breana@intel.com>; linux-=0A=
> iio@vger.kernel.org=0A=
> Subject: Re: [PATCH 0/2] Add support for MAX31722/MAX31723=0A=
> temperature sensors=0A=
>=0A=
> On 09/03/16 13:30, Tiberiu Breana wrote:=0A=
> > This patch set adds support for the MAX31722/MAX31723 temperature=0A=
> > sensors / thermostats.=0A=
> > Patch 1 adds basic support and power management.=0A=
> > Patch 2 adds threshold interrupt support.=0A=
> >=0A=
> > Tiberiu Breana (2):=0A=
> >   iio: temperature: Add support for MAX31722/MAX31723 temperature=0A=
> >     sensors=0A=
> >   iio: temperature: Add threshold interrupt support for max31722=0A=
> >=0A=
> >  drivers/iio/temperature/Kconfig    |  12 +=0A=
> >  drivers/iio/temperature/Makefile   |   1 +=0A=
> >  drivers/iio/temperature/max31722.c | 673=0A=
> > +++++++++++++++++++++++++++++++++++++=0A=
> >  3 files changed, 686 insertions(+)=0A=
> >  create mode 100644 drivers/iio/temperature/max31722.c=0A=
> >=0A=
> Hi Tiberiu,=0A=
>=0A=
> When proposing a temperature sensor driver, we need some additional=0A=
> justification for why it is suited for IIO rather than the more focused (=
and in=0A=
> someways simpler) hwmon.=0A=
>=0A=
> So far we have had thermophiles that don't fit in as devices typically us=
ed for=0A=
> hardware monitoring. Also in there are a few drivers which are for parts=
=0A=
> where they are a cut down version of a more complex sensor (the=0A=
> measurement specialties parts are either pressure sensors or humidty=0A=
> sensors at least in terms of what they share interfaces with)=0A=
>=0A=
> Also, please cc the hwmon maintainers (and probably list) as we want thei=
r=0A=
> agreement.=0A=
>=0A=
> Jonathan=0A=
> --=0A=
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in t=
he body=0A=
> of a message to majordomo@vger.kernel.org More majordomo info at=0A=
> http://vger.kernel.org/majordomo-info.html=0A=
--=0A=
To unsubscribe from this list: send the line "unsubscribe linux-iio" in=0A=
the body of a message to majordomo@vger.kernel.org=0A=
More majordomo info at  http://vger.kernel.org/majordomo-info.html=0A=
