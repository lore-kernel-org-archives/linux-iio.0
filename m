Return-Path: <Florian.Lobmaier@ams.com>
From: Florian Lobmaier <Florian.Lobmaier@ams.com>
To: Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Elitsa Polizoeva
	<Elitsa.Polizoeva@ams.com>, "knaack.h@gmx.de" <knaack.h@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Lars-Peter Clausen
	<lars@metafoo.de>, Jean Delvare <jdelvare@suse.de>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: RE: [PATCH V4 1/1] iio: as6200: add AS6200 temperature sensor driver
 from ams AG
Date: Thu, 25 Aug 2016 12:37:13 +0000
Message-ID: <68bd71cf635849ba8bb80f34e09bddf0@SUX5076.office.amsiag.com>
References: <4ace1394d6064ab2b7dd4a5335cc1a7c@SUX5076.office.amsiag.com>
 <14a70eac-eed6-426f-d22d-ccc79ccf5ebb@kernel.org>
 <20160815194327.GA4400@roeck-us.net>
In-Reply-To: <20160815194327.GA4400@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hello Guenter, hello Jonathan,

we went for developing an IIO driver as the intended use-cases for the AS62=
00 temperature sensor are biosensors as well as environmental sensors. It i=
s currently designed-in in an Android wearable device to measure the skin t=
emperature. So we did not think hwmon is the right place. Of course it may =
also be used for such purposes, but due to its tiny size its more intended =
for wearable devices and smartphones to measure skin- or outside air temper=
ature.

Regarding the remaining custom ABI you are right. We will move this setting=
 to the device tree. Makes much more sense there ;)

Maybe you can give an answer regarding the hwmon/iio topic before we submit=
 an update?

Thank you for your help,
Florian Lobmaier

-----Original Message-----
From: Guenter Roeck [mailto:linux@roeck-us.net]=20
Sent: Montag, 15. August 2016 21:43
To: Jonathan Cameron <jic23@kernel.org>
Cc: Florian Lobmaier <Florian.Lobmaier@ams.com>; Peter Meerwald-Stadler <pm=
eerw@pmeerw.net>; Elitsa Polizoeva <Elitsa.Polizoeva@ams.com>; knaack.h@gmx=
.de; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; Lars-Peter Cl=
ausen <lars@metafoo.de>; Jean Delvare <jdelvare@suse.de>; linux-hwmon@vger.=
kernel.org
Subject: Re: [PATCH V4 1/1] iio: as6200: add AS6200 temperature sensor driv=
er from ams AG

On Mon, Aug 15, 2016 at 06:25:44PM +0100, Jonathan Cameron wrote:
> On 04/08/16 09:35, Florian Lobmaier wrote:
> > Hello Peter,
> >=20
> > Thanks again for your valuable feedback. We use now IIO_EV_THRESH to=20
> > set high and low limits for temperature. Also removed all the custom=20
> > ABI as this are mainly settings which will be set one-time only. For=20
> > the removed custom ABI init defines where introduced which will be=20
> > written to the registers in the probe function. The remaining custom=20
> > ABI is now documented as well as the device tree bindings.> Br,=20
> > Florian
> >=20
> > Signed-off-by: Florian Lobmaier <florian.lobmaier@ams.com>
> > Signed-off-by: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
> Please post as a fresh email thread with a clean title. Otherwise=20
> people will assume it is simply a reply to a comment on an earlier=20
> version.  Also don't include earlier versions as you have here!
>=20
> i.e. drop the RE from the title as it's confusing!
>=20
> Anyhow, right back at v1 Peter mentioned that this might be more=20
> suitable as a hwmon driver than an IIO one.  If you have a good reason=20
> for supporting this part via IIO you should put it in the patch=20
> description. I'm afraid I've been more or less offline for the last=20
> couple fo weeks or I'd have highlighted that this question was=20
> important. A superficial look suggest to me that this is definitely a=20
> part targeting hardware monitoring applications.
>=20
Conversion time, conversion rate, the presence of limit registers, and the =
intended use cases suggest that this should be a hardware monitoring driver=
.

Regarding the attributes, most of those would be standard attributes in a h=
wmon driver. "alarm polarity" should be a  devicetree / platform data confi=
guration parameter, and interrupt vs. comparator mode could be determined b=
ased on the presence of an interrupt line.

> I'll only take a border line part with agreement form Guenter / Jean=20
> who are the hwmon maintainers.
>=20
> I'll do a quick review ignoring this question.
> Mostly pretty good though I really don't like the remaining custom=20
> ABI. Can't see a reason for its existence.

Me not either.

Guenter
