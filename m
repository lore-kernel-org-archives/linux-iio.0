Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:49806 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750909Ab1LULXH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Dec 2011 06:23:07 -0500
Message-ID: <4EF1C18D.5090300@metafoo.de>
Date: Wed, 21 Dec 2011 12:22:53 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Duss Pirmin <pirmin.duss@flytec.ch>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] Add support for ads1110
References: <4EE9FB74.6010402@flytec.ch> <4EEA1B54.5060607@metafoo.de> <4EF03E28.4020900@flytec.ch>
In-Reply-To: <4EF03E28.4020900@flytec.ch>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/20/2011 08:50 AM, Duss Pirmin wrote:
> Hi
> 
> On 12/15/2011 05:07 PM, Lars-Peter Clausen wrote:
> 
>>> +static struct ads1110_conversion_mode
>>> +ads1110_conv_mode_table[ADS1110_MAX_CONV_MODE] = {
>>> +  { "continuous-conversion", 0 },
>>> +  { "single-conversion", 1 },
>>> +};
>>
>> This should probably not user controllable. You probably want to do a
>> single
>> conversion when reading from sysfs and use continuous conversion when
>> using
>> a triggered buffer.
> 
> As this chip doesn't have an interrupt line all we can do is poll to
> determine if a conversion is completed. my suggestion here is to just
> use continuous conversion and return the last value from the chip.
> Otherwise we would need to poll in the read routine for sysfs. Or is
> there a better way to do it?
> 

I would assume that the downside of having the chip constantly performing
conversions is that power consumption increases. If you know how long
approximately a conversion takes you could start the conversion in single mode
wait the conversion time and read the result back.

>>> +static struct attribute *ads1110_attributes[] = {
>>> +&iio_dev_attr_available_conversion_modes.dev_attr.attr,
>>> +&iio_dev_attr_available_data_rates.dev_attr.attr,
>>> +&iio_dev_attr_available_gains.dev_attr.attr,
>>> +&iio_dev_attr_value.dev_attr.attr,
>>> +&iio_dev_attr_conversion_mode.dev_attr.attr,
>>> +&iio_dev_attr_data_rate.dev_attr.attr,
>>> +&iio_dev_attr_gain.dev_attr.attr,
>>> +&iio_dev_attr_start_conversion.dev_attr.attr,
>>> +  NULL,
>>> +};
>>
>> Please use channel_spec. Most of the attributes can probably be expresses
>> through it. For those which can not please take a look at
>> Documentation/sysfs-bus-iio and see which already existing attribute
>> names
>> match your use case. E.g. your "data_rate" should probably be
>> "sampling_frequency".
>>
> 
> Is there an attribute for gain? I'm asking this, because the next chip I
> will write a driver for is the TI ADS1242, which also has a programmable
> gain.

We usually make the scale attribute writable for changing the gain. And if the
gain factor can only be on of a few discrete values also provide
scale_available attribute.

