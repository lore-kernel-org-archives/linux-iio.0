Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.140]:35930 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbcGZCwG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2016 22:52:06 -0400
Message-ID: <5796D036.1060101@rock-chips.com>
Date: Tue, 26 Jul 2016 10:51:34 +0800
From: Caesar Wang <wxt@rock-chips.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
CC: linux-iio@vger.kernel.org, dianders@chromium.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH] iio: adc: rockchip_saradc: Explicitly disable ADC on
 probe
References: <1469475540-26855-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1469475540-26855-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Guenter,

Thanks for fixing it.

On 2016年07月26日 03:39, Guenter Roeck wrote:
> If the ADC is read for the first time, the caller gets a timeout error,
> and the kernel log shows
>
> read channel() error: -110
>
> The ADC may be enabled on boot, and needs to be explicitly disabled
> for a read sequence to work (otherwise there is no completion interrupt).
> Disaple it explicitly in the probe function.
>
> Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/iio/adc/rockchip_saradc.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index f9ad6c2d6821..6aa3271d86b5 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -280,6 +280,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>   		goto err_pclk;
>   	}
>   
> +	/* Make sure ADC is disabled */
> +	writel_relaxed(0, info->regs + SARADC_CTRL);

I think we should reset the saradc controller.
Since make sure the reset value is 0 and loader-->kernel may even cause 
harm, as my experience on tsadc. (drivers/thermal/rockchip_thermal.c)


e.g.:
/**
* Reset SARADC Controller, reset all saradc registers.
*/
static void rockchip_saradc_reset_controller(struct reset_control *reset)
{
reset_control_assert(reset);
usleep_range(10, 20);
reset_control_deassert(reset);
}

..probe()
{
...
rockchip_saradc_reset_controller();
...
}


-
Caesar

> +
>   	platform_set_drvdata(pdev, indio_dev);
>   
>   	indio_dev->name = dev_name(&pdev->dev);


-- 
caesar wang | software engineer | wxt@rock-chip.com


