Return-Path: <jic23@kernel.org>
Message-ID: <4FE8C9D3.8010703@kernel.org>
Date: Mon, 25 Jun 2012 21:28:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk
Subject: Re: [PATCH 2/7] iio staging: remove unused variable
References: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net> <1340651505-31081-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340651505-31081-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Missing sign off.

Just got the same warnings testing the previous patch as you
did so yup agreed with this one.  Do remember to add your sign off

Acked-by: Jonathan Cameron <jic23@kernel.org>

> ---
>  drivers/staging/iio/Documentation/generic_buffer.c |    2 --
>  drivers/staging/iio/Documentation/iio_utils.h      |    2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
> index 8d6e91c..81358ac 100644
> --- a/drivers/staging/iio/Documentation/generic_buffer.c
> +++ b/drivers/staging/iio/Documentation/generic_buffer.c
> @@ -131,8 +131,6 @@ int main(int argc, char **argv)
>  
>  
>  	int ret, c, i, j, toread;
> -
> -	FILE *fp_ev;
>  	int fp;
>  
>  	int num_channels;
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index 6f3a392..6fe8540 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -280,7 +280,7 @@ inline int build_channel_array(const char *device_dir,
>  {
>  	DIR *dp;
>  	FILE *sysfsfp;
> -	int count, temp, i;
> +	int count, i;
>  	struct iio_channel_info *current;
>  	int ret;
>  	const struct dirent *ent;
> 
