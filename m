Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41075 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbcBFSTI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 13:19:08 -0500
Subject: Re: [PATCH] Staging:iio:Remove exceptional & on function name
To: Bhumika Goyal <bhumirks@gmail.com>, gregkh@linuxfoundation.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net
References: <1454644412-6861-1-git-send-email-bhumirks@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B6391A.9040508@kernel.org>
Date: Sat, 6 Feb 2016 18:19:06 +0000
MIME-Version: 1.0
In-Reply-To: <1454644412-6861-1-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/16 03:53, Bhumika Goyal wrote:
> In this file,function names are otherwise used as pointers without &.
> Found using coccinelle.
> // <smpl>
> @r@
> identifier f;
> @@
> 
> f(...) { ... }
> @@
> identifier r.f;
> @@
> 
> - &f
> + f
> // </smpl>
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Nice little bit of tidying up.

Applied to the togreg branch of iio.git -  initially pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 10c43dda..d1218d8 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -558,7 +558,7 @@ out:
>  }
>  
>  static const struct iio_info ad5933_info = {
> -	.read_raw = &ad5933_read_raw,
> +	.read_raw = ad5933_read_raw,
>  	.attrs = &ad5933_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
> @@ -616,9 +616,9 @@ static int ad5933_ring_postdisable(struct iio_dev *indio_dev)
>  }
>  
>  static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
> -	.preenable = &ad5933_ring_preenable,
> -	.postenable = &ad5933_ring_postenable,
> -	.postdisable = &ad5933_ring_postdisable,
> +	.preenable = ad5933_ring_preenable,
> +	.postenable = ad5933_ring_postenable,
> +	.postdisable = ad5933_ring_postdisable,
>  };
>  
>  static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
> 

