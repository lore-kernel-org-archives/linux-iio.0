Return-Path: <antoine.tenart@free-electrons.com>
Date: Tue, 7 Apr 2015 12:20:11 +0200
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	zmxu@marvell.com, jszhang@marvell.com, yrliao@marvell.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ARM: berlin: add an ADC node for the BG2Q
Message-ID: <20150407102011.GA19914@kwain>
References: <1428066409-30392-1-git-send-email-antoine.tenart@free-electrons.com>
 <1428066409-30392-4-git-send-email-antoine.tenart@free-electrons.com>
 <551FBC34.4070501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <551FBC34.4070501@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Sebastian,

On Sat, Apr 04, 2015 at 12:25:56PM +0200, Sebastian Hesselbarth wrote:
> On 03.04.2015 15:06, Antoine Tenart wrote:
> >This patch adds the ADC node for the Berlin BG2Q, using the newly added
> >Berlin IIO ADC driver.
> >
> >Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> >---
> >  arch/arm/boot/dts/berlin2q.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> >index 187d056f7ad2..72b1c969a99d 100644
> >--- a/arch/arm/boot/dts/berlin2q.dtsi
> >+++ b/arch/arm/boot/dts/berlin2q.dtsi
> >@@ -565,6 +565,14 @@
> >  						function = "twsi3";
> >  					};
> >  				};
> >+
> >+				adc: adc {
> >+					compatible = "marvell,berlin2-adc";
> >+					interrupt-parent = <&sic>;
> >+					interrupts = <12>, <14>;
> >+					interrupt-names = "adc", "tsen";
> >+					status = "disabled";
> >+				};
> 
> nit: there is no gated clock for the ADC, I guess we can just always
> enable it. That will save you the last patch of the series.

Sure, we can just drop the last patch (and the status property).

> BTW, I have the strong feeling that moving berlin's clk drivers to
> regmap will block any subsequent patches you are preparing. How about
> we target the next merge window for moving the clk node but not the
> drivers (except of_iomap of the _parent's_ reg property) and push the
> less controversal patches (pinctrl, reset) with regmap/syscon forward?

The entire clock rework series does not affect this ADC series or any
other on going series. It can be merged latter, without breaking
anything. I just realized I mentioned the clock rework series as a
dependency in the cover letter of this series but it is not, my bad.

So, we can target the next merge window for all series but the clock
rework. In addition to this, I can send a series moving the clock node,
with minor modifications to the driver so we have a proper dt. And then
we can see if moving to a regmap aware clock driver can be done.

To sum up:
- chip/system controller series can be pushed
- this ADC series too, as it does not depend on the clock rework (as
  soon as we have the needed acked-by)
- I need to make a new series to move the clock node
- the clock driver rework series can live in parallel

Agreed?

Antoine

-- 
Antoine Ténart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
