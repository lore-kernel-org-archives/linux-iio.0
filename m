Return-Path: <SRS0=h1n5=Y4=poczta.fm=sst@kernel.org>
Date: Sat, 14 Jan 2017 12:42:18 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, cristina.moraru09@gmail.com,
	matthew.weber@rockwellcollins.com,
	maury.anderson@rockwellcollins.com,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] iio: max5481: Add support for Maxim digital
 potentiometers
Message-ID: <20170114114218.GA17907@x220.localdomain>
References: <20170108185733.GA8511@x220.localdomain>
 <ee973aa1-c881-6bc8-c61a-9f36b8598f5f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ee973aa1-c881-6bc8-c61a-9f36b8598f5f@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Jan 14, 2017 10:38, Jonathan Cameron wrote:
> As this has device tree bindings it should have gone to linux-devicetree,
> Rob and Mark (maintainers of bindings).

I will add them to CC on the new version.

> Spi buffers for spi_write need to be cacheline aligned.  See below
> for roughly why.

I can recall that from my previous submissions... I made the same mistake.
Thank you once again for explaining that. I hope this will imprint in my mind
from now on.

Thank you!

> Jonathan
> > ---
> > +static int max5481_write_cmd(struct spi_device *spi, u8 cmd, u16 val)
> > +{
> > +	/* SPI Format from MAX5481-MAX5484 (19-3708; Rev 5; 4/10) pg 15 */
> > +	u8 msg[3];
> It's clearly one of those days - same issue in two drivers in a row. :(
> Still I can refine me response ;)
> 
> There are requirements for buffers passed directly to spi_read / spi_write.
> They get passed to spi_sync which calls into the spi master drivers.
> SPI master drivers are explicitly allowed to directly use this buffer
> in dma. On most modern platforms it is fine to do DMA from any location...
> 
> However, cacheline corruption comes in here. There is no guarantee that
> the SPI controller won't write back to this address, as it it will be
> bypassing the processor whilst doing this, that can result in a difference
> in other parts of the cacheline between what is in the cache and what is
> in main memory.  At the end of the dma transfer any changes elsewhere in
> the cacheline can be wiped out as result. (or something like that ;)
> 
> Anyhow, two solutions.  Either allocate the memory in it's own cacheline
> which will naturally happen if you allocate on the heap using kmalloc
> or use the fact we carefully align the iio_priv memory to be cacheline
> aligned. This means that if you stick a __cacheline_aligned buffer at the
> end of your iio_priv structure it was also be in it's own cacheline.
> 
> Not doing this is the source of really hard to track down bugs!
> > +
> > +	msg[0] = cmd;
> > +
> > +	switch (cmd) {
> > +	case MAX5481_WRITE_WIPER:
> > +		msg[1] = val >> 2;
> > +		msg[2] = (val & 0x3) << 6;
> > +		return spi_write(spi, msg, ARRAY_SIZE(msg));
> > +
> > +	case MAX5481_COPY_AB_TO_NV:
> > +	case MAX5481_COPY_NV_TO_AB:
> > +		return spi_write(spi, msg, sizeof(u8));
> > +
> > +	default:
> > +		return -EIO;
> > +	}
> > +}

-- 
Slawomir Stepien
