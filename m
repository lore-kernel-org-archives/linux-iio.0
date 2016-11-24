Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51010 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757276AbcKXUM5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2016 15:12:57 -0500
Subject: Re: [patch] iio: tsl2583: make array large enough
To: Brian Masney <masneyb@onstation.org>, walter harms <wharms@bfs.de>
References: <20161118140326.GA20458@basecamp.onstation.org>
 <20161124133807.GA32255@mwanda>
 <20161124154833.GB2118@basecamp.onstation.org> <58371B39.30503@bfs.de>
 <20161124175126.GA3088@basecamp.onstation.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5b562702-483c-5400-5586-145005817d27@kernel.org>
Date: Thu, 24 Nov 2016 20:12:52 +0000
MIME-Version: 1.0
In-Reply-To: <20161124175126.GA3088@basecamp.onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/11/16 17:51, Brian Masney wrote:
> On Thu, Nov 24, 2016 at 05:54:17PM +0100, walter harms wrote:
>>
>>
>> Am 24.11.2016 16:48, schrieb Brian Masney:
>>> On Thu, Nov 24, 2016 at 04:38:07PM +0300, Dan Carpenter wrote:
>>>> This array is supposed to have 10 elements.  Smatch complains that with
>>>> the current code we can have n == max_ints and read beyond the end of
>>>> the array.
>>>>
>>>> Fixes: ac4f6eee8fe8 ("staging: iio: TAOS tsl258x: Device driver")
>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>>
>>>> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
>>>> index 0b87f6a..a78b602 100644
>>>> --- a/drivers/iio/light/tsl2583.c
>>>> +++ b/drivers/iio/light/tsl2583.c
>>>> @@ -565,7 +565,7 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
>>>>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>>>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
>>>>  	const unsigned int max_ints = TSL2583_MAX_LUX_TABLE_ENTRIES * 3;
>>>> -	int value[TSL2583_MAX_LUX_TABLE_ENTRIES * 3];
>>>> +	int value[TSL2583_MAX_LUX_TABLE_ENTRIES * 3 + 1];
>>>>  	int ret = -EINVAL;
>>>>  	unsigned int n;
>>>>  
>>>
>>
>> sorry i did not notice that bevor ..
>> there is a
>>   max_ints = TSL2583_MAX_LUX_TABLE_ENTRIES * 3
>>
>> IMHO this should read either:
>>    int value[max_ints+1];
> 
> I originally went this route when I refactored the function, however
> running make C=1 yields the following warnings:
> 
> drivers/iio/light/tsl2583.c:568:19: warning: Variable length array is
> used.
> drivers/iio/light/tsl2583.c:574:26: error: cannot size expression
> 
> That is why I went with the current implementation.
> 
>> or
>>   max_ints=ARRAY_SIZE(value)-1;
>>
>> (my personal favorite is dropping max_ints completely).
> 
> The max_ints value is also shown in the error message if the user passes
> in too many or too few entries in the per device lux table. I wanted the
> user to see the maximum allowable number without having to dig through
> the kernel source code. Without it, I would have had to duplicate the
> TSL2583_MAX_LUX_TABLE_ENTRIES * 3 statement a third time.
> 
> Brian
> 
I'm taking this as is, because it'll just squeeze into my last
pull request to Greg.  Sorry for not waiting for this discussion
to finish first!

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to very briefly play with it.

Thanks,

Jonathan
