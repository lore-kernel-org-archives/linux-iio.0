Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ed1-f42.google.com ([209.85.208.42]:34044 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeJIEbr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Oct 2018 00:31:47 -0400
Received: by mail-ed1-f42.google.com with SMTP id w19-v6so3681349eds.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Oct 2018 14:18:05 -0700 (PDT)
Subject: Re: [PATCH 1/2] Add AD7949 ADC driver family
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org
References: <20181006203036.20338-1-charles-antoine.couret@essensium.com>
 <20181007172522.04d50998@archlinux>
From: Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Message-ID: <09d26591-d200-b561-0baa-f40b2970a062@essensium.com>
Date: Mon, 8 Oct 2018 23:18:03 +0200
MIME-Version: 1.0
In-Reply-To: <20181007172522.04d50998@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Le 07/10/2018 à 18:25, Jonathan Cameron a écrit :
> Hi Charles-Antoine, 

Hello,

Thank you for your code review, I'm trying to take everything into 
account but I have some questions about it before making the V2.

>> +#define AD7949_OFFSET_CHANNEL_SEL	7
>> +#define AD7949_CFG_READ_BACK		0x1
>> +#define AD7949_CFG_REG_SIZE_BITS	14
>> +
>> +enum {
>> +	HEIGHT_14BITS = 0,
>> +	QUAD_16BITS,
>> +	HEIGHT_16BITS,
> Height? I guess EIGHT was the intent.
> I would just use the part numbers for this rather than a
> descriptive phrase.

Thank you for the typo.

But I don't understand your remark. What do you mean by "part numbers" 
here?

>> +	struct spi_message msg;
>> +	struct spi_transfer tx[] = {
>> +		{
>> +			.tx_buf = &buf_value,
>> +			.len = 4,
>> +			.bits_per_word = bits_per_word,
>> +		},
>> +	};
>> +
>> +	ad7949_adc->cfg = buf_value >> shift;
>> +	spi_message_init(&msg);
>> +	spi_message_add_tail(&tx[0], &msg);
>> +	ret = spi_sync(ad7949_adc->spi, &msg);
>> +	udelay(2);
> These delays need explaining as they are non obvious and there
> may be cleaner ways to handle them.

I want to add this comment:

     /* This delay is to avoid a new request before the required time to
      * send a new command to the device
      */

It is clear and relevant enough?

>
>> +	struct spi_message msg;
>> +	struct spi_transfer tx[] = {
>> +		{
>> +			.rx_buf = &buf_value,
>> +			.len = 4,
>> +			.bits_per_word = bits_per_word,
>> +		},
>> +	};
> I 'think' this is the same in every call of this function, so why not
> set it up in the probe function and have it ready all the time rather than
> spinning up a new copy here each time.
bits_per_word depends on if the configuration readback is enabled or 
not. It could be changed in runtime. So I considered we can not optimize 
in that way.

Regards,
Charles-Antoine Couret
