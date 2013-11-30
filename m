Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48386 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab3K3LNs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 06:13:48 -0500
Message-ID: <5299C868.7060306@kernel.org>
Date: Sat, 30 Nov 2013 11:13:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 13/15] staging:iio:ad7746: Do not store the transfer buffer
 on the stack
References: <1385383327-28181-1-git-send-email-lars@metafoo.de> <1385383327-28181-13-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-13-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 12:42, Lars-Peter Clausen wrote:
> Some I2C controllers might not be able to handle transfer buffers that are
> stored on stack.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/staging/iio/cdc/ad7746.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 01e15e2..cbb1588 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -105,6 +105,11 @@ struct ad7746_chip_info {
>  	u8	vt_setup;
>  	u8	capdac[2][2];
>  	s8	capdac_set;
> +
> +	union {
> +		__be32 d32;
> +		u8 d8[4];
> +	} data ____cacheline_aligned;
>  };
>  
>  enum ad7746_chan {
> @@ -566,11 +571,6 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  	int ret, delay;
>  	u8 regval, reg;
>  
> -	union {
> -		__be32 d32;
> -		u8 d8[4];
> -	} data;
> -
>  	mutex_lock(&indio_dev->mlock);
>  
>  	switch (mask) {
> @@ -591,12 +591,12 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		/* Now read the actual register */
>  
>  		ret = i2c_smbus_read_i2c_block_data(chip->client,
> -			chan->address >> 8, 3, &data.d8[1]);
> +			chan->address >> 8, 3, &chip->data.d8[1]);
>  
>  		if (ret < 0)
>  			goto out;
>  
> -		*val = (be32_to_cpu(data.d32) & 0xFFFFFF) - 0x800000;
> +		*val = (be32_to_cpu(chip->data.d32) & 0xFFFFFF) - 0x800000;
>  
>  		switch (chan->type) {
>  		case IIO_TEMP:
> 
