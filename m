Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57235 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753533AbcLCOlw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Dec 2016 09:41:52 -0500
Subject: Re: [PATCH] iio: 104-quad-8: Fix active level mismatch for the preset
 enable option
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20161129155148.GA4193@sophia>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ea6bbee3-6770-ea87-1158-2a7d6936a083@kernel.org>
Date: Sat, 3 Dec 2016 10:08:38 +0000
MIME-Version: 1.0
In-Reply-To: <20161129155148.GA4193@sophia>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/11/16 15:51, William Breathitt Gray wrote:
> The set_to_preset_on_index sysfs attribute provides a boolean
> configuration option to enable a preset operation on the respective
> channel's counter when Index occurs. However, the corresponding
> configuration bit on the Input/Output Control register must be set low
> to enable the preset operation.
> 
> This patch inverts the internal driver boolean logic exposed via the
> set_to_preset_on_index attribute in order to correctly configure the
> device which expects an active low bit.
> 
> Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8")
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied to the fixes-togreg-post-rc1 branch and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/counter/104-quad-8.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
> index 2d2ee35..9847221 100644
> --- a/drivers/iio/counter/104-quad-8.c
> +++ b/drivers/iio/counter/104-quad-8.c
> @@ -233,7 +233,7 @@ static ssize_t quad8_read_set_to_preset_on_index(struct iio_dev *indio_dev,
>  	const struct quad8_iio *const priv = iio_priv(indio_dev);
>  
>  	return snprintf(buf, PAGE_SIZE, "%u\n",
> -		priv->preset_enable[chan->channel]);
> +		!priv->preset_enable[chan->channel]);
>  }
>  
>  static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
> @@ -250,6 +250,9 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> +	/* Preset enable is active low in Input/Output Control register */
> +	preset_enable = !preset_enable;
> +
>  	priv->preset_enable[chan->channel] = preset_enable;
>  
>  	ior_cfg = priv->ab_enable[chan->channel] |
> 

