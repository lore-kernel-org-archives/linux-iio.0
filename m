Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:63715 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbbGXTT4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 24 Jul 2015 15:19:56 -0400
Message-ID: <55B28FD6.6080305@gmx.de>
Date: Fri, 24 Jul 2015 21:19:50 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Joo Aun Saw <jasaw@dius.com.au>, linux-iio@vger.kernel.org
CC: jic23@kernel.org
Subject: Re: [PATCH 2/2] tools: iio: remove unnecessary double pointer
References: <1437751409-28837-1-git-send-email-jasaw@dius.com.au> <1437751409-28837-3-git-send-email-jasaw@dius.com.au>
In-Reply-To: <1437751409-28837-3-git-send-email-jasaw@dius.com.au>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Joo Aun Saw schrieb am 24.07.2015 um 17:23:
> From: Joo Aun Saw <jasaw@dius.com.au>
> 
> Remove unnecessary double pointer from channel sorting function.

That is not really unnecessary. The way you propose expresses that
ci_array would be a pointer to an element of type iio_channel_info. But
what we want ci_array to be is a pointer to an array of elements
of type iio_channel_info.
Not sure if this is a good explanation.

> 
> Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
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

