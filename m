Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:43492 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbdIRPr1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Sep 2017 11:47:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 18 Sep 2017 23:47:25 +0800
From: icenowy@aosc.io
To: maxime.ripard@free-electrons.com
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH v4 1/6] dt-bindings: update the
 Allwinner GPADC device tree binding for H3
In-Reply-To: <20170918083045.7bfiialtbm7w6i7j@flea.lan>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-2-icenowy@aosc.io>
 <20170918073336.j7finend3g76chsu@flea.lan>
 <310CE549-B8CE-4C0C-95B1-B545E38BDAF5@aosc.io>
 <20170918083045.7bfiialtbm7w6i7j@flea.lan>
Message-ID: <e73ead447af89031749e85207cac1e69@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

在 2017-09-18 16:30，Maxime Ripard 写道：
> On Mon, Sep 18, 2017 at 03:36:43PM +0800, Icenowy Zheng wrote:
>> 于 2017年9月18日 GMT+08:00 下午3:33:36, Maxime Ripard 
>> <maxime.ripard@free-electrons.com> 写到:
>> >On Thu, Sep 14, 2017 at 10:52:46PM +0800, Icenowy Zheng wrote:
>> >> Allwinner H3 features a thermal sensor like the one in A33, but has
>> >its
>> >> register re-arranged, the clock divider moved to CCU (originally the
>> >> clock divider is in ADC) and added a pair of bus clock and reset.
>> >>
>> >> Update the binding document to cover H3.
>> >>
>> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> >> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>> >> ---
>> >> Changes in v4:
>> >> - Add nvmem calibration data (not yet used by the driver)
>> >> Changes in v3:
>> >> - Clock name changes.
>> >> - Example node name changes.
>> >> - Add interupts (not yet used by the driver).
>> >>
>> >>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 30
>> >++++++++++++++++++++--
>> >>  1 file changed, 28 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> >b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> >> index badff3611a98..6c470d584bf9 100644
>> >> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> >> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> >> @@ -4,12 +4,26 @@ The Allwinner SoCs all have an ADC that can also
>> >act as a thermal sensor
>> >>  and sometimes as a touchscreen controller.
>> >>
>> >>  Required properties:
>> >> -  - compatible: "allwinner,sun8i-a33-ths",
>> >> +  - compatible: must contain one of the following compatibles:
>> >> +		- "allwinner,sun8i-a33-ths"
>> >> +		- "allwinner,sun8i-h3-ths"
>> >>    - reg: mmio address range of the chip,
>> >>    - #thermal-sensor-cells: shall be 0,
>> >>    - #io-channel-cells: shall be 0,
>> >>
>> >> -Example:
>> >> +Optional properties:
>> >> +  - nvmem-cells: A phandle to the calibration data provided by a
>> >nvmem device.
>> >> +                 If unspecified default values shall be used.
>> >> +  - nvmem-cell-names: Should be "calibration-data"
>> >
>> >I'd prefer to have which sensor it applies to here. It wouldn't change
>> >anything for the H3, but it definitely does for example for the A83t
>> >that has two sensors, one for each cluster, and one for the GPU, each
>> >with calibration data.
>> >
>> >What about cluster0-calibration?

I prefer sensor0-calibration to sensor3-calibration now.
(Theortically the new generation THS can support up to 4 sensors)

>> 
>> The calibration data is in fact a 2 word (8 bytes) zone,
>> which is reserved for 4 sensors on all SoCs, even on H3.
>> It's half word per sensor.
>> 
>> I prefer to just assume a 2 word cell for every SoC.
> 
> You have three different data sources, it should be reprensented as
> such.
> 
> Otherwise, the client has to get some knowledge of how the data are
> stored in the provider, which is an abstraction violation.
> 
> Maxime
> 
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
