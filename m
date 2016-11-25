Return-Path: <wharms@bfs.de>
Message-ID: <5837FC09.7010902@bfs.de>
Date: Fri, 25 Nov 2016 09:53:29 +0100
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
To: Brian Masney <masneyb@onstation.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eva Rachel Retuya <eraretuya@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio: tsl2583: make array large enough
References: <20161118140326.GA20458@basecamp.onstation.org> <20161124133807.GA32255@mwanda> <20161124154833.GB2118@basecamp.onstation.org> <58371B39.30503@bfs.de> <20161124175126.GA3088@basecamp.onstation.org>
In-Reply-To: <20161124175126.GA3088@basecamp.onstation.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>



Am 24.11.2016 18:51, schrieb Brian Masney:
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


Hello Brian, thanks for the replay,

i have no problem when people so such things intentional but some times
people do this unintentional. When i review code, i see it as part of my
job to challenge constructs where i get a strange feeling.

re,
 wh
