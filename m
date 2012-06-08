Return-Path: <lars@metafoo.de>
Message-ID: <4FD1B065.4060503@metafoo.de>
Date: Fri, 08 Jun 2012 09:57:25 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/9] iio:adc:at91: Use new triggered buffer setup helper
References: <1338983756-31243-1-git-send-email-lars@metafoo.de> <1338983756-31243-3-git-send-email-lars@metafoo.de> <4FD108C1.3020405@kernel.org>
In-Reply-To: <4FD108C1.3020405@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/07/2012 10:02 PM, Jonathan Cameron wrote:
> On 06/06/2012 12:55 PM, Lars-Peter Clausen wrote:
>> Use the new triggered buffer setup helper function to allocate and register
>> buffer and pollfunc.
>>
> Other than dropping IIO_TRIGGER select this is fine.
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/iio/adc/Kconfig    |    2 +-
>>  drivers/iio/adc/at91_adc.c |   49 +++-----------------------------------------
>>  2 files changed, 4 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 9a0df81..bbd2291 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -7,7 +7,7 @@ config AT91_ADC
>>  	tristate "Atmel AT91 ADC"
>>  	depends on ARCH_AT91
>>  	select IIO_BUFFER
>> -	select IIO_KFIFO_BUF
>> +	select IIO_TRIGGERED_BUFFER
>>  	select IIO_TRIGGER
> given IIO_TRIGGERED_BUFFER selects IIO_TRIGGER, drop that as well.

The reasoning for keeping it was, that the driver registers it's own trigger
and as such has a direct dependency on the trigger code. Whereas the kfifo
dependency is now implicit. But I can remove the 'select IIO_TRIGGER' if you
prefer it.

Thanks,
- Lars
