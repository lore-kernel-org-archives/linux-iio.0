Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from [212.40.180.149] ([212.40.180.149]:39293 "EHLO
	smtp-out-195.synserver.de" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756224AbcBCPvh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Feb 2016 10:51:37 -0500
Subject: Re: [PATCH v2] iio: adc: Add TI ADS1015 ADC driver support
To: Daniel Baluta <daniel.baluta@intel.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1454494947-9073-1-git-send-email-daniel.baluta@intel.com>
 <alpine.DEB.2.02.1602031122350.12205@pmeerw.net>
 <CAEnQRZDxQ4KCX_paZCf0iGjZ1rp-qeF1BGKgWoQZOhUYk_fi1g@mail.gmail.com>
 <alpine.DEB.2.02.1602031604531.12205@pmeerw.net>
 <CAEnQRZBDfb_2F=UafL9Dx+6s8Q4Si7JCdrgSb5D0xq_nT2BipQ@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56B22064.5030706@metafoo.de>
Date: Wed, 3 Feb 2016 16:44:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZBDfb_2F=UafL9Dx+6s8Q4Si7JCdrgSb5D0xq_nT2BipQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/03/2016 04:18 PM, Daniel Baluta wrote:
> On Wed, Feb 3, 2016 at 5:09 PM, Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
>>
>>>>> +     .scan_index = _addr,                                    \
>>>>> +     .scan_type = {                                          \
>>>>> +             .sign = 's',                                    \
>>>>> +             .realbits = 12,                                 \
>>>>> +             .storagebits = 16,                              \
>>>>> +             .shift = 4,                                     \
>>>>> +             .endianness = IIO_CPU,                          \
>>>>
>>>> I don't see the code for endianness conversion, I guess it should be _BE
>>>> (also below)
>>>
>>> Conversion register is _BE but I think here is better to use IIO_CPU.
>>> regmap_read() encapsulates a lot of magic, it actually does the endianness
>>> conversion.
>>
>> indeed, this is super complicated
>>
>>> converts the value read from reg endianess to cpu endianness (in our case
>>> there is a transparent call  to b16_to_cpu).
>>
>> kind of, depending on what i2c capabilities you have :)
>>
>> anyway, your code *might* be correct :)
> 
> Can you point a case where the code can be wrong?

It should always be correct. When using the raw I2C functions regmap does
the conversion, when the adapter only supports SMBUS and the SMBUS functions
are used those do the conversion.
