Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOMZO5BxwngKrpHf4F_vVAgAskKABDEr4m7TtuZN2LSt-JJSQA@mail.gmail.com>
References: <CAOMZO5BxwngKrpHf4F_vVAgAskKABDEr4m7TtuZN2LSt-JJSQA@mail.gmail.com>
Date: Tue, 3 Nov 2015 14:01:15 -0200
Message-ID: <CAOMZO5B0infwHoHPbTP9Mb9Es31cOA+rXBtsRmb-thFAN8cejQ@mail.gmail.com>
Subject: Re: vf610_adc: Division by zero
From: Fabio Estevam <festevam@gmail.com>
To: Duan Fugang-B38611 <B38611@freescale.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Nov 3, 2015 at 1:26 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Andy,
>
> Enabling vf610-adc in a imx6sx dts file causes the following error:

Ok, passing fsl,adck-max-frequency in the dtsi avoids the issue:

--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1152,6 +1152,8 @@
                 interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
                 clocks = <&clks IMX6SX_CLK_IPG>;
                 clock-names = "adc";
+                fsl,adck-max-frequency = <30000000>, <40000000>,
+                             <20000000>;
                 status = "disabled";
                         };

@@ -1161,6 +1163,8 @@
                 interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
                 clocks = <&clks IMX6SX_CLK_IPG>;
                 clock-names = "adc";
+                fsl,adck-max-frequency = <30000000>, <40000000>,
+                             <20000000>;
                 status = "disabled";
                         };

,but we still should better add some default frequencies in case
'adck-max-frequency' property is absent.
