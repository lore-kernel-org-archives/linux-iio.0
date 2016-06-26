Return-Path: <hns@goldelico.com>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/9 v2] iio: pressure: bmp280: support device tree initialization
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <cba4bd61-b615-95fc-de0e-1084fddae6e7@kernel.org>
Date: Sun, 26 Jun 2016 12:27:07 +0200
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-iio@vger.kernel.org,
 Akinobu Mita <akinobu.mita@gmail.com>,
 Matt Ranostay <mranostay@gmail.com>,
 Christoph Mair <christoph.mair@gmail.com>,
 Vlad Dogaru <vlad.dogaru@intel.com>,
 Hartmut Knaack <knaack.h@gmx.de>,
 Marek Belisko <marek@goldelico.com>,
 Eric Andersson <eric.andersson@unixphere.com>,
 Neil Brown <neilb@suse.de>
Message-Id: <8B770E31-0E36-4ED6-9440-766F51C8E5E4@goldelico.com>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org> <1466628819-29784-3-git-send-email-linus.walleij@linaro.org> <cba4bd61-b615-95fc-de0e-1084fddae6e7@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hi,

> Am 26.06.2016 um 11:52 schrieb Jonathan Cameron <jic23@kernel.org>:
>=20
> On 22/06/16 21:53, Linus Walleij wrote:
>> This adds device tree support to the BMP085, BMP180 and BMP280
>> pressure sensors. Tested on the Qualcomm APQ8060 Dragonboard:
>>=20
>> iio:device1$ cat in_temp_input
>> 26700
>> iio:device1$ cat in_pressure_input
>> 99.185000000
>>=20
> Please also confirm the value of 'name' given the mess we have had
> over that recently.

Here is what I get on a bmp085 equipped device:

root@letux:/sys/bus/iio/devices/iio:device0# for i in *
> do
> echo $i $(cat $i)
> done
dev 252:0
in_pressure_input 94.778000000
in_pressure_oversampling_ratio 8
in_pressure_oversampling_ratio_available 1 2 4 8
in_temp_input 33200
in_temp_oversampling_ratio 1
in_temp_oversampling_ratio_available 1
name bmp085
of_node
power
subsystem
uevent MAJOR=3D252 MINOR=3D0 DEVNAME=3Diio:device0 DEVTYPE=3Diio_device =
OF_NAME=3Dbmp085 OF_FULLNAME=3D/ocp/i2c@48072000/bmp085@77 =
OF_COMPATIBLE_0=3Dbosch,bmp085 OF_COMPATIBLE_N=3D1
root@letux:/sys/bus/iio/devices/iio:device0#=20

So "name" is the name of the chip variant.

>=20
>=20
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v1->v2:
>> - Fix some BMP085 misspelled as BMP058 errors.
>> - Add the new BME280 sensor as well
>> ---
>> drivers/iio/pressure/bmp280.c | 14 ++++++++++++++
>> 1 file changed, 14 insertions(+)
>>=20
>> diff --git a/drivers/iio/pressure/bmp280.c =
b/drivers/iio/pressure/bmp280.c
>> index dbbcd6d83e3b..655e888ef8f9 100644
>> --- a/drivers/iio/pressure/bmp280.c
>> +++ b/drivers/iio/pressure/bmp280.c
>> @@ -18,6 +18,7 @@
>> #include <linux/module.h>
>> #include <linux/i2c.h>
>> #include <linux/acpi.h>
>> +#include <linux/of.h>
>> #include <linux/regmap.h>
>> #include <linux/delay.h>
>> #include <linux/iio/iio.h>
>> @@ -1094,6 +1095,18 @@ static const struct acpi_device_id =
bmp280_acpi_match[] =3D {
>> };
>> MODULE_DEVICE_TABLE(acpi, bmp280_acpi_match);
>>=20
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id bmp280_of_match[] =3D {
>> +	{ .compatible =3D "bosch,bme280", .data =3D (void =
*)BME280_CHIP_ID },
>> +	{ .compatible =3D "bosch,bmp280", .data =3D (void =
*)BMP280_CHIP_ID },
>> +	{ .compatible =3D "bosch,bmp180", .data =3D (void =
*)BMP180_CHIP_ID },
>> +	{ .compatible =3D "bosch,bmp085", .data =3D (void =
*)BMP180_CHIP_ID },
>> +};
>> +MODULE_DEVICE_TABLE(of, bmp280_of_match);
>> +#else
>> +#define bmp280_of_match NULL
>> +#endif
>> +
>> static const struct i2c_device_id bmp280_id[] =3D {
>> 	{"bmp280", BMP280_CHIP_ID },
>> 	{"bmp180", BMP180_CHIP_ID },
>> @@ -1107,6 +1120,7 @@ static struct i2c_driver bmp280_driver =3D {
>> 	.driver =3D {
>> 		.name	=3D "bmp280",
>> 		.acpi_match_table =3D ACPI_PTR(bmp280_acpi_match),
>> +		.of_match_table =3D of_match_ptr(bmp280_of_match),
>> 	},
>> 	.probe		=3D bmp280_probe,
>> 	.id_table	=3D bmp280_id,
>>=20
>=20


BR,
Nikolaus=
