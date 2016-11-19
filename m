Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47388 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752975AbcKSPVt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Nov 2016 10:21:49 -0500
Subject: Re: [RFC PATCH v2 1/7] dt-bindings: document devicetree bindings for
 mux-gpio
To: Peter Rosin <peda@axentia.se>, Rob Herring <robh@kernel.org>
References: <1479419289-17553-1-git-send-email-peda@axentia.se>
 <1479419289-17553-2-git-send-email-peda@axentia.se>
 <20161118153528.tl24bp5xjwpjppk6@rob-hp-laptop>
 <a6a6610e-6827-a069-36e6-ca30a7110836@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9cc15c40-2eef-a118-16bb-71d21baebc8b@kernel.org>
Date: Sat, 19 Nov 2016 15:21:43 +0000
MIME-Version: 1.0
In-Reply-To: <a6a6610e-6827-a069-36e6-ca30a7110836@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/11/16 16:59, Peter Rosin wrote:
> On 2016-11-18 16:35, Rob Herring wrote:
>> On Thu, Nov 17, 2016 at 10:48:03PM +0100, Peter Rosin wrote:
>>> ---
>>>  .../devicetree/bindings/misc/mux-gpio.txt          | 79 ++++++++++++++++++++++
>>>  1 file changed, 79 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/misc/mux-gpio.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/misc/mux-gpio.txt b/Documentation/devicetree/bindings/misc/mux-gpio.txt
>>> new file mode 100644
>>> index 000000000000..73699a37824f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/misc/mux-gpio.txt
>>> @@ -0,0 +1,79 @@
>>> +GPIO-based multiplexer controller bindings
>>> +
>>> +Define what GPIO pins are used to control a multiplexer. Or several
>>> +multiplexers, if the same pins control more than one multiplexer.
>>
>> I think this makes sense in your case, but I think it is too complicated 
>> for a non-shared case. Perhaps mux-gpios should be used directly (i.e. 
>> in the adc-mux node) and control-muxes only used for the shared case.
>>
>> Part of me feels like you are working around in DT the GPIO subsystem 
>> limitation that it can't share GPIO lines. Either this could be fixed 
>> in some way in the GPIO subsystem, or the mux subsys could deal with it. 
>> You just have to look up if you already have a mux registered for the 
>> same GPIOs. Of course, that may make the mux subsys pretty much GPIO 
>> only, but I'm having a hard time thinking how you would have shared 
>> muxes that are not GPIO controlled. Any other control would be 
>> integrated into the mux itself.
> 
> But if someone wants to mux an adc line with a mux that is some kind of
> integrated i2c device, you'd have to add extra code to the iio muxer
> driver to handle that case. Or fork it. Or build something like the
> i2c muxer infrastructure and separate out the mux control in small
> drivers and handle the generic iio muxing centrally. But then someone
> else uses that i2c device to instead mux an i2c bus, and you'd end up
> with code duplication when that same muxer control code is added under
> drivers/i2c/muxes.
> 
> With the proposed solution, this is unified.
> 
> I'd just hate to see drivers for muxers added under drivers/i2c/muxes
> that do little more that control a mux that happens to be used to mux
> an i2c bus, but are generic muxers that could equally well mux something
> else. Even if the control is integrated into the mux, what the mux is
> actually used for should perhaps not determine where its driver should
> live.
> 
> Anyway, I don't know what to make with your suggestion, I just don't
> see the path forward (not enough experience with the kernel and/or gpio
> code). And it would be a limited solution (GPIO only,a s you say) so it
> doesn't feel right.
Also worth pointing out here the possibility of multi pole muxes...
Relays are ultimately muxes as well (be it slow ones ;)

A quick google fed me:
TI SN74LS153 for example.  This one is digital only though...

Analog option (in both senses) is:
http://www.analog.com/media/en/technical-documentation/data-sheets/ADG888.pdf

So these 'look' the same as two single muxes wired to the same GPIOs.

> 
> Is there perhaps some way to keep the complicated shared case work as
> is (or equivalently, the exact details are not important), and also
> provide a simpler in-node thingy to glue a mux control to a consumer
> w/o pointing to it with a phandle, but still have the same mux driver
> handle both cases? No, I'm not a devicetree guru, so I don't see a
> solution for that either, but maybe someone else does?
> 
> Perhaps the consumer could look for the mux control in first the
> phandle, as in my proposal. If not found, it could also look for
> a mux provider bound to child node.
> 
> 	adc-mux {
> 		compatible = "iio-mux";
> 		io-channels = <&adc 0>;
> 		io-channel-names = "parent";
> 
> 		mux-control {
> 			compatible = "mux-gpio";
> 			mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
> 				    <&pioA 1 GPIO_ACTIVE_HIGH>;
> 		};
> 
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		sync-1@0 {
> 			reg = <0>;
> 		};
> 		/* ... */
> 	};
> 
> Or perhaps look in a parent node:
> 
> 	mux-control {
> 		compatible = "mux-gpio";
> 		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
> 			    <&pioA 1 GPIO_ACTIVE_HIGH>;
> 
> 		adc-mux {
> 			compatible = "iio-mux";
> 			io-channels = <&adc 0>;
> 			io-channel-names = "parent";
> 
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			sync-1@0 {
> 				reg = <0>;
> 			};
> 			/* ... */
> 		};
> 	};
> 
> With the last suggestion, you could have multiple children of the
> mux-control node for the complicated case where it controls more
> than one mux. Not too bad? Hmm, what does the driver for the
> mux-control node have to do to have drivers tied to its children?
> 
> Maybe this last layout should be the only thing supported? Good
> enough for me anyway...
> 
> Cheers,
> Peter
> 
> PS. I will take care of the other comments for the next round.
> 

