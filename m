Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46308 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbcFZKjg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 06:39:36 -0400
Subject: Re: [PATCH 2/9 v2] iio: pressure: bmp280: support device tree
 initialization
To: "H. Nikolaus Schaller" <hns@goldelico.com>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
 <1466628819-29784-3-git-send-email-linus.walleij@linaro.org>
 <cba4bd61-b615-95fc-de0e-1084fddae6e7@kernel.org>
 <8B770E31-0E36-4ED6-9440-766F51C8E5E4@goldelico.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5b69b870-9dd4-871a-aacf-5949aeb2a604@kernel.org>
Date: Sun, 26 Jun 2016 11:39:34 +0100
MIME-Version: 1.0
In-Reply-To: <8B770E31-0E36-4ED6-9440-766F51C8E5E4@goldelico.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/06/16 11:27, H. Nikolaus Schaller wrote:
> Hi,
> 
>> Am 26.06.2016 um 11:52 schrieb Jonathan Cameron <jic23@kernel.org>:
>>
>> On 22/06/16 21:53, Linus Walleij wrote:
>>> This adds device tree support to the BMP085, BMP180 and BMP280
>>> pressure sensors. Tested on the Qualcomm APQ8060 Dragonboard:
>>>
>>> iio:device1$ cat in_temp_input
>>> 26700
>>> iio:device1$ cat in_pressure_input
>>> 99.185000000
>>>
>> Please also confirm the value of 'name' given the mess we have had
>> over that recently.
> 
> Here is what I get on a bmp085 equipped device:
> 
> root@letux:/sys/bus/iio/devices/iio:device0# for i in *
>> do
>> echo $i $(cat $i)
>> done
> dev 252:0
> in_pressure_input 94.778000000
> in_pressure_oversampling_ratio 8
> in_pressure_oversampling_ratio_available 1 2 4 8
> in_temp_input 33200
> in_temp_oversampling_ratio 1
> in_temp_oversampling_ratio_available 1
> name bmp085
> of_node
> power
> subsystem
> uevent MAJOR=252 MINOR=0 DEVNAME=iio:device0 DEVTYPE=iio_device OF_NAME=bmp085 OF_FULLNAME=/ocp/i2c@48072000/bmp085@77 OF_COMPATIBLE_0=bosch,bmp085 OF_COMPATIBLE_N=1
> root@letux:/sys/bus/iio/devices/iio:device0# 
> 
> So "name" is the name of the chip variant.
Thanks.  That's great then.

Jonathan
> 
>>
>>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>> ChangeLog v1->v2:
>>> - Fix some BMP085 misspelled as BMP058 errors.
>>> - Add the new BME280 sensor as well
>>> ---
>>> drivers/iio/pressure/bmp280.c | 14 ++++++++++++++
>>> 1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
>>> index dbbcd6d83e3b..655e888ef8f9 100644
>>> --- a/drivers/iio/pressure/bmp280.c
>>> +++ b/drivers/iio/pressure/bmp280.c
>>> @@ -18,6 +18,7 @@
>>> #include <linux/module.h>
>>> #include <linux/i2c.h>
>>> #include <linux/acpi.h>
>>> +#include <linux/of.h>
>>> #include <linux/regmap.h>
>>> #include <linux/delay.h>
>>> #include <linux/iio/iio.h>
>>> @@ -1094,6 +1095,18 @@ static const struct acpi_device_id bmp280_acpi_match[] = {
>>> };
>>> MODULE_DEVICE_TABLE(acpi, bmp280_acpi_match);
>>>
>>> +#ifdef CONFIG_OF
>>> +static const struct of_device_id bmp280_of_match[] = {
>>> +	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
>>> +	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
>>> +	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
>>> +	{ .compatible = "bosch,bmp085", .data = (void *)BMP180_CHIP_ID },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, bmp280_of_match);
>>> +#else
>>> +#define bmp280_of_match NULL
>>> +#endif
>>> +
>>> static const struct i2c_device_id bmp280_id[] = {
>>> 	{"bmp280", BMP280_CHIP_ID },
>>> 	{"bmp180", BMP180_CHIP_ID },
>>> @@ -1107,6 +1120,7 @@ static struct i2c_driver bmp280_driver = {
>>> 	.driver = {
>>> 		.name	= "bmp280",
>>> 		.acpi_match_table = ACPI_PTR(bmp280_acpi_match),
>>> +		.of_match_table = of_match_ptr(bmp280_of_match),
>>> 	},
>>> 	.probe		= bmp280_probe,
>>> 	.id_table	= bmp280_id,
>>>
>>
> 
> 
> BR,
> Nikolaus
> 

