Return-Path: <bigeasy@linutronix.de>
Message-ID: <521E42F2.2090707@linutronix.de>
Date: Wed, 28 Aug 2013 20:35:30 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Zubair Lutfullah : <zubair.lutfullah@gmail.com>
CC: jic23@cam.ac.uk, lee.jones@linaro.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
References: <1377470724-15710-1-git-send-email-zubair.lutfullah@gmail.com> <1377470724-15710-3-git-send-email-zubair.lutfullah@gmail.com> <20130828164308.GE14111@linutronix.de> <20130828181951.GA3580@gmail.com>
In-Reply-To: <20130828181951.GA3580@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 08/28/2013 08:19 PM, Zubair Lutfullah : wrote:
> On Wed, Aug 28, 2013 at 06:43:08PM +0200, Sebastian Andrzej Siewior wrote:
>> * Zubair Lutfullah | 2013-08-25 23:45:24 [+0100]:
>>
>>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>>> index a952538..ae2202b 100644
>>> --- a/drivers/iio/adc/ti_am335x_adc.c
>>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>>> @@ -231,28 +406,56 @@ static int tiadc_probe(struct platform_device *pdev)
>> …
>>> +err_free_device:
>>> +	iio_device_free(indio_dev);
>>
>> I am not sure about this one.
> 
> If I understand correctly, if devm_iio_device_alloc 
> is successful earlier in the code and subsequent stuff fails. 
> 
> Then the code jumps to err_free_device and this is needed.

Yes, but devm_() helper release the memory on failer _or_ device /
driver removal.

>>> +err_ret:
>>> 	return err;
>>> }
>>>
>>> @@ -262,11 +465,14 @@ static int tiadc_remove(struct platform_device *pdev)
>>> 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>>> 	u32 step_en;
>>>
>>> +	free_irq(adc_dev->irq, indio_dev);
>>> 	iio_device_unregister(indio_dev);
>>> +	iio_buffer_unregister(indio_dev);
>>> 	tiadc_channels_remove(indio_dev);
>>>
>>> 	step_en = get_adc_step_mask(adc_dev);
>>> 	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);
>>> +	iio_device_free(indio_dev);
>>
>> But this one is wrong. The will be removed via dev_res() and if you do
>> it here as well then dev_res() will decrement the reference of an unused
>> object.
> I was unaware of this aspect.
> 
> *but*
> 
> iio_simple_dummy.c has it in its remove function.
> And I just checked and found it in several drivers as well.
> 
> I'll leave this to the more experienced folks on the list..

You can belive me one thing or the other :)
Point me one driver please. Do they use devm_iio_device_alloc() like
you do or iio_device_alloc()? In case of the latter you need to
manually free the memory.

>>>
>>> 	return 0;
>>> }

Sebastian
