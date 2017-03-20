Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55960 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755284AbdCTTgG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 15:36:06 -0400
Subject: Re: [PATCH v3] staging: iio: accel: adis16201: remove iio_dev mlock
To: Aishwarya Pant <aishpant@gmail.com>
References: <20170317214356.GA8369@aishwarya>
 <c4f803ee-8a6a-520e-2be3-bb68a57a8303@kernel.org>
 <20170320103432.GA8228@aishwarya>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>,
        outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <60099361-efd8-cdd8-85eb-761e8a607401@kernel.org>
Date: Mon, 20 Mar 2017 19:36:03 +0000
MIME-Version: 1.0
In-Reply-To: <20170320103432.GA8228@aishwarya>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/03/17 10:34, Aishwarya Pant wrote:
> On Sun, Mar 19, 2017 at 10:19:42AM +0000, Jonathan Cameron wrote:
>> On 17/03/17 21:43, Aishwarya Pant wrote:
>>> In the driver adis16201 read raw does not require an iio_dev->mlock for
>>> reads. It can run concurrently as adis_read_reg_16() is protected by a
>>> transaction lock.
>>>
>>> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
>> Great, one suggestion for a follow up patch below.
>>
>> Applied to the togreg branch of iio.git and pushed out as testing for
>> the autobuilders to play with it.
>>
>> Thanks,
>>
>> Jonathan
>>>
>>> ---
>>> Changes in v3:
>>> 	-- Fix change log format
>>> 	-- Send patch to linuc-iio
>>> Changes in v2:
>>> 	-- Remove read lock
>>>
>>>  drivers/staging/iio/accel/adis16201.c | 6 +-----
>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
>>> index d6c8658..fd2baf2 100644
>>> --- a/drivers/staging/iio/accel/adis16201.c
>>> +++ b/drivers/staging/iio/accel/adis16201.c
>>> @@ -223,17 +223,13 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>>>  		default:
>>>  			return -EINVAL;
>>>  		}
>>> -		mutex_lock(&indio_dev->mlock);
>>>  		addr = adis16201_addresses[chan->scan_index];
>>>  		ret = adis_read_reg_16(st, addr, &val16);
>> Not a lot of point in having the local variable addr given it's
>> only used here.  Perhaps you could follow up with a patch getting
>> rid of it?
> 
> Sure. I will look at clean-up opportunities here. 
> 
> But I'm unsure of where I should be rebasing from? 
> greg's staging tree or the togreg branch of the iio tree.
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/
> According to the link, togreg was last updated 2 weeks ago.
> 
> thanks
> Aishwarya
> 
Hohum. That's me forgetting to push it out before applying new patches.

The togreg branch is non rebasing, so I try to get build feedback from
the 0-day service (amazing system that builds 100s of configurations for
every tree that changes at least a few times a day).

After that comes in good I push out (in theory).  On busy days I tend
to forget.  So whilst in theory I'd advise against it, the testing
branch is moderately safe to send patches against.

It's all rather high churn in some of these drivers at the moment for
some reason ;)  Alison did warn me before posting this task!

Gah, apparently I got really distracted yesterday and didn't push out
at all.  Should now be up as testing.  If all good should get it out
as togreg tomorrow.

Jonathan
> 
>>> -		if (ret) {
>>> -			mutex_unlock(&indio_dev->mlock);
>>> +		if (ret)
>>>  			return ret;
>>> -		}
>>>  		val16 &= (1 << bits) - 1;
>>>  		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>>>  		*val = val16;
>>> -		mutex_unlock(&indio_dev->mlock);
>>>  		return IIO_VAL_INT;
>>>  	}
>>>  	return -EINVAL;
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

