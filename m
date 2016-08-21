Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51121 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbcHUKyl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 06:54:41 -0400
Subject: Re: [PATCH RESEND] iio: iio-utils: use channel modifier scaling if it
 exists
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1471639492-23531-1-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d960bd96-eb0a-d62a-e9ca-16e44d0b0e89@kernel.org>
Date: Sun, 21 Aug 2016 11:54:39 +0100
MIME-Version: 1.0
In-Reply-To: <1471639492-23531-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/08/16 21:44, Matt Ranostay wrote:
> Now there are channel modifiers with their own scaling those should be
> used when possible over the generic channel type scaling.
Fine in general.

Example though for this intro please.

Makes it easier to follow through the changes in the patch.

Thanks,

Jonathan
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
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

