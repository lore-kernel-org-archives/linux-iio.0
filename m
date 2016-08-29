Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41568 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757878AbcH2P2G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 11:28:06 -0400
Subject: Re: [PATCH v2] iio: iio-utils: use channel modifier scaling if it
 exists
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1471904377-11228-1-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1aec7a09-0326-227a-8a0b-c0945aac387c@kernel.org>
Date: Mon, 29 Aug 2016 16:28:04 +0100
MIME-Version: 1.0
In-Reply-To: <1471904377-11228-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/08/16 23:19, Matt Ranostay wrote:
> Now there are channel modifiers with their own scaling those should be
> used when possible over the generic channel type scaling.
> 
> Examples are of IIO_TEMP channel having a generic scaling value, and
> another having IIO_MOD_TEMP_AMBIENT modifier with another scaling value.
> 
> Previously the first scaling value for a channel type would be applied
> to all channels of like type in iio_generic_buffer
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied. Thanks.

I remember a long time ago wondering if we should ever allow a 
hierarchy like this and never making my mind up.

If we have these out in the wild, not much choice really!

Jonathan
> ---
> 
> Changes from v1:
> 
> * make commit message more verbose
> 
>  tools/iio/iio_utils.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 5eb6793f3972..7a6d61c6c012 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -121,10 +121,6 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>  
>  	ret = -ENOENT;
>  	while (ent = readdir(dp), ent)
> -		/*
> -		 * Do we allow devices to override a generic name with
> -		 * a specific one?
> -		 */
>  		if ((strcmp(builtname, ent->d_name) == 0) ||
>  		    (strcmp(builtname_generic, ent->d_name) == 0)) {
>  			ret = asprintf(&filename,
> @@ -178,6 +174,13 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>  			sysfsfp = 0;
>  			free(filename);
>  			filename = 0;
> +
> +			/*
> +			 * Avoid having a more generic entry overwriting
> +			 * the settings.
> +			 */
> +			if (strcmp(builtname, ent->d_name) == 0)
> +				break;
>  		}
>  
>  error_close_sysfsfp:
> 

