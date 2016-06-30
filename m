Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41521 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbcF3N7P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 09:59:15 -0400
In-Reply-To: <20160630034725.GA26484@roeck-us.net>
References: <1467101897-15946-4-git-send-email-quentin.schulz@free-electrons.com> <20160630034725.GA26484@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [3/3] hwmon: iio_hwmon: defer probe when no channel is found
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 30 Jun 2016 14:59:06 +0100
To: Guenter Roeck <linux@roeck-us.net>,
	Quentin Schulz <quentin.schulz@free-electrons.com>
CC: jdelvare@suse.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Message-ID: <6FBFD60A-4D68-4B60-AB34-5077BE6BD586@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 30 June 2016 04:47:25 BST, Guenter Roeck <linux@roeck-us.net> wrote:
>On Tue, Jun 28, 2016 at 10:18:17AM +0200, Quentin Schulz wrote:
>> iio_channel_get_all returns -ENODEV when it cannot find either
>phandles and
>> properties in the Device Tree or channels whose consumer_dev_name
>matches
>> iio_hwmon in iio_map_list. The iio_map_list is filled in by iio
>drivers
>> which might be probed after iio_hwmon.
>> 
>> It is better to defer the probe of iio_hwmon if such error is
>returned by
>> iio_channel_get_all in order to let a chance to iio drivers to expose
>> channels in iio_map_list.
>> 
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>  drivers/hwmon/iio_hwmon.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
>> index b550ba5..c0da4d9 100644
>> --- a/drivers/hwmon/iio_hwmon.c
>> +++ b/drivers/hwmon/iio_hwmon.c
>> @@ -73,8 +73,11 @@ static int iio_hwmon_probe(struct platform_device
>*pdev)
>>  		name = dev->of_node->name;
>>  
>>  	channels = iio_channel_get_all(dev);
>> -	if (IS_ERR(channels))
>> +	if (IS_ERR(channels)) {
>> +		if (PTR_ERR(channels) == -ENODEV)
>> +			return -EPROBE_DEFER;
>
>The problem, as I see it, is with iio, which should return
>-EPROBE_DEFER
>in this situation.
Agreed. New fangled stuff this deferred probing :) 
>
>We can not convert -ENODEV to -EPROBE_DEFER without risking that the
>channels are _really_ not there, which would result in endless
>"deferred"
>messages.
Hmm not entirely sure how we prevent that happening wherever it is done..

>
>Guenter
>
>>  		return PTR_ERR(channels);
>> +	}
>>  
>>  	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
>>  	if (st == NULL) {
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
