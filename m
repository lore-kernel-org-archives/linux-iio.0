Return-Path: <SRS0=B/yk=4G=axis.com=marten.lindahl@kernel.org>
Message-ID: <1493556147.2883.33.camel@axis.com>
Subject: Re: [PATCH] iio: adc: add driver for the ti-adc084s021 chip
From: =?ISO-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
To: Rob Herring <robh@kernel.org>
Cc: =?ISO-8859-1?Q?M=E5rten?= Lindahl <martenli@axis.com>, jic23@kernel.org,
  knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org,  mark.rutland@arm.com, devicetree@vger.kernel.org
Date: Sun, 30 Apr 2017 14:42:27 +0200
In-Reply-To: <20170428135248.du6smmzktqldj4u4@rob-hp-laptop>
References: <1492786703-5149-1-git-send-email-marten.lindahl@axis.com>
	 <20170428135248.du6smmzktqldj4u4@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Fri, 2017-04-28 at 08:52 -0500, Rob Herring wrote:
> On Fri, Apr 21, 2017 at 04:58:23PM +0200, Mårten Lindahl wrote:
> > From: Mårten Lindahl <martenli@axis.com>
> > 
> > This adds support for the Texas Instruments ADC084S021 ADC chip.
> > 
> > Signed-off-by: Mårten Lindahl <martenli@axis.com>
> > ---
> >  .../devicetree/bindings/iio/adc/ti-adc084s021.txt  |  25 ++
> 
> It's preferred to put bindings in a separate patch.
I am sorry for that. I split this into its own patch in v2.
> 
> >  drivers/iio/adc/Kconfig                            |  12 +
> >  drivers/iio/adc/Makefile                           |   1 +
> >  drivers/iio/adc/ti-adc084s021.c                    | 342 +++++++++++++++++++++
> >  4 files changed, 380 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
> >  create mode 100644 drivers/iio/adc/ti-adc084s021.c
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
> > new file mode 100644
> > index 0000000..921eb46
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
> > @@ -0,0 +1,25 @@
> > +* Texas Instruments' ADC084S021
> > +
> > +Required properties:
> > + - compatible        : Must be "ti,adc084s021"
> > + - reg               : SPI chip select number for the device
> > + - vref-supply       : The regulator supply for ADC reference voltage
> > + - spi-max-frequency : Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
> > +
> > +Optional properties:
> > + - spi-cpol          : SPI inverse clock polarity, as per spi-bus bindings
> > + - spi-cpha          : SPI shifted clock phase (CPHA), as per spi-bus bindings
> > + - spi-cs-high       : SPI chip select active high, as per spi-bus bindings
> 
> How are these optional? A given device should have specific properties 
> required here.
No, they are not optional. I removed this section in v2 and updated the
required properties section.
> 
> Also, no need to define them, "per spi-bus bindings" is enough.
Fixed in v2.
> 
> Rob

Thanks,
Mårten
