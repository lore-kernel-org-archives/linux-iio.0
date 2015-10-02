Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 2 Oct 2015 12:53:43 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Crt Mori <cmo@melexis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Vianney le Clement de Saint-Marcq <vianney.leclement@essensium.com>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] [BUGFIX] iio: mlx96014: Error checking from positive to
 negative
Message-ID: <20151002095343.GL7289@mwanda>
References: <1443777243-5095-1-git-send-email-cmo@melexis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443777243-5095-1-git-send-email-cmo@melexis.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Oct 02, 2015 at 02:14:03AM -0700, Crt Mori wrote:
>  	/* Write changed values */
>  	ret = mlx90614_write_word(client, MLX90614_CONFIG,
>  			(i << MLX90614_CONFIG_IIR_SHIFT) |
> -			(((u16) ((0x7 << MLX90614_CONFIG_FIR_SHIFT) |
> -			((u16) ret & (~((u16) MLX90614_CONFIG_FIR_MASK))))) &
> -			(~(u16) MLX90614_CONFIG_IIR_MASK)));
> +			(((u16) ((MLX90614_CONST_FIR << MLX90614_CONFIG_FIR_SHIFT) |
> +			((u16) ret & ((u16) ~MLX90614_CONFIG_FIR_MASK)))) &
> +			((u16) ~MLX90614_CONFIG_IIR_MASK)));

Yeah.  Ok.  This works.  When I was looking at it, I got some of the
parenthesis mixed up so I simplified it in the wrong way.  It really is
an unparsable wall of gobbledigook.  Also the casts are still not needed
even for time travellers I mentioned earlier.

This could be written more simply as:

	ret &= ~MLX90614_CONFIG_FIR_MASK;
	ret &= ~MLX90614_CONFIG_IIR_MASK;
	ret |= MLX90614_CONST_FIR << MLX90614_CONFIG_FIR_SHIFT;

	ret = mlx90614_write_word(client, MLX90614_CONFIG,
				  i << MLX90614_CONFIG_IIR_SHIFT | ret);

regards,
dan carpenter
