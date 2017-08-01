Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3898 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbdHAPpd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Aug 2017 11:45:33 -0400
Message-ID: <1501602326.29303.332.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads7950: Allow to use on ACPI
 platforms
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner <david@lechnology.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Date: Tue, 01 Aug 2017 18:45:26 +0300
In-Reply-To: <20170730143158.3b907e8f@kernel.org>
References: <20170728222015.43574-1-andriy.shevchenko@linux.intel.com>
         <20170728222015.43574-2-andriy.shevchenko@linux.intel.com>
         <9d74cad7-be8e-9893-58bd-9fdd50298723@lechnology.com>
         <20170730143158.3b907e8f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 2017-07-30 at 14:31 +0100, Jonathan Cameron wrote:
> On Sat, 29 Jul 2017 20:27:13 -0500
> David Lechner <david@lechnology.com> wrote:
> 

Thanks for review! My answers below.

> > On 07/28/2017 05:20 PM, Andy Shevchenko wrote:
> > > ACPI enabled platforms do not have a mean of regulators. Instead
> > > we use
> > > hard coded voltage value for reference pin. When value is 0
> > > (default) we
> > > fall back to request a regulator.

> > > +/*
> > > + * In case of ACPI, we use the 5000 mV as default for the
> > > reference pin.
> > > + * Device tree users encode that via the vref-supply regulator.
> > > + */
> > > +#define TI_ADS7950_VA_MV_ACPI_DEFAULT	5000  
> > 
> > Now that I've thought about it a bit, you don't need to call this
> > the 
> > ACPI default, just call it the default. Then it will be obvious
> > that 
> > this is used when you don't have a regulator.

OK.
  
> > > +	/* Use hard coded value for reference voltage in ACPI
> > > case */
> > > +	if (ACPI_COMPANION(&spi->dev))
> > > +		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;  
> > 
> > Instead of checking or ACPI, you could just say "if we have a dummy 
> > regulator, then use the default value".


> Agreed. Sounds sensible to me.  Hopefully in DT people will
> provide the right regulator, but chances are this won't
> always happen.

There is no call like
regulator_is_dummy()
(and, looking into the code of regulator framework, can't be)

Can you elaborate a bit, maybe I'm missing something obvious?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
