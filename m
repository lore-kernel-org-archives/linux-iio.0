Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59372 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946068AbbHHQbU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 12:31:20 -0400
Subject: Re: [PATCH 4/7] iio:accel:mma8452: check values to be written
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1438483410.git.knaack.h@gmx.de>
 <35eaf1398b5b084bf611a1d5c024d98068531b93.1438483410.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	martink@posteo.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C62ED6.3070403@kernel.org>
Date: Sat, 8 Aug 2015 17:31:18 +0100
MIME-Version: 1.0
In-Reply-To: <35eaf1398b5b084bf611a1d5c024d98068531b93.1438483410.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/08/15 21:43, Hartmut Knaack wrote:
> Check values to be written to the device for valid lower and upper bounds.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.  Thanks.  Note these will be in testing for a short while
if anyone else wants to comment.

J
> ---
>  drivers/iio/accel/mma8452.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 1463392f679c..516b6108d5f8 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -471,15 +471,17 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
>  
>  	switch (info) {
>  	case IIO_EV_INFO_VALUE:
> -		return mma8452_change_config(data, MMA8452_TRANSIENT_THS,
> -					     val & MMA8452_TRANSIENT_THS_MASK);
> +		if (val < 0 || val > MMA8452_TRANSIENT_THS_MASK)
> +			return -EINVAL;
> +
> +		return mma8452_change_config(data, MMA8452_TRANSIENT_THS, val);
>  
>  	case IIO_EV_INFO_PERIOD:
>  		steps = (val * USEC_PER_SEC + val2) /
>  				mma8452_transient_time_step_us[
>  					mma8452_get_odr_index(data)];
>  
> -		if (steps > 0xff)
> +		if (steps < 0 || steps > 0xff)
>  			return -EINVAL;
>  
>  		return mma8452_change_config(data, MMA8452_TRANSIENT_COUNT,
> 

