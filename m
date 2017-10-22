Return-Path: <SRS0=T2fd=BV=h08.hostsharing.net=foo00@kernel.org>
Date: Sun, 22 Oct 2017 11:48:54 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mathias Duckeck <m.duckeck@kunbus.de>,
	Phil Elwell <phil@raspberrypi.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: dac: Add Texas Instruments 8/10/12-bit
 2/4-channel DAC driver
Message-ID: <20171022094854.GA30715@wunner.de>
References: <cover.1508232186.git.lukas@wunner.de>
 <a3d85aed78a808d170dc4d52253532a49ae02d22.1508232186.git.lukas@wunner.de>
 <20171021203308.15ad9c1a@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171021203308.15ad9c1a@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Oct 21, 2017 at 08:33:08PM +0100, Jonathan Cameron wrote:
> On Tue, 17 Oct 2017 12:42:00 +0200 Lukas Wunner <lukas@wunner.de> wrote:
> > +struct ti_dac_chip {
> > +	struct mutex lock;
> > +	struct regulator *vref;
> > +	struct spi_message mesg;
> > +	struct spi_transfer xfer;
> > +	u8 buf[2] ____cacheline_aligned;
> 
> I missed this the first time.  The whole point of the fun
> of ____cacheline_aligned is to ensure nothing shares a
> cacheline with the buffer used for DMA.  We take care
> when allocating these private structures that this
> will be true, but it relies on nothing that might be
> changed during dma being after the buffer.
> 
> Simple reordering fix so I'll do it whilst applying.

TBH I was a bit confused about how to achieve proper cacheline
alignment.  My limited understanding of the slab allocator is
that it neither guarantees that an allocation begins on a cacheline
nor that no another allocation immediately starts after it.

However taking a closer look at iio_device_alloc() I realize now
that it implicitly takes care of both by inserting the necessary
padding.  Neat.  I was already wondering why the IIO subsystem
takes this somewhat unusual approach to allocate the private struct
behind struct iio_dev, instead of letting the driver embed it
within its private struct and use container_of() to yield the
private struct corresponding to a struct iio_dev, as most other
subsystems do.  But that explains it.

Thanks,

Lukas
