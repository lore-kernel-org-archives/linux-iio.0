Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57196 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753511AbcLCOlv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Dec 2016 09:41:51 -0500
Subject: Re: [PATCH] iio: 104-quad-8: Fix index control configuration
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20161128212244.GA6655@sophia>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <784965ac-6181-d64e-a44f-b06f2e9510fa@kernel.org>
Date: Sat, 3 Dec 2016 10:02:19 +0000
MIME-Version: 1.0
In-Reply-To: <20161128212244.GA6655@sophia>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/11/16 21:22, William Breathitt Gray wrote:
> The LS7266R1 requires bits 5 & 6 to be high in order to select the Index
> Control Register. This patch fixes a typo that incorrectly selects the
> Input/Output Control Register where the Index Control Register was
> desired.
> 
> Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8")
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied to the fixes-togreg-post-rc1 branch and marked for stable
(though that is probably irrelevant given this didn't apply to my fixes-togreg tree.

Jonathan
> ---
>  drivers/iio/counter/104-quad-8.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
> index 2d2ee35..c0a69d7 100644
> --- a/drivers/iio/counter/104-quad-8.c
> +++ b/drivers/iio/counter/104-quad-8.c
> @@ -362,7 +362,7 @@ static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
>  	priv->synchronous_mode[chan->channel] = synchronous_mode;
>  
>  	/* Load Index Control configuration to Index Control Register */
> -	outb(0x40 | idr_cfg, base_offset);
> +	outb(0x60 | idr_cfg, base_offset);
>  
>  	return 0;
>  }
> @@ -444,7 +444,7 @@ static int quad8_set_index_polarity(struct iio_dev *indio_dev,
>  	priv->index_polarity[chan->channel] = index_polarity;
>  
>  	/* Load Index Control configuration to Index Control Register */
> -	outb(0x40 | idr_cfg, base_offset);
> +	outb(0x60 | idr_cfg, base_offset);
>  
>  	return 0;
>  }
> 

