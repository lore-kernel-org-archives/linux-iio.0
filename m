Return-Path: <hns@goldelico.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 7/8] drivers:input:ads7846(+tsc2046): fix spi module table
From: H. Nikolaus Schaller <hns@goldelico.com>
In-Reply-To: <20161119181824.GB20446@dtor-ws>
Date: Tue, 22 Nov 2016 15:00:08 +0100
Cc: Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,
 Michael Welling <mwelling@ieee.org>,
 =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Igor Grinberg <grinberg@compulab.co.il>,
 Sebastian Reichel <sre@kernel.org>,
 "Andrew F. Davis" <afd@ti.com>,
 Mark Brown <broonie@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Sangwon Jee <jeesw@melfas.com>,
 linux-input@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org,
 letux-kernel@openphoenux.org,
 linux-iio@vger.kernel.org,
 kernel@pyra-handheld.com
Message-Id: <40022D47-58CC-4D76-88B9-CBEC971328F9@goldelico.com>
References: <cover.1477557860.git.hns@goldelico.com> <54f282e1adebeeb133687b6c430ecbb6f2fe6d5b.1477557860.git.hns@goldelico.com> <20161119181824.GB20446@dtor-ws>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Dmitry,

> Am 19.11.2016 um 19:18 schrieb Dmitry Torokhov =
<dmitry.torokhov@gmail.com>:
>=20
> On Thu, Oct 27, 2016 at 10:44:20AM +0200, H. Nikolaus Schaller wrote:
>> Fix module table so that the driver is loaded if compiled
>> as module and requested by DT.
>=20
> We really need to fix it between spi/i23c core and module utils =
instead
> of keeping adding duplicate IDs all over drivers. We already have OF
> module device table containing the same data, we should be able to use
> it.

Is someone working on that so that we can rely on it in the next merge =
window?

Otherwise I have no idea what I could change in this driver to make it =
working.
So I leave it as is for v8.

>=20
> Thanks.
>=20
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/input/touchscreen/ads7846.c | 11 ++++++++++-
>> 1 file changed, 10 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/input/touchscreen/ads7846.c =
b/drivers/input/touchscreen/ads7846.c
>> index 400e421..50c85d2 100644
>> --- a/drivers/input/touchscreen/ads7846.c
>> +++ b/drivers/input/touchscreen/ads7846.c
>> @@ -1532,6 +1532,16 @@ static int ads7846_remove(struct spi_device =
*spi)
>> 	return 0;
>> }
>>=20
>> +static const struct spi_device_id ads7846_idtable[] =3D {
>> +	{ "tsc2046", 0 },
>> +	{ "ads7843", 0 },
>> +	{ "ads7845", 0 },
>> +	{ "ads7846", 0 },
>> +	{ "ads7873", 0 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(spi, ads7846_idtable);
>> +
>> static struct spi_driver ads7846_driver =3D {
>> 	.driver =3D {
>> 		.name	=3D "ads7846",
>> @@ -1546,4 +1556,3 @@ module_spi_driver(ads7846_driver);
>>=20
>> MODULE_DESCRIPTION("ADS7846 TouchScreen Driver");
>> MODULE_LICENSE("GPL");
>> -MODULE_ALIAS("spi:ads7846");
>> --=20
>> 2.7.3
>>=20
>=20
> --=20
> Dmitry

BR and thanks,
Nikolaus
