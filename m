Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeKQE1K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Nov 2018 23:27:10 -0500
Date: Fri, 16 Nov 2018 18:13:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: vadc: Add unit address to ADC
 channel node in example
Message-ID: <20181116181338.52674a46@archlinux>
In-Reply-To: <20181112221126.27142-2-mka@chromium.org>
References: <20181112221126.27142-1-mka@chromium.org>
        <20181112221126.27142-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 12 Nov 2018 14:11:25 -0800
Matthias Kaehlcke <mka@chromium.org> wrote:

> The node has a reg property, therefore its name should include a unit
> address. Also change the name from 'usb_id_nopull' to 'adc-chan', which
> is the preferred name for ADC channel nodes.
> 
> Include headers for constants used in the example.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
Looks good to me.  I'd just like to leave it a little longer
to give Rob or other device tree specialists a change
to take one last look at it.

Ping me if I seem to have forgotten about it!

Thanks,

Jonathan
> ---
> Changes in v6:
> - changed node name to adc-chan@
> - added includes for constants used in the example
> - updated commit message
> - added 'Reviewed-by: Douglas Anderson <dianders@chromium.org>' tag
> 
> Changes in v5:
> - patch added to the series
> ---
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt          | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> index b3c86f4ac7cdb..c81993f8d8c39 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> @@ -140,6 +140,10 @@ VADC_GND_REF and VADC_VDD_VADC.
>  
>  Example:
>  
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <linux/irq.h>
> +/* ... */
> +
>  	/* VADC node */
>  	pmic_vadc: vadc@3100 {
>  		compatible = "qcom,spmi-vadc";
> @@ -151,7 +155,7 @@ Example:
>  		io-channel-ranges;
>  
>  		/* Channel node */
> -		usb_id_nopull {
> +		adc-chan@VADC_LR_MUX10_USB_ID {
>  			reg = <VADC_LR_MUX10_USB_ID>;
>  			qcom,decimation = <512>;
>  			qcom,ratiometric;
