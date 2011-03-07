Return-Path: <greg@kroah.com>
Date: Mon, 7 Mar 2011 13:43:20 -0800
From: Greg KH <greg@kroah.com>
To: michael.hennerich@analog.com
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] Staging: IIO: Documentation: iio_utils: fix channel
 array generation.
Message-ID: <20110307214320.GA5639@kroah.com>
References: <1299167403-18017-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299167403-18017-1-git-send-email-michael.hennerich@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 03, 2011 at 04:50:03PM +0100, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> The previous implementation flawed, in case some channels are not enabled.
> The sorted array would then include channel information of disabled channels,
> And misses the enabled ones, when the count is reached.
> More troublesome, the loop would not even terminate.
> 
> The fix is twofold:
> 
> First we skip channels that are not enabled.
> Then we use a tested bubble sort algorithm to sort the array.
> Since we already allocated exactly the number of bytes we need.
> We can exercise bubble sort on the original memory.
> In all cases I've seen, the array is already sorted, so this sort
> terminates immediately.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/Documentation/iio_utils.h |   53 ++++++++++++++----------
>  1 files changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index 1b33c04..da10b4e 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -242,6 +242,25 @@ error_ret:
>  	return ret;
>  }
> 
> +/**
> + * bsort_channel_array_by_index() - reorder so that the array is in index order
> + *
> + **/
> +
> +inline void bsort_channel_array_by_index(struct iio_channel_info **ci_array, int cnt)
> +{
> +
> +	struct iio_channel_info temp;
> +	int x,y;
> +
> +	for(x=0; x<cnt; x++)
> +		for(y=0; y<(cnt - 1); y++)
> +			if((*ci_array)[y].index > (*ci_array)[y+1].index) {
> +				temp = (*ci_array)[y+1];
> +				(*ci_array)[y+1] = (*ci_array)[y];
> +				(*ci_array)[y] = temp;
> +			}
> +}

This fails the checkpatch tool.  It might be documentation, but it still
needs to follow the correct rules :)

thanks,

greg k-h
