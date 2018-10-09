Return-Path: <charles-antoine.couret@essensium.com>
Subject: Re: [PATCH 1/2] Add AD7949 ADC driver family
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
 "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20181006203036.20338-1-charles-antoine.couret@essensium.com>
 <20181007172522.04d50998@archlinux>
 <09d26591-d200-b561-0baa-f40b2970a062@essensium.com>
 <788ae1dddbb5ef8f44477483873ac321bb922056.camel@analog.com>
From: Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Message-ID: <06c004bf-fc15-7b03-aa09-8d6f55ab47f1@essensium.com>
Date: Tue, 9 Oct 2018 09:12:35 +0200
MIME-Version: 1.0
In-Reply-To: <788ae1dddbb5ef8f44477483873ac321bb922056.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Le 09/10/2018 à 08:25, Ardelean, Alexandru a écrit :
>
>>>> +#define AD7949_OFFSET_CHANNEL_SEL	7
>>>> +#define AD7949_CFG_READ_BACK		0x1
>>>> +#define AD7949_CFG_REG_SIZE_BITS	14
>>>> +
>>>> +enum {
>>>> +	HEIGHT_14BITS = 0,
>>>> +	QUAD_16BITS,
>>>> +	HEIGHT_16BITS,
>>> Height? I guess EIGHT was the intent.
>>> I would just use the part numbers for this rather than a
>>> descriptive phrase.
>> Thank you for the typo.
>>
>> But I don't understand your remark. What do you mean by "part numbers"
>> here?
> A lot of drivers define something like:
> enum {
>     ID_AD7949,
>     ID_AD7682,
>     ID_AD7689,
> }
> which can be refered to as "part number", and then you can use these enum
> values to identify behavior and configuration for each device the driver
> supports.
>
> This method is preferred, because when/if a new chip comes along that fits
> into this driver (let's say ID_ADXXYZ), and may have QUAD_16BITS and
> differs in some other minor aspect, it can be easier to identify via the
> part-number. Or, in some cases, some chips get a newer revision (example:
> ID_AD7949B) that may differ slightly (from ID_AD7949).
Ok, I understand, thank you for the explanation.
>>>> +	struct spi_message msg;
>>>> +	struct spi_transfer tx[] = {
>>>> +		{
>>>> +			.tx_buf = &buf_value,
>>>> +			.len = 4,
>>>> +			.bits_per_word = bits_per_word,
>>>> +		},
>>>> +	};
>>>> +
>>>> +	ad7949_adc->cfg = buf_value >> shift;
>>>> +	spi_message_init(&msg);
>>>> +	spi_message_add_tail(&tx[0], &msg);
>>>> +	ret = spi_sync(ad7949_adc->spi, &msg);
>>>> +	udelay(2);
>>> These delays need explaining as they are non obvious and there
>>> may be cleaner ways to handle them.
>> I want to add this comment:
>>
>>       /* This delay is to avoid a new request before the required time to
>>        * send a new command to the device
>>        */
>>
>> It is clear and relevant enough?
> I think in such a case, a lock/mutex would be needed.
> As far as I remember, kernel SPI calls should have their own locks for
> single SPI transactions, so maybe some locks for accessing the chip during
> a set of SPI transactions would be neater.

The mutex is used in parent level (the functions which make the link 
between userspace and this function). It seems enough for me.

In that case the purpose of the delay is only to avoid a new request 
just after this one which will fail because too early for the device. It 
is just a timing protection, it is not uncommon from my point of view.


Regards,

Charles-Antoine Couret
