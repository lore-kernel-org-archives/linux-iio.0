Return-Path: <SRS0=RIsb=75=wunner.de=lukas@kernel.org>
Date: Sun, 27 Aug 2017 17:34:05 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
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
	Adriana Reus <adi.reus@gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: iio: adc: mcp320x: Update for
 mcp3550/1/3
Message-ID: <20170827153405.GA13399@wunner.de>
References: <cover.1503407738.git.lukas@wunner.de>
 <87644503b0397248c06fbe0058f292955dd10f79.1503407738.git.lukas@wunner.de>
 <20170825195941.iylf4w5hitjwniio@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170825195941.iylf4w5hitjwniio@rob-hp-laptop>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Aug 25, 2017 at 02:59:41PM -0500, Rob Herring wrote:
> On Tue, Aug 22, 2017 at 03:33:00PM +0200, Lukas Wunner wrote:
> > --- a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
> > +Optional properties:
> > +	- microchip,continuous-conversion (boolean):
> > +			Only applicable to MCP3550/1/3:  These ADCs have long
> > +			conversion times and therefore support "continuous
> > +			conversion mode" to allow retrieval of conversions
> > +			at any time without observing a delay.  The mode is
> > +			enabled by permanently driving CS low, e.g. by wiring
> > +			it to ground.
> 
> Second binding I have seen today with a continuous property. Make this 
> common (or maybe we already have one).

The other one was the TI LMP92001 ADC driver posted by Abhisit Sangjan
(cc), however looking at the datasheet of that chip reveals that
continuous versus one-shot mode is selected by flipping a bit in the
chip's register map.

So it is configurable at run-time.  It's not something that's hardwired.
(Which is the case with the MCP3550 in my patch.)

My understanding was that run-time configurable options should not be
listed in the device-tree at all, only hardware features.  If that is
correct then that device-tree property should be dropped from Abhisit
Sangjan's patch.  Configuring the feature via sysfs is fine I guess.

However we do have another driver supporting continuous versus one-shot
mode and that is drivers/iio/light/us5182d.c by Adriana Reus (cc).
The feature was added with commit c3304c212326.  I'm not sure if it's
hardwired or runtime-configurable, the datasheet is gone from the
manufacturer's website.

I agree that a common "continuous" property makes sense.  We haven't
defined any common IIO properties so far and that has already led to
inconsistencies.  E.g. most ADC/DAC drivers name the reference regulator
"vref-supply", but e.g. drivers/iio/dac/ad7303.c calls it "REF-supply".

What do you think of this:

-- >8 --
Subject: [PATCH] dt-bindings: iio: Document common properties

It's about time we standardize on common names for frequently used IIO
properties.  For starters, document "vref-supply" and "continuous".

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 Documentation/devicetree/bindings/iio/iio-bindings.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
index 68d6f8c..c3e87e15 100644
--- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
+++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
@@ -95,3 +95,18 @@ vdd channel is connected to output 0 of the &ref device.
 		io-channels = <&adc 10>, <&adc 11>;
 		io-channel-names = "adc1", "adc2";
 	};
+
+==Common IIO properties==
+
+Reference voltage:
+ADCs, DACs and several other IIO devices require a reference voltage.
+By convention the property specifying this regulator is named "vref-supply".
+If the chip lacks a dedicated Vref pin and instead uses its own power supply
+as reference, the property specifying the regulator is commonly named
+"vdd-supply" or "vcc-supply".
+
+Continuous mode:
+Some sensors can be configured to perform continuous (versus one-shot)
+measurements.  Continuous mode may require more energy in return for faster
+or more reliable measurements.  A boolean property named "continuous"
+signifies that the device is configured for this mode.
-- 
2.11.0
