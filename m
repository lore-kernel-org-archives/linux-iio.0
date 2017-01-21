Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35186 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdAUO3M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:29:12 -0500
Subject: Re: [PATCH v2 01/15] staging: iio: isl29028: made alignment of
 variables in struct isl29028_chip consistent
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20170117092502.6951-1-masneyb@onstation.org>
 <20170117092502.6951-2-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <514b131c-0f0e-8955-b86f-e123761bb863@kernel.org>
Date: Sat, 21 Jan 2017 14:29:10 +0000
MIME-Version: 1.0
In-Reply-To: <20170117092502.6951-2-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 09:24, Brian Masney wrote:
> The alignment of the variables in the struct isl29028_chip is not
> consistent. This changes all of the variables to use consistent
> alignment to improve the code readability.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it. 

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29028.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 1de81f5..4cce663 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -67,13 +67,13 @@ enum isl29028_als_ir_mode {
>  };
>  
>  struct isl29028_chip {
> -	struct mutex		lock;
> -	struct regmap		*regmap;
> +	struct mutex			lock;
> +	struct regmap			*regmap;
>  
> -	unsigned int		prox_sampling;
> -	bool			enable_prox;
> +	unsigned int			prox_sampling;
> +	bool				enable_prox;
>  
> -	int			lux_scale;
> +	int				lux_scale;
>  	enum isl29028_als_ir_mode	als_ir_mode;
>  };
>  
> 

