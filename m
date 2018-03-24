Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751930AbeCXNsH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 09:48:07 -0400
Date: Sat, 24 Mar 2018 13:48:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: add unit converter
Message-ID: <20180324134801.0e6254ee@archlinux>
In-Reply-To: <0863dfa7-c1da-7691-a896-9b414e2fddfa@axentia.se>
References: <20180319170246.26830-1-peda@axentia.se>
        <20180323141401.000031cc@huawei.com>
        <0863dfa7-c1da-7691-a896-9b414e2fddfa@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Mar 2018 14:59:41 +0100
Peter Rosin <peda@axentia.se> wrote:

> On 2018-03-23 14:14, Jonathan Cameron wrote:
> > On Mon, 19 Mar 2018 18:02:43 +0100
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> Hi!
> >>
> >> This moves the iio-mux driver to a new category, since I think
> >> it will be the single driver in that category forever, and now
> >> I'm adding a new driver that is somewhat similar in nature...
> >>
> >> But that rename is not very interesting, it's just reshuffling.
> >> It's the new driver that I need. Specifically, I need to allow
> >> linear scaling and modification of the type of an io-channel.
> >> I don't know exactly how that is accomplished in the best way,
> >> but this is what I came up with.
> >>
> >> The use cases are an ADC hooked up to measure a "big" voltage by
> >> looking at the midpoint of a voltage divider, and an ADC used
> >> to measure the current by looking at the voltage over a resistor.
> >>
> >> Comments?  
> > It is pretty much how I would have implemented it as well.
> > 
> > Will probably do a detailed review over the weekend.
> > Not convinced entirely on the 'wrapper' naming though.
> > Will think about it...  
> 
> Yeah, let's put 'Wrapper' in the crapper. Not married to it.
> 
> Miscellaneous?
> 
> So, not super-happy about that either. And maybe leave the mux
> where it is? It's just that I have the feeling that the iio-mux
> is never going to get any friends in its category, and the mux
> and the unit-converter are kind of related in that they operate
> on other channels. But maybe that's only logical it you know how
> they are implemented...
Perhaps Analog Front ends?
We could move the amplifier driver into the same directory as well,
though right now that driver is not passing the channels through
(it's often used without there being an IIO ADC behind it I think...)

Jonathan


> 
> Cheers,
> Peter
> 
> > 
> > Jonathan
> >   
> >>
> >> Cheers,
> >> Peter
> >>
> >> Peter Rosin (3):
> >>   iio: rename the multiplexer category to wrapper
> >>   dt-bindings: iio: wrapper: add io-channel-unit-converter
> >>   iio: wrapper: unit-converter: new driver
> >>
> >>  .../{multiplexer => wrapper}/io-channel-mux.txt    |   0
> >>  .../iio/wrapper/io-channel-unit-converter.txt      |  84 +++++++
> >>  MAINTAINERS                                        |  11 +-
> >>  drivers/iio/Kconfig                                |   2 +-
> >>  drivers/iio/Makefile                               |   2 +-
> >>  drivers/iio/multiplexer/Makefile                   |   6 -
> >>  drivers/iio/{multiplexer => wrapper}/Kconfig       |  13 +-
> >>  drivers/iio/wrapper/Makefile                       |   7 +
> >>  drivers/iio/{multiplexer => wrapper}/iio-mux.c     |   0
> >>  drivers/iio/wrapper/iio-unit-converter.c           | 268 +++++++++++++++++++++
> >>  10 files changed, 381 insertions(+), 12 deletions(-)
> >>  rename Documentation/devicetree/bindings/iio/{multiplexer => wrapper}/io-channel-mux.txt (100%)
> >>  create mode 100644 Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> >>  delete mode 100644 drivers/iio/multiplexer/Makefile
> >>  rename drivers/iio/{multiplexer => wrapper}/Kconfig (53%)
> >>  create mode 100644 drivers/iio/wrapper/Makefile
> >>  rename drivers/iio/{multiplexer => wrapper}/iio-mux.c (100%)
> >>  create mode 100644 drivers/iio/wrapper/iio-unit-converter.c
> >>  
> >   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

