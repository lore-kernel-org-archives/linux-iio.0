Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:33916 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781AbbHDH4p (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 03:56:45 -0400
Subject: Re: [PATCH V2] iio: declare struct to fix warning
To: Lars-Peter Clausen <lars@metafoo.de>, <jic23@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
References: <1438569580-3712-1-git-send-email-pengyu.ma@windriver.com>
 <55C06F3D.5080803@windriver.com> <55C06FA8.6030705@metafoo.de>
From: Pengyu Ma <pengyu.ma@windriver.com>
Message-ID: <55C07035.8030200@windriver.com>
Date: Tue, 4 Aug 2015 15:56:37 +0800
MIME-Version: 1.0
In-Reply-To: <55C06FA8.6030705@metafoo.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 08/04/2015 03:54 PM, Lars-Peter Clausen wrote:
> On 08/04/2015 09:52 AM, Pengyu Ma wrote:
>> If this patch is fine, could somebody help me to merge into upstream kernel?
> It will be merged, don't worry. But things typically take a bit longer than
> just a single day.
So it's will be merge by patch, no need a pull-request, right?

Thanks,
Pengyu
>> Thanks,
>> Pengyu
>>
>> On 08/03/2015 10:39 AM, Pengyu Ma wrote:
>>> When compile iio related driver the following warning shown:
>>>
>>> include/linux/iio/trigger.h:35:34: warning: 'struct iio_trigger'
>>> declared inside parameter list
>>>     int (*set_trigger_state)(struct iio_trigger *trig, bool state);
>>>
>>> include/linux/iio/trigger.h:38:18: warning: 'struct iio_dev'
>>> declared inside parameter list
>>>              struct iio_dev *indio_dev);
>>>
>>> 'struct iio_dev' and 'struct iio_trigger' was used before declaration,
>>> forward declaration for these structs to fix warning.
>>>
>>> Signed-off-by: Pengyu Ma <pengyu.ma@windriver.com>
>>> ---
>>>    include/linux/iio/trigger.h | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
>>> index fa76c79..974cf73 100644
>>> --- a/include/linux/iio/trigger.h
>>> +++ b/include/linux/iio/trigger.h
>>> @@ -18,6 +18,10 @@ struct iio_subirq {
>>>        bool enabled;
>>>    };
>>>    +/* forward declaration */
>>> +struct iio_dev;
>>> +struct iio_trigger;
>>> +
>>>    /**
>>>     * struct iio_trigger_ops - operations structure for an iio_trigger.
>>>     * @owner:        used to monitor usage count of the trigger.

