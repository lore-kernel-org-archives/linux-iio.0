Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60494 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbaH3Jpj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Aug 2014 05:45:39 -0400
Message-ID: <54019D42.205@kernel.org>
Date: Sat, 30 Aug 2014 10:45:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?windows-1252?Q?Heiko_St=FCbner?= <heiko@sntech.de>
CC: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: rockchip_saradc: remove unused variable in
 probe
References: <2134722.Yfu4MZ4klm@diego>
In-Reply-To: <2134722.Yfu4MZ4klm@diego>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/08/14 23:40, Heiko Stübner wrote:
> The rate variable in the probe function of the saradc is a remnant
> of a previous patch iteration. It is unused and thus produces a
> compile time warning. Therefore remove it.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/rockchip_saradc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 1fad964..e074a0b 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -141,7 +141,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	struct resource	*mem;
>  	int ret;
>  	int irq;
> -	u32 rate;
>  
>  	if (!np)
>  		return -ENODEV;
> 
