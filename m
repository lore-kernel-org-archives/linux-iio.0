Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43934 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416AbcC1ID2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 04:03:28 -0400
Subject: Re: [PATCH 2/4] iio: st_sensors: read each channel individually
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
 <1458825486-17188-2-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F8E550.6040305@kernel.org>
Date: Mon, 28 Mar 2016 09:03:28 +0100
MIME-Version: 1.0
In-Reply-To: <1458825486-17188-2-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/16 13:18, Linus Walleij wrote:
> The current buffer read code tries to optimize reads from the
> sensor data registers by issuing a single read operation across
> all the indata registers.
> 
> This doesn't work: when the LIS331DL accelerometer sensor is
> configured to open drain, active low interrupt mode, this will
> just clear the XDA (X-axis data available) bit in the STATUS_REG
> register (0x27), while YDA, ZDA and even ZYXDA remain set to 1,
> and the internal logic of the sensor holds the DRDY (INT1) line
> asserted (the value of the status register is 0xee).
> 
> If we instead issue one read operation per enabled channel
> (X, Y, Z) things start working and we can use open drain and
> active low interrupts.
Hi Linus,

No problem with the patch itself, but I'd like to get a better
understanding of the issue.  Are we talking a weird hardware 'bug' that
occurs only in these particular circumstances?  Can we pin down which of
the above conditions are necessary to make it not work?

I'd just like to know if this is a fix that needs to go upstream faster
than the open drain support or not.

Thanks,

Jonathan
> 
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/common/st_sensors/st_sensors_buffer.c | 63 +++++------------------
>  1 file changed, 13 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index 73764961feac..2ce0d2a3f855 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -24,67 +24,30 @@
>  
>  int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>  {
> -	u8 addr[3]; /* no ST sensor has more than 3 channels */
> -	int i, n = 0, len;
> +	int i, len;
> +	int total = 0;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  	unsigned int num_data_channels = sdata->num_data_channels;
> -	unsigned int byte_for_channel =
> -			indio_dev->channels[0].scan_type.storagebits >> 3;
>  
>  	for (i = 0; i < num_data_channels; i++) {
> +		unsigned int bytes_to_read;
> +
>  		if (test_bit(i, indio_dev->active_scan_mask)) {
> -			addr[n] = indio_dev->channels[i].address;
> -			n++;
> -		}
> -	}
> -	switch (n) {
> -	case 1:
> -		len = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
> -			addr[0], byte_for_channel, buf, sdata->multiread_bit);
> -		break;
> -	case 2:
> -		if ((addr[1] - addr[0]) == byte_for_channel) {
> +			bytes_to_read = indio_dev->channels[i].scan_type.storagebits >> 3;
>  			len = sdata->tf->read_multiple_byte(&sdata->tb,
> -				sdata->dev, addr[0], byte_for_channel * n,
> -				buf, sdata->multiread_bit);
> -		} else {
> -			u8 *rx_array;
> -			rx_array = kmalloc(byte_for_channel * num_data_channels,
> -					   GFP_KERNEL);
> -			if (!rx_array)
> -				return -ENOMEM;
> +				sdata->dev, indio_dev->channels[i].address,
> +				bytes_to_read,
> +				buf + total, sdata->multiread_bit);
>  
> -			len = sdata->tf->read_multiple_byte(&sdata->tb,
> -				sdata->dev, addr[0],
> -				byte_for_channel * num_data_channels,
> -				rx_array, sdata->multiread_bit);
> -			if (len < 0) {
> -				kfree(rx_array);
> -				return len;
> -			}
> +			if (len < bytes_to_read)
> +				return -EIO;
>  
> -			for (i = 0; i < n * byte_for_channel; i++) {
> -				if (i < n)
> -					buf[i] = rx_array[i];
> -				else
> -					buf[i] = rx_array[n + i];
> -			}
> -			kfree(rx_array);
> -			len = byte_for_channel * n;
> +			/* Advance the buffer pointer */
> +			total += len;
>  		}
> -		break;
> -	case 3:
> -		len = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
> -			addr[0], byte_for_channel * num_data_channels,
> -			buf, sdata->multiread_bit);
> -		break;
> -	default:
> -		return -EINVAL;
>  	}
> -	if (len != byte_for_channel * n)
> -		return -EIO;
>  
> -	return len;
> +	return total;
>  }
>  EXPORT_SYMBOL(st_sensors_get_buffer_element);
>  
> 

