Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34564 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940AbbHDH73 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 03:59:29 -0400
Received: by ykax123 with SMTP id x123so1593470yka.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2015 00:59:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55C07035.8030200@windriver.com>
References: <1438569580-3712-1-git-send-email-pengyu.ma@windriver.com>
 <55C06F3D.5080803@windriver.com> <55C06FA8.6030705@metafoo.de> <55C07035.8030200@windriver.com>
From: Crt Mori <cmo@melexis.com>
Date: Tue, 4 Aug 2015 09:58:49 +0200
Message-ID: <CAKv63uvmOP44r4hD1T1cX+kj_5JPP3jSzJv8cCrSf==1___6jQ@mail.gmail.com>
Subject: Re: [PATCH V2] iio: declare struct to fix warning
To: Pengyu Ma <pengyu.ma@windriver.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Johnathan Iain Cameron <jic23@kernel.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4 August 2015 at 09:56, Pengyu Ma <pengyu.ma@windriver.com> wrote:
>
>
> On 08/04/2015 03:54 PM, Lars-Peter Clausen wrote:
>>
>> On 08/04/2015 09:52 AM, Pengyu Ma wrote:
>>>
>>> If this patch is fine, could somebody help me to merge into upstream
>>> kernel?
>>
>> It will be merged, don't worry. But things typically take a bit longer
>> than
>> just a single day.
>
> So it's will be merge by patch, no need a pull-request, right?
Correct.
>
> Thanks,
> Pengyu
>
>>> Thanks,
>>> Pengyu
>>>
>>> On 08/03/2015 10:39 AM, Pengyu Ma wrote:
>>>>
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
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
