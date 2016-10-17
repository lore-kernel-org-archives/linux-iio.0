Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:64474 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965042AbcJQQxB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2016 12:53:01 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 7/8] drivers:input:ads7846(+tsc2046): fix spi module table
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <acdf452f-01f2-27df-11c5-bb8db002394a@ti.com>
Date: Mon, 17 Oct 2016 18:52:51 +0200
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        =?windows-1252?Q?Mika_Penttil=E4?= <mika.penttila@nextfour.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org, linux-iio@vger.kernel.org,
        kernel@pyra-handheld.com
Message-Id: <FB793B8D-2CFB-4070-9267-A6A9680C8B5C@goldelico.com>
References: <cover.1476712675.git.hns@goldelico.com> <70cc986f3cf98dd89f0460b5042083aad58a7366.1476712675.git.hns@goldelico.com> <acdf452f-01f2-27df-11c5-bb8db002394a@ti.com>
To: "Andrew F. Davis" <afd@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Am 17.10.2016 um 17:54 schrieb Andrew F. Davis <afd@ti.com>:
>=20
> On 10/17/2016 08:57 AM, H. Nikolaus Schaller wrote:
>> Fix module table so that the driver is loaded if compiled
>> as module and requested by DT.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/input/touchscreen/ads7846.c | 11 +++++++++++
>> 1 file changed, 11 insertions(+)
>>=20
>> diff --git a/drivers/input/touchscreen/ads7846.c =
b/drivers/input/touchscreen/ads7846.c
>> index 400e421..9a5d84d 100644
>> --- a/drivers/input/touchscreen/ads7846.c
>> +++ b/drivers/input/touchscreen/ads7846.c
>> @@ -1532,6 +1532,17 @@ static int ads7846_remove(struct spi_device =
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
>> +
>=20
> no space needed
>=20
>> +MODULE_DEVICE_TABLE(spi, ads7846_idtable);
>> +
>> static struct spi_driver ads7846_driver =3D {
>> 	.driver =3D {
>> 		.name	=3D "ads7846",
>>=20
>=20
> the MODULE_ALIAS below can now also be removed with this patch.

Ok! Noted for V5.

BR and thanks,
Nikolaus

