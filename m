Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbdJZPf6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 11:35:58 -0400
Date: Thu, 26 Oct 2017 16:35:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: dac: Add Texas Instruments 8/10/12-bit
 2/4-channel DAC driver
Message-ID: <20171026163548.0e59fa6c@archlinux>
In-Reply-To: <20171022094854.GA30715@wunner.de>
References: <cover.1508232186.git.lukas@wunner.de>
        <a3d85aed78a808d170dc4d52253532a49ae02d22.1508232186.git.lukas@wunner.de>
        <20171021203308.15ad9c1a@archlinux>
        <20171022094854.GA30715@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 22 Oct 2017 11:48:54 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Sat, Oct 21, 2017 at 08:33:08PM +0100, Jonathan Cameron wrote:
> > On Tue, 17 Oct 2017 12:42:00 +0200 Lukas Wunner <lukas@wunner.de> wrote:  
> > > +struct ti_dac_chip {
> > > +	struct mutex lock;
> > > +	struct regulator *vref;
> > > +	struct spi_message mesg;
> > > +	struct spi_transfer xfer;
> > > +	u8 buf[2] ____cacheline_aligned;  
> > 
> > I missed this the first time.  The whole point of the fun
> > of ____cacheline_aligned is to ensure nothing shares a
> > cacheline with the buffer used for DMA.  We take care
> > when allocating these private structures that this
> > will be true, but it relies on nothing that might be
> > changed during dma being after the buffer.
> > 
> > Simple reordering fix so I'll do it whilst applying.  
> 
> TBH I was a bit confused about how to achieve proper cacheline
> alignment.  My limited understanding of the slab allocator is
> that it neither guarantees that an allocation begins on a cacheline
> nor that no another allocation immediately starts after it.
> 
> However taking a closer look at iio_device_alloc() I realize now
> that it implicitly takes care of both by inserting the necessary
> padding.  Neat.  I was already wondering why the IIO subsystem
> takes this somewhat unusual approach to allocate the private struct
> behind struct iio_dev, instead of letting the driver embed it
> within its private struct and use container_of() to yield the
> private struct corresponding to a struct iio_dev, as most other
> subsystems do.  But that explains it.
Kind of - if we didn't play that game, the drivers could do it
themselves in their private structures.

Back when we got started with IIO it was actually a pretty
even split in kernel subsystems between those who did the embedding
one way around and those that went the other way around - there
are advantages to both approaches but it doesn't really matter.
Honestly an early reviewer (can't remember who) said do it this
way (before that we were separately allocating both) and I never
thought about it at the time ;)

I now wonder if we made the right choice sometimes - particularly
as it makes drivers embedding both IIO and other interfaces a bit
messy.  I always planned to put in the various
initializers to handle the embedding in the private structure case
correctly, but haven't gotten around to it yet :) Should be easy
enough to do I think...  From a review point of view though it
is nice to keep all drivers looking roughly the same so perhaps
introducing another option would be a bad idea...

Malloc calls are always guaranteed to be cacheline aligned (though
largely through implementation than I think an explicit rule - though
they are guaranteed to be safe for DMA as long as the whole memory
space is accessible for DMA - so this enforces cacheline alignment
rather indirectly).

A lot of drivers rely on this for dma buffers though so it won't
change without a 'lot' of work.  Much nicer than in userspace
where you have to go through the dance of alloc_aligned to
guarantee anything at all...

Jonathan
> 
> Thanks,
> 
> Lukas

