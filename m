Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbeIVPFB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Sep 2018 11:05:01 -0400
Date: Sat, 22 Sep 2018 10:12:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU
 usage
Message-ID: <20180922101204.07ce82d5@archlinux>
In-Reply-To: <7a70711c-5d38-5ba6-ec90-b2506dc0727d@lechnology.com>
References: <20180918170850.2749-1-david@lechnology.com>
        <20180918170850.2749-4-david@lechnology.com>
        <7a70711c-5d38-5ba6-ec90-b2506dc0727d@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 18 Sep 2018 12:14:50 -0500
David Lechner <david@lechnology.com> wrote:

> On 09/18/2018 12:08 PM, David Lechner wrote:
> > This changes how the SPI message for the triggered buffer is setup in
> > the TI ADS7950 A/DC driver. By using the SPI_CS_WORD flag, we can read
> > multiple samples in a single SPI transfer. If the SPI controller
> > supports DMA transfers, we can see a significant reduction in CPU usage.
> > 
> > For example, on an ARM9 system running at 456MHz reading just 4 channels
> > at 100Hz: before this change, top shows the CPU usage of the IRQ thread
> > of this driver to be ~7.7%. After this change, the CPU usage drops to
> > ~3.8%.
> > 
> > The use of big-endian for the raw data was cargo culted from another
> > driver when this driver was originally written. It used an SPI word size
> > of 8 bits and big-endian byte ordering to effectively emulate 16 bit
> > words.
> > 
> > Now, in order to inject a CS toggle between each word, we need to use
> > the correct word size, otherwise we would get a CS toggle half way
> > through each word 16-bit. The SPI subsystem uses CPU byte ordering for
> > multi-byte words. So, the data we get back from the SPI is going to be
> > CPU endian now no matter what. Converting that to big endian will just
> > add overhead on little endian systems so we opt to change the raw data
> > format from big endian to CPU endian.
> > 
> > There is a small risk that this could break some lazy userspace programs
> > that use the raw data without checking the data format. We can address
> > this if/when it actually comes up.
> > 
> > Signed-off-by: David Lechner <david@lechnology.com>
> > ---  
> 
> And I just realized I forgot to pick up...
> 
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
I've applied this on top of the original series on the basis I doubt
anyone will be testing this particular driver in such a way as to hit the
changes you made in the last two patches + I don't think Mark has tagged
those for me to easily pick up.  If it's a problem I can apply them
to the IIO tree as well and git will sort it out come merge window time.
However, that's inelegant so I won't do it unless needed.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it

Thanks,

Jonathan
