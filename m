Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34913 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeJFDsK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Oct 2018 23:48:10 -0400
Date: Fri, 5 Oct 2018 15:47:43 -0500
From: Rob Herring <robh@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: vadc: Update example to include
 unit address for node 'usb-id-nopull'
Message-ID: <20181005204743.GA17135@bogus>
References: <20181004001432.21218-1-mka@chromium.org>
 <20181004001432.21218-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181004001432.21218-2-mka@chromium.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 03, 2018 at 05:14:31PM -0700, Matthias Kaehlcke wrote:
> The node has a reg property, therefore its name should include a unit
> address.
> 
> Also change the name from 'usb_id_nopull' to 'usb-id-nopull' to follow
> DT conventions.

This is ADC channels? If so, then DT convention would really be 
"adc@...". 

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v4:
> - patch added to the series
> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> index d0c188e5c922..ff7aa5038ba6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> @@ -112,7 +112,7 @@ Example:
>  		io-channel-ranges;
>  
>  		/* Channel node */
> -		usb_id_nopull {
> +		usb-id-nopull@VADC_LR_MUX10_USB_ID {
>  			reg = <VADC_LR_MUX10_USB_ID>;

Defines are generally used when there's not well defined numbering such 
as clock ids. Interrupts and addresses are generally well defined and 
don't need defines.

>  			qcom,decimation = <512>;
>  			qcom,ratiometric;
> -- 
> 2.19.0.605.g01d371f741-goog
> 
