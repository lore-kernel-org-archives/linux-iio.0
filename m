Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:3635 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750761AbaBSFHk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2014 00:07:40 -0500
Date: Wed, 19 Feb 2014 13:07:22 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Fugang Duan <B38611@freescale.com>
CC: <jic23@kernel.org>, <sachin.kamat@linaro.org>, <pmeerw@pmeerw.net>,
	<lars@metafoo.de>, <mark.rutland@arm.com>,
	<linux-iio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 1/3] ARM: dts: vf610-twr: Add ADC support
Message-ID: <20140219050716.GA3010@S2101-09.ap.freescale.net>
References: <1390714773-23066-1-git-send-email-B38611@freescale.com>
 <1390714773-23066-2-git-send-email-B38611@freescale.com>
 <20140216074850.GA2946@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140216074850.GA2946@S2101-09.ap.freescale.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Feb 16, 2014 at 03:48:53PM +0800, Shawn Guo wrote:
> Copy more DT folks and lists, as I want to make sure everyone agrees on
> how the fixed regulators should organized in the device tree sources,
> before I apply the patch.
> 
> On Sun, Jan 26, 2014 at 01:39:31PM +0800, Fugang Duan wrote:
> > vf610 has two ADC controllers, and vf610-twr board ADC0_SE5 pin connect
> > to sliding rheostat for ADC test, other ADC pins connect to connectors for
> > future use.
> > 
> > Add support for ADC0_SE5.
> > 
> > CC: Shawn Guo <shawn.guo@linaro.org>
> > CC: Jonathan Cameron <jic23@kernel.org>
> > CC: Mark Rutland <mark.rutland@arm.com>
> > CC: Otavio Salvador <otavio@ossystems.com.br>
> > CC: Peter Meerwald <pmeerw@pmeerw.net>
> > CC: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Fugang Duan <B38611@freescale.com>
> > ---
> >  arch/arm/boot/dts/vf610-twr.dts |   21 +++++++++++++++++++++
> >  arch/arm/boot/dts/vf610.dtsi    |   26 ++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
> > index c8047ca..d867be3 100644
> > --- a/arch/arm/boot/dts/vf610-twr.dts
> > +++ b/arch/arm/boot/dts/vf610-twr.dts
> > @@ -34,6 +34,27 @@
> >  		};
> >  	};
> >  
> > +	regulators {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		reg_vcc_3v3_mcu: regulator@0 {
> > +			compatible = "regulator-fixed";
> > +			reg = <0>;
> > +			regulator-name = "vcc_3v3_mcu";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +		};
> > +	};
> 
> Per discussion [1], Mark Rutland suggests that instead of organizing
> the fixed regulator nodes in a simple-bus container, it should be put
> under root node directly like below.
> 
> / {
> 	reg_vcc_3v3_mcu: regulator_0 {
> 		compatible = "regulator-fixed";
> 		regulator-name = "vcc_3v3_mcu";
> 		regulator-min-microvolt = <3300000>;
> 		regulator-max-microvolt = <3300000>;
> 	};
> };
> 
> Is this what all DT folks agree on?  At least the node name should be
> 'regulator-0' since it's more idiomatic to use '-' than '_' in node
> name?

It looks that Mark is giving up [1].  And we're fine with the original
code then.

Shawn

[1] http://thread.gmane.org/gmane.linux.drivers.devicetree/61894/focus=62405

