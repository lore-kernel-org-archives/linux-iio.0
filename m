Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35283 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab3GCT0m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2013 15:26:42 -0400
Message-ID: <51D47AEC.8070606@kernel.org>
Date: Wed, 03 Jul 2013 20:26:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hector Palacios <hector.palacios@digi.com>
CC: Marek Vasut <marex@denx.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH] iio: mxs-lradc: Remove useless check in read_raw
References: <1372723722-13902-1-git-send-email-marex@denx.de> <201307021955.45799.marex@denx.de> <51D3EE00.4050907@digi.com> <201307031338.26928.marex@denx.de> <51D42E22.8060006@digi.com>
In-Reply-To: <51D42E22.8060006@digi.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/03/2013 02:58 PM, Hector Palacios wrote:
> Dear Marek,
> 
> On 07/03/2013 01:38 PM, Marek Vasut wrote:
>> Dear Hector Palacios,
>>
>>> Dear Marek,
>>>
>>> On 07/02/2013 07:55 PM, Marek Vasut wrote:
>>>> Dear Otavio Salvador,
>>>>
>>>>> On Tue, Jul 2, 2013 at 2:36 PM, Marek Vasut <marex-
>> ynQEQJNshbs@public.gmane.org> wrote:
>>>>>> Dear Otavio Salvador,
>>>>>>
>>>>>>> On Tue, Jul 2, 2013 at 1:13 PM, Marek Vasut <marex-
>> ynQEQJNshbs@public.gmane.org> wrote:
>>>>>>>> Dear Alexandre Belloni,
>>>>>>>>
>>>>>>>>> On 02/07/2013 14:03, Marek Vasut wrote:
>>>>>>>>>> Dear Alexandre Belloni,
>>>>>>>>>>
>>>>>>>>>>> Dear Marek,
>>>>>>>>>>>
>>>>>>>>>>> I don't seem to be hitting that issue. I'm using 3.10rc7. Do you
>>>>>>>>>>> know how to reproduce it ?
>>>>>>>>>>
>>>>>>>>>> The check is just redundant, it's not a bug.
>>>>>>>>>
>>>>>>>>> Ok, that's what I understood first but then got confused by reports
>>>>>>>>> of it solving a bug.
>>>>>>>>
>>>>>>>> It cannot solve a thing. If it does, then we have a problem.
>>>>>>>>
>>>>>>>> What kind of bug do you see ? How can I replicate it ? Can you send
>>>>>>>> me a testcase?
>>>>>>>
>>>>>>> As I said this code sometimes work. If you put a printf before this
>>>>>>> call it sometimes work. So I think we have a race somewhere.
>>>>>>>
>>>>>>> When I were debugging this I found that when it works we have 10
>>>>>>> active channels, it seems.
>>>>>>
>>>>>> Uh, the read_raw() should exit with -EBUSY, since the mutex_tryload()
>>>>>> will fail iff buffered operation is in progress. Or what do you mean by
>>>>>> having "10 active channels"?
>>>>>
>>>>> The read_raw returned invalid. The onehot always returns false and I
>>>>> have 10 as mask comparing return.
>>>>
>>>> Looking at the code.
>>>>
>>>> the bitmap_set() will set (1 << chan->channel) into "mask" var.
>>>>
>>>> The iio_validate_scan_mask_onehot is implemented like this:
>>>>
>>>> 688 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
>>>> 689         const unsigned long *mask)
>>>> 690 {
>>>> 691         return bitmap_weight(mask, indio_dev->masklength) == 1;
>>>> 692 }
>>>>
>>>> So if mask _always_ has exactly one bit set, the
>>>> iio_validate_scan_mask_onehot will always return 1. Aaaand ... now I see
>>>> why it fixes a bug for you.
>>>>
>>>> if (ret)
>>>>
>>>>    return -EINVAL;
>>>>
>>>> This stuff above will always be if (1) so will always return -EINVAL.
>>>> Dang!
>>>
>>> Yes, this was exactly what was happening on my MX28 when trying to read one
>>> channel. Now, after the different comments I'm confused, was this a bug
>>> that your patch solved or was I doing something wrong?
>>
>> This patch accidentally (in completely unintended way) solved a bug, yes. But
>> the main idea was to just remove redundant code.
> 
> Maybe you should then amend the commit message to make clear that it solves a bug.
Definitely.

I'll apply a version that mentions the bug in the commit comment to a branch that
will hopefully be applied just after rc1 then can be picked up by stable as appropriate.

Jonathan
> 
> Best regards,
> -- 
> Hector Palacios
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
