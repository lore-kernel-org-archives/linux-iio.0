Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55602 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756115AbdLVQK3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Dec 2017 11:10:29 -0500
Date: Fri, 22 Dec 2017 17:10:16 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com
Subject: Re: [PATCH 14/14] ARM: dts: at91: sama5d2: Add resistive touch device
Message-ID: <20171222161016.GI18255@piout.net>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
 <1513955241-10985-15-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513955241-10985-15-git-send-email-eugen.hristev@microchip.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 22/12/2017 at 17:07:21 +0200, Eugen Hristev wrote:
> Add the resistive touchscreen device, and the cell numbers to the
> ADC device.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index b1a26b4..30b3797 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -402,7 +402,6 @@
>  					compatible = "atmel,hlcdc-display-controller";
>  					#address-cells = <1>;
>  					#size-cells = <0>;
> -

This is an unrelated change.

>  					port@0 {
>  						#address-cells = <1>;
>  						#size-cells = <0>;

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
