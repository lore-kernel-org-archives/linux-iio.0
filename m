Return-Path: <SRS0=kG2y=N3=poczta.fm=sst@kernel.org>
Date: Fri, 16 Nov 2018 13:19:57 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: potentiometer mcp4131: use spi_get_device_id()
 only when needed
Message-ID: <20181116121957.GB10192@x220.localdomain>
References: <20181116094722.1070-1-sst@poczta.fm>
 <20181116094722.1070-3-sst@poczta.fm>
 <20181116115335.2d9fa9c5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181116115335.2d9fa9c5@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On lis 16, 2018 11:53, Jonathan Cameron wrote:
> On Fri, 16 Nov 2018 10:47:22 +0100
> Slawomir Stepien <sst@poczta.fm> wrote:
> 
> > There is no need to find the device id up front, since the
> > of_device_get_match_data() might return the correct data.
> > 
> Ah. That explains it.   This should just have been merged with the previous
> patch :)
> 
> Anyhow, I'll apply them both but merge them whilst doing so.

OK, that's fine for me.

> So applied as one patch to the togreg branch of iio.git and pushed out as
> testing for the autobuilders to play with it.
> 
> As things currently stand it's not worth going through and doing this for
> every driver as I don't think the other path is being removed any
> time soon.  It's a worthwhile change if people happen to be doing other
> work on a particular driver though!

OK.

Thank you for quick review.

-- 
Slawomir Stepien
