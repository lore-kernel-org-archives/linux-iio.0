Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-194.synserver.de ([212.40.185.194]:1035 "EHLO
	smtp-out-194.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235AbbHDIAD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 04:00:03 -0400
Message-ID: <55C070FF.7060205@metafoo.de>
Date: Tue, 04 Aug 2015 09:59:59 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Pengyu Ma <pengyu.ma@windriver.com>, jic23@kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH V2] iio: declare struct to fix warning
References: <1438569580-3712-1-git-send-email-pengyu.ma@windriver.com> <55C06F3D.5080803@windriver.com> <55C06FA8.6030705@metafoo.de> <55C07035.8030200@windriver.com>
In-Reply-To: <55C07035.8030200@windriver.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/2015 09:56 AM, Pengyu Ma wrote:
> 
> 
> On 08/04/2015 03:54 PM, Lars-Peter Clausen wrote:
>> On 08/04/2015 09:52 AM, Pengyu Ma wrote:
>>> If this patch is fine, could somebody help me to merge into upstream kernel?
>> It will be merged, don't worry. But things typically take a bit longer than
>> just a single day.
> So it's will be merge by patch, no need a pull-request, right?

Yes, Jonathan will pick it up and apply it to the IIO tree.

Thanks for the patch.

> 
> Thanks,
> Pengyu
>>> Thanks,
>>> Pengyu
>>>
>>> On 08/03/2015 10:39 AM, Pengyu Ma wrote:
>>>> When compile iio related driver the following warning shown:
>>>>
>>>> include/linux/iio/trigger.h:35:34: warning: 'struct iio_trigger'
>>>> declared inside parameter list
>>>>     int (*set_trigger_state)(struct iio_trigger *trig, bool state);
>>>>
>>>> include/linux/iio/trigger.h:38:18: warning: 'struct iio_dev'
>>>> declared inside parameter list
>>>>              struct iio_dev *indio_dev);
>>>>
>>>> 'struct iio_dev' and 'struct iio_trigger' was used before declaration,
>>>> forward declaration for these structs to fix warning.
>>>>
>>>> Signed-off-by: Pengyu Ma <pengyu.ma@windriver.com>
>>>> ---
>>>>    include/linux/iio/trigger.h | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
>>>> index fa76c79..974cf73 100644
>>>> --- a/include/linux/iio/trigger.h
>>>> +++ b/include/linux/iio/trigger.h
>>>> @@ -18,6 +18,10 @@ struct iio_subirq {
>>>>        bool enabled;
>>>>    };
>>>>    +/* forward declaration */
>>>> +struct iio_dev;
>>>> +struct iio_trigger;
>>>> +
>>>>    /**
>>>>     * struct iio_trigger_ops - operations structure for an iio_trigger.
>>>>     * @owner:        used to monitor usage count of the trigger.
> 

