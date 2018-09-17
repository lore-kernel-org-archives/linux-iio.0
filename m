Return-Path: <SRS0=2/42=L7=huawei.com=jonathan.cameron@kernel.org>
Date: Mon, 17 Sep 2018 09:33:25 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: David Lechner <david@lechnology.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"Mark Brown" <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] iio: adc: ti-ads7950: use SPI_CS_WORD to reduce
 CPU usage
Message-ID: <20180917093325.00006e24@huawei.com>
In-Reply-To: <b8b6201c-3574-d383-e3e8-9f162206e505@lechnology.com>
References: <20180913003920.30600-1-david@lechnology.com>
	<20180913003920.30600-4-david@lechnology.com>
	<20180916124110.4edfad9d@archlinux>
	<b8b6201c-3574-d383-e3e8-9f162206e505@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Sun, 16 Sep 2018 11:24:16 -0500
David Lechner <david@lechnology.com> wrote:

> On 09/16/2018 06:41 AM, Jonathan Cameron wrote:
> > On Wed, 12 Sep 2018 19:39:19 -0500
> > David Lechner <david@lechnology.com> wrote:
> >   
> >> This changes how the SPI message for the triggered buffer is setup in
> >> the TI ADS7950 A/DC driver. By using the SPI_CS_WORD flag, we can read
> >> multiple samples in a single SPI transfer. If the SPI controller
> >> supports DMA transfers, we can see a significant reduction in CPU usage.
> >>
> >> For example, on an ARM9 system running at 456MHz reading just 4 channels
> >> at 100Hz: before this change, top shows the CPU usage of the IRQ thread
> >> of this driver to be ~7.7%. After this change, the CPU usage drops to
> >> ~3.8%.
> >>
> >> Signed-off-by: David Lechner <david@lechnology.com>  
> > 
> > Hi David,
> > 
> > I've managed to forget why we are changing any of the endian related code
> > at all.  The change SPI_CS_WORD result in changes between words which is
> > fine but it doesn't change any ordering within words?  So as such why
> > do we no longer need to do the big endian conversions?
> >   
> 
> The big-endian stuff was cargo culted from another driver when this driver
> was originally written. It used an SPI word size of 8 bits and big-endian
> byte ordering to effectively emulate 16 bit words.
> 
> Now, in order to inject a CS toggle between each word, we need to use the
> correct word size, otherwise we would get a CS toggle half way through
> each word 16-bit. The SPI subsystem uses CPU byte ordering for multi-byte
> words. So, the data we get back from the SPI is going to be CPU endian now
> no matter what. Converting that to big endian will just add overhead on
> little endian systems.

Cool. Thanks for the explanation.  If you are rerolling put that in the
patch description.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm kind of assuming Mark will want to take this through the SPI tree
if he is happy with it.

Mark, shout if you want to do it another way.

Thanks,

Jonathan
