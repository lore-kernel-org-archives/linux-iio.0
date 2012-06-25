Return-Path: <jic23@kernel.org>
Message-ID: <4FE8CA76.5000808@kernel.org>
Date: Mon, 25 Jun 2012 21:30:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk
Subject: Re: [PATCH 3/7] iio staging: move comment
References: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net> <1340651505-31081-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340651505-31081-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/25/2012 08:11 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/Documentation/iio_utils.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index 6fe8540..d9439f8 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -7,7 +7,6 @@
>   * the Free Software Foundation.
>   */
>  
> -/* Made up value to limit allocation sizes */
>  #include <string.h>
>  #include <stdlib.h>
>  #include <ctype.h>
> @@ -15,6 +14,7 @@
>  #include <stdint.h>
>  #include <dirent.h>
>  
> +/* Made up value to limit allocation sizes */
>  #define IIO_MAX_NAME_LENGTH 30
>  
>  #define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
> 
