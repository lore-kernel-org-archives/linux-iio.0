Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753099AbdICQuI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 12:50:08 -0400
Date: Sun, 3 Sep 2017 17:50:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads1015: fix comparator polarity setting
Message-ID: <20170903175004.12b3f289@archlinux>
In-Reply-To: <1503534177-3840-1-git-send-email-akinobu.mita@gmail.com>
References: <1503534177-3840-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 24 Aug 2017 09:22:57 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> The comparator polarity field in config register is not correctly
> initialized as per the interrupt trigger setting.  Because the bitfield
> definision is wrong and bit shifting is missed.
> 
> Fixes: d9f39babd8ba ("iio: adc: ti-ads1015: add threshold event support")
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Hmm.. This one is dependent on a patch queued up for the coming merge window.

I've created a new branch based on Greg's next tree called
fixes-togreg-post-rc1. Hopefully I won't forget to send a pull request for
it after rc1, but if it looks like I have - please do give me a poke.

Applied to the fixes-togreg-post-rc1 branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads1015.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 36078bfc..1dad9f0 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -52,7 +52,7 @@
>  
>  #define ADS1015_CFG_COMP_QUE_MASK	GENMASK(1, 0)
>  #define ADS1015_CFG_COMP_LAT_MASK	BIT(2)
> -#define ADS1015_CFG_COMP_POL_MASK	BIT(2)
> +#define ADS1015_CFG_COMP_POL_MASK	BIT(3)
>  #define ADS1015_CFG_COMP_MODE_MASK	BIT(4)
>  #define ADS1015_CFG_DR_MASK	GENMASK(7, 5)
>  #define ADS1015_CFG_MOD_MASK	BIT(8)
> @@ -1017,10 +1017,12 @@ static int ads1015_probe(struct i2c_client *client,
>  
>  		switch (irq_trig) {
>  		case IRQF_TRIGGER_LOW:
> -			cfg_comp |= ADS1015_CFG_COMP_POL_LOW;
> +			cfg_comp |= ADS1015_CFG_COMP_POL_LOW <<
> +					ADS1015_CFG_COMP_POL_SHIFT;
>  			break;
>  		case IRQF_TRIGGER_HIGH:
> -			cfg_comp |= ADS1015_CFG_COMP_POL_HIGH;
> +			cfg_comp |= ADS1015_CFG_COMP_POL_HIGH <<
> +					ADS1015_CFG_COMP_POL_SHIFT;
>  			break;
>  		default:
>  			return -EINVAL;

