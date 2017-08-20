Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752612AbdHTLFa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 07:05:30 -0400
Date: Sun, 20 Aug 2017 11:54:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2 03/11] iio: adc: ti-ads1015: enable conversion when
 CONFIG_PM is not set
Message-ID: <20170820115428.35d5c0c2@archlinux>
In-Reply-To: <1500564267-8613-4-git-send-email-akinobu.mita@gmail.com>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
        <1500564267-8613-4-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 21 Jul 2017 00:24:19 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> The ADS1015 device have two operating modes, continuous conversion mode
> and single-shot mode.  This driver assumes that the continuous conversion
> mode is selected by runtime resume callback when the ADC result is
> requested.
> 
> If CONFIG_PM is disabled, the device is always in the default single-shot
> mode and no one begins a single conversion.  So the conversion register
> doesn't contain valid ADC result.  Fix it by changing the continuous mode
> in probe function.
> 
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Applied to the togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index f32d046..fcfa570 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -623,6 +623,13 @@ static int ads1015_probe(struct i2c_client *client,
>  		dev_err(&client->dev, "iio triggered buffer setup failed\n");
>  		return ret;
>  	}
> +
> +	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
> +				ADS1015_CFG_MOD_MASK,
> +				ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
> +	if (ret)
> +		return ret;
> +
>  	ret = pm_runtime_set_active(&client->dev);
>  	if (ret)
>  		goto err_buffer_cleanup;

