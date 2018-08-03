Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729876AbeHCXw1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 Aug 2018 19:52:27 -0400
Date: Fri, 3 Aug 2018 22:54:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH v3 8/9] dt-bindings: iio: tsl2772: add binding for
 avago,apds9930
Message-ID: <20180803225414.37cca479@archlinux>
In-Reply-To: <20180803001900.25371-9-masneyb@onstation.org>
References: <20180803001900.25371-1-masneyb@onstation.org>
        <20180803001900.25371-9-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  2 Aug 2018 20:18:59 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch adds avago,apds9930 to the tsl2772 bindings.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
As before I'll pick up with the rest.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/light/tsl2772.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> index 4e7d98627cbf..1c5e6f17a1df 100644
> --- a/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> +++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> @@ -13,6 +13,7 @@ Required properties:
>  		"amstaos,tmd2672"
>  		"amstaos,tsl2772"
>  		"amstaos,tmd2772"
> +		"avago,apds9930"
>    - reg: the I2C address of the device
>  
>  Optional properties:

