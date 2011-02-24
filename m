Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:34839 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab1BXMwg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Feb 2011 07:52:36 -0500
Message-ID: <4D6654B3.3020907@cam.ac.uk>
Date: Thu, 24 Feb 2011 12:53:07 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO: Documentation: iio_utils: fix mask generation
References: <1298551276-20564-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1298551276-20564-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/24/11 12:41, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Variable sizeint is used uninitialized.
> Remove sizeint completely and use bits_used instead.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

I clearly need to be more thorough in checking my demo apps code...

oops.
> ---
>  drivers/staging/iio/Documentation/iio_utils.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index bde2313..1b33c04 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -113,7 +113,7 @@ inline int iioutils_get_type(unsigned *is_signed,
>  	DIR *dp;
>  	char *scan_el_dir, *builtname, *builtname_generic, *filename = 0;
>  	char signchar;
> -	unsigned sizeint, padint;
> +	unsigned padint;
>  	const struct dirent *ent;
>  
>  	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir);
> @@ -159,7 +159,7 @@ inline int iioutils_get_type(unsigned *is_signed,
>  			fscanf(sysfsfp,
>  			       "%c%u/%u", &signchar, bits_used, &padint);
>  			*bytes = padint / 8;
> -			if (sizeint == 64)
> +			if (*bits_used == 64)
>  				*mask = ~0;
>  			else
>  				*mask = (1 << *bits_used) - 1;

