Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752612AbdHTLFZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 07:05:25 -0400
Date: Sun, 20 Aug 2017 12:00:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2 10/11] iio: adc: ti-ads1015: use
 iio_device_claim_direct_mode()
Message-ID: <20170820120038.075e8903@archlinux>
In-Reply-To: <1500564267-8613-11-git-send-email-akinobu.mita@gmail.com>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
        <1500564267-8613-11-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 21 Jul 2017 00:24:26 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> While the iio buffer for the ti-ads1015 driver is enabled, reading the
> raw ADC channel data is restricted.  We usually use the
> iio_device_claim_direct_mode()/iio_device_release_direct_mode() pair for
> that.
> 
> This change consequently reverses the locking order for the driver's
> private lock and indio_dev->mlock which acquired by
> iio_device_claim_direct_mode() internally. But it's safe because there is
> no other dependency between these locks.
> 
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index da25780..5568be4 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -347,34 +347,34 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>  	int ret, idx;
>  	struct ads1015_data *data = iio_priv(indio_dev);
>  
> -	mutex_lock(&indio_dev->mlock);
>  	mutex_lock(&data->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW: {
>  		int shift = chan->scan_type.shift;
>  
> -		if (iio_buffer_enabled(indio_dev)) {
> -			ret = -EBUSY;
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
>  			break;
> -		}
>  
>  		ret = ads1015_set_power_state(data, true);
>  		if (ret < 0)
> -			break;
> +			goto release_direct;
>  
>  		ret = ads1015_get_adc_result(data, chan->address, val);
>  		if (ret < 0) {
>  			ads1015_set_power_state(data, false);
> -			break;
> +			goto release_direct;
>  		}
>  
>  		*val = sign_extend32(*val >> shift, 15 - shift);
>  
>  		ret = ads1015_set_power_state(data, false);
>  		if (ret < 0)
> -			break;
> +			goto release_direct;
>  
>  		ret = IIO_VAL_INT;
> +release_direct:
> +		iio_device_release_direct_mode(indio_dev);
>  		break;
>  	}
>  	case IIO_CHAN_INFO_SCALE:
> @@ -393,7 +393,6 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>  		break;
>  	}
>  	mutex_unlock(&data->lock);
> -	mutex_unlock(&indio_dev->mlock);
>  
>  	return ret;
>  }

