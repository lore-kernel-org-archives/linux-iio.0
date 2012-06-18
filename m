Return-Path: <lars@metafoo.de>
Message-ID: <4FDEE57E.1040301@metafoo.de>
Date: Mon, 18 Jun 2012 10:23:26 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [v2 2/9] iio:adc:at91: Use new triggered buffer setup helper
References: <1339145332-26811-1-git-send-email-lars@metafoo.de> <1339145332-26811-2-git-send-email-lars@metafoo.de> <4FDB6399.8080209@metafoo.de> <4FDEDF3A.7030601@free-electrons.com>
In-Reply-To: <4FDEDF3A.7030601@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 06/18/2012 09:56 AM, Maxime Ripard wrote:
> Hi Lars-Peter,
> 
> Sorry, I thought Jonathan's Acked-by was enough.

No problem. I guess Jonathan's Acked-by is sort of enough, but having your
Acked-by as well is even better :). You are the author of that driver and
probably know the code better than anybody else.

> 
> I'm definitely ok with these changes, you can add my acked-by.
> 

Thanks,
- Lars

> Maxime
> 
> Le 15/06/2012 18:32, Lars-Peter Clausen a écrit :
>> On 06/08/2012 10:48 AM, Lars-Peter Clausen wrote:
>>> Use the new triggered buffer setup helper function to allocate and register
>>> buffer and pollfunc.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>>
>> Hi Maxime,
>>
>> Can you take a look at this patch and say whether you are OK with it? I've
>> only compile tested it since I don't have the hardware, but I don't expect
>> any problems since the conversion is straight forward and a similar
>> conversion has been done for other drivers as well, which worked fine so far.
>>
>> Thanks,
>> - Lars
>>
>>
>>> ---
>>>  drivers/iio/adc/Kconfig    |    3 +--
>>>  drivers/iio/adc/at91_adc.c |   51 ++++----------------------------------------
>>>  2 files changed, 5 insertions(+), 49 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index 9a0df81..4f7f584 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -7,8 +7,7 @@ config AT91_ADC
>>>  	tristate "Atmel AT91 ADC"
>>>  	depends on ARCH_AT91
>>>  	select IIO_BUFFER
>>> -	select IIO_KFIFO_BUF
>>> -	select IIO_TRIGGER
>>> +	select IIO_TRIGGERED_BUFFER
>>>  	select SYSFS
>>>  	help
>>>  	  Say yes here to build support for Atmel AT91 ADC.
>>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>>> index f18a95d..6a08469 100644
>>> --- a/drivers/iio/adc/at91_adc.c
>>> +++ b/drivers/iio/adc/at91_adc.c
>>> @@ -26,9 +26,9 @@
>>>  
>>>  #include <linux/iio/iio.h>
>>>  #include <linux/iio/buffer.h>
>>> -#include <linux/iio/kfifo_buf.h>
>>>  #include <linux/iio/trigger.h>
>>>  #include <linux/iio/trigger_consumer.h>
>>> +#include <linux/iio/triggered_buffer.h>
>>>  
>>>  #include <mach/at91_adc.h>
>>>  
>>> @@ -318,58 +318,15 @@ static void at91_adc_trigger_remove(struct iio_dev *idev)
>>>  	}
>>>  }
>>>  
>>> -static const struct iio_buffer_setup_ops at91_adc_buffer_ops = {
>>> -	.preenable = &iio_sw_buffer_preenable,
>>> -	.postenable = &iio_triggered_buffer_postenable,
>>> -	.predisable = &iio_triggered_buffer_predisable,
>>> -};
>>> -
>>>  static int at91_adc_buffer_init(struct iio_dev *idev)
>>>  {
>>> -	int ret;
>>> -
>>> -	idev->buffer = iio_kfifo_allocate(idev);
>>> -	if (!idev->buffer) {
>>> -		ret = -ENOMEM;
>>> -		goto error_ret;
>>> -	}
>>> -
>>> -	idev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
>>> -					    &at91_adc_trigger_handler,
>>> -					    IRQF_ONESHOT,
>>> -					    idev,
>>> -					    "%s-consumer%d",
>>> -					    idev->name,
>>> -					    idev->id);
>>> -	if (idev->pollfunc == NULL) {
>>> -		ret = -ENOMEM;
>>> -		goto error_pollfunc;
>>> -	}
>>> -
>>> -	idev->setup_ops = &at91_adc_buffer_ops;
>>> -	idev->modes |= INDIO_BUFFER_TRIGGERED;
>>> -
>>> -	ret = iio_buffer_register(idev,
>>> -				  idev->channels,
>>> -				  idev->num_channels);
>>> -	if (ret)
>>> -		goto error_register;
>>> -
>>> -	return 0;
>>> -
>>> -error_register:
>>> -	iio_dealloc_pollfunc(idev->pollfunc);
>>> -error_pollfunc:
>>> -	iio_kfifo_free(idev->buffer);
>>> -error_ret:
>>> -	return ret;
>>> +	return iio_triggered_buffer_setup(idev, &iio_pollfunc_store_time,
>>> +		&at91_adc_trigger_handler, NULL);
>>>  }
>>>  
>>>  static void at91_adc_buffer_remove(struct iio_dev *idev)
>>>  {
>>> -	iio_buffer_unregister(idev);
>>> -	iio_dealloc_pollfunc(idev->pollfunc);
>>> -	iio_kfifo_free(idev->buffer);
>>> +	iio_triggered_buffer_cleanup(idev);
>>>  }
>>>  
>>>  static int at91_adc_read_raw(struct iio_dev *idev,
>>
> 
> 
