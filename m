Return-Path: <robh@kernel.org>
MIME-Version: 1.0
References: <20180724183004.20279-1-marcus.folkesson@gmail.com>
 <20180724183004.20279-2-marcus.folkesson@gmail.com> <20180725175117.GA825@rob-hp-laptop>
 <20180725190441.GA3373@gmail.com>
In-Reply-To: <20180725190441.GA3373@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 26 Jul 2018 07:45:20 -0600
Message-ID: <CAL_JsqLiG-iTh5rys+ZZ1UpMMB1ub9hqxnRFEHtM8Ouo+d5ZDA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: add bindings for mcp3911
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Mark Rutland <mark.rutland@arm.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jul 25, 2018 at 1:04 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> Hello Rob,
>
> Thank you for the review.
>
> On Wed, Jul 25, 2018 at 11:51:17AM -0600, Rob Herring wrote:
> > On Tue, Jul 24, 2018 at 08:30:03PM +0200, Marcus Folkesson wrote:
> > > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> > >
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > Signed-off-by: Kent Gustavsson <kent@minoris.se>
> > > ---
> > >
> > > Notes:
> > >     v2:
> > >             - drop channel width
> > >             - drop `external_vref`
> > >             - replace `external-clock` with proper clock bindings
> > >
> > >  .../devicetree/bindings/iio/adc/mcp3911.txt        | 28 ++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> > > new file mode 100644
> > > index 000000000000..af5472f51a84
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> > > @@ -0,0 +1,28 @@
> > > +* Microchip MCP3911 Dual channel analog front end (ADC)
> > > +
> > > +Required properties:
> > > + - compatible: Should be "microchip,mcp3911"
> > > + - reg: SPI chip select number for the device
> > > +
> > > +Recommended properties:
> > > + - spi-max-frequency: Definition as per
> > > +    Documentation/devicetree/bindings/spi/spi-bus.txt.
> > > +    Max frequency for this chip is 20MHz.
> > > +
> > > +Optional properties:
> > > + - device-addr: Device address when multiple MCP3911 chips are present on the
> > > +   same SPI bus. Valid values are 0-3. Defaults to 0.
> >
> > Isn't this the reg value?
> >
>
> The reg value defines which chip select the chip hangs on.
> The chip has support to connect up to four chips on the same SPI bus,
> including the same chip select signal.
>
> The chips are separated by the device-addr as it is part of the
> communication protocol.

Okay, seems pretty specific to this chip. Just add a vendor prefix.

> When reading the description for device-addr, I agree that it fits well
> for the reg property as well..

Except that reg format is already defined for SPI devices, so it's
going to have to be separate property.

> > > + - vref-supply: Phandle to the external reference voltage supply.
> > > + - clocks: Phandle and clock identifier (see clock-names)
> > > + - clock-names: "adc_clk" for the ADC (sampling) clock
> >
> > Datasheet calls this clki (or mclk internally). Or just drop clock-names
> > as it is pointless
> > when there is only 1 clock.
>
> I will drop the clock-names, thanks!
>
> >
> > Also DR handling as an IRQ is missing.
>
> I have considered using the DR signal, but as we not support buffering
> yet I did not see any point in using it.

For the binding it doesn't matter if a particular driver uses it or
not. If it's connected in a h/w design it should be in DT.

Rob
