Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59355 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946068AbbHHQaG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 12:30:06 -0400
Subject: Re: [PATCH 3/7] iio:accel:mma8452: pass up real error code
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1438483410.git.knaack.h@gmx.de>
 <cbf8195dee344145ca006a09650ba0da10613c09.1438483410.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	martink@posteo.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C62E8C.5040407@kernel.org>
Date: Sat, 8 Aug 2015 17:30:04 +0100
MIME-Version: 1.0
In-Reply-To: <cbf8195dee344145ca006a09650ba0da10613c09.1438483410.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/08/15 21:43, Hartmut Knaack wrote:
> Pass up the error code provided by functions.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied
> ---
>  drivers/iio/accel/mma8452.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 153f26bc88dc..1463392f679c 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -343,7 +343,7 @@ static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
>  
>  	i = mma8452_get_hp_filter_index(data, val, val2);
>  	if (i < 0)
> -		return -EINVAL;
> +		return i;
>  
>  	reg = i2c_smbus_read_byte_data(data->client,
>  				       MMA8452_HP_FILTER_CUTOFF);
> @@ -369,7 +369,7 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		i = mma8452_get_samp_freq_index(data, val, val2);
>  		if (i < 0)
> -			return -EINVAL;
> +			return i;
>  
>  		data->ctrl_reg1 &= ~MMA8452_CTRL_DR_MASK;
>  		data->ctrl_reg1 |= i << MMA8452_CTRL_DR_SHIFT;
> @@ -378,7 +378,7 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		i = mma8452_get_scale_index(data, val, val2);
>  		if (i < 0)
> -			return -EINVAL;
> +			return i;
>  		data->data_cfg &= ~MMA8452_DATA_CFG_FS_MASK;
>  		data->data_cfg |= i;
>  		return mma8452_change_config(data, MMA8452_DATA_CFG,
> 

