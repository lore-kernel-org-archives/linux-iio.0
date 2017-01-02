Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39830 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756526AbdABSGA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 13:06:00 -0500
Subject: Re: [PATCH v6 8/9] dt-bindings: mux-adg792a: document devicetree
 bindings for ADG792A/G mux
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1480493823-21462-1-git-send-email-peda@axentia.se>
 <1480493823-21462-9-git-send-email-peda@axentia.se>
 <d4c41153-aebf-be05-a323-1298e8c4ee65@kernel.org>
 <3fa5b6f0-76c1-0ca6-978e-9407a44a2e7e@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <86bfcc29-df24-d877-915f-d62fc3987c05@kernel.org>
Date: Mon, 2 Jan 2017 18:05:56 +0000
MIME-Version: 1.0
In-Reply-To: <3fa5b6f0-76c1-0ca6-978e-9407a44a2e7e@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/01/17 16:01, Peter Rosin wrote:
> On 2017-01-01 12:00, Jonathan Cameron wrote:
>> On 30/11/16 08:17, Peter Rosin wrote:
>>> Analog Devices ADG792A/G is a triple 4:1 mux.
>>>
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> Few comments inline.  Worth adding anything about the gpio (output pins) to
>> the binding at this stage as well?  Would certainly be nice to support
>> them.
> 
> I'll add optional properties "gpio-controller;" and "#gpio-cells = <2>;"
> with the usual interpretation in v7 (but no implementation...) Is that
> enough?
> 
>> Jonathan
>>> ---
>>>  .../devicetree/bindings/misc/mux-adg792a.txt       | 64 ++++++++++++++++++++++
>>>  1 file changed, 64 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/misc/mux-adg792a.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/misc/mux-adg792a.txt b/Documentation/devicetree/bindings/misc/mux-adg792a.txt
>>> new file mode 100644
>>> index 000000000000..4677f9ab1c55
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/misc/mux-adg792a.txt
>>> @@ -0,0 +1,64 @@
>>> +Bindings for Analog Devices ADG792A/G Triple 4:1 Multiplexers
>>> +
>>> +Required properties:
>>> +- compatible : "adi,adg792a" or "adi,adg792g"
>>> +- #mux-control-cells : <0> if parallel, or <1> if not.
>>> +* Standard mux-controller bindings as decribed in mux-controller.txt
>>> +
>>> +Optional properties:
>>> +- adi,parallel : if present, the three muxes are bound together with a single
>>> +  mux controller, controlling all three muxes in parallel.
>>> +- adi,idle-state : if present, array of states the three mux controllers will
>>> +  have when idle (or, if parallel, a single idle-state).
>> Hmm. These are actually a policy decision.  As only one policy will make
>> sense for a given set of hardware probably fine to have it in here I guess.
>> Might be worth adding a note to say this though.
> 
> I don't really know what you want me to add, do you have a suggestion for the
> wording?
> 
>>> +
>>> +Mux controller states 0 through 3 correspond to signals A through D in the
>>> +datasheet. Mux controller states 4 and 5 are only available as possible idle
>>> +states. State 4 represents that nothing is connected, and state 5 represents
>>> +that the mux controller keeps the mux in its previously selected state during
>>> +the idle period. State 5 is the default idle state.
>> I'm never a great fan of magic numbers.  Can we represent this more cleanly by
>> breaking it into multiple properties?
>> Optional:
>> adi,idle-switch-to-channel : switch to this channel when idle.
>> adi,idle-high-impedance : <boolean> the nothing connected state?
>>
>> If neither present leaves it in previous state?
> 
> It's not that easy. adi,idle-state is an array when there are three single
> pole quadruple throw muxes, so there really needs to be a number for each
> desired idle-behavior. Unless you have a better idea for how to describe
> that?
The above with arrays for each of the two parameters?
Though then you need a priority documented - I'd say high impedance overrides
the channel selection if both are present.
> 
> Cheers,
> peda
> 
>>> +
>>> +Example:
>>> +
>>> +	/* three independent mux controllers (of which one is used) */
>>> +	&i2c0 {
>>> +		mux: adg792a@50 {
>>> +			compatible = "adi,adg792a";
>>> +			reg = <0x50>;
>>> +			#mux-control-cells = <1>;
>>> +		};
>>> +	};
>>> +
>>> +	adc-mux {
>>> +		compatible = "iio-mux";
>>> +		io-channels = <&adc 0>;
>>> +		io-channel-names = "parent";
>>> +
>>> +		mux-controls = <&mux 1>;
>>> +
>>> +		channels = "sync-1", "", "out";
>>> +	};
>>> +
>>> +
>>> +	/*
>>> +	 * Three parallel muxes with one mux controller, useful e.g. if
>>> +	 * the adc is differential, thus needing two signals to be muxed
>>> +	 * simultaneously for correct operation.
>>> +	 */
>>> +	&i2c0 {
>>> +		pmux: adg792a@50 {
>>> +			compatible = "adi,adg792a";
>>> +			reg = <0x50>;
>>> +			#mux-control-cells = <0>;
>>> +			adi,parallel;
>>> +		};
>>> +	};
>>> +
>>> +	diff-adc-mux {
>>> +		compatible = "iio-mux";
>>> +		io-channels = <&adc 0>;
>>> +		io-channel-names = "parent";
>>> +
>>> +		mux-controls = <&pmux>;
>>> +
>>> +		channels = "sync-1", "", "out";
>>> +	};
>>>
>>
> 

