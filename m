Return-Path: <SRS0=A2el=MZ=embeddedor.com=gustavo@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181008173528.GA31787@embeddedor.com>
 <ded46d23-0ec9-3fc8-3fc2-fa8003639272@axentia.se>
 <20181013133831.7dbd31e8@archlinux>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] iio: dpot-dac: mark expected switch fall-through
Message-ID: <1f64449a-ef19-20c8-f8cb-7e629f8fe71b@embeddedor.com>
Date: Sat, 13 Oct 2018 15:08:08 +0200
MIME-Version: 1.0
In-Reply-To: <20181013133831.7dbd31e8@archlinux>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>



On 10/13/18 2:38 PM, Jonathan Cameron wrote:
> On Mon, 8 Oct 2018 20:42:41 +0000
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On 2018-10-08 19:35, Gustavo A. R. Silva wrote:
>>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>>> where we are expecting to fall through.  
>>
>> The way I see it, it is pretty well marked up as is. So, this paragraph
>> is not describing the change.
>>
>>>
>>> Notice that in this particular case, I replaced "...and fall through."
>>> with a proper "fall through", which is what GCC is expecting to find.  
>>
>> What is not "proper" about the existing comment? Yes yes, I *know* that
>> GCC is not very intelligent about it and requires hand-holding, but
>> blaming the existing comment for not *properly* marking an intentional
>> fall through is ... rich.
>>
>>>
>>> Addresses-Coverity-ID: 1462408 ("Missing break in switch")
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>  drivers/iio/dac/dpot-dac.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
>>> index a791d0a..e353946 100644
>>> --- a/drivers/iio/dac/dpot-dac.c
>>> +++ b/drivers/iio/dac/dpot-dac.c
>>> @@ -78,7 +78,7 @@ static int dpot_dac_read_raw(struct iio_dev *indio_dev,  
>>
>> Adding some more context here.
>>
>> 		case IIO_VAL_INT:
>> 			/*
>> 			 * Convert integer scale to fractional scale by
>> 			 * setting the denominator (val2) to one...
>>>  			 */
>>>  			*val2 = 1;
>>>  			ret = IIO_VAL_FRACTIONAL;
>>> -			/* ...and fall through. */
>>> +			/* fall through */
>>>  		case IIO_VAL_FRACTIONAL:
>>>  			*val *= regulator_get_voltage(dac->vref) / 1000;
>>>  			*val2 *= dac->max_ohms;
>>>   
>>
>> Considering the above added context, I have to say that this mindless
>> change is not an improvement, as you have just destroyed the continued
>> sentence from the previous comment. You must have noticed that this
>> was the end of a continued sentence, as you even quoted it in the commit
>> message. The big question is why you did not stop to think and consider
>> the context?
>>
>> Yes, I'm annoyed by mindless changes. Especially mindless changes aimed
>> at improving readability while in fact making things less readable.
>>
>> TL;DR, if you are desperate to fix "the problem" with this fall through
>> comment, please do so in a way that preserves overall readability. And
>> it would be nice to not blame the existing code for brain damage in GCC
>> and various other static analyzers.
>>
>> Cheers,
>> Peter
> I agree with you in principle Peter and have tweaked the patch description
> to make it clearer that we are doing this to make GCC static analysis more
> helpful (suppressing a false warning is a worthwhile if you are dealing with
> lots of them).
> 
> However, nice though it is to have elegant comment structure I think we
> should still have this patch in place.  This effort to 'fix' these
> warnings has already identified a few places where it was wrong so
> I'm keen to see it applied by default even if it isn't perfect.
> 

Thanks, Jonathan. Below are some examples of cases in which the fall-through
warning turned out to be an actual bug:

commit c24bfa8f21b59283580043dada19a6e943b6e426
commit ad0eaee6195db1db1749dd46b9e6f4466793d178
commit 9ba8376ce1e2cbf4ce44f7e4bee1d0648e10d594
commit dc586a60a11d0260308db1bebe788ad8973e2729
commit a8e9b186f153a44690ad0363a56716e7077ad28c
commit 4e57562b4846e42cd1c2e556f0ece18c1154e116
commit 7c92e5fbf4dac0dd4dd41a0383adc54f16f403e2
commit c5b974bee9d2ceae4c441ae5a01e498c2674e100
commit 2c930e3d0aed1505e86e0928d323df5027817740
commit 882518debc8487147d618d5f26f4bb0bea1cc05b
commit f745e9cc7e40c4570ab5e8d5ef32bfaa6e8ced46
commit 5dc874252faa818426480a7c00fa05738fe05402
commit 4a00aa057759d713e1296ecbc614fa560d569977
commit 6d3f06a0042ebd59a5e9d4ba6e8a85596901e140
commit 827d240a232d27cc12e9657d012f2e5ba953e98a
commit a28b259b43914b04746184cec318c67bded7234c
commit 9e7b319e1d1e6cba41ae96f791789a7806b29584
commit d393be3ed0bebb30a4666d7f5ed4486cd6b31716
commit 680682d4d537565e2c358483e1feeca30a8cf3d4
commit 06af9b0f4949b85b20107e6d75f5eba15111d220

So, yeah. This effort is worth it.

Thanks
--
Gustavo
