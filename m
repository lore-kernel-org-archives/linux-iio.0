Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47396 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbcGCPsx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 11:48:53 -0400
Subject: Re: [3/3] hwmon: iio_hwmon: defer probe when no channel is found
To: Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Quentin Schulz <quentin.schulz@free-electrons.com>
References: <1467101897-15946-4-git-send-email-quentin.schulz@free-electrons.com>
 <20160630034725.GA26484@roeck-us.net>
 <6FBFD60A-4D68-4B60-AB34-5077BE6BD586@jic23.retrosnub.co.uk>
 <577531D4.1090106@roeck-us.net>
 <b1ebf22d-389e-5d2e-93f2-f77728d28f28@kernel.org>
Cc: jdelvare@suse.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <577933CD.60207@roeck-us.net>
Date: Sun, 3 Jul 2016 08:48:29 -0700
MIME-Version: 1.0
In-Reply-To: <b1ebf22d-389e-5d2e-93f2-f77728d28f28@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/03/2016 03:47 AM, Jonathan Cameron wrote:
> On 30/06/16 15:51, Guenter Roeck wrote:
>> On 06/30/2016 06:59 AM, Jonathan Cameron wrote:
>>>
>>>
>>> On 30 June 2016 04:47:25 BST, Guenter Roeck <linux@roeck-us.net> wrote:
>>>> On Tue, Jun 28, 2016 at 10:18:17AM +0200, Quentin Schulz wrote:
>>>>> iio_channel_get_all returns -ENODEV when it cannot find either
>>>> phandles and
>>>>> properties in the Device Tree or channels whose consumer_dev_name
>>>> matches
>>>>> iio_hwmon in iio_map_list. The iio_map_list is filled in by iio
>>>> drivers
>>>>> which might be probed after iio_hwmon.
>>>>>
>>>>> It is better to defer the probe of iio_hwmon if such error is
>>>> returned by
>>>>> iio_channel_get_all in order to let a chance to iio drivers to expose
>>>>> channels in iio_map_list.
>>>>>
>>>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>>>> ---
>>>>>    drivers/hwmon/iio_hwmon.c | 5 ++++-
>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
>>>>> index b550ba5..c0da4d9 100644
>>>>> --- a/drivers/hwmon/iio_hwmon.c
>>>>> +++ b/drivers/hwmon/iio_hwmon.c
>>>>> @@ -73,8 +73,11 @@ static int iio_hwmon_probe(struct platform_device
>>>> *pdev)
>>>>>            name = dev->of_node->name;
>>>>>
>>>>>        channels = iio_channel_get_all(dev);
>>>>> -    if (IS_ERR(channels))
>>>>> +    if (IS_ERR(channels)) {
>>>>> +        if (PTR_ERR(channels) == -ENODEV)
>>>>> +            return -EPROBE_DEFER;
>>>>
>>>> The problem, as I see it, is with iio, which should return
>>>> -EPROBE_DEFER
>>>> in this situation.
>>> Agreed. New fangled stuff this deferred probing :)
>>>>
>>>> We can not convert -ENODEV to -EPROBE_DEFER without risking that the
>>>> channels are _really_ not there, which would result in endless
>>>> "deferred"
>>>> messages.
>>> Hmm not entirely sure how we prevent that happening wherever it is done..
>>>
>>
>> Outch. Better at the source, though. I didn't look at the iio code recently,
>> but can you detect the defer situation at least with devicetree ?
>>
>> For non-devicetree situations, the only option I can think of would be
>> to replace the module initcall with a later initcall. That should solve
>> the problem if both iio_hwmon and and underlying drivers are built
>> into the kernel. If iio_hwmon is modular, the only real option I can
>> see is to make sure that all drivers it needs are loaded first.
>>
>> Does this make sense ?
> I think we need to look in a couple of directions.  Firstly, investigate doing
> something similar to gpio and basically move the setup of maps much earlier.
> This will replace drivers presenting their own maps
>
> The other direction is to get userspace (i.e. configfs) setup of these maps
> working so for cases where it's a bit less hardware defined (i.e. using an
> accelerometer as an input device) we can do once we know all devices relevant
> are present and instantiate new instances on the fly.
>
> Anyhow, neither is trivial unfortunately.
>

On a higher level, I think it would be better if the iio-hwmon bridge was tied
to chips (and thus to the chip driver), and not be an independent binding.
No idea if/how we can do that, though.

Guenter

