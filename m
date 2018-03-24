Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752659AbeCXRrl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 13:47:41 -0400
Date: Sat, 24 Mar 2018 17:47:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 0/3] iio: add unit converter
Message-ID: <20180324174734.1ac1706f@archlinux>
In-Reply-To: <CACRpkdYPayHqYdFMmts20yLRdMEy6SW-qqnC+BsYip-RdN2HSQ@mail.gmail.com>
References: <20180319170246.26830-1-peda@axentia.se>
        <20180323141401.000031cc@huawei.com>
        <0863dfa7-c1da-7691-a896-9b414e2fddfa@axentia.se>
        <20180324134801.0e6254ee@archlinux>
        <CACRpkdYPayHqYdFMmts20yLRdMEy6SW-qqnC+BsYip-RdN2HSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 24 Mar 2018 17:34:17 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sat, Mar 24, 2018 at 2:48 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Fri, 23 Mar 2018 14:59:41 +0100
> > Peter Rosin <peda@axentia.se> wrote:  
> 
> >> So, not super-happy about that either. And maybe leave the mux
> >> where it is? It's just that I have the feeling that the iio-mux
> >> is never going to get any friends in its category, and the mux
> >> and the unit-converter are kind of related in that they operate
> >> on other channels. But maybe that's only logical it you know how
> >> they are implemented...  
> >
> > Perhaps Analog Front ends?
> > We could move the amplifier driver into the same directory as well,
> > though right now that driver is not passing the channels through
> > (it's often used without there being an IIO ADC behind it I think...)  
> 
> (passive) linear scaler?
> analog linear scaler?
> But maybe these supersets are not broad enough.
> 
> Or just invent another acronym akin to "PHY" such as
> "AIF" (analog interface)?
AFE (analog front end) is commonly used, but I'm not sure if implies
more than we want here.  Lars, Michael this is more your area than
mine - what do you think?

We could call it an amplifier and be done with it but that wouldn't
really encompass the fact we are also changing it's apparent measurement
from voltage to current because we know enough about the circuit to do
so...

Jonathan




> 
> Yours,
> Linus Walleij

