Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60102 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992509AbbHHSyp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 14:54:45 -0400
Subject: Re: [PATCH 2/2] tools: iio: remove unnecessary double pointer
To: Joo Aun Saw <jasaw@dius.com.au>, linux-iio@vger.kernel.org
References: <1437751409-28837-1-git-send-email-jasaw@dius.com.au>
 <1437751409-28837-3-git-send-email-jasaw@dius.com.au>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C65074.8090406@kernel.org>
Date: Sat, 8 Aug 2015 19:54:44 +0100
MIME-Version: 1.0
In-Reply-To: <1437751409-28837-3-git-send-email-jasaw@dius.com.au>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/07/15 16:23, Joo Aun Saw wrote:
> From: Joo Aun Saw <jasaw@dius.com.au>
> 
> Remove unnecessary double pointer from channel sorting function.
> 
> Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  tools/iio/iio_utils.c | 12 ++++++------
>  tools/iio/iio_utils.h |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 8731905..5b0beea 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -289,17 +289,17 @@ error_free_builtname:
>   * @cnt: the amount of array elements
>   **/
>  
> -void bsort_channel_array_by_index(struct iio_channel_info **ci_array, int cnt)
> +void bsort_channel_array_by_index(struct iio_channel_info *ci_array, int cnt)
>  {
>  	struct iio_channel_info temp;
>  	int x, y;
>  
>  	for (x = 0; x < cnt; x++)
>  		for (y = 0; y < (cnt - 1); y++)
> -			if ((*ci_array)[y].index > (*ci_array)[y + 1].index) {
> -				temp = (*ci_array)[y + 1];
> -				(*ci_array)[y + 1] = (*ci_array)[y];
> -				(*ci_array)[y] = temp;
> +			if (ci_array[y].index > ci_array[y + 1].index) {
> +				temp = ci_array[y + 1];
> +				ci_array[y + 1] = ci_array[y];
> +				ci_array[y] = temp;
>  			}
>  }
>  
> @@ -519,7 +519,7 @@ int build_channel_array(const char *device_dir,
>  
>  	free(scan_el_dir);
>  	/* reorder so that the array is in index order */
> -	bsort_channel_array_by_index(ci_array, *counter);
> +	bsort_channel_array_by_index(*ci_array, *counter);
>  
>  	return 0;
>  
> diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
> index f30a109..e3503bf 100644
> --- a/tools/iio/iio_utils.h
> +++ b/tools/iio/iio_utils.h
> @@ -60,7 +60,7 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>  int iioutils_get_param_float(float *output, const char *param_name,
>  			     const char *device_dir, const char *name,
>  			     const char *generic_name);
> -void bsort_channel_array_by_index(struct iio_channel_info **ci_array, int cnt);
> +void bsort_channel_array_by_index(struct iio_channel_info *ci_array, int cnt);
>  int build_channel_array(const char *device_dir,
>  			struct iio_channel_info **ci_array, int *counter);
>  int find_type_by_name(const char *name, const char *type);
> 

