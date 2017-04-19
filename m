Return-Path: <SRS0=Eec2=33=pengutronix.de=p.zabel@kernel.org>
Message-ID: <1492593449.2970.24.camel@pengutronix.de>
Subject: Re: [PATCH v13 02/10] dt-bindings: document devicetree bindings for
 mux-controllers and gpio-mux
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Wolfram
 Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>,  linux-doc@vger.kernel.org, kernel@pengutronix.de, Paul
 Gortmaker <paul.gortmaker@windriver.com>, Rob Herring <robh+dt@kernel.org>,
  linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>, Colin Ian King
 <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Cameron <jic23@kernel.org>
Date: Wed, 19 Apr 2017 11:17:29 +0200
In-Reply-To: <17135062-e58a-b50e-ac85-5f0f0b73d958@axentia.se>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
	 <1492101794-13444-3-git-send-email-peda@axentia.se>
	 <1492509996.2432.63.camel@pengutronix.de>
	 <17135062-e58a-b50e-ac85-5f0f0b73d958@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Tue, 2017-04-18 at 15:36 +0200, Peter Rosin wrote:
> On 2017-04-18 12:06, Philipp Zabel wrote:
> > On Thu, 2017-04-13 at 18:43 +0200, Peter Rosin wrote:
> >> Allow specifying that a single multiplexer controller can be used to
> >> control several parallel multiplexers, thus enabling sharing of the
> >> multiplexer controller by different consumers.
> >>
> >> Add a binding for a first mux controller in the form of a GPIO based mux
> >> controller.
> >>
> >> Acked-by: Jonathan Cameron <jic23@kernel.org>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>  Documentation/devicetree/bindings/mux/gpio-mux.txt |  69 +++++++++
> >>  .../devicetree/bindings/mux/mux-controller.txt     | 157 +++++++++++++++++++++
> >>  MAINTAINERS                                        |   6 +
> >>  include/dt-bindings/mux/mux.h                      |  16 +++
> >>  4 files changed, 248 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mux/gpio-mux.txt
> >>  create mode 100644 Documentation/devicetree/bindings/mux/mux-controller.txt
> >>  create mode 100644 include/dt-bindings/mux/mux.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.txt b/Documentation/devicetree/bindings/mux/gpio-mux.txt
> >> new file mode 100644
> >> index 000000000000..b8f746344d80
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mux/gpio-mux.txt
> >> @@ -0,0 +1,69 @@
> >> +GPIO-based multiplexer controller bindings
> >> +
> >> +Define what GPIO pins are used to control a multiplexer. Or several
> >> +multiplexers, if the same pins control more than one multiplexer.
> >> +
> >> +Required properties:
> >> +- compatible : "gpio-mux"
> >> +- mux-gpios : list of gpios used to control the multiplexer, least
> >> +	      significant bit first.
> >> +- #mux-control-cells : <0>
> >> +* Standard mux-controller bindings as decribed in mux-controller.txt
> >> +
> >> +Optional properties:
> >> +- idle-state : if present, the state the mux will have when idle. The
> >> +	       special state MUX_IDLE_AS_IS is the default.
> >> +
> >> +The multiplexer state is defined as the number represented by the
> >> +multiplexer GPIO pins, where the first pin is the least significant
> >> +bit. An active pin is a binary 1, an inactive pin is a binary 0.
> >> +
> >> +Example:
> >> +
> >> +	mux: mux-controller {
> >> +		compatible = "gpio-mux";
> >> +		#mux-control-cells = <0>;
> >> +
> >> +		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
> >> +			    <&pioA 1 GPIO_ACTIVE_HIGH>;
> >> +	};
> >> +
> >> +	adc-mux {
> >> +		compatible = "io-channel-mux";
> >> +		io-channels = <&adc 0>;
> >> +		io-channel-names = "parent";
> >> +
> >> +		mux-controls = <&mux>;
> >> +
> >> +		channels = "sync-1", "in", "out", "sync-2";
> >> +	};
> > 
> > Could you explain in more detail the reasoning behind this split between
> > the mux controller and the actual mux?
> > For SoC internal video bus muxes that are controlled by a register
> > bitfield, it seems a bit strange to have to split them into two device
> > tree nodes.
> 
> The background for the split is in the cover letter.

Thanks for explaining anyway, I didn't read past the changelog earlier.

[...]
> > Basically I'm trying to figure out whether a video mux (which has a mux
> > control plus OF-graph bindings to describe its ports and connections)
> > would fit into the same category as an adc-mux or i2c-mux, or whether it
> > would be better to handle them as a specialized form of mux-controller.
> 
> I did read some earlier thread about your muxing requirements and I got
> the impression that you also had HW which controlled the mux with
> gpio lines? In that case, the mux subsystem seems like a perfect fit
> with a new syscon/mmio/reg based mux driver (or whatever the name should
> be, I think I'd go with syscon) pretty much as suggested in your RFC
> patches. And then of course reuse the existing gpio-mux driver for the
> other case.

Yes, the requirement on hand is for MMIO controlled SoC internal muxes
for the i.MX6 video capture subsystem, but I'd like to also support GPIO
controlled external muxes to switch between two camera sources on those
boards that have them.

> The video-mux would fit as a mux consumer just like the iio-mux and the
> i2c-mux are mux consumers, with input 0/input 1 being the port that
> would be selected with the mux I guess.

Exactly. An N-input mux would have N+1 ports with port N being the
output.

[...]
> If I got things wrong when I skimmed whatever I came across, and if the
> mmio register is the only mux control option in the stars, it becomes
> less obvious... It's of course still possible to hook into the mux
> subsystem, but the benefit is questionable. And you do get the extra
> device tree node. You could of course also implement a mux driver
> outside of drivers/mux and thus make use of the mux api, but it's tiny
> and any benefit is truly small.

What I wondered mostly is whether it would be a good idea to move the
OF-graph ports into the mux controller node, and let the video capture
device be the consumer of the mux.
But this wouldn't fit well with the clear split between the mux
controller and the actual mux hardware in the mux DT bindings.

regards
Philipp
