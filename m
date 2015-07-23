Return-Path: <knaack.h@gmx.de>
Message-ID: <55B1406B.70005@gmx.de>
Date: Thu, 23 Jul 2015 21:28:43 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Joo Aun Saw <jasaw@dius.com.au>, linux-iio@vger.kernel.org
CC: jic23@kernel.org
Subject: Re: [PATCH] tools: iio: make scale and offset files optional
References: <1437620027-24635-1-git-send-email-jasaw@dius.com.au>
In-Reply-To: <1437620027-24635-1-git-send-email-jasaw@dius.com.au>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Joo Aun Saw schrieb am 23.07.2015 um 04:53:
> From: Joo Aun Saw <jasaw@dius.com.au>
> 
> Make scale and offset optional by adding -ENOENT check as not all
> drivers implement them.
> 
> Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  tools/iio/iio_utils.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index c3f9e37..1dcdf03 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -487,7 +487,7 @@ int build_channel_array(const char *device_dir,
>  						       device_dir,
>  						       current->name,
>  						       current->generic_name);
> -			if (ret < 0)
> +			if ((ret < 0) && (ret != -ENOENT))
>  				goto error_cleanup_array;
>  
>  			ret = iioutils_get_param_float(&current->offset,
> @@ -495,7 +495,7 @@ int build_channel_array(const char *device_dir,
>  						       device_dir,
>  						       current->name,
>  						       current->generic_name);
> -			if (ret < 0)
> +			if ((ret < 0) && (ret != -ENOENT))
>  				goto error_cleanup_array;
>  
>  			ret = iioutils_get_type(&current->is_signed,
> 
