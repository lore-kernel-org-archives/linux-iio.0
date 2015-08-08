Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57964 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbbHHL1a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 07:27:30 -0400
Subject: Re: [PATCH V2] iio: declare struct to fix warning
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Pengyu Ma <pengyu.ma@windriver.com>
References: <1438569580-3712-1-git-send-email-pengyu.ma@windriver.com>
 <CAEnQRZDF=1Dec85yyMT0AEMEct_V4DFOK6vXpUi2UjMdZFrQMg@mail.gmail.com>
 <55C073A7.10907@windriver.com>
 <CAEnQRZA0wm=LB1mn_h-uKY=6XD+xMo7Q=-CGF+QAC08A4RDnCg@mail.gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C5E7A0.5050902@kernel.org>
Date: Sat, 8 Aug 2015 12:27:28 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZA0wm=LB1mn_h-uKY=6XD+xMo7Q=-CGF+QAC08A4RDnCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/08/15 09:14, Daniel Baluta wrote:
> On Tue, Aug 4, 2015 at 11:11 AM, Pengyu Ma <pengyu.ma@windriver.com> wrote:
>>
>>
>> On 08/04/2015 04:03 PM, Daniel Baluta wrote:
>>>
>>> On Mon, Aug 3, 2015 at 5:39 AM, Pengyu Ma <pengyu.ma@windriver.com> wrote:
>>>>
>>>> When compile iio related driver the following warning shown:
>>>>
>>>> include/linux/iio/trigger.h:35:34: warning: 'struct iio_trigger'
>>>> declared inside parameter list
>>>>    int (*set_trigger_state)(struct iio_trigger *trig, bool state);
>>>>
>>>> include/linux/iio/trigger.h:38:18: warning: 'struct iio_dev'
>>>> declared inside parameter list
>>>>             struct iio_dev *indio_dev);
>>>>
>>>> 'struct iio_dev' and 'struct iio_trigger' was used before declaration,
>>>> forward declaration for these structs to fix warning.
>>>>
>>>> Signed-off-by: Pengyu Ma <pengyu.ma@windriver.com>
>>>> ---
>>>>   include/linux/iio/trigger.h | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
>>>> index fa76c79..974cf73 100644
>>>> --- a/include/linux/iio/trigger.h
>>>> +++ b/include/linux/iio/trigger.h
>>>> @@ -18,6 +18,10 @@ struct iio_subirq {
>>>>          bool enabled;
>>>>   };
>>>>
>>>> +/* forward declaration */
>>>
>>> I would remove this comment. It doesn't says much.
>>
>> OK, Do I need a v3 review or you apply it with your modification directly?
> 
> Please send v3, Jonathan will appreciate this :).
I will indeed ;)

Thanks,
> 
> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

