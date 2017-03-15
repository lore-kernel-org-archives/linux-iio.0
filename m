Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36670 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdCOTZY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 15:25:24 -0400
Date: Wed, 15 Mar 2017 14:25:21 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, benjamin.gaignard@linaro.org,
        benjamin.gaignard@st.com, linus.walleij@linaro.org
Subject: Re: [PATCH v3 1/6] dt-bindings: iio: introduce trigger providers,
 consumers
Message-ID: <20170315192521.l7mb3egh4hbxdpx6@rob-hp-laptop>
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
 <1488300679-3259-2-git-send-email-fabrice.gasnier@st.com>
 <20170303062126.5bewa5u6o7wu7sy4@rob-hp-laptop>
 <948e5b96-7a8f-406d-6d03-d129d1b2ce54@kernel.org>
 <12a6a2f8-9ff6-a4f0-c9a2-c7de037019ef@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12a6a2f8-9ff6-a4f0-c9a2-c7de037019ef@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 05, 2017 at 12:13:36PM +0000, Jonathan Cameron wrote:
> On 05/03/17 11:43, Jonathan Cameron wrote:
> > On 03/03/17 06:21, Rob Herring wrote:
> >> On Tue, Feb 28, 2017 at 05:51:14PM +0100, Fabrice Gasnier wrote:
> >>> Document iio provider and consumer bindings.
> >>>
> >>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >>> ---
> >>>  .../devicetree/bindings/iio/iio-bindings.txt       | 38 ++++++++++++++++++++++
> >>>  1 file changed, 38 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> >>> index 68d6f8c..01765e9 100644
> >>> --- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> >>> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> >>> @@ -95,3 +95,41 @@ vdd channel is connected to output 0 of the &ref device.
> >>>  		io-channels = <&adc 10>, <&adc 11>;
> >>>  		io-channel-names = "adc1", "adc2";
> >>>  	};
> >>> +
> >>> +==IIO trigger providers==
> >>> +Sources of IIO triggers can be represented by any node in the device
> >>> +tree. Those nodes are designated as IIO trigger providers. IIO trigger
> >>> +consumer uses a phandle and an IIO trigger specifier to connect to an
> >>> +IIO trigger provider.
> >>> +An IIO trigger specifier is an array of one or more cells identifying
> >>> +the IIO trigger output on a device. The length of an IIO trigger
> >>> +specifier is defined by the value of a #io-trigger-cells property in
> >>> +the IIO trigger provider node.
> >>> +
> >>> +Required properties:
> >>> +#io-trigger-cells:
> >>> +		Number of cells in an IIO trigger specifier; Typically
> >>> +		0 for nodes with a simple IIO trigger output.
> >>> +
> >>> +Example:
> >>> +	trig0: interrupt-trigger0 {
> >>> +		#io-trigger-cells = <0>;
> >>> +		compatible = "interrupt-trigger";
> >>> +		interrupts = <11 0>;
> >>> +		interrupt-parent = <&gpioa>;
> >>> +	}
> >>> +
> >>> +==IIO trigger consumers==
> >>> +Required properties:
> >>> +- io-triggers:	List of phandle representing the IIO trigger specifier.
> >>> +
> >>> +Optional properties:
> >>> +- io-trigger-names :
> >>> +		List of IIO trigger name strings that matches elements
> >>> +		in 'io-triggers' list property.
> >>> +
> >>> +Example:
> >>> +	some_trigger_consumer {
> >>> +		io-triggers = <&trig0>;
> >>> +		io-trigger-names = "mytrig";
> >>> +	}
> >>
> >> I have some reservations about this. We could just as easily add the 
> >> interrupt directly to the consumer node and use "trigger" for a standard 
> >> interrupt name. So the question is whether this extra level of 
> >> indirection is needed? 
> > 
> > First thing to note here, is that Fabrice's use of the generic interrupt
> > trigger is an extremely 'unusual' one! Normal use case is that we have
> > a random gpio pin providing interrupts to driver triggering on random
> > devices - there need be no association between the two whatsoever.
> > So what we are doing here is 'allowing' an interrupt to provide a trigger.
> > It's not necessarily the one going to be used by any particular device
> > driver.  The decision of which trigger to use is definitely one for
> > userspace, not something that should be configured in to the device tree.
> > 
> > For this particular case you could in theory just do it by using an interrupt
> > as you describe.  Ultimately though we should be able to play more complex
> > games with this device and having it able to handle any trigger - which 
> > includes those not using the direct hardware route.  It'll be up to the
> > driver to figure out when it can use the fast method and when it can't.
> > 
> > Conversely, even when we are using this hardware route to drive the
> > triggering it should be possible to hang off a device to be triggered
> > by the interrupt via the kernel rather than directly. 
> > 
> > So from a device tree point of view we are just describing the fact that
> > there is a pin, which may be used to trigger something.  What that something
> > is, is a question for userspace not the device tree.
> > 
> Ah, I'm half asleep this morning.  Clearly there is a more general follow
> up question.  If we are arguing these are generic, why are we setting
> up the mapping in device tree?
> 
> My gut feeling is we shouldn't be.  So I think we need the first chunk
> above but the latter part should be a job for userspace not the devicetree.

So you mean keep the provider side, but get rid of the consumer? That 
makes sense to me.

Rob
