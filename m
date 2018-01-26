Return-Path: <SRS0=B3Gt=EV=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH v3 1/2] iio: adc: driver for ti adc081s/adc101s/adc121s
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Milan Stevanovic <milan.o.stevanovic@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>,
 Matt Ranostay <mranostay@gmail.com>
References: <1515961960-35157-1-git-send-email-milan.o.stevanovic@gmail.com>
 <CAHp75Ve-WpJ6kqdW3WZFpO6pnSPdnVidVJ3EhOM+Fvs2AstQxw@mail.gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <7eb264e1-810a-ae6d-08fe-c6df2fe5d126@metafoo.de>
Date: Fri, 26 Jan 2018 19:34:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve-WpJ6kqdW3WZFpO6pnSPdnVidVJ3EhOM+Fvs2AstQxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 01/26/2018 07:19 PM, Andy Shevchenko wrote:
> On Sun, Jan 14, 2018 at 10:32 PM, Milan Stevanovic
> <milan.o.stevanovic@gmail.com> wrote:
>>     Add Linux device driver for TI single-channel CMOS
>>     8/10/12-bit analog-to-digital converter with a
>>     high-speed serial interface.
>>
>> Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>
> 
>> + * Analog Devices AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver
>> + * TI ADC081S/ADC101S/ADC121S 8/10/12-bit SPI ADC driver
> 
> Guys, I'm not sure I understood this mix.
> 
> We have like few TI drivers here:
> 
> drivers/iio/adc/ti-adc0832.c:352:module_spi_driver(adc0832_driver);
> drivers/iio/adc/ti-adc084s021.c:269:module_spi_driver(adc084s021_driver);
> drivers/iio/adc/ti-adc108s102.c:343:module_spi_driver(adc108s102_driver);
> drivers/iio/adc/ti-adc12138.c:547:module_spi_driver(adc12138_driver);
> drivers/iio/adc/ti-adc128s052.c:211:module_spi_driver(adc128_driver);
> drivers/iio/adc/ti-adc161s626.c:276:module_spi_driver(ti_adc_driver);
> drivers/iio/adc/ti-ads7950.c:519:module_spi_driver(ti_ads7950_driver);
> drivers/iio/adc/ti-ads8688.c:481:module_spi_driver(ads8688_driver);
> drivers/iio/adc/ti-tlc4541.c:266:module_spi_driver(tlc4541_driver);
> 
> What's wrong with them?
> 
> Is it here code duplication between two vendors?
> 

Looking at this list ti-adc161s626 could probably be combined with the
ad7476 driver. It fits the bill, single channel ADC with SPI interface and
no control registers.
