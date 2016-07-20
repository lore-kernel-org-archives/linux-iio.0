Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37788 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbcGTO7X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2016 10:59:23 -0400
Subject: Re: [PATCH v2 2/4] iio: adc: add support for Allwinner SoCs ADC
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
	jdelvare@suse.com, linux@roeck-us.net, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-3-git-send-email-quentin.schulz@free-electrons.com>
 <e24c8b63-7774-66d2-3317-43fd5598ecc9@kernel.org>
 <f6e32bf0-f043-0d34-5190-18b89920bbfd@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <583cc331-69f9-bea4-486b-323c10c65447@kernel.org>
Date: Wed, 20 Jul 2016 15:59:20 +0100
MIME-Version: 1.0
In-Reply-To: <f6e32bf0-f043-0d34-5190-18b89920bbfd@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/07/16 13:37, Quentin Schulz wrote:
> On 18/07/2016 15:18, Jonathan Cameron wrote:
> [...]
>>> +
>>> +	if (!wait_for_completion_timeout(&info->completion,
>>> +					 msecs_to_jiffies(100))) {
>>> +		ret = -ETIMEDOUT;
>>> +		goto out;
>>> +	}
>>> +
>>> +	if (info->flags & SUNXI_GPADC_ARCH_SUN4I)
>>> +		*val = info->temp_data * 133 - 257000;
>> Why report as processed?  I'd just report them as raw with the scale
>> and offset provided.  It's not a big thing, but if we can leave it so
>> that the conversion only occurs when desired, why not?
>>
>> For in kernel users, this all happen 'automagically' anyway ;)
>>
> 
> Mmmmh, in the code above we apply the scale on the raw value and then
> the offset. While in iio_convert_raw_to_processed
> (http://lxr.free-electrons.com/source/drivers/iio/inkern.c#L507), the
> offset is applied before the scale.
> 
> The way would be to factorize the computation by scale:
> Now: *val = raw * scale + offset
> Then: *val = (raw + offset/scale) * scale
> 
> But the offset is an integer and offset/scale is therefore rounded.
> Currently, we have the following values:
> sun4i: -257000/133 = -1932.3308270676691
> sun5i: -144700/100 = -1447
> sun6i: -271000/167 = -1622.754491017964
> 
> Do we accept such rounding?
Yes - how accurate do you think a temp sensor is - really not a problem.
> 
> If not, we either stay with the processed value in read_raw or patch
> inkern to add an offset to apply after having applied the scale to the
> raw value (val2 from iio_channel_read is yet unused with
> IIO_CHAN_INFO_OFFSET for example, we could use that to specify an
> offset2 to apply after the switch(scale_type)-case).
I don't really care that much if you just want to keep them as
processed values.

J
> 
> [...]
> Quentin
> 

