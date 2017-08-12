Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53238 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdHLMt1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2017 08:49:27 -0400
Date: Sat, 12 Aug 2017 13:39:13 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Andy Yan <andy.yan@rock-chips.com>
Cc: heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 09/13] dt-bindings: adc: add description for rv1108
 saradc
Message-ID: <20170812133913.5311a274@archlinux>
In-Reply-To: <1502423180-31154-1-git-send-email-andy.yan@rock-chips.com>
References: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
        <1502423180-31154-1-git-send-email-andy.yan@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 11 Aug 2017 11:46:20 +0800
Andy Yan <andy.yan@rock-chips.com> wrote:

> Add device tree bindings document for saradc on
> rockchip rv1108 soc.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>
I've already applied.  This please drop it from the next version of the
series.

Jonathan
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> index e0a9b9d..c2c50b5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> @@ -6,6 +6,7 @@ Required properties:
>     - "rockchip,rk3066-tsadc": for rk3036
>     - "rockchip,rk3328-saradc", "rockchip,rk3399-saradc": for rk3328
>     - "rockchip,rk3399-saradc": for rk3399
> +   - "rockchip,rv1108-saradc", "rockchip,rk3399-saradc": for rv1108
>  
>  - reg: physical base address of the controller and length of memory mapped
>         region.

