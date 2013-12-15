Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34579 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab3LOVDp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2013 16:03:45 -0500
Message-ID: <52AE192E.9000803@kernel.org>
Date: Sun, 15 Dec 2013 21:03:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Beomho Seo <beomho.seo@samsung.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: cm36651: Changed return value of read function
References: <52A5284D.4080906@samsung.com> <52AC3E47.4010007@kernel.org> <52ADA8CE.8090309@metafoo.de>
In-Reply-To: <52ADA8CE.8090309@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/15/13 13:04, Lars-Peter Clausen wrote:
> On 12/14/2013 12:17 PM, Jonathan Cameron wrote:
>> On 12/09/13 02:17, Beomho Seo wrote:
>>> Hello,
>>>
>>> I have fixed cm36651 driver.
>>> Some return value of callback have been changed to IIO_VAL_INT.
>>> If not IIO_VAL_INT, driver will print wrong value(*_read_int_time) or not print(*_read_prox_thresh).
>>>
>>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>> Applied to the fixes-togreg branch of iio.git
>>
>> This is going to cause a merge conflict with the reworking of the event
>> handling in the togreg branch, but the solution is simple so shouldn't
>> cause any problems (hopefully I'll remember to metion it when I send
>> the pull requests!)
> 
> Actually the patch should be split into two parts. The first hunk is a fix
> for the a problem which is already present in the current (as in Linus tree)
> version of the driver. While the problem, which is fixed in the second hunk,
> is something I introduced with the conversion to the new style event
> interface. So only the first part should go to fixes-togreg and the second
> to togreg. I don't think there will be any conflicts that way.
> 
Ah, good point.

Anyhow, I've switched the original patch for one that only does the first change.  Will
deal with the second one when I have a bored moment.

Jonathan
> - Lars
> 
>>> ---
>>>  drivers/iio/light/cm36651.c |    4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
>>> index 21df571..0206eab 100644
>>> --- a/drivers/iio/light/cm36651.c
>>> +++ b/drivers/iio/light/cm36651.c
>>> @@ -387,7 +387,7 @@ static int cm36651_read_int_time(struct cm36651_data *cm36651,
>>>  		return -EINVAL;
>>>  	}
>>>
>>> -	return IIO_VAL_INT_PLUS_MICRO;
>>> +	return IIO_VAL_INT;
>>>  }
>>>
>>>  static int cm36651_write_int_time(struct cm36651_data *cm36651,
>>> @@ -494,7 +494,7 @@ static int cm36651_read_prox_thresh(struct iio_dev *indio_dev,
>>>
>>>  	*val = cm36651->ps_ctrl_regs[CM36651_PS_THD];
>>>
>>> -	return 0;
>>> +	return IIO_VAL_INT;
>>>  }
>>>
>>>  static int cm36651_write_prox_thresh(struct iio_dev *indio_dev,
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
