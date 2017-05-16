Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33316 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdEPSHO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 May 2017 14:07:14 -0400
Subject: Re: [PATCH v3 2/9] iio: light: rpr0521 poweroff for probe fails
To: "Koivunen, Mikko" <Mikko.Koivunen@fi.rohmeurope.com>
Cc: "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1493983193-8753-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1493983193-8753-2-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <d3b2f247-08f6-3ae5-e206-e77b1c574855@kernel.org>
 <E223F49C7E3E1C4E8F3928A8EC9CF0F8DBEC70D1@WILL-MAIL002.REu.RohmEu.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cb95c107-61ef-5a2f-854f-11cdf287006b@kernel.org>
Date: Tue, 16 May 2017 19:07:11 +0100
MIME-Version: 1.0
In-Reply-To: <E223F49C7E3E1C4E8F3928A8EC9CF0F8DBEC70D1@WILL-MAIL002.REu.RohmEu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/05/17 11:32, Koivunen, Mikko wrote:
> On 7.5.2017 14:42, Jonathan Cameron wrote:
>> On 05/05/17 12:19, Mikko Koivunen wrote:
>>> Set sensor measurement off after probe fail in pm_runtime_set_active() or
>>> iio_device_register(). Without this change sensor measurement stays on
>>> even though probe fails on these calls.
>>>
>>> This is maybe rare case, but causes constant power drain without any
>>> benefits when it happens. Power drain is 20-500uA, typically 180uA.
>>>
>>> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
>> Looks good to me, but I will be looking for Acks from Daniel on this
>> set.  Daniel let me know if you want to pass on responsibility for the
>> driver (perhaps Mikko if willing?)
>>
>> one tiny point inline.
>>> ---
>>> Sensor measurement is turned on rpr0521_init() so in probe it should be
>>> turned off in error cases after that. With CONFIG_PM it's probably
>>> unnecessary for iio_device_register()-fail, but without CONFIG_PM it is
>>> needed. Writing power off twice when CONFIG_PM enabled is ok.
>>>
>>>   drivers/iio/light/rpr0521.c |   17 +++++++++++++++--
>>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
>>> index 03504f6..5d077f4 100644
>>> --- a/drivers/iio/light/rpr0521.c
>>> +++ b/drivers/iio/light/rpr0521.c
>>> @@ -516,13 +516,26 @@ static int rpr0521_probe(struct i2c_client *client,
>>>   
>>>   	ret = pm_runtime_set_active(&client->dev);
>>>   	if (ret < 0)
>>> -		return ret;
>>> +		goto err_poweroff;
>>>   
>>>   	pm_runtime_enable(&client->dev);
>>>   	pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS);
>>>   	pm_runtime_use_autosuspend(&client->dev);
>>>   
>>> -	return iio_device_register(indio_dev);
>>> +	ret = iio_device_register(indio_dev);
>>> +	if (ret)
>>> +		goto err_pm_disable;
>>> +
>>> +	return 0;
>>> +
>>> +err_pm_disable:
>>> +	pm_runtime_disable(&client->dev);
>>> +	pm_runtime_set_suspended(&client->dev);
>>> +	pm_runtime_put_noidle(&client->dev);
>>> +err_poweroff:
>>> +	(void) rpr0521_poweroff(data);
>> shouldn't need the void cast.
> 
> It is there because discarding the return value is done on purpose, not
> by accident. Should I still remove it?
> 
In an error path it's normal not to check so I don't think it needs
to be explicit...
>>> +
>>> +	return ret;
>>>   }
>>>   
>>>   static int rpr0521_remove(struct i2c_client *client)
>>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

