Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbeFJMgK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Jun 2018 08:36:10 -0400
Date: Sun, 10 Jun 2018 13:36:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <ludovic.desroches@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <dmitry.torokhov@gmail.com>,
        <robh@kernel.org>
Subject: Re: [PATCH v7 9/9] ARM: dts: at91: sama5d2: Add resistive touch
 device
Message-ID: <20180610133604.71421803@archlinux>
In-Reply-To: <1526975559-18966-10-git-send-email-eugen.hristev@microchip.com>
References: <1526975559-18966-1-git-send-email-eugen.hristev@microchip.com>
        <1526975559-18966-10-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 May 2018 10:52:39 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Add generic resistive touch device which is connected to ADC block
> inside the SAMA5D2 SoC
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
As with the previous patch, the driver side of things is working it's
way through the IIO tree, but will be the next merge window, not the
current one.

Thanks,

Jonathan

> ---
> Changes in v5:
>  - renamed touchscreen-threshold-pressure to touchscreen-min-pressure
> 
>  arch/arm/boot/dts/sama5d2.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index f06ba99..a44f325 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -1442,6 +1442,16 @@
>  				status = "disabled";
>  			};
>  
> +			resistive_touch: resistive-touch {
> +				compatible = "resistive-adc-touch";
> +				io-channels = <&adc AT91_SAMA5D2_ADC_X_CHANNEL>,
> +					      <&adc AT91_SAMA5D2_ADC_Y_CHANNEL>,
> +					      <&adc AT91_SAMA5D2_ADC_P_CHANNEL>;
> +				io-channel-names = "x", "y", "pressure";
> +				touchscreen-min-pressure = <50000>;
> +				status = "disabled";
> +			};
> +
>  			pioA: pinctrl@fc038000 {
>  				compatible = "atmel,sama5d2-pinctrl";
>  				reg = <0xfc038000 0x600>;

