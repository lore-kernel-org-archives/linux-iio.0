Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from dougal.metanate.com ([90.155.101.14]:8891 "EHLO metanate.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752067AbcGZJUN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 26 Jul 2016 05:20:13 -0400
Date: Tue, 26 Jul 2016 10:00:07 +0100
From: John Keeping <john@metanate.com>
To: Caesar Wang <wxt@rock-chips.com>
Cc: jic23@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	dianders@chromium.org, linux-rockchip@lists.infradead.org,
	robh+dt@kernel.org, linux@roeck-us.net
Subject: Re: [PATCH 1/4] iio: adc: rockchip_saradc: reset saradc controller
 before programming it
Message-ID: <20160726100007.5166e7f9.john@metanate.com>
In-Reply-To: <1469513510-1516-1-git-send-email-wxt@rock-chips.com>
References: <1469513510-1516-1-git-send-email-wxt@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 26 Jul 2016 14:11:47 +0800, Caesar Wang wrote:

> SARADC controller needs to be reset before programming it, otherwise
> it will not function properly.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> ---
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index f9ad6c2..2f0e110 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -218,6 +231,13 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	if (IS_ERR(info->regs))
>  		return PTR_ERR(info->regs);
>  
> +	info->reset = devm_reset_control_get(&pdev->dev, "saradc-apb");
> +	if (IS_ERR(info->reset)) {
> +		ret = PTR_ERR(info->reset);
> +		dev_err(&pdev->dev, "failed to get saradc reset: %d\n", ret);
> +		return ret;
> +	}

Does this need to handle ENOENT so as to avoid failing with old device
tree blobs?
