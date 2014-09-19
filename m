Return-Path: <maitysanchayan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20140918133426.GI4796@dragon>
References: <cover.1411039381.git.maitysanchayan@gmail.com>
	<20140918133426.GI4796@dragon>
Date: Fri, 19 Sep 2014 15:27:32 +0530
Message-ID: <CANkTNWAtxhsxUFJ0H2OfA0jNrbm=Cdb+gP5-c3_t15fJt8MHyQ@mail.gmail.com>
Subject: Re: [PATCH v2] Implement temperature sensor for vf610-adc
From: Sanchayan Maity <maitysanchayan@gmail.com>
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Stefan Agner <stefan@agner.ch>, jic23@kernel.org, B38611@freescale.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

>> Vybrid ADC peripheral includes a temperature sensor
>> which is connected to channel number 26. The patch
>> adds support for the sensor. The raw value is read
>> and the temperature calculated in milli degree Celsius,
>> which is returned using IIO_CHAN_INFO_PROCESSED option.
>>
>> Sanchayan Maity (1):
>>   ARM: imx: vf610-adc: Add temperature sensor support
>
> This is not an arch/arm/mach-imx patch, so shouldn't be prefixed with
> "ARM: imx: ".  And also it's more appropriate to put Jonathan Cameron
> <jic23@kernel.org> on "To:", since he is responsible for picking
> drivers/iio/adc patches.
>
> Shawn

Thanks for the input. Will clean and resend. Will address the v3 patch
to Jonathan.

>
>>
>>  drivers/iio/adc/vf610_adc.c |   28 ++++++++++++++++++++++++++--
>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> --
>> 1.7.9.5
>>
