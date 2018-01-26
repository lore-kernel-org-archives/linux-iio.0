Return-Path: <SRS0=B3Gt=EV=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH v3 1/2] iio: adc: driver for ti adc081s/adc101s/adc121s
From: Lars-Peter Clausen <lars@metafoo.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Milan Stevanovic <milan.o.stevanovic@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>
References: <1515961960-35157-1-git-send-email-milan.o.stevanovic@gmail.com>
 <CAHp75Ve-WpJ6kqdW3WZFpO6pnSPdnVidVJ3EhOM+Fvs2AstQxw@mail.gmail.com>
 <783221ff-7366-5a50-f022-8b7b8a21e998@metafoo.de>
Message-ID: <3ae9e7ba-9107-86fa-12f0-33226226a0ab@metafoo.de>
Date: Fri, 26 Jan 2018 19:29:39 +0100
MIME-Version: 1.0
In-Reply-To: <783221ff-7366-5a50-f022-8b7b8a21e998@metafoo.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 01/26/2018 07:25 PM, Lars-Peter Clausen wrote:
> On 01/26/2018 07:19 PM, Andy Shevchenko wrote:
>> On Sun, Jan 14, 2018 at 10:32 PM, Milan Stevanovic
>> <milan.o.stevanovic@gmail.com> wrote:
>>>     Add Linux device driver for TI single-channel CMOS
>>>     8/10/12-bit analog-to-digital converter with a
>>>     high-speed serial interface.
>>>
>>> Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>
>>
>>> + * Analog Devices AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver
>>> + * TI ADC081S/ADC101S/ADC121S 8/10/12-bit SPI ADC driver
>>
>> Guys, I'm not sure I understood this mix.
> 
> You often have the case where two or even more vendors produce parts that
> are (mostly) pin and register map compatible. This is typically to fulfill
> the second source requirement that some customers have.
> 
> It is not uncommon to see drivers that support parts from different vendors.

And I should probably add that this driver is for devices which are single
channel ADCs with a SPI interface and no configuration registers. There are
only so many ways to implement this (And I ensure you hardware designers
will definitely create implementations of all of those limited ways), so
there will probably be overlap between vendors.

- Lars
