Return-Path: <SRS0=K+Tw=XZ=free-electrons.com=quentin.schulz@kernel.org>
Subject: Re: [PATCH v8 3/3] iio: adc: add support for Allwinner SoCs ADC
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20161209102236.17655-1-quentin.schulz@free-electrons.com>
 <20161209102236.17655-4-quentin.schulz@free-electrons.com>
 <alpine.DEB.2.02.1612091657540.16360@pmeerw.net>
 <b985dc64-fa14-1930-e73d-1d197b29ba53@free-electrons.com>
 <alpine.DEB.2.02.1612100801450.30369@pmeerw.net>
Cc: linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org,
 jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <08883409-b6ce-94d5-82c9-fc8602dec194@free-electrons.com>
Date: Sat, 10 Dec 2016 09:42:50 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1612100801450.30369@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Hi Peter,

On 10/12/2016 08:04, Peter Meerwald-Stadler wrote:
> 
>> [...]
>>>> +	case IIO_CHAN_INFO_SCALE:
>>>> +		if (chan->type == IIO_VOLTAGE) {
>>>> +			/* 3000mV / 4096 * raw */
>>>> +			*val = 0;
>>>> +			*val2 = 732421875;
>>>
>>> this looks more like INT_PLUS_NANO, beyond range of micro?
>>>
>>>> +			return IIO_VAL_INT_PLUS_MICRO;
>>
>> No, this is rather a mistake.
>>
>> The scale to convert to mV is 0.732421875 (3000mV / 4096). The scale to
> 
> correct
> 
>> convert to uV is thus 732.421875.
> 
> yes, but we want millivolt in IIO (ABI/testing/see sysfs-bus-iio)
> 
> I think you should change _PLUS_MICRO to _PLUS_NANO
> 

Then, obviously yes. I'll check the other scales as well to be sure.

Thanks!

Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
