Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:61475 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754789AbcLNKfY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2016 05:35:24 -0500
Date: Wed, 14 Dec 2016 11:34:55 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net
Subject: Re: [PATCH v2 1/2] iio: adc: hx711: Add DT binding for avia,hx711
Message-ID: <20161214103455.GA27362@andreas>
References: <20161214095945.GA26511@andreas>
 <470f0017-2607-d5bd-bcd3-69f892cdc88b@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <470f0017-2607-d5bd-bcd3-69f892cdc88b@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars-Peter,

Lars-Peter Clausen <lars@metafoo.de> schrieb am Wed, 14. Dec 11:11:
> On 12/14/2016 10:59 AM, Andreas Klinger wrote:
> > Add DT bindings for avia,hx711
> > Add vendor avia to vendor list
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  .../devicetree/bindings/iio/adc/avia-hx711.txt      | 21 +++++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.txt         |  1 +
> >  2 files changed, 22 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > new file mode 100644
> > index 000000000000..6a4659fc7a4f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > @@ -0,0 +1,21 @@
> > +* AVIA HX711 ADC chip for weight cells
> > +  Bit-banging driver
> > +
> > +Required properties:
> > + - compatible: Should be "avia,hx711"
> > + - sck-gpios:	Definition of the GPIO for the clock
> > + - dout-gpios:	Definition of the GPIO for data-out
> > +		See Documentation/devicetree/bindings/gpio/gpio.txt
> > +
> > +Recommended properties:
> > + - gain:	Gain select, can be 32, 64 or 128
> > +		default is 128
> 
> If the gain is software programmable it should be exposed by the driver
> allowing the application to change it rather than putting it in the devicetree.
> 
There is also a hardware dependency in terms of where to connect the input
channel to:
- gain 64 and gain 128 are available only on input channel A
- gain 32 is only available on input channel B

Do you still think, it should be removed from the devicetree?

Andreas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
