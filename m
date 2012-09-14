Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-028.synserver.de ([212.40.185.28]:1498 "EHLO
	smtp-out-028.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab2INI5j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Sep 2012 04:57:39 -0400
Message-ID: <5052F1A8.3060502@metafoo.de>
Date: Fri, 14 Sep 2012 10:58:16 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, drivers@analog.com
Subject: Re: [PATCH] iio:dac: Add ad5755 driver
References: <1347542015-27209-1-git-send-email-lars@metafoo.de> <50524343.7060301@kernel.org>
In-Reply-To: <50524343.7060301@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/13/2012 10:34 PM, Jonathan Cameron wrote:
> On 09/13/2012 02:13 PM, Lars-Peter Clausen wrote:
>> This patch adds support for the AD5755, AD5755-1, AD5757, AD5735, AD5737 16 and
>> 14 bit quad-channel DACs. The AD5757/AD5737 only have current outputs, but
>> for the AD5755/AD5757 each of the outputs can be configured to either be a
>> voltage or a current output. We only allow to configure this at device probe
>> time since usually this needs to match the external circuitry and should not be
>> changed on the fly.
>>
> Fair enough.
> 
> Couple of little bits inline.

Thanks for the review.

>> +static void ad5755_get_min_max(struct ad5755_state *st,
>> +	struct iio_chan_spec const *chan, int *min, int *max)
>> +{
>> +	enum ad5755_mode mode = st->ctrl[chan->channel] & 7;
>> +
> This might be a bit cleaner as a lookup table than as
> a switch statement.
> static const modemaxmin[2][] = {
>        [AD5755_MOD_VOLTAGE_0V_5V] = { 0, 5000},
> etc.
> };

Yes, definitely. I actually feel kind of stupid now for implementing this
with a switch case statement ;)

>> +	switch (mode) {
>> +	case AD5755_MODE_VOLTAGE_0V_5V:
>> +		*min = 0;
>> +		*max = 5000;
>> +		break;
>> +	case AD5755_MODE_VOLTAGE_0V_10V:
>> +		*min = 0;
>> +		*max = 10000;
>> +		break;
>> +	case AD5755_MODE_VOLTAGE_PLUSMINUS_5V:
>> +		*min = -5000;
>> +		*max = 5000;
>> +		break;
>> +	case AD5755_MODE_VOLTAGE_PLUSMINUS_10V:
>> +		*min = -10000;
>> +		*max = 10000;
>> +		break;
>> +	case AD5755_MODE_CURRENT_4mA_20mA:
>> +		*min = 4;
>> +		*max = 20;
>> +		break;
>> +	case AD5755_MODE_CURRENT_0mA_20mA:
>> +		*min = 0;
>> +		*max = 20;
>> +		break;
>> +	case AD5755_MODE_CURRENT_0mA_24mA:
>> +		*min = 0;
>> +		*max = 24;
>> +		break;
>> +	default:
> When does this apply?

In practice never. But 'st->ctrl[chan->channel] & 7' could in theory lead
here, so it was to keep the compiler to not complain about maybe
uninitialized variables.

>> +		*min = 0;
>> +		*max = 1;
>> +		break;
>> +	}
>> +}
>> 
