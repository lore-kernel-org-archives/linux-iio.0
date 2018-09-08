Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbeIHS5o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Sep 2018 14:57:44 -0400
Date: Sat, 8 Sep 2018 15:11:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: vadc: Fix documentation of
 'reg'
Message-ID: <20180908151142.465a1b7b@archlinux>
In-Reply-To: <20180906210454.247219-2-mka@chromium.org>
References: <20180906210454.247219-1-mka@chromium.org>
        <20180906210454.247219-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  6 Sep 2018 14:04:52 -0700
Matthias Kaehlcke <mka@chromium.org> wrote:

> The documentation of Qualcomm's SPMI PMIC voltage ADC claims that the
> 'reg' property consists of two values, the SPMI address and the length
> of the controller's registers. However the SPMI bus to which it is added
> specifies "#size-cells = <0>;". Remove the controller register length
> from the documentation of the field and the example.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> --
> Changes in v2:
> - none
> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> index 0fb46137f936..d0c188e5c922 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> @@ -13,7 +13,7 @@ VADC node:
>  - reg:
>      Usage: required
>      Value type: <prop-encoded-array>
> -    Definition: VADC base address and length in the SPMI PMIC register map.
> +    Definition: VADC base address in the SPMI PMIC register map.
>  
>  - #address-cells:
>      Usage: required
> @@ -104,7 +104,7 @@ Example:
>  	/* VADC node */
>  	pmic_vadc: vadc@3100 {
>  		compatible = "qcom,spmi-vadc";
> -		reg = <0x3100 0x100>;
> +		reg = <0x3100>;
>  		interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
