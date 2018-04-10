Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34090 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753127AbeDJNNl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2018 09:13:41 -0400
Date: Tue, 10 Apr 2018 08:13:38 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Phil Reid <preid@electromag.com.au>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: afe: add current-sense-cuicuit
 and voltage-divider
Message-ID: <20180410131338.k744yajxspiaqwn4@rob-hp-laptop>
References: <20180403153635.8228-1-peda@axentia.se>
 <20180403153635.8228-2-peda@axentia.se>
 <20180408175031.4945e2d7@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180408175031.4945e2d7@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Apr 08, 2018 at 05:50:31PM +0100, Jonathan Cameron wrote:
> On Tue,  3 Apr 2018 17:36:34 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
> circuit in the patch title is spelled wrong.
> 
> > An ADC is often used to measure other quantities indirectly. These
> > bindings describe two cases, a current through a sense resistor, and
> > a "big" voltage measured with the help of a voltage divider.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Will definitely be wanting wide opinions on this one - Rob in particularly
> for the binding side.
> 
> One comment inline. What we have here is nice and generic, but is
> it what would be 'expected' for current sense circuit?  Should we
> also be more specific in the naming.  There are lots of options for
> current sense circuits and this is just the simplest (current loop
> for example).
> 
> One option would be to use current-sense-shunt perhaps?
> 
> https://en.wikipedia.org/wiki/Current_sensing_techniques
> Gives a few that I didn't think of beyond current loops etc.
> 
> 
> > ---
> >  .../bindings/iio/afe/current-sense-circuit.txt     | 45 ++++++++++++++++++++++
> >  .../bindings/iio/afe/voltage-divider.txt           | 45 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  7 ++++
> >  3 files changed, 97 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
> > new file mode 100644
> > index 000000000000..0bc7d89387c0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
> > @@ -0,0 +1,45 @@
> > +Current Sense Curcuit
> > +=====================
> > +
> > +When an io-channel measures the voltage over a current sense resistor,
> > +the interesting mesaurement is often the current through the resistor,
> > +not the voltage over it. This binding describes such a current sense
> > +curcuit.
> > +
> > +Required properties:
> > +- compatible : "current-sense-circuit"
> > +- io-channels : Channel node of a voltage io-channel.
> > +
> > +Optional properties:
> > +- numerator : The io-channel scale is multiplied by this value (default 1).
> > +- denominator : The io-channel scale is divided by this value (default 1).
> > +
> > +Example:
> > +The system current is measured by measuring the voltage over a
> > +3.3 ohms sense resistor.
> 
> Hmm. It sort of feels like the binding doesn't really reflect the
> hardware as directly as it might.   Should we be explicitly having the
> resistance in this case?  (with some more mapping logic needed in the
> driver to figure out the scaling this causes).

I think having the resistance would be better as least in this case. For 
other cases like voltage dividers I'm not sure though. Those would be 
different compatibles so the associated properties don't necessarily 
need to be the same.

Rob
