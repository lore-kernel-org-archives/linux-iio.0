Return-Path: <SRS0=PNad=7D=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1501608271.29303.342.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads7950: Allow to use on ACPI
 platforms
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <david@lechnology.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org
Date: Tue, 01 Aug 2017 20:24:31 +0300
In-Reply-To: <75c912ec-da05-1473-ef42-777386a54ffc@lechnology.com>
References: <20170728222015.43574-1-andriy.shevchenko@linux.intel.com>
	 <20170728222015.43574-2-andriy.shevchenko@linux.intel.com>
	 <9d74cad7-be8e-9893-58bd-9fdd50298723@lechnology.com>
	 <20170730143158.3b907e8f@kernel.org>
	 <1501602326.29303.332.camel@linux.intel.com>
	 <51d5783f-4a7d-b51e-fd45-e4d84576f1c3@lechnology.com>
	 <1501605706.29303.339.camel@linux.intel.com>
	 <75c912ec-da05-1473-ef42-777386a54ffc@lechnology.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Tue, 2017-08-01 at 12:15 -0500, David Lechner wrote:
> On 08/01/2017 11:41 AM, Andy Shevchenko wrote:
> > On Tue, 2017-08-01 at 11:21 -0500, David Lechner wrote:
> > > On 08/01/2017 10:45 AM, Andy Shevchenko wrote:
> > > >     
> > > > > > > +	/* Use hard coded value for reference voltage in
> > > > > > > ACPI
> > > > > > > case */
> > > > > > > +	if (ACPI_COMPANION(&spi->dev))
> > > > > > > +		st->vref_mv =
> > > > > > > TI_ADS7950_VA_MV_ACPI_DEFAULT;
> > > > > > 
> > > > > > Instead of checking or ACPI, you could just say "if we have
> > > > > > a
> > > > > > dummy
> > > > > > regulator, then use the default value".
> > > > 
> > > > 
> > > > > Agreed. Sounds sensible to me.  Hopefully in DT people will
> > > > > provide the right regulator, but chances are this won't
> > > > > always happen.
> > > > 
> > > > There is no call like
> > > > regulator_is_dummy()
> > > > (and, looking into the code of regulator framework, can't be)
> > > > 
> > > > Can you elaborate a bit, maybe I'm missing something obvious?
> > > > 
> > > 
> > > I haven't tested this, but shouldn't regulator_get_voltage()
> > > return
> > > an
> > > error for a dummy regulator? You could use this as your test.
> > 
> > While it would work it's very fragile.
> > 
> > _regulator_get_voltage() will return error code even for normal
> > regulators if something happened there. And user gets an impression
> > that
> > everything is okay while it's not.
> > 
> > So, I wouldn't go this way.
> 

> In drivers/iio/adc/max11100.c:91. The solution was to only support
> raw 
> value and not scaled if there is a dummy regulator.

The comment there is just partially correct. While get_voltage() indeed
returns -EINVAL for dummy it might return same or other error code for
non-dummy regulator.

So, by the fact the code there should be done like in the rest (the
below is mangled, can't be used directly as a patch):

--- a/drivers/iio/adc/max11100.c
+++ b/drivers/iio/adc/max11100.c
@@ -88,8 +88,7 @@ static int max11100_read_raw(struct iio_dev
*indio_dev,
        case IIO_CHAN_INFO_SCALE:
                vref_uv = regulator_get_voltage(state->vref_reg);
                if (vref_uv < 0)
-                       /* dummy regulator "get_voltage" returns -EINVAL
*/
-                       return -EINVAL;
+                       return vref_uv;

                *val =  vref_uv / 1000;
                *val2 = MAX11100_LSB_DIV;


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
