Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33913 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbeAZSTz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Jan 2018 13:19:55 -0500
MIME-Version: 1.0
In-Reply-To: <1515961960-35157-1-git-send-email-milan.o.stevanovic@gmail.com>
References: <1515961960-35157-1-git-send-email-milan.o.stevanovic@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 26 Jan 2018 20:19:53 +0200
Message-ID: <CAHp75Ve-WpJ6kqdW3WZFpO6pnSPdnVidVJ3EhOM+Fvs2AstQxw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: adc: driver for ti adc081s/adc101s/adc121s
To: Milan Stevanovic <milan.o.stevanovic@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jan 14, 2018 at 10:32 PM, Milan Stevanovic
<milan.o.stevanovic@gmail.com> wrote:
>     Add Linux device driver for TI single-channel CMOS
>     8/10/12-bit analog-to-digital converter with a
>     high-speed serial interface.
>
> Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>

> + * Analog Devices AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver
> + * TI ADC081S/ADC101S/ADC121S 8/10/12-bit SPI ADC driver

Guys, I'm not sure I understood this mix.

We have like few TI drivers here:

drivers/iio/adc/ti-adc0832.c:352:module_spi_driver(adc0832_driver);
drivers/iio/adc/ti-adc084s021.c:269:module_spi_driver(adc084s021_driver);
drivers/iio/adc/ti-adc108s102.c:343:module_spi_driver(adc108s102_driver);
drivers/iio/adc/ti-adc12138.c:547:module_spi_driver(adc12138_driver);
drivers/iio/adc/ti-adc128s052.c:211:module_spi_driver(adc128_driver);
drivers/iio/adc/ti-adc161s626.c:276:module_spi_driver(ti_adc_driver);
drivers/iio/adc/ti-ads7950.c:519:module_spi_driver(ti_ads7950_driver);
drivers/iio/adc/ti-ads8688.c:481:module_spi_driver(ads8688_driver);
drivers/iio/adc/ti-tlc4541.c:266:module_spi_driver(tlc4541_driver);

What's wrong with them?

Is it here code duplication between two vendors?

-- 
With Best Regards,
Andy Shevchenko
