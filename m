Return-Path: <SRS0=gmc3=YS=gmail.com=eraretuya@kernel.org>
Date: Wed, 4 Jan 2017 18:09:56 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, daniel.baluta@gmail.com,
	amsfield22@gmail.com
Subject: Re: [PATCH v3 2/2] staging: iio: ad7606: move out of staging
Message-ID: <20170104100952.GB3284@Socrates-UM>
References: <cover.1481424136.git.eraretuya@gmail.com>
 <406fd6f60db88f051b36bf6f28cfe8fc8b1acb32.1481424136.git.eraretuya@gmail.com>
 <9b5ec6ff-ed6b-f8a5-ea7f-967c00571268@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9b5ec6ff-ed6b-f8a5-ea7f-967c00571268@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Dec 30, 2016 at 08:16:02PM +0000, Jonathan Cameron wrote:
> On 11/12/16 02:47, Eva Rachel Retuya wrote:
> > Move the ad7606 driver from staging/iio/adc to iio/adc. Also, update the
> > corresponding Makefile and Kconfig associated with the change.
> > 
> > Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> Personally (and this is much debated ;) I prefer for the odd case
> of staging graduations, that git isn't run with the -M parameter so we
> have the whole driver to comment on.
> 
> Anyhow, just casting my eyes over the code so here are some notes:
> 1. The whole computing scale available values on the fly seems rather over the
> top as they can be easily precomputed and stored in a static const array.
> There are only 2 of them!
> 

OK, will submit another version with this in mind. Also, will drop this
patch since Lars said he prefers to not "graduate" this driver yet until the
hardwire issues are resolved.

Thanks for the notes, will consider submitting a patchset addressing
these after I'm done with my IIO project.

Eva

> 2. There are some single line comments still using multiline syntax (now
> I'm really nitpicking ;)
> 
> 3. A slight oddity has crept in with the cleanup of attributes.  We now
> prevent the appearance of the _scale_available / oversampling_ratio_available
> attributes if the gpios are attached, but not _scale or _oversampling.
> (oops).  If we are going to do this dance, then we should also have an
> alternative set of iio_chan_spec array to reflect this.
> 
> 4. I'd drop the 'More devices added in future' comment. It's now the future
> and they haven't been yet ;)
> 
> 5. We can write oversampling ratio, but queries to the write_get_fmt will
> return an error for that. Probably want to fix that unless I'm missing something.
> 
> 6. There are some ancient references to 'ring' buffers in the comments and
> function naming.  We switched over from my hand rolled ring buffer to the
> kfifo buffer we now use ages ago.  Would be nice to clear those out.
> 
> None of these are really blockers to it moving out of staging
> (except the bugs we introduced in the cleanup), but might be nice
> to do one last series pinning those down then get a final review done to
> see if we missed anything else.
> 
> Been a long time since I looked at this one in any depth and it's certainly
> heading in the right direction!
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/Kconfig                    | 34 ++++++++++++++++++++++++++++++
> >  drivers/iio/adc/Makefile                   |  3 +++
> >  drivers/{staging => }/iio/adc/ad7606.c     |  0
> >  drivers/{staging => }/iio/adc/ad7606.h     |  0
> >  drivers/{staging => }/iio/adc/ad7606_par.c |  0
> >  drivers/{staging => }/iio/adc/ad7606_spi.c |  0
> >  drivers/staging/iio/adc/Kconfig            | 34 ------------------------------
> >  drivers/staging/iio/adc/Makefile           |  4 ----
> >  8 files changed, 37 insertions(+), 38 deletions(-)
> >  rename drivers/{staging => }/iio/adc/ad7606.c (100%)
> >  rename drivers/{staging => }/iio/adc/ad7606.h (100%)
> >  rename drivers/{staging => }/iio/adc/ad7606_par.c (100%)
> >  rename drivers/{staging => }/iio/adc/ad7606_spi.c (100%)
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index be81ba3..3fa2c60 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -58,6 +58,40 @@ config AD7476
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called ad7476.
> >  
> > +config AD7606
> > +	tristate "Analog Devices AD7606 ADC driver"
> > +	depends on GPIOLIB || COMPILE_TEST
> > +	depends on HAS_IOMEM
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	help
> > +	  Say yes here to build support for Analog Devices:
> > +	  ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ad7606.
> > +
> > +config AD7606_IFACE_PARALLEL
> > +	tristate "parallel interface support"
> > +	depends on AD7606
> > +	help
> > +	  Say yes here to include parallel interface support on the AD7606
> > +	  ADC driver.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ad7606_parallel.
> > +
> > +config AD7606_IFACE_SPI
> > +	tristate "spi interface support"
> > +	depends on AD7606
> > +	depends on SPI
> > +	help
> > +	  Say yes here to include parallel interface support on the AD7606
> > +	  ADC driver.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ad7606_spi.
> > +
> >  config AD7766
> >  	tristate "Analog Devices AD7766/AD7767 ADC driver"
> >  	depends on SPI_MASTER
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index f8e1218..dfe7dea 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -9,6 +9,9 @@ obj-$(CONFIG_AD7291) += ad7291.o
> >  obj-$(CONFIG_AD7298) += ad7298.o
> >  obj-$(CONFIG_AD7923) += ad7923.o
> >  obj-$(CONFIG_AD7476) += ad7476.o
> > +obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
> > +obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
> > +obj-$(CONFIG_AD7606) += ad7606.o
> >  obj-$(CONFIG_AD7766) += ad7766.o
> >  obj-$(CONFIG_AD7791) += ad7791.o
> >  obj-$(CONFIG_AD7793) += ad7793.o
> > diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > similarity index 100%
> > rename from drivers/staging/iio/adc/ad7606.c
> > rename to drivers/iio/adc/ad7606.c
> > diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> > similarity index 100%
> > rename from drivers/staging/iio/adc/ad7606.h
> > rename to drivers/iio/adc/ad7606.h
> > diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> > similarity index 100%
> > rename from drivers/staging/iio/adc/ad7606_par.c
> > rename to drivers/iio/adc/ad7606_par.c
> > diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> > similarity index 100%
> > rename from drivers/staging/iio/adc/ad7606_spi.c
> > rename to drivers/iio/adc/ad7606_spi.c
> > diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> > index deff899..995867b 100644
> > --- a/drivers/staging/iio/adc/Kconfig
> > +++ b/drivers/staging/iio/adc/Kconfig
> > @@ -3,40 +3,6 @@
> >  #
> >  menu "Analog to digital converters"
> >  
> > -config AD7606
> > -	tristate "Analog Devices AD7606 ADC driver"
> > -	depends on GPIOLIB || COMPILE_TEST
> > -	depends on HAS_IOMEM
> > -	select IIO_BUFFER
> > -	select IIO_TRIGGERED_BUFFER
> > -	help
> > -	  Say yes here to build support for Analog Devices:
> > -	  ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
> > -
> > -	  To compile this driver as a module, choose M here: the
> > -	  module will be called ad7606.
> > -
> > -config AD7606_IFACE_PARALLEL
> > -	tristate "parallel interface support"
> > -	depends on AD7606
> > -	help
> > -	  Say yes here to include parallel interface support on the AD7606
> > -	  ADC driver.
> > -
> > -	  To compile this driver as a module, choose M here: the
> > -	  module will be called ad7606_parallel.
> > -
> > -config AD7606_IFACE_SPI
> > -	tristate "spi interface support"
> > -	depends on AD7606
> > -	depends on SPI
> > -	help
> > -	  Say yes here to include parallel interface support on the AD7606
> > -	  ADC driver.
> > -
> > -	  To compile this driver as a module, choose M here: the
> > -	  module will be called ad7606_spi.
> > -
> >  config AD7780
> >  	tristate "Analog Devices AD7780 and similar ADCs driver"
> >  	depends on SPI
> > diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> > index ac09485..549032b 100644
> > --- a/drivers/staging/iio/adc/Makefile
> > +++ b/drivers/staging/iio/adc/Makefile
> > @@ -2,10 +2,6 @@
> >  # Makefile for industrial I/O ADC drivers
> >  #
> >  
> > -obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
> > -obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
> > -obj-$(CONFIG_AD7606) += ad7606.o
> > -
> >  obj-$(CONFIG_AD7780) += ad7780.o
> >  obj-$(CONFIG_AD7816) += ad7816.o
> >  obj-$(CONFIG_AD7192) += ad7192.o
> > 
> 
