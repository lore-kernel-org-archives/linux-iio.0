Return-Path: <SRS0=n0sD=AE=h08.hostsharing.net=foo00@kernel.org>
Date: Sun, 3 Sep 2017 20:20:46 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Adriana Reus <adi.reus@gmail.com>, Rob Herring <robh@kernel.org>,
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
	Soeren Andersen <san@rosetechnology.dk>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Abhisit Sangjan <s.abhisit@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: iio: adc: mcp320x: Update for
 mcp3550/1/3
Message-ID: <20170903182046.GA1511@wunner.de>
References: <cover.1503407738.git.lukas@wunner.de>
 <87644503b0397248c06fbe0058f292955dd10f79.1503407738.git.lukas@wunner.de>
 <20170825195941.iylf4w5hitjwniio@rob-hp-laptop>
 <20170827153405.GA13399@wunner.de>
 <CABjU8GvCB61envBiR0ei3gHEPadd5VDZ7FGysDjhCrJcQrEXDg@mail.gmail.com>
 <20170903143429.749be480@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170903143429.749be480@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Sep 03, 2017 at 02:37:49PM +0100, Jonathan Cameron wrote:
> On Tue, Aug 22, 2017 at 03:33:00PM +0200, Lukas Wunner wrote:  
> > --- a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
> > +Optional properties:
> > +   - microchip,continuous-conversion (boolean):
> > +           Only applicable to MCP3550/1/3:  These ADCs have long
> > +           conversion times and therefore support "continuous
> > +           conversion mode" to allow retrieval of conversions
> > +           at any time without observing a delay.  The mode is
> > +           enabled by permanently driving CS low, e.g. by wiring
> > +           it to ground.  
> 
> hmm.  This is odd.  We probably need to make the SPI subsystem aware
> of this. It is possible to ask for exclusive use of an SPI bus and
> I think we should be doing this here.  It may be wired low on your
> board, but it may be wired to a controllable chip select on other
> boards and we can still force it low to trigger this mode if it makes
> sense for the current application.
> 
> So I'd argue what we actually need to represent here is that the CS line
> is not controllable.  What this means to the driver should be handled
> in the driver - ideally also dealing with the case where it is controllable
> appropriately (via exclusive bus usage).  Spi devices have the SPI_NO_CS
> bit in the mode member of the spi device but I'm not sure about bindings.
[...]
> The one case where we normally want to flip to continuous modes is when
> we have a chardev access going on to the device.  In IIO that reflects
> the fact we are in a push mode rather than userspace polling for new data.

It seems there is no DT binding so far to set SPI_NO_CS.

Conceivably, continuous mode could be used even with multiple devices
on the bus if CLK and MISO is AND-gated with the CS signal coming from
the SPI master.  (And the CS of the ADC is pulled low.)  In that case,
the notion that "continuous mode == CS not controllable" would be
incorrect, hence the approach I've chosen.

On the Revolution Pi we don't use continuous mode.  I merely included
it in the driver for completeness.  If it is too controversial I'd be
inclined to drop the feature.

On-demand switching to continuous mode by keeping CS low would be
possible by setting the cs_change bit of struct mcp320x ->transfer[1],
but that might not work if there are other devices on the bus.


> Personally I don't think we are in a position yet to make this a generic
> property - this is the first device where it is actually to do with the
> physical circuit (and arguably it isn't really - see above).

Okay.


> Reference voltages are an oddity as the supply naming typically should match
> that on the datasheet. It's 'fairly' consistent but some devices
> have a set of relatively obscure references to different parts of the
> input circuitry.  We can document it as a 'default' assuming nothing
> strange is going on though.  This is why we have the vagueness below
> on VDD and VCC.

That is new to me, I believe it's not documented or am I missing something?
I'd be happy to respin the below patch without the "Continuous mode"
portion if you want?  (Amended with the info you gave above.)
Do you think iio-bindings.txt is the right place to put this or would
a separate common.txt be more appropriate? (See e.g. leds/common.txt)

Thanks,

Lukas

> -- >8 --  
> Subject: [PATCH] dt-bindings: iio: Document common properties
>
> It's about time we standardize on common names for frequently used IIO
> properties.  For starters, document "vref-supply" and "continuous".
>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  Documentation/devicetree/bindings/iio/iio-bindings.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> index 68d6f8c..c3e87e15 100644
> --- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> @@ -95,3 +95,18 @@ vdd channel is connected to output 0 of the &ref device.
>                 io-channels = <&adc 10>, <&adc 11>;
>                 io-channel-names = "adc1", "adc2";
>         };
> +
> +==Common IIO properties==
> +
> +Reference voltage:
> +ADCs, DACs and several other IIO devices require a reference voltage.
> +By convention the property specifying this regulator is named "vref-supply".
> +If the chip lacks a dedicated Vref pin and instead uses its own power supply
> +as reference, the property specifying the regulator is commonly named
> +"vdd-supply" or "vcc-supply".
> +
> +Continuous mode:
> +Some sensors can be configured to perform continuous (versus one-shot)
> +measurements.  Continuous mode may require more energy in return for faster
> +or more reliable measurements.  A boolean property named "continuous"
> +signifies that the device is configured for this mode.
> --
> 2.11.0  
