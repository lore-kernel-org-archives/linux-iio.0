Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:27877 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753405AbeDKPfc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2018 11:35:32 -0400
Subject: Re: [PATCH v3 0/2] iio: add unit converter
To: Peter Rosin <peda@axentia.se>, <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fabio Estevam <festevam@gmail.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <fe90dc62-ef2b-d999-6841-2d9d5943654c@ti.com>
Date: Wed, 11 Apr 2018 10:34:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180411141555.15044-1-peda@axentia.se>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/11/2018 09:15 AM, Peter Rosin wrote:
> Hi!
> 
> I'm now following up with one more binding for the unit-converter.
> This time with a real IC, namely LT6106 from Analog Devices.

This makes more sense to me, I wasn't thinking about more complex ICs
like this when I made my "resistor being part of the sensing device"
argument.

I can see how having a new node will probably be needed. It just seems
strange to ask a resistor for its current, although it is the "device"
that "knows" how much current if flowing though it..

A case I'm more familiar with, fuel gauges, we have a gauge device that
has a handle to the battery it is gauging [0], we still ask the
"fuel-gauge" node to get out the state of charge, not the "battery"
node, the battery is not a "device" from our perspective.

Thinking more about that, I like your way better, so I recant my earlier
objections.

Andrew

[0] Documentation/devicetree/bindings/power/supply/bq27xxx.txt

> It's
> a current sense amplifier. I was a but unsure if I should have
> the Rin and Rout resistors in the binding or if I instead should
> have used the "gain". In the end I went with the resistors since
> while the normal case is an integer gain, that may not always be
> the case. And when it's not, that could get tricky. But I'm open
> for arguments on that.
> 
> Cheers,
> Peter
> 
> Peter Rosin (2):
>   dt-bindings: iio: afe: add binding for adi,lt6106
>   iio: afe: unit-converter: add support for adi,lt6106
> 
>  .../devicetree/bindings/iio/afe/adi,lt6106.txt     | 50 ++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  drivers/iio/afe/Kconfig                            |  3 +-
>  drivers/iio/afe/iio-unit-converter.c               | 54 ++++++++++++++++++++++
>  4 files changed, 107 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt
> 
