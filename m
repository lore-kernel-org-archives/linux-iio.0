Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbeGVJOF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Jul 2018 05:14:05 -0400
Date: Sun, 22 Jul 2018 09:18:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add Meson8m2 support
Message-ID: <20180722091809.59d442b0@archlinux>
In-Reply-To: <20180721194049.23265-2-martin.blumenstingl@googlemail.com>
References: <20180721194049.23265-1-martin.blumenstingl@googlemail.com>
        <20180721194049.23265-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 21 Jul 2018 21:40:48 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> The Amlogic Meson SAR ADC implementation on the Meson8m2 SoC is
> identical to the Meson8b variant. Add a compatible string to indicate
> that we support the SAR ADC on the Meson8m2 SoC.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilder to ignore it.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/amlogic,meson-saradc.txt         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> index d1acd5ea2737..54b823f3a453 100644
> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> @@ -4,6 +4,7 @@ Required properties:
>  - compatible:	depending on the SoC this should be one of:
>  			- "amlogic,meson8-saradc" for Meson8
>  			- "amlogic,meson8b-saradc" for Meson8b
> +			- "amlogic,meson8m2-saradc" for Meson8m2
>  			- "amlogic,meson-gxbb-saradc" for GXBB
>  			- "amlogic,meson-gxl-saradc" for GXL
>  			- "amlogic,meson-gxm-saradc" for GXM

