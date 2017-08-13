Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:46504 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbdHMOZy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Aug 2017 10:25:54 -0400
Message-ID: <1502634350.15214.6.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads7950: Allow to use on ACPI
 platforms
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <david@lechnology.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Date: Sun, 13 Aug 2017 17:25:50 +0300
In-Reply-To: <20170809142456.04b3767f@archlinux>
References: <20170728222015.43574-1-andriy.shevchenko@linux.intel.com>
         <20170728222015.43574-2-andriy.shevchenko@linux.intel.com>
         <9d74cad7-be8e-9893-58bd-9fdd50298723@lechnology.com>
         <20170730143158.3b907e8f@kernel.org>
         <1501602326.29303.332.camel@linux.intel.com>
         <51d5783f-4a7d-b51e-fd45-e4d84576f1c3@lechnology.com>
         <1501605706.29303.339.camel@linux.intel.com>
         <75c912ec-da05-1473-ef42-777386a54ffc@lechnology.com>
         <1501608271.29303.342.camel@linux.intel.com>
         <20170809142456.04b3767f@archlinux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2017-08-09 at 14:24 +0100, Jonathan Cameron wrote:
> On Tue, 01 Aug 2017 20:24:31 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Tue, 2017-08-01 at 12:15 -0500, David Lechner wrote:
> > > On 08/01/2017 11:41 AM, Andy Shevchenko wrote:  
> > > > On Tue, 2017-08-01 at 11:21 -0500, David Lechner wrote:  
> > > > > On 08/01/2017 10:45 AM, Andy Shevchenko wrote:  
> > > > > >       
> > > > > > > > > +	/* Use hard coded value for reference voltage
> > > > > > > > > in
> > > > > > > > > ACPI
> > > > > > > > > case */
> > > > > > > > > +	if (ACPI_COMPANION(&spi->dev))
> > > > > > > > > +		st->vref_mv =
> > > > > > > > > TI_ADS7950_VA_MV_ACPI_DEFAULT;  
> > > > > > > > 
> > > > > > > > Instead of checking or ACPI, you could just say "if we
> > > > > > > > have
> > > > > > > > a
> > > > > > > > dummy
> > > > > > > > regulator, then use the default value".  
> > > > > > 
> > > > > >   
> > > > > > > Agreed. Sounds sensible to me.  Hopefully in DT people
> > > > > > > will
> > > > > > > provide the right regulator, but chances are this won't
> > > > > > > always happen.  
> > > > > > 
> > > > > > There is no call like
> > > > > > regulator_is_dummy()
> > > > > > (and, looking into the code of regulator framework, can't
> > > > > > be)
> > > > > > 
> > > > > > Can you elaborate a bit, maybe I'm missing something
> > > > > > obvious?
> > > > > >   
> > > > > 
> > > > > I haven't tested this, but shouldn't regulator_get_voltage()
> > > > > return
> > > > > an
> > > > > error for a dummy regulator? You could use this as your
> > > > > test.  
> > > > 
> > > > While it would work it's very fragile.
> 
> Hmm. The optional get is what we have always used when a regulator
> has been added to a drivers bindings after the initial merge.
> In that case there is little choice (particularly as the one
> added is often the power supply regulator rather than anything
> related to scale.
> 
> If you want to do the scale thing, then you want to not expose
> the attribute at all if the scale isn't available.  So do
> it by swapping the iio_chan_spec array for one without the
> scale bit set for the relevant channels.
> 
> So if we want to support as described (using the default)
> then the optional regulator get is the only way to go that
> I can think of...
> 
> To a degree, as it was originally in the bindings for this one
> tough luck if it's not specified.  Someone didn't implement
> the dt properly...   So I wouldn't do the fall back at all.

...and what is the conclusion to the patch itself? I didn't see any
other way is to check ACPI_HANDLE() for ACPI case and leave the rest as
is.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
