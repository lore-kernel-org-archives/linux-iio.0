Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46769 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbbEDQGe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2015 12:06:34 -0400
Message-ID: <55474A32.1010705@kernel.org>
Date: Mon, 04 May 2015 11:30:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH] iio:prox:sx9500 trivial simplification of return path
 in init function.
References: <1430562582-27932-1-git-send-email-jic23@kernel.org> <CAEnQRZCcvM6OLqupJuBxYWQLyBbqNEP4qF7rFC+rxF9GZuhiyg@mail.gmail.com> <55473E08.7040102@kernel.org>
In-Reply-To: <55473E08.7040102@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/05/15 10:38, Jonathan Cameron wrote:
> On 04/05/15 10:22, Daniel Baluta wrote:
>> On Sat, May 2, 2015 at 1:29 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>>> Cc: Vlad Dogaru <vlad.dogaru@intel.com>
>>> ---
>>>  drivers/iio/proximity/sx9500.c | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
>>> index f1e9d734b6b6..323de9510ba5 100644
>>> --- a/drivers/iio/proximity/sx9500.c
>>> +++ b/drivers/iio/proximity/sx9500.c
>>> @@ -860,10 +860,8 @@ static int sx9500_init_device(struct iio_dev *indio_dev)
>>>         }
>>>
>>>         ret = sx9500_init_compensation(indio_dev);
>>> -       if (ret < 0)
>>> -               return ret;
>>>
>>> -       return 0;
>>> +       return ret;
>>>  }
>>
>> Or, better directly return sx9500_init_comp...
> oops. Good point ;)
Applied with the entirely obvious change that I'd missed and Vlad hadn't
noticed made!

Btw Vlad, this is why even stupidly simple patches ideally get a review.
Often they have the silliest mistakes in them.

Thanks All,

I'm travelling for a few days so not sure when I'll push out my local
tree.
>>
>> Daniel.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

