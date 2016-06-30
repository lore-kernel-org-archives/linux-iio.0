Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:50509 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116AbcF3OuD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 10:50:03 -0400
Subject: Re: [3/3] hwmon: iio_hwmon: defer probe when no channel is found
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	Quentin Schulz <quentin.schulz@free-electrons.com>
References: <1467101897-15946-4-git-send-email-quentin.schulz@free-electrons.com>
 <20160630034725.GA26484@roeck-us.net>
 <6FBFD60A-4D68-4B60-AB34-5077BE6BD586@jic23.retrosnub.co.uk>
Cc: jdelvare@suse.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <57753185.10500@metafoo.de>
Date: Thu, 30 Jun 2016 16:49:41 +0200
MIME-Version: 1.0
In-Reply-To: <6FBFD60A-4D68-4B60-AB34-5077BE6BD586@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/30/2016 03:59 PM, Jonathan Cameron wrote:
> 
> 
> On 30 June 2016 04:47:25 BST, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Tue, Jun 28, 2016 at 10:18:17AM +0200, Quentin Schulz wrote:
>>> iio_channel_get_all returns -ENODEV when it cannot find either
>> phandles and
>>> properties in the Device Tree or channels whose consumer_dev_name
>> matches
>>> iio_hwmon in iio_map_list. The iio_map_list is filled in by iio
>> drivers
>>> which might be probed after iio_hwmon.
>>>
>>> It is better to defer the probe of iio_hwmon if such error is
>> returned by
>>> iio_channel_get_all in order to let a chance to iio drivers to expose
>>> channels in iio_map_list.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>> ---
>>>  drivers/hwmon/iio_hwmon.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
>>> index b550ba5..c0da4d9 100644
>>> --- a/drivers/hwmon/iio_hwmon.c
>>> +++ b/drivers/hwmon/iio_hwmon.c
>>> @@ -73,8 +73,11 @@ static int iio_hwmon_probe(struct platform_device
>> *pdev)
>>>  		name = dev->of_node->name;
>>>  
>>>  	channels = iio_channel_get_all(dev);
>>> -	if (IS_ERR(channels))
>>> +	if (IS_ERR(channels)) {
>>> +		if (PTR_ERR(channels) == -ENODEV)
>>> +			return -EPROBE_DEFER;
>>
>> The problem, as I see it, is with iio, which should return
>> -EPROBE_DEFER
>> in this situation.
> Agreed. New fangled stuff this deferred probing :) 
>>
>> We can not convert -ENODEV to -EPROBE_DEFER without risking that the
>> channels are _really_ not there, which would result in endless
>> "deferred"
>> messages.
> Hmm not entirely sure how we prevent that happening wherever it is done..

EPROBE_DEFER is supposed to be returned if you know that a provider was
specified, but the provider is not yet available. Whereas
ENODEV/ENOENT/ENXIO (choose your favorite) is supposed to be returned when
no provider is available.

In the case of the bridge the later case does not really makes sense though
since it wouldn't work without any channels.

This of course requires that all provider-consumer maps are available before
the first consumer is registered. Which is not the case with IIO where the
provider registers the consumer map. We should really do what GPIO does
which registers the map in the board file.
