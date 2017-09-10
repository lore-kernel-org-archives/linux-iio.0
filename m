Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbdIJNgF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Sep 2017 09:36:05 -0400
Date: Sun, 10 Sep 2017 14:36:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Adriana Reus <adi.reus@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        Rob Herring <robh@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Manfred Schlaegl <manfred.schlaegl@gmx.at>,
        Michael Welling <mwelling@ieee.org>,
        Soeren Andersen <san@rosetechnology.dk>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Abhisit Sangjan <s.abhisit@gmail.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: iio: adc: mcp320x: Update for
 mcp3550/1/3
Message-ID: <20170910143604.3431d17c@archlinux>
In-Reply-To: <20170904172221.47si6swykixnb5of@sirena.org.uk>
References: <cover.1503407738.git.lukas@wunner.de>
        <87644503b0397248c06fbe0058f292955dd10f79.1503407738.git.lukas@wunner.de>
        <20170825195941.iylf4w5hitjwniio@rob-hp-laptop>
        <20170827153405.GA13399@wunner.de>
        <CABjU8GvCB61envBiR0ei3gHEPadd5VDZ7FGysDjhCrJcQrEXDg@mail.gmail.com>
        <20170903143429.749be480@archlinux>
        <20170904172221.47si6swykixnb5of@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 4 Sep 2017 18:22:21 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Sun, Sep 03, 2017 at 02:37:49PM +0100, Jonathan Cameron wrote:
> 
> > +cc Mark Brown and linux-spi to address question about how to represent
> > a hardwired chip select.  See below for why I think that is what we should
> > be representing rather than the fact it puts it in 'continuous mode'.  
> 
> There's a good chance that if you just send me mail with a not obviously
> related subject line it might get discarded unread, people CC me on lots
> of things that are of questionable relevance.
> 
> > > >> > +   - microchip,continuous-conversion (boolean):
> > > >> > +                   Only applicable to MCP3550/1/3:  These ADCs have long
> > > >> > +                   conversion times and therefore support "continuous
> > > >> > +                   conversion mode" to allow retrieval of conversions
> > > >> > +                   at any time without observing a delay.  The mode is
> > > >> > +                   enabled by permanently driving CS low, e.g. by wiring
> > > >> > +                   it to ground.    
> 
> > hmm.  This is odd.  We probably need to make the SPI subsystem aware of this.
> > It is possible to ask for exclusive use of an SPI bus and I think we should
> > be doing this here.  It may be wired low on your board, but it may be wired to  
> 
> This sounds like SPI_NO_CS, though it's vanishingly rare for it to be
> implemented as there's a lot of ways for it to go wrong electrically -
> it's a lot simpler to just have a chip select and minimise the number of
> times it gets asserted.

Thanks Mark.  It sounds like we don't actually need it for the driver under
consideration on the particular platform it is being used on.  If it comes
up later, then adding bindings for SPI_NO_CS and adding relevant support
in the driver looks the way to go to me.

Jonathan


