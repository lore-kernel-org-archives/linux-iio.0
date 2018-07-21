Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbeGURJq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Jul 2018 13:09:46 -0400
Date: Sat, 21 Jul 2018 17:16:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <arnaud.pouliquen@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: sigma-delta-modulator: fix
 unit-address in example
Message-ID: <20180721171626.69fb20cf@archlinux>
In-Reply-To: <1532011910-11641-1-git-send-email-fabrice.gasnier@st.com>
References: <1532011910-11641-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Jul 2018 16:51:50 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Device tree compiler gives a warning if a device node has "@"
> but no reg property.
> Fix the example in iio: adc: sigma-delta-modulator.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing
to be completely ignored by the autobuilders.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> index ba24ca7..59b92cd 100644
> --- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> @@ -7,7 +7,7 @@ Required properties:
>  
>  Example node:
>  
> -	ads1202: adc@0 {
> +	ads1202: adc {
>  		compatible = "sd-modulator";
>  		#io-channel-cells = <0>;
>  	};

