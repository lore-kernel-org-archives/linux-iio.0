Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59335 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946068AbbHHQ2T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 12:28:19 -0400
Subject: Re: [PATCH 1/7] iio:accel:mma8452: fix _get_hp_filter_index
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1438483410.git.knaack.h@gmx.de>
 <0296b82421da1d80a12a6a153e803585bee43cd4.1438483410.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	martink@posteo.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C62E20.9090202@kernel.org>
Date: Sat, 8 Aug 2015 17:28:16 +0100
MIME-Version: 1.0
In-Reply-To: <0296b82421da1d80a12a6a153e803585bee43cd4.1438483410.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/08/15 21:43, Hartmut Knaack wrote:
> To iterate through the available frequencies of mma8452_hp_filter_cutoff[],
> the array size of a row of that table needs to be provided to
> _get_int_plus_micros_index().
> 
> Fixes: 	1e79841a00e46 ("iio: mma8452: Add highpass filter configuration.")
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git - initially pushed out as testing
etc.
> ---
>  drivers/iio/accel/mma8452.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index e8e2077c7244..245b95fc22be 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -229,7 +229,7 @@ static int mma8452_get_hp_filter_index(struct mma8452_data *data,
>  	int i = mma8452_get_odr_index(data);
>  
>  	return mma8452_get_int_plus_micros_index(mma8452_hp_filter_cutoff[i],
> -		ARRAY_SIZE(mma8452_scales[0]), val, val2);
> +		ARRAY_SIZE(mma8452_hp_filter_cutoff[0]), val, val2);
>  }
>  
>  static int mma8452_read_hp_filter(struct mma8452_data *data, int *hz, int *uHz)
> 

