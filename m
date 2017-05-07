Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57389 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755915AbdEGVlH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 17:41:07 -0400
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: adc: add Meson8 and Meson8b
 support
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-iio@vger.kernel.org
Cc: carlo@caione.org, khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, thomas.langer@intel.com
References: <20170506134929.31190-1-martin.blumenstingl@googlemail.com>
 <20170506134929.31190-3-martin.blumenstingl@googlemail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56a48302-c7f1-65a0-95f9-22c7a1c21e8b@kernel.org>
Date: Sun, 7 May 2017 12:35:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170506134929.31190-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/05/17 14:49, Martin Blumenstingl wrote:
> The Amlogic Meson SAR ADC driver can be used on Meson8 and Meson8b
> (probably on earlier SoC generations as well, but I don't have any
> hardware available for testing that).
> Add a separate compatible for Meson8 and Meson8b because it does not
> need any of the BL30 magic (unlike the GX SoCs).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Acked-by: Rob Herring <robh@kernel.org>
Applied
> ---
>  Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> index f9e3ff2c656e..08cee82e54c3 100644
> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> @@ -2,6 +2,8 @@
>  
>  Required properties:
>  - compatible:	depending on the SoC this should be one of:
> +			- "amlogic,meson8-saradc" for Meson8
> +			- "amlogic,meson8b-saradc" for Meson8b
>  			- "amlogic,meson-gxbb-saradc" for GXBB
>  			- "amlogic,meson-gxl-saradc" for GXL
>  			- "amlogic,meson-gxm-saradc" for GXM
> 

