Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35850 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009AbbFAVRH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:17:07 -0400
Message-ID: <556C33D7.7090703@kernel.org>
Date: Mon, 01 Jun 2015 11:28:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: Always compute masklength
References: <1432916062-15195-1-git-send-email-lars@metafoo.de> <1432916062-15195-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1432916062-15195-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/05/15 17:14, Lars-Peter Clausen wrote:
> Even if no userspace consumer buffer is attached to the IIO device at
> registration we still need to compute the masklength, since it is possible
> that a in-kernel consumer buffer is going to get attached to the device at
> a later point.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Not sure we actually have this condition as of yet, but I guess it 'might'
occur.  Certainly would be good to allow for IIO devices without an
IIO 'front end' in the future.
> ---
>  drivers/iio/industrialio-buffer.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 1129125..a72db00 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -968,6 +968,15 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  	int ret, i, attrn, attrcount, attrcount_orig = 0;
>  	const struct iio_chan_spec *channels;
>  
> +	channels = indio_dev->channels;
> +	if (channels) {
> +		int ml = indio_dev->masklength;
> +
> +		for (i = 0; i < indio_dev->num_channels; i++)
> +			ml = max(ml, channels[i].scan_index + 1);
> +		indio_dev->masklength = ml;
> +	}
> +
>  	if (!buffer)
>  		return 0;
>  
> @@ -1011,12 +1020,6 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  			if (channels[i].scan_index < 0)
>  				continue;
>  
> -			/* Establish necessary mask length */
> -			if (channels[i].scan_index >
> -			    (int)indio_dev->masklength - 1)
> -				indio_dev->masklength
> -					= channels[i].scan_index + 1;
> -
>  			ret = iio_buffer_add_channel_sysfs(indio_dev,
>  							 &channels[i]);
>  			if (ret < 0)
> 

