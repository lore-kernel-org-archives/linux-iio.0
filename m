Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16384 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751781AbcC1Dmm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2016 23:42:42 -0400
Date: Mon, 28 Mar 2016 11:42:33 +0800
From: Denis Ciocca <denis.ciocca@st.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe BARBA <giuseppe.barba@st.com>
Subject: Re: [PATCH 1/4] iio: st_sensors: simplify buffer address handling
Message-ID: <20160328034233.GA5682@beicxl1122>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Linus,

it makes sense to me. Thanks

Acked-by: Denis Ciocca <denis.ciocca@st.com>


On |24 Mar 16 @ 14:18|, Linus Walleij wrote:
> The driver goes to some length to dynamically allocate an array
> to hold the channel addresses. However no ST sensor has more than
> three channels (x, y, z at most). Instead of kmalloc():ing and
> kfree():in the address array, just use a fixed array of three
> elements.
> 
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/common/st_sensors/st_sensors_buffer.c | 28 ++++++-----------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index e18bc6782256..73764961feac 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -24,19 +24,13 @@
>  
>  int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>  {
> -	u8 *addr;
> +	u8 addr[3]; /* no ST sensor has more than 3 channels */
>  	int i, n = 0, len;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  	unsigned int num_data_channels = sdata->num_data_channels;
>  	unsigned int byte_for_channel =
>  			indio_dev->channels[0].scan_type.storagebits >> 3;
>  
> -	addr = kmalloc(num_data_channels, GFP_KERNEL);
> -	if (!addr) {
> -		len = -ENOMEM;
> -		goto st_sensors_get_buffer_element_error;
> -	}
> -
>  	for (i = 0; i < num_data_channels; i++) {
>  		if (test_bit(i, indio_dev->active_scan_mask)) {
>  			addr[n] = indio_dev->channels[i].address;
> @@ -57,10 +51,8 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>  			u8 *rx_array;
>  			rx_array = kmalloc(byte_for_channel * num_data_channels,
>  					   GFP_KERNEL);
> -			if (!rx_array) {
> -				len = -ENOMEM;
> -				goto st_sensors_free_memory;
> -			}
> +			if (!rx_array)
> +				return -ENOMEM;
>  
>  			len = sdata->tf->read_multiple_byte(&sdata->tb,
>  				sdata->dev, addr[0],
> @@ -68,7 +60,7 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>  				rx_array, sdata->multiread_bit);
>  			if (len < 0) {
>  				kfree(rx_array);
> -				goto st_sensors_free_memory;
> +				return len;
>  			}
>  
>  			for (i = 0; i < n * byte_for_channel; i++) {
> @@ -87,17 +79,11 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>  			buf, sdata->multiread_bit);
>  		break;
>  	default:
> -		len = -EINVAL;
> -		goto st_sensors_free_memory;
> -	}
> -	if (len != byte_for_channel * n) {
> -		len = -EIO;
> -		goto st_sensors_free_memory;
> +		return -EINVAL;
>  	}
> +	if (len != byte_for_channel * n)
> +		return -EIO;
>  
> -st_sensors_free_memory:
> -	kfree(addr);
> -st_sensors_get_buffer_element_error:
>  	return len;
>  }
>  EXPORT_SYMBOL(st_sensors_get_buffer_element);
> -- 
> 2.4.3
> 
