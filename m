Return-Path: <SRS0=yHnl=N4=usp.br=matheus.bernardino@kernel.org>
MIME-Version: 1.0
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
 <20181109220044.24843-5-matheus.bernardino@usp.br> <20181111114848.266d3937@archlinux>
In-Reply-To: <20181111114848.266d3937@archlinux>
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Sat, 17 Nov 2018 01:29:09 -0200
Message-ID: <CAHd-oW4_Lp3-1toTeMmx4qBozfYZ6=7oPUa0BVG05OgjhnFm-w@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings:iio:resolver: Add docs for ad2s90
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>, kernel-usp@googlegroups.com,
	Victor Colombo <victorcolombo@gmail.com>, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Sun, Nov 11, 2018 at 9:48 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri,  9 Nov 2018 20:00:42 -0200
> Matheus Tavares <matheus.bernardino@usp.br> wrote:
>
> > This patch adds the device tree binding documentation for the ad2s90
> > resolver-to-digital converter.
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  .../bindings/iio/resolver/ad2s90.txt          | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> > new file mode 100644
> > index 000000000000..b42cc7752ffd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> > @@ -0,0 +1,26 @@
> > +Analog Devices AD2S90 Resolver-to-Digital Converter
> > +
> > +https://www.analog.com/en/products/ad2s90.html
> > +
> > +Required properties:
> > +  - compatible : should be "adi,ad2s90"
> > +  - reg : SPI chip select number for the device
> > +  - spi-max-frequency : set maximum clock frequency, must be 830000
> > +  - spi-cpol and spi-cpha : must be defined to enable SPI mode 3
>
> As the part only works in mode 3, my gut feeling is that this belongs
> in the driver, not here.  Rob, what do you think?
>

For this patch, I assumed the part only worked in mode 3 based on the
driver's code that set this at probe. But today I carefully looked for
it at the datasheet and now I'm unsure. It is never said, explicitly,
which SPI mode ad2s90 works with. But looking at the diagram that
shows the expected pins signals at each communication moment, it seems
to me that this chip can either work in mode 0 (CPOL=0, CPHA=0) or
mode 3 (CPOL=1, CPHA=1). Could someone help me to confirm this? And if
that is the case, them the SPI mode setting should be left in DT, as
adc/mcp320x and dac/ti-dac082s085 do, right?

Also, when I thought that ad2s90 only worked in mode 3, I wrote this
patch based on the dt-binding docs for the adxl345 accelerometer,
which only works in mode 3 but lets this setting to DT not in the
driver. Do you think, perhaps, it is wrong in adxl345, them?

Thanks,
Matheus.

> > +
> > +Note about max frequency:
> > +    Chip's max frequency, as specified in its datasheet, is 2Mhz. But a 600ns
> > +    delay is expected between the application of a logic LO to CS and the
> > +    application of SCLK, as also specified. And since the delay is not
> > +    implemented in the spi code, to satisfy it, SCLK's period should be at most
> > +    2 * 600ns, so the max frequency should be 1 / (2 * 6e-7), which gives
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
