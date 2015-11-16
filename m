Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55826 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbbKPR2G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Nov 2015 12:28:06 -0500
In-Reply-To: <5649A265.5060002@baylibre.com>
References: <CAEnQRZBeZpBxSCf85MRmByguHA8kXTNp9+NPD2d3cdsMRb+74w@mail.gmail.com> <1447333052-12791-1-git-send-email-mtitinger@baylibre.com> <56478493.3030703@kernel.org> <5649A265.5060002@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC v2 1/2] iio: ina2xx: add direct IO support for TI INA2xx Power Monitors
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 16 Nov 2015 17:27:02 +0000
To: Marc Titinger <mtitinger@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mturquette@baylibre.com, bcousson@baylibre.com,
	ptitiano@baylibre.com
Message-ID: <7D5B8D99-3343-4BFC-A88B-A3B0A90C9A30@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 16 November 2015 09:31:17 GMT+00:00, Marc Titinger <mtitinger@baylibre.com> wrote:
>On 14/11/2015 19:59, Jonathan Cameron wrote:
>> On 12/11/15 12:57, Marc Titinger wrote:
>>> Basic support or direct IO raw read, with averaging attribute.
>>> Values are RAW, INT_PLUS_MICRO (Volt/Ampere/Watt).
>>>
>>> Output of iio_info:
>>>
>>>       iio:device0: ina226
>>>        4 channels found:
>>>          power3:  (input)
>>>          1 channel-specific attributes found:
>>>                  attr 0: raw value: 1.150000
>>>          voltage0:  (input)
>>>          1 channel-specific attributes found:
>>>                  attr 0: raw value: 0.000003
>>>          voltage1:  (input)
>>>          1 channel-specific attributes found:
>>>                  attr 0: raw value: 4.277500
>>>          current2:  (input)
>>>          1 channel-specific attributes found:
>>>                  attr 0: raw value: 0.268000
>>>        2 device-specific attributes found:
>>>                  attr 0: in_calibscale value: 10000
>>>                  attr 1: in_mean_raw value: 4
>>>                  attr 2: in_sampling_frequency value: 455
>>>
>>> Tested with ina226, on BeagleBoneBlack.
>>>
>>> Datasheet: http://www.ti.com/lit/gpn/ina226
>>>
>>> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
>> Hi Marc
>>
>
>Hi Jonathan,
>
>> To express a personal preference, please don't have series of patches
>as
>> replies to the original thread.  It gets really hard to follow after
>> a couple of revisions!
>>
>Ok, sorry for that.
>
>> May seem a random question, but what do you want to gain from an IIO
>> driver over what the hwmon provides?
>
>Good question. In the frame of Baylibre's ACME power and temperature 
>monitoring demo based on Sigrock, we wish to add a remote mode for the 
>GUI and processing front-end as well as explore other possibilities
>like 
>using an on-board accelerator to capture the sensor data and stream it 
>back to the front-end. This work is a pathfinder as IIO seems 
>appropriate for what we want to do.
Fair enough I guess. Will need to check we aren't stepping on too many toes in
 hwmon if we merge a second driver...
>
>>
>> Various bits inline..
>
>Thanks for the review, further questions below!
>
>Marc.
>
>>
>> Mostly looks pretty good though.
>>
>> Jonathan
>>> ---
>>>
>
>...
>
>>> +#define INA2XX_RSHUNT_DEFAULT           10000
>>> +
>>> +/* bit mask for reading the averaging setting in the configuration
>register */
>>> +#define INA226_AVG_RD_MASK              0x0E00
>> genmask is always good for these.
>>
>
>ok.
>
>..
>
>>> +
>>> +static bool ina2xx_is_writeable_reg(struct device *dev, unsigned
>int reg)
>>> +{
>>> +	return (reg == INA2XX_CONFIG)
>>> +	    || (reg == INA2XX_CALIBRATION);
>> On one line I think this is still way less than 80 chars..
>>> +}
>
>ok
>
>...
>
>
>>> +struct ina2xx_chip_info {
>>> +	struct iio_dev *indio_dev;
>> Having a pointer back to the indio_dev is usually a sign of
>> something 'unusual' going on...  Will be interesting to see what it
>is for ;)
>>
>> Ah, that was easy, you don't use it that I can see.
>>
>
>Ah, forgot to remove it when splitting into two patches, but yeah
>you're 
>right, I shall pass the indio_dev ptr as data in the first place.
>
>...
>
>>> +
>>> +static int ina2xx_get_value(struct ina2xx_chip_info *chip, u8 reg,
>>> +			    unsigned int regval, int *val, int *uval)
>>> +{
>>> +	*val = 0;
>>> +
>>> +	switch (reg) {
>>> +	case INA2XX_SHUNT_VOLTAGE:
>>> +		/* signed register */
>>> +		*uval = DIV_ROUND_CLOSEST((s16) regval,
>>> +					  chip->config->shunt_div);
>>> +		*val = *uval/1000000;
>>> +		*uval = *uval - *val*1000000;
>>> +		return IIO_VAL_INT_PLUS_MICRO;
>> I'm somewhat unconvinced that this wrapper is adding anything over
>> just doing this where you care about the result.
>> Also, this is a straight forward linear conversion.  Do it in
>userspace
>> by providing the relevant 'scale' element.
>
>got it! A practical question: can you specify a divider rather than a 
>multiplier as a scale so that userspace does the division?
Sort of see IIO_TYPE_FRACTIONAL

>
>>> +
>>> +	case INA2XX_BUS_VOLTAGE:
>>> +		*uval = (regval >> chip->config->bus_voltage_shift)
>>> +			* chip->config->bus_voltage_lsb;
>>> +		*val = *uval/1000000;
>>> +		*uval = *uval - *val*1000000;
>>> +		return IIO_VAL_INT_PLUS_MICRO;
>...
>
>>> +	tmp = config;
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_AVERAGE_RAW:
>>> +
>>> +		ret = ina226_set_average(chip, val, &tmp);
>> This isn't what the ABI uses the info_average_raw attribute for -
>it's
>> for outputing the average of a channel rather than setting a mean
>> filter width (which is what you have here).  Probably need some new
>ABI
>> for this as our current filter description ABI is rather limited!
>>
>Ah ok, should this go into a sysfs attribute then, until the ABI
>section 
>is defined ? How about specifying the ABI section while we are at it ?

Go ahead and have a go at defining a suitable ABI :)

Post it as a separate RFC though as discussion might be rather in depth and
not really driver related. 
>
>...
>
>.driver_module = THIS_MODULE,
>>> +};
>>> +
>>> +/*
>> Single line comment, use single line comment syntax.
>
>ok

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
