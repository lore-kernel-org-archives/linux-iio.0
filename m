Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-004.synserver.de ([212.40.185.4]:1064 "EHLO
	smtp-out-004.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbaFFPkL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jun 2014 11:40:11 -0400
Message-ID: <5391E0D7.8050309@metafoo.de>
Date: Fri, 06 Jun 2014 17:40:07 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
CC: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: make blocking read wait for data
References: <1402065052-32161-1-git-send-email-josselin.costanzi@mobile-devices.fr> <5391D279.5060909@metafoo.de> <CAJA4uhc+RdEmOgyK8f3VHTqgCdAbVtdko1EW8z3BDvFq8Y4Rzw@mail.gmail.com>
In-Reply-To: <CAJA4uhc+RdEmOgyK8f3VHTqgCdAbVtdko1EW8z3BDvFq8Y4Rzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/06/2014 05:12 PM, Josselin Costanzi wrote:
> 2014-06-06 16:38 GMT+02:00 Lars-Peter Clausen <lars@metafoo.de>:
>>
>> On 06/06/2014 04:30 PM, Josselin Costanzi wrote:
>>>
>>> Currently the IIO buffer blocking read only wait until at least one
>>> data element is available.
>>
>> But that is how it is supposed to work. With this patch for example you won't be able to read the last data from the buffer after the buffer has been disabled.
>
> I don't understand the usecase this patch breaks... If the buffer is
> disabled then we return what was read alreay.
>

If there is less data in the buffer than the amount of requested data you'll 
keep looping forever.

>
>> Or if for example n is not aligned to the sample size you'll also continue to loop forever.
>
> If n isn't aligned to the sample size, wouldn't iio_read_first_n_kfifo
> still return data multiple of samples size? In that case we would copy
> complete elements until we try to do a short read which would fail at
> n < kfifo_esize(&kf->kf) (in iio_read_first_n_kfifo).
>

The read_first_n() callback will make sure that it only returns full 
samples, which means if n is smaller than the sample size it will return 0.

Now in your patch you have
	do {
		ret = read_first_n(..., n, ...);
		n -= ret;
	} while (n > 0);

So if n is not a multiple of the sample size you'll end up with n being 
smaller than the size of one sample but larger than 0 and at that point 
read_first_n() will always return 0 and n will stay at its current value. 
This means the exit condition of the while loop will never be met and you 
keep on looping forever.

Maybe start with which problem you are trying to address with this patch and 
then we can work forward from there to a solution. The current form of the 
patch changes the semantics of read() in a way they shouldn't be changed, so 
this is not only about the implementation bugs.

- Lars
