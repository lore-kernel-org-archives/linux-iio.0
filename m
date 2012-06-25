Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44932 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756549Ab2FYUiy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jun 2012 16:38:54 -0400
Message-ID: <4FE8CC5D.5050106@kernel.org>
Date: Mon, 25 Jun 2012 21:38:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 7/7] iio staging: quell asprintf() warning, missing #includes
References: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net> <1340651505-31081-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340651505-31081-7-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/25/2012 08:11 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net
Acked-by: Jonathan Cameron <jic23@kernel.org>

Thanks for this set Peter.  Nice to get cleanups on the
bits that don't get hit by the autobuilders!


> ---
>  drivers/staging/iio/Documentation/generic_buffer.c |    3 +++
>  drivers/staging/iio/Documentation/iio_utils.h      |    1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
> index 1dd0681..aaf6146 100644
> --- a/drivers/staging/iio/Documentation/generic_buffer.c
> +++ b/drivers/staging/iio/Documentation/generic_buffer.c
> @@ -18,6 +18,8 @@
>   *
>   */
>  
> +#define _GNU_SOURCE
> +
>  #include <unistd.h>
>  #include <dirent.h>
>  #include <fcntl.h>
> @@ -29,6 +31,7 @@
>  #include <string.h>
>  #include <poll.h>
>  #include <endian.h>
> +#include <getopt.h>
>  #include <inttypes.h>
>  #include "iio_utils.h"
>  
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index 9c7a5aa..c0448b3 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -13,6 +13,7 @@
>  #include <stdio.h>
>  #include <stdint.h>
>  #include <dirent.h>
> +#include <errno.h>
>  
>  /* Made up value to limit allocation sizes */
>  #define IIO_MAX_NAME_LENGTH 30
> 


