Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50034 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934863AbbI2R1l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2015 13:27:41 -0400
Subject: Re: [PATCH v3 6/6] Add ms8607 meas-spec driver support
To: "ludovic.tancerel@maplehightech.com"
	<ludovic.tancerel@maplehightech.com>
References: <1443189405-18516-1-git-send-email-ludovic.tancerel@maplehightech.com>
 <1443189405-18516-7-git-send-email-ludovic.tancerel@maplehightech.com>
 <56082ECC.7060909@kernel.org>
 <E4E43BF8-9E70-41A6-8C50-128F0DB55864@maplehightech.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	William.Markezana@meas-spec.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <560ACA0B.80207@kernel.org>
Date: Tue, 29 Sep 2015 18:27:39 +0100
MIME-Version: 1.0
In-Reply-To: <E4E43BF8-9E70-41A6-8C50-128F0DB55864@maplehightech.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/09/15 11:00, ludovic.tancerel@maplehightech.com wrote:
> Please read below
> 
> 
> Le 27 sept. 2015 à 20:00, Jonathan Cameron <jic23@kernel.org> a écrit :
> 
>> On 25/09/15 14:56, Ludovic Tancerel wrote:
>>> Support for MS8607 temperature, pressure & humidity sensor.
>>> This part is using functions from MS5637 for temperature and pressure
>>> and HTU21 for humidity
>>>
>>> Signed-off-by: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
>> As I commented (early today) in response to the previous thread, I'd prefer
>> a little more than -h and -tp in the naming but otherwise this is good.
>>
> OK, I will change it
> 
>> btw. Having added the tiny amount of infrastructure needed to do the different
>> device support in htu21 you could easily add the temperature part as well as
>> another option :)  Just saying…
> 
> I somehow agree, but the MS8607 is really a MS5673 + HTU21 part,
> it is a bit different for TSYS02D and MS5637.
> Again, all this has been discussed with Meas-Spec and this is their wish to organize as it is.
As state, I'm not fussed, but if I get a patch from someone else down
the line combining the drivers, I might well take it as long as they
are willing to then help maintain the resulting driver...
(probably never happen!)
> 
>>
>> Anyhow, the only real issues other than a bit of reorganization to split
>> the typo fix out of the previous patch are little things in patch 1.
>>
>> Get those sorted and we can get this lot merged in plenty of time for
>> the next merge window.
> 
> This will come soon…
> Thanks a lot for the feedback.
> 
> Shall I add somewhere « Reviewed by » tag in the patchset ?
Typically you only add those if a reviewer explicitly gives
you such a tag.  In my case, as maintainer I in theory reviewed
everything anyway (or sometimes accepted a review from someone I
trust) and it will have my Signed-off-by tag when
I apply it which 'trumps' any other sign of anyway ;)

The only tag I'd put in explicitly for myself or add without
an explicit one from a reviewer is tested-by for anyone who happened
to have the hardware to test and has said it worked fine (including
me).  Acts as a way of tracking those with hardware down if there is
a problem in future.

J

> Regards,
> Ludovic
> 
>>
>> Thanks,
>>
>> Jonathan
>>> ---
>>> Documentation/ABI/testing/sysfs-bus-iio-meas-spec |  1 +
>>> drivers/iio/humidity/Kconfig                      |  2 ++
>>> drivers/iio/humidity/htu21.c                      | 33 ++++++++++++++++++++---
>>> drivers/iio/pressure/Kconfig                      |  2 ++
>>> drivers/iio/pressure/ms5637.c                     |  6 ++++-
>>> 5 files changed, 40 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
>>> index 6d47e54..1a6265e 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
>>> @@ -5,3 +5,4 @@ Description:
>>>                 Reading returns either '1' or '0'. '1' means that the
>>>                 battery level supplied to sensor is below 2.25V.
>>>                 This ABI is available for tsys02d, htu21, ms8607
>>> +		This ABI is available for htu21, ms8607
>>> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
>>> index 3fab60c..75ca043 100644
>>> --- a/drivers/iio/humidity/Kconfig
>>> +++ b/drivers/iio/humidity/Kconfig
>>> @@ -19,6 +19,8 @@ config HTU21
>>> 	help
>>> 	  If you say yes here you get support for the Measurement Specialties
>>> 	  HTU21 humidity and temperature sensor.
>>> +	  This driver is also used for MS8607 temperature, pressure & humidity
>>> +	  sensor
>>>
>>> 	  This driver can also be built as a module. If so, the module will
>>> 	  be called htu21.
>>> diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
>>> index 706faff..0530545 100644
>>> --- a/drivers/iio/humidity/htu21.c
>>> +++ b/drivers/iio/humidity/htu21.c
>>> @@ -1,6 +1,7 @@
>>> /*
>>>  * htu21.c - Support for Measurement-Specialties
>>>  *           htu21 temperature & humidity sensor
>>> + *	     and humidity part of MS8607 sensor
>>>  *
>>>  * Copyright (c) 2014 Measurement-Specialties
>>>  *
>>> @@ -10,6 +11,8 @@
>>>  *
>>>  * Datasheet:
>>>  *  http://www.meas-spec.com/downloads/HTU21D.pdf
>>> + * Datasheet:
>>> + *  http://www.meas-spec.com/downloads/MS8607-02BA01.pdf
>>>  *
>>>  */
>>>
>>> @@ -25,6 +28,11 @@
>>>
>>> #define HTU21_RESET				0xFE
>>>
>>> +enum {
>>> +	HTU21,
>>> +	MS8607
>>> +};
>>> +
>>> static const int htu21_samp_freq[4] = { 20, 40, 70, 120 };
>>> /* String copy of the above const for readability purpose */
>>> static const char htu21_show_samp_freq[] = "20 40 70 120";
>>> @@ -107,6 +115,18 @@ static const struct iio_chan_spec htu21_channels[] = {
>>> 	 }
>>> };
>>>
>>> +/*
>>> + * Meas Spec recommendation is to not read temperature
>>> + * on this driver part for MS8607
>>> + */
>>> +static const struct iio_chan_spec ms8607_channels[] = {
>>> +	{
>>> +		.type = IIO_HUMIDITYRELATIVE,
>>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_PROCESSED),
>>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>> +	 }
>>> +};
>>> +
>>> static ssize_t htu21_show_battery_low(struct device *dev,
>>> 				      struct device_attribute *attr, char *buf)
>>> {
>>> @@ -189,8 +209,14 @@ int htu21_probe(struct i2c_client *client,
>>> 	indio_dev->name = id->name;
>>> 	indio_dev->dev.parent = &client->dev;
>>> 	indio_dev->modes = INDIO_DIRECT_MODE;
>>> -	indio_dev->channels = htu21_channels;
>>> -	indio_dev->num_channels = ARRAY_SIZE(htu21_channels);
>>> +
>>> +	if (id->driver_data == MS8607) {
>>> +		indio_dev->channels = ms8607_channels;
>>> +		indio_dev->num_channels = ARRAY_SIZE(ms8607_channels);
>>> +	} else {
>>> +		indio_dev->channels = htu21_channels;
>>> +		indio_dev->num_channels = ARRAY_SIZE(htu21_channels);
>>> +	}
>>>
>>> 	i2c_set_clientdata(client, indio_dev);
>>>
>>> @@ -207,7 +233,8 @@ int htu21_probe(struct i2c_client *client,
>>> }
>>>
>>> static const struct i2c_device_id htu21_id[] = {
>>> -	{"htu21", 0},
>>> +	{"htu21", HTU21},
>>> +	{"ms8607-h", MS8607},
>>> 	{}
>>> };
>>>
>>> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
>>> index 8142cfe..53f9a44 100644
>>> --- a/drivers/iio/pressure/Kconfig
>>> +++ b/drivers/iio/pressure/Kconfig
>>> @@ -86,6 +86,8 @@ config MS5637
>>> 	help
>>> 	  If you say yes here you get support for the Measurement Specialties
>>> 	  MS5637 pressure and temperature sensor.
>>> +	  This driver is also used for MS8607 temperature, pressure & humidity
>>> +	  sensor
>>>
>>> 	  This driver can also be built as a module. If so, the module will
>>> 	  be called ms5637.
>>> diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
>>> index 0dbbd4e..f6b5544 100644
>>> --- a/drivers/iio/pressure/ms5637.c
>>> +++ b/drivers/iio/pressure/ms5637.c
>>> @@ -1,5 +1,5 @@
>>> /*
>>> - * ms5637.c - Support for Measurement-Specialties ms5637
>>> + * ms5637.c - Support for Measurement-Specialties ms5637 and ms8607
>>>  *            pressure & temperature sensor
>>>  *
>>>  * Copyright (c) 2015 Measurement-Specialties
>>> @@ -10,8 +10,11 @@
>>>  *
>>>  * Datasheet:
>>>  *  http://www.meas-spec.com/downloads/MS5637-02BA03.pdf
>>> + * Datasheet:
>>> + *  http://www.meas-spec.com/downloads/MS8607-02BA01.pdf
>>>  *
>>>  */
>>> +
>>> #include <linux/init.h>
>>> #include <linux/device.h>
>>> #include <linux/kernel.h>
>>> @@ -168,6 +171,7 @@ static int ms5637_probe(struct i2c_client *client,
>>>
>>> static const struct i2c_device_id ms5637_id[] = {
>>> 	{"ms5637", 0},
>>> +	{"ms8607-tp", 1},
>>> 	{}
>>> };
>>>
>>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

