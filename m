Return-Path: <SRS0=ndMX=N7=usp.br=matheus.bernardino@kernel.org>
MIME-Version: 1.0
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
 <20181118042540.12697-5-matheus.bernardino@usp.br> <563614e00314ba92b9513645a82fde06504a42d5.camel@analog.com>
In-Reply-To: <563614e00314ba92b9513645a82fde06504a42d5.camel@analog.com>
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Tue, 20 Nov 2018 21:34:38 -0200
Message-ID: <CAHd-oW7vvk+gvk787OS29XP+O=Gf93raczuxiYJ9XSuWDJEu7A@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] dt-bindings:iio:resolver: Add docs for ad2s90
To: Alexandru Ardelean <alexandru.Ardelean@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Mark Rutland <mark.rutland@arm.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Victor Colombo <victorcolombo@gmail.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	kernel-usp@googlegroups.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Mon, Nov 19, 2018 at 6:22 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
> On Sun, 2018-11-18 at 02:25 -0200, Matheus Tavares wrote:
> > This patch adds the device tree binding documentation for the ad2s90
> > resolver-to-digital converter.
> >
>
> One minor comment inline.
>
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> > Changes in v2:
> >  - Rewritten 'spi-cpol and spi-cpha' item to say that the device can
> >  work in either mode (0,0) or (1,1) and explain how they should be
> >  specified in DT.
> >
> >  .../bindings/iio/resolver/ad2s90.txt          | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> > b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> > new file mode 100644
> > index 000000000000..594417539938
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> > @@ -0,0 +1,28 @@
> > +Analog Devices AD2S90 Resolver-to-Digital Converter
> > +
> > +https://www.analog.com/en/products/ad2s90.html
> > +
> > +Required properties:
> > +  - compatible: should be "adi,ad2s90"
> > +  - reg: SPI chip select number for the device
> > +  - spi-max-frequency: set maximum clock frequency, must be 830000
> > +  - spi-cpol and spi-cpha:
> > +        Either SPI mode (0,0) or (1,1) must be used, so specify none or
> > both of
> > +        spi-cpha, spi-cpol.
> For SPI properties it's a good idea to also reference the document for SPI
> bindings.
> Something like:
>     See for more details:
>      Documentation/devicetree/bindings/spi/spi-bus.txt
>

Thanks, Alex! I'll add that for v3.

Also, can you confirm AD2S90 works in both spi mode 0 and 3? It's not
explicitly stated in the datasheet, but that's what it seemed to me
and some colleagues.

Thanks,
Matheus

> > +
> > +Note about max frequency:
> > +    Chip's max frequency, as specified in its datasheet, is 2Mhz. But a
> > 600ns
> > +    delay is expected between the application of a logic LO to CS and
> > the
> > +    application of SCLK, as also specified. And since the delay is not
> > +    implemented in the spi code, to satisfy it, SCLK's period should be
> > at most
> > +    2 * 600ns, so the max frequency should be 1 / (2 * 6e-7), which
> > gives
> > +    roughly 830000Hz.
> > +
> > +Example:
> > +resolver@0 {
> > +     compatible = "adi,ad2s90";
> > +     reg = <0>;
> > +     spi-max-frequency = <830000>;
> > +     spi-cpol;
> > +     spi-cpha;
> > +};
>
> --
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To post to this group, send email to kernel-usp@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/563614e00314ba92b9513645a82fde06504a42d5.camel%40analog.com.
> For more options, visit https://groups.google.com/d/optout.
