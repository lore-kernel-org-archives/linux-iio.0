Return-Path: <zhiyong.tao@mediatek.com>
Message-ID: <1468291396.419.15.camel@mhfsdcap03>
Subject: Re: [PATCH v4 1/3] dt-bindings: auxadc: Add binding document for
 Mediatek auxadc.
From: zhiyong tao <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <srv_heupstream@mediatek.com>,
	<liguo.zhang@mediatek.com>, <yingjoe.chen@mediatek.com>,
	<eddie.huang@mediatek.com>, <erin.lo@mediatek.com>,
	<dawei.chien@mediatek.com>, <matthias.bgg@gmail.com>,
	<s.hauer@pengutronix.de>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date: Tue, 12 Jul 2016 10:43:16 +0800
In-Reply-To: <1468219197-9572-2-git-send-email-zhiyong.tao@mediatek.com>
References: <1468219197-9572-1-git-send-email-zhiyong.tao@mediatek.com>
	 <1468219197-9572-2-git-send-email-zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Mon, 2016-07-11 at 14:39 +0800, Zhiyong Tao wrote:
> The commit adds the device tree binding documentation for the mediatek
> auxadc found on Mediatek MT2701.
> Thermal gets auxadc sample data by iio device.
> So the commit changes auxadc device tree binding documentation from
> /soc/mediatek/auxadc.txt to /iio/adc/mt6577_auxadc.txt.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---

I forgot that I should use the command 'git format-patch -M' to submit
this patch. The follow information is the patch after executing the
above command. If the patch needs to be resent, please help to notify
me. I will resend the patch quickly.
The follow information:

 .../auxadc.txt => iio/adc/mt6577_auxadc.txt}       |   16
+++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/{soc/mediatek/auxadc.txt =>
iio/adc/mt6577_auxadc.txt} (50%)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
similarity index 50%
rename from Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
rename to Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
index bdb7829..bc23792 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
@@ -1,4 +1,4 @@
-MediaTek AUXADC
+* Mediatek AUXADC - Analog to Digital Converter on Mediatek mobile soc
(mt65xx/mt81xx/mt27xx)
 ===============

 The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
@@ -10,12 +10,18 @@
Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
 for the Thermal Controller which holds a phandle to the AUXADC.

 Required properties:
-- compatible: Must be "mediatek,mt8173-auxadc"
-- reg: Address range of the AUXADC unit
+  - compatible: "mediatek,mt2701-auxadc" or "mediatek,mt8173-auxadc"
+  - reg: Address range of the AUXADC unit.
+  - clocks: Should contain a clock specifier for each entry in
clock-names
+  - clock-names: Should contain "main".
+  - #io-channel-cells: Should be 1, see ../iio-bindings.txt

 Example:

-auxadc: auxadc@11001000 {
-       compatible = "mediatek,mt8173-auxadc";
+auxadc: adc@11001000 {
+       compatible = "mediatek,mt2701-auxadc";
        reg = <0 0x11001000 0 0x1000>;
+       clocks = <&pericfg CLK_PERI_AUXADC>;
+       clock-names = "main";
+       #io-channel-cells = <1>;
 };
-- 
1.7.9.5


>  .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |   27 ++++++++++++++++++++
>  .../devicetree/bindings/soc/mediatek/auxadc.txt    |   21 ---------------
>  2 files changed, 27 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
>  delete mode 100644 Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> new file mode 100644
> index 0000000..bc23792
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> @@ -0,0 +1,27 @@
> +* Mediatek AUXADC - Analog to Digital Converter on Mediatek mobile soc (mt65xx/mt81xx/mt27xx)
> +===============
> +
> +The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
> +in some Mediatek SoCs which among other things measures the temperatures
> +in the SoC. It can be used directly with register accesses, but it is also
> +used by thermal controller which reads the temperatures from the AUXADC
> +directly via its own bus interface. See
> +Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> +for the Thermal Controller which holds a phandle to the AUXADC.
> +
> +Required properties:
> +  - compatible: "mediatek,mt2701-auxadc" or "mediatek,mt8173-auxadc"
> +  - reg: Address range of the AUXADC unit.
> +  - clocks: Should contain a clock specifier for each entry in clock-names
> +  - clock-names: Should contain "main".
> +  - #io-channel-cells: Should be 1, see ../iio-bindings.txt
> +
> +Example:
> +
> +auxadc: adc@11001000 {
> +	compatible = "mediatek,mt2701-auxadc";
> +	reg = <0 0x11001000 0 0x1000>;
> +	clocks = <&pericfg CLK_PERI_AUXADC>;
> +	clock-names = "main";
> +	#io-channel-cells = <1>;
> +};
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/auxadc.txt b/Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
> deleted file mode 100644
> index bdb7829..0000000
> --- a/Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -MediaTek AUXADC
> -===============
> -
> -The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
> -in some Mediatek SoCs which among other things measures the temperatures
> -in the SoC. It can be used directly with register accesses, but it is also
> -used by thermal controller which reads the temperatures from the AUXADC
> -directly via its own bus interface. See
> -Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> -for the Thermal Controller which holds a phandle to the AUXADC.
> -
> -Required properties:
> -- compatible: Must be "mediatek,mt8173-auxadc"
> -- reg: Address range of the AUXADC unit
> -
> -Example:
> -
> -auxadc: auxadc@11001000 {
> -	compatible = "mediatek,mt8173-auxadc";
> -	reg = <0 0x11001000 0 0x1000>;
> -};
