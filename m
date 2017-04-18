Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ve1eur01on0098.outbound.protection.outlook.com ([104.47.1.98]:50560
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753332AbdDRNg2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Apr 2017 09:36:28 -0400
Subject: Re: [PATCH v13 02/10] dt-bindings: document devicetree bindings for
 mux-controllers and gpio-mux
To: Philipp Zabel <p.zabel@pengutronix.de>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
 <1492101794-13444-3-git-send-email-peda@axentia.se>
 <1492509996.2432.63.camel@pengutronix.de>
CC: <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-iio@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <kernel@pengutronix.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-i2c@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <jic23@kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <17135062-e58a-b50e-ac85-5f0f0b73d958@axentia.se>
Date: Tue, 18 Apr 2017 15:36:14 +0200
MIME-Version: 1.0
In-Reply-To: <1492509996.2432.63.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-04-18 12:06, Philipp Zabel wrote:
> On Thu, 2017-04-13 at 18:43 +0200, Peter Rosin wrote:
>> Allow specifying that a single multiplexer controller can be used to
>> control several parallel multiplexers, thus enabling sharing of the
>> multiplexer controller by different consumers.
>>
>> Add a binding for a first mux controller in the form of a GPIO based mux
>> controller.
>>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  Documentation/devicetree/bindings/mux/gpio-mux.txt |  69 +++++++++
>>  .../devicetree/bindings/mux/mux-controller.txt     | 157 +++++++++++++++++++++
>>  MAINTAINERS                                        |   6 +
>>  include/dt-bindings/mux/mux.h                      |  16 +++
>>  4 files changed, 248 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mux/gpio-mux.txt
>>  create mode 100644 Documentation/devicetree/bindings/mux/mux-controller.txt
>>  create mode 100644 include/dt-bindings/mux/mux.h
>>
>> diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.txt b/Documentation/devicetree/bindings/mux/gpio-mux.txt
>> new file mode 100644
>> index 000000000000..b8f746344d80
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mux/gpio-mux.txt
>> @@ -0,0 +1,69 @@
>> +GPIO-based multiplexer controller bindings
>> +
>> +Define what GPIO pins are used to control a multiplexer. Or several
>> +multiplexers, if the same pins control more than one multiplexer.
>> +
>> +Required properties:
>> +- compatible : "gpio-mux"
>> +- mux-gpios : list of gpios used to control the multiplexer, least
>> +	      significant bit first.
>> +- #mux-control-cells : <0>
>> +* Standard mux-controller bindings as decribed in mux-controller.txt
>> +
>> +Optional properties:
>> +- idle-state : if present, the state the mux will have when idle. The
>> +	       special state MUX_IDLE_AS_IS is the default.
>> +
>> +The multiplexer state is defined as the number represented by the
>> +multiplexer GPIO pins, where the first pin is the least significant
>> +bit. An active pin is a binary 1, an inactive pin is a binary 0.
>> +
>> +Example:
>> +
>> +	mux: mux-controller {
>> +		compatible = "gpio-mux";
>> +		#mux-control-cells = <0>;
>> +
>> +		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
>> +			    <&pioA 1 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	adc-mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc 0>;
>> +		io-channel-names = "parent";
>> +
>> +		mux-controls = <&mux>;
>> +
>> +		channels = "sync-1", "in", "out", "sync-2";
>> +	};
> 
> Could you explain in more detail the reasoning behind this split between
> the mux controller and the actual mux?
> For SoC internal video bus muxes that are controlled by a register
> bitfield, it seems a bit strange to have to split them into two device
> tree nodes.

The background for the split is in the cover letter.

Basically, when the same set of gpio lines control several muxes, and
when these muxes are used for unrelated things, you needs some extra
complexity.

The mux controller is what controls those gpio lines, and thus the mux
state for all muxes they are connected to. The consumers refer to the
mux controller and request a certain state. So, the consumers naturally
need to interact or else they would destroy the mux state for each other.
Regarding the device tree layout, perhaps the mux consumers could be
children of the mux controller, but I think that would make the mux
controller more like a bus instead of a class. Anyway, I don't want to
go there again, because I remember it as a messy place. Maybe I could
do better now than I did way back when, but I'm not going willingly
and someone would have to force me.

The benefit of the split is that the mux consumer need no longer concern
itself with if the mux is controlled by gpio lines, an I2C based chip
like the ADG792 or if it is controlled by some mmio register. You can
thus avoid building muxing sub-sub-systems like drivers/i2c/muxes for
every subsystem needing muxing.

The drawback is that you get an extra device tree node for the mux
controller that may not make sense if it is in no way possible to
reuse your driver for HW with a different mux. Which may be the case
for your video case? But for generic stuff like ADC lines and I2C
buses, muxing options are diverse...

> Basically I'm trying to figure out whether a video mux (which has a mux
> control plus OF-graph bindings to describe its ports and connections)
> would fit into the same category as an adc-mux or i2c-mux, or whether it
> would be better to handle them as a specialized form of mux-controller.

I did read some earlier thread about your muxing requirements and I got
the impression that you also had HW which controlled the mux with
gpio lines? In that case, the mux subsystem seems like a perfect fit
with a new syscon/mmio/reg based mux driver (or whatever the name should
be, I think I'd go with syscon) pretty much as suggested in your RFC
patches. And then of course reuse the existing gpio-mux driver for the
other case.

The video-mux would fit as a mux consumer just like the iio-mux and the
i2c-mux are mux consumers, with input 0/input 1 being the port that
would be selected with the mux I guess. I don't think there should be a
bunch of video code inside the drivers/mux subdir, for the same reason
there's no iio/i2c code in there.

If I got things wrong when I skimmed whatever I came across, and if the
mmio register is the only mux control option in the stars, it becomes
less obvious... It's of course still possible to hook into the mux
subsystem, but the benefit is questionable. And you do get the extra
device tree node. You could of course also implement a mux driver
outside of drivers/mux and thus make use of the mux api, but it's tiny
and any benefit is truly small.

Cheers,
peda

