Return-Path: <jic23@kernel.org>
Message-ID: <4FE8CC12.3040109@kernel.org>
Date: Mon, 25 Jun 2012 21:37:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk
Subject: Re: [PATCH 6/7] iio staging: use PRId64 format specifier for int64_t
References: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net> <1340651505-31081-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340651505-31081-6-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

New one to me, but fair enough.

On 06/25/2012 08:11 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/Documentation/generic_buffer.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
> index ab228b4..1dd0681 100644
> --- a/drivers/staging/iio/Documentation/generic_buffer.c
> +++ b/drivers/staging/iio/Documentation/generic_buffer.c
> @@ -29,6 +29,7 @@
>  #include <string.h>
>  #include <poll.h>
>  #include <endian.h>
> +#include <inttypes.h>
>  #include "iio_utils.h"
>  
>  /**
> @@ -111,7 +112,7 @@ void process_scan(char *data,
>  				/* special case for timestamp */
>  				if (channels[k].scale == 1.0f &&
>  				    channels[k].offset == 0.0f)
> -					printf(" %lld", val);
> +					printf(" %" PRId64, val);
>  				else
>  					printf("%05f ", ((float)val +
>  							 channels[k].offset)*
> 
