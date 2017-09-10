Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbdIJNkV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Sep 2017 09:40:21 -0400
Date: Sun, 10 Sep 2017 14:40:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Phil Elwell <phil@raspberrypi.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Manfred Schlaegl <manfred.schlaegl@gmx.at>,
        Michael Welling <mwelling@ieee.org>,
        Soeren Andersen <san@rosetechnology.dk>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: adc: mcp320x: Add support for mcp3550/1/3
Message-ID: <20170910144022.5a608d94@archlinux>
In-Reply-To: <20170907064450.GA15733@wunner.de>
References: <cover.1503407738.git.lukas@wunner.de>
        <52441ded22e8c9ca84792576e72ca310f01416eb.1503407738.git.lukas@wunner.de>
        <20170903152226.150cdcc8@archlinux>
        <20170907064450.GA15733@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 7 Sep 2017 08:44:50 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Sun, Sep 03, 2017 at 03:22:39PM +0100, Jonathan Cameron wrote:
> > On Tue, 22 Aug 2017 15:33:00 +0200 Lukas Wunner <lukas@wunner.de> wrote:  
> > > After power-on reset, the chip sometimes fails to perform conversions
> > > and clocks out "all ones".  For some reason it can be unwedged by
> > > carrying out two consecutive conversions, without any delay between them.  
> > 
> > Put this description inline in the driver.
> >   
> > > If there is a delay the chip stays wedged.  I tried various other things
> > > to no avail, such as extending the conversion time, extending the CS
> > > assertion time to start a conversion or clocking out a few bytes.
> > > This may be an undocumented bug in the chip's internal state machine,
> > > possibly caused by the SPI pins' state on boot of the bcm2837.
> > > The driver unconditionally performs these two conversions on ->probe to
> > > ascertain all subsequent conversions succeed.  On platforms that support
> > > system sleep, it may be necessary to repeat this procedure upon resume.  
> [snip]
> > > +		/* perform two consecutive conversions to unwedge device */
> > > +		mcp320x_adc_conversion(adc, 0, 1, device_index, &val);
> > > +		mcp320x_adc_conversion(adc, 0, 1, device_index, &val);  
> > 
> > That needs more explanation.  Why would the device need unwedging?  
> 
> The pin controller on the BCM2835 (Raspberry Pi) by default initializes
> all GPIOs to direction "input" with pull down.  Thus, when the machine
> boots, the CS pin is either floating or low until the SPI master is
> initialized, which happens several seconds after power-on.  (I recall
> seeing on the oscilloscope that CS was initially low and then jumped
> to high on SPI master initialization, so the pin is probably not floating
> but low on boot.)
> 
> Per the spec, if CS is asserted for prolonged time the chip enters
> continuous conversion mode.  If CS is then driven high, the chip goes
> into shutdown (Fig 5-3, page 22 of the datasheet).
> 
> If CS is subsequently driven low again, the chip should wake up and
> start a conversion, but sometimes it doesn't and clocks out 0xffffff.
> Thus, about 50% of the time the chip would not work after boot.
> To me this looks like a bug in the chip's internal state machine.
> 
> By accident I've found that performing two conversions without any
> delay between them causes the chip to work again.
> 
> It's possible to change the initial pin controller configuration
> of the BCM2835 by supplying a dt-blob.bin which is consumed by the
> firmware.  If I set the initial configuration of the CS pin to output /
> active-low, the chip *always* works on boot.  However it seems fragile
> to depend on proper pin configuration, hence I've decided to always
> reset the chip on ->probe using the two conversion magic sequence.

It is certainly preferable to not have to rely on correct initialization
but there are numerous cases where it is true with other hardware.

Good to put a workaround in place if one is known though - like here!
> 
> I will expand the comment as requested.

Great, will be good to not lose the hard work you've done to come
up with a workaround!

> 
> These pin issues suggest that switching back and forth between single
> conversion and continuous conversion may not work as expected.  The chip
> is hairy and I'm glad that I have it working reliably now in single
> conversion mode.  The boards I have here aren't designed to run it in
> continuous conversion mode, so I can't really test that.  I've moved
> support for it to a separate commit and will mark it informational when
> posting, that commit is not intended for merging but merely to get others
> started who have a suitable board.
> 
> 
> > > @@ -398,6 +517,10 @@ static const struct spi_device_id mcp320x_id[] = {
> > >  	{ "mcp3204", mcp3204 },
> > >  	{ "mcp3208", mcp3208 },
> > >  	{ "mcp3301", mcp3301 },
> > > +	{ "mcp3550-50", mcp3550_50 },
> > > +	{ "mcp3550-60", mcp3550_60 },  
> > 
> > From a kernel point of view do we care if they have 50Hz or 60Hz rejection?
> > i.e. do we want to represent the two models, or are we better off with
> > just mcp3350?  
> 
> The 50 Hz and 60 Hz versions have different conversion times, hence the
> distinction.
> 
> Thanks a lot for the review,
> 
> Lukas

