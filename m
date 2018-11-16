Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbeKQEut (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Nov 2018 23:50:49 -0500
Date: Fri, 16 Nov 2018 18:37:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com,
        Victor Colombo <victorcolombo@gmail.com>, broonie@kernel.org
Subject: Re: [PATCH 2/6] staging:iio:ad2s90: Remove spi setup that should be
 done via dt
Message-ID: <20181116183711.5ac7f200@archlinux>
In-Reply-To: <CAHd-oW5ax5uj=xtpOD3HYHT+TM8eAZ6kJ91mHpFVf+VFX6NoeQ@mail.gmail.com>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
        <20181109220044.24843-3-matheus.bernardino@usp.br>
        <20181111114224.1d8cfaec@archlinux>
        <CAHd-oW5ax5uj=xtpOD3HYHT+TM8eAZ6kJ91mHpFVf+VFX6NoeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 15 Nov 2018 12:44:39 -0200
Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:

> On Sun, Nov 11, 2018 at 9:42 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri,  9 Nov 2018 20:00:40 -0200
> > Matheus Tavares <matheus.bernardino@usp.br> wrote:
> >  
> > > The ad2s90 driver currently sets some spi settings (max_speed_hz and
> > > mode) at ad2s90_probe. This should, instead, be handled via device tree.
> > > This patch removes these configurations from the probe function.
> > >
> > > Note: The way in which the mentioned spi settings need to be specified
> > > on the ad2s90's node of a device tree will be documented in the future
> > > patch "dt-bindings:iio:resolver: Add docs for ad2s90".
> > >
> > > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>  
> > I'd actually like to get Rob and Mark's views on this one.  Previously
> > I would just have applied it without thinking on the basis these can
> > be easily specified from devicetree.
> >
> > Recent discussions with Rob have suggested that the settings in devicetree
> > should perhaps be concerned with specifying constraints about the device
> > that are not visible to the driver.  The driver itself should apply
> > the device constraints, but there are others such as wiring that
> > might reduce the maximum frequency for example...
> >
> > So should a driver be clamping an over specified value from DT for
> > example?  Or given that is optional in DT, should it be making sure
> > that a controller max frequency isn't too high for the sensor?
> >  
> 
> First of all, thanks for the review and comments.
> 
> By what you've said here and in the reviews for patches 3 and 4 of
> this patch-set, it seems to me that the most reasonable thing would be
> to keep the SPI mode 3 settings at the driver but the max frequency
> setting at DT and check if it exceeds the maximum at the driver (as
> patch 3 does). This makes sense to me, based on what you've said,
> because mode 3 is a device constraint visible to the driver (as it
> won't change) but max frequency is not (because of things such as
> wiring, as you said).
> 
> What do you think, Jonathan, Rob, and Mark?
Sounds good to me. I just checked the DT bindings for spi-bus
and max-frequency is indeed a required binding element for slave
devices, hence has to be there.  Best to confirm it is sane in
the driver however as you suggest.  I think we'll standardise
on that bit of paranoia in IIO unless Rob or Mark shouts otherwise.

Jonathan

> 
> Matheus
> 
> > It seems to be unusual to do this, but to my mind it would make
> > sense and might be worth pushing out into more drivers.
> >
> > Jonathan  
> > > ---
> > >  drivers/staging/iio/resolver/ad2s90.c | 11 -----------
> > >  1 file changed, 11 deletions(-)
> > >
> > > diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> > > index ff32ca76ca00..95c118c48400 100644
> > > --- a/drivers/staging/iio/resolver/ad2s90.c
> > > +++ b/drivers/staging/iio/resolver/ad2s90.c
> > > @@ -77,7 +77,6 @@ static int ad2s90_probe(struct spi_device *spi)
> > >  {
> > >       struct iio_dev *indio_dev;
> > >       struct ad2s90_state *st;
> > > -     int ret;
> > >
> > >       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > >       if (!indio_dev)
> > > @@ -94,16 +93,6 @@ static int ad2s90_probe(struct spi_device *spi)
> > >       indio_dev->num_channels = 1;
> > >       indio_dev->name = spi_get_device_id(spi)->name;
> > >
> > > -     /* need 600ns between CS and the first falling edge of SCLK */
> > > -     spi->max_speed_hz = 830000;
> > > -     spi->mode = SPI_MODE_3;
> > > -     ret = spi_setup(spi);
> > > -
> > > -     if (ret < 0) {
> > > -             dev_err(&spi->dev, "spi_setup failed!\n");
> > > -             return ret;
> > > -     }
> > > -
> > >       return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> > >  }
> > >  
> >  
