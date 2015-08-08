Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57951 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097AbbHHLZK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 07:25:10 -0400
Subject: Re: [PATCH v2 7/7] iio:accel:stk8312: drop local buffer
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1438204273.git.knaack.h@gmx.de>
 <f3fe313ea881ad695de6b088b60cd7efbe0cc38d.1438204273.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C5E714.2050009@kernel.org>
Date: Sat, 8 Aug 2015 12:25:08 +0100
MIME-Version: 1.0
In-Reply-To: <f3fe313ea881ad695de6b088b60cd7efbe0cc38d.1438204273.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/07/15 22:39, Hartmut Knaack wrote:
> Drop the local buffer in stk8312_trigger_handler() and use data->buffer
> instead for bulk reads.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/stk8312.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index 39eb9f4ea5c0..c88baabe08e7 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -435,7 +435,6 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct stk8312_data *data = iio_priv(indio_dev);
>  	int bit, ret, i = 0;
> -	u8 buffer[STK8312_ALL_CHANNEL_SIZE];
>  
>  	mutex_lock(&data->lock);
>  	/*
> @@ -446,15 +445,12 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
>  		ret = i2c_smbus_read_i2c_block_data(data->client,
>  						    STK8312_REG_XOUT,
>  						    STK8312_ALL_CHANNEL_SIZE,
> -						    buffer);
> +						    data->buffer);
>  		if (ret < STK8312_ALL_CHANNEL_SIZE) {
>  			dev_err(&data->client->dev, "register read failed\n");
>  			mutex_unlock(&data->lock);
>  			goto err;
>  		}
> -		data->buffer[0] = buffer[0];
> -		data->buffer[1] = buffer[1];
> -		data->buffer[2] = buffer[2];
>  	} else {
>  		for_each_set_bit(bit, indio_dev->active_scan_mask,
>  				 indio_dev->masklength) {
> 

