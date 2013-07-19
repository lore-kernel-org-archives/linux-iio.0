Return-Path: <Hector.Palacios@digi.com>
Message-ID: <51E967D8.8020001@digi.com>
Date: Fri, 19 Jul 2013 18:22:48 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>, "jic23@kernel.org"
	<jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH v2 5/5] iio: mxs-lradc: add write_raw function to modify
 scale
References: <1374225208-28940-1-git-send-email-hector.palacios@digi.com> <201307191639.01240.marex@denx.de> <51E95BEC.5080703@digi.com> <201307191817.27102.marex@denx.de>
In-Reply-To: <201307191817.27102.marex@denx.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Dear Marek,

On 07/19/2013 06:17 PM, Marek Vasut wrote:
>> Here you have three entries per channel:
>> in_voltageX_raw		-> the sample raw value
>> in_voltageX_scale	-> the scale to multiply the raw value to get the
> voltage
>> in mV in_voltageX_scale_available -> lists the available scales of the
>> channel
>>
>> For example for channel 0:
>>
>> # cat in_voltage0_scale_available
>> 0.451660156 0.903320312	(two scales available, first with divider by two
>> disabled, second with divider by two enabled)
>>
>> # cat in_voltage0_scale
>> 0.451660156			(divider by two is currently disabled)
>>
>> # cat in_voltage0_raw		(shows measured value)
>> 1000
>>
>> If you multiply the value by the scale you get: 1000 * 0.451660156 = 451.6
>> mV
>>
>> # echo 0.903320312 > in_voltage0_scale	(enables the divider by two)
>
> Ok, so I have to remember this value : '0.903320312' in case I want to enable
> divide-by-two functionality?

No you don't. That's why there is a 'in_voltage_scale_available' that lists the 
available values.

> Hmmmm ... why would this interface not work:
> echo 2 > in_voltage0_scale
>
> or
>
> echo 1 > in_voltage0_scale

An easy thing like that is what I first submitted, but it was rejected and I was told 
to use the scale_available descriptor instead, which is the common interface the rest 
of drivers use.

Best regards,
--
Hector Palacios
