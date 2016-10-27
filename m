Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37716 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755186AbcJ0Nss (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Oct 2016 09:48:48 -0400
Received: by mail-wm0-f52.google.com with SMTP id 140so26715943wmv.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Oct 2016 06:48:48 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] iio: adc: spmi-vadc: Changes to support different
 scaling
To: Rama Krishna Phani A <rphani@codeaurora.org>,
        linux-iio@vger.kernel.org, jic23@kernel.org,
        devicetree@vger.kernel.org
References: <1477492887-1663-1-git-send-email-rphani@codeaurora.org>
 <1477492887-1663-3-git-send-email-rphani@codeaurora.org>
Cc: robh@kernel.org, linux-arm-msm@vger.kernel.org,
        smohanad@codeaurora.org, mgautam@codeaurora.org,
        sivaa@codeaurora.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Julia.Lawall@lip6.fr
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <8418e7f1-55d9-2dfa-1dc7-5960f9da0305@linaro.org>
Date: Thu, 27 Oct 2016 14:18:42 +0300
MIME-Version: 1.0
In-Reply-To: <1477492887-1663-3-git-send-email-rphani@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Rama,

On 10/26/2016 05:41 PM, Rama Krishna Phani A wrote:
> Polling can also be used for End of conversion completion. Implement logic
> to choose either polling or interrupt for End of conversion completion.
> Scaling can be done on the voltage to report adc code in physical units.
> Add changes to support different scale functions to convert adc code to
> physical units.
> 
> Signed-off-by: Rama Krishna Phani A <rphani@codeaurora.org>
> ---
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |  14 ++
>  drivers/iio/adc/qcom-spmi-vadc.c                   | 263 +++++++++++++++++----
>  2 files changed, 236 insertions(+), 41 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> index 0fb4613..39e31c0e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> @@ -37,6 +37,12 @@ VADC node:
>      Value type: <prop-encoded-array>
>      Definition: End of conversion interrupt.
>  
> +- qcom,vadc-poll-eoc:
> +    Usage: optional
> +    Value type: <bool>
> +    Definition: Use polling instead of interrupts for End of Conversion
> +		completion.

Why you need to add such a flag in DT?

The DT should describe hardware details not how the driver will choose
pooling vs interrupt.

On which use-case you would prefer pooling?

> +
>  Channel node properties:
>  
>  - reg:
> @@ -92,6 +98,14 @@ Channel node properties:
>              Valid values are: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512
>              If property is not found, 1 sample will be used.
>  
> +- qcom,scale-function:
> +    Usage: optional
> +    Value type: <u32>
> +    Definition: Scaling function used to convert raw ADC code to
> +	units specific to a given channel. Scaled units can be
> +	microvolts, millidegC.Valid values are: 0, 1, 2, 3, 4.
> +	If property is not found, 0 scaling will be used.

This shouldn't be in DT binding. Just select the scale function for each
channel in the driver based on compatible property.


-- 
regards,
Stan
