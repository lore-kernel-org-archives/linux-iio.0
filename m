Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36186 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbcGDRJ7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2016 13:09:59 -0400
Subject: Re: [PATCH v2 1/7] iio:st_sensors: align on storagebits boundaries
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1467023672.git.gregor.boirie@parrot.com>
 <84d1a2b1b2a9cb8700f5cd446f4146d8e07a7a3c.1467023672.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6c99637f-b7b5-f9c5-9824-5206343637e6@kernel.org>
Date: Mon, 4 Jul 2016 18:09:56 +0100
MIME-Version: 1.0
In-Reply-To: <84d1a2b1b2a9cb8700f5cd446f4146d8e07a7a3c.1467023672.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/06/16 11:38, Gregor Boirie wrote:
> Ensure triggered buffering memory accesses are properly aligned on per
> channel storagebits boundaries.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Applied to the togreg branch of iio.git - initially pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/common/st_sensors/st_sensors_buffer.c | 37 +++++++++++------------
>  drivers/iio/common/st_sensors/st_sensors_core.c   |  2 +-
>  2 files changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index 50afc0f..d766643 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -24,30 +24,29 @@
>  
>  static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>  {
> -	int i, len;
> -	int total = 0;
> +	int i;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  	unsigned int num_data_channels = sdata->num_data_channels;
>  
> -	for (i = 0; i < num_data_channels; i++) {
> -		unsigned int bytes_to_read;
> -
> -		if (test_bit(i, indio_dev->active_scan_mask)) {
> -			bytes_to_read = indio_dev->channels[i].scan_type.storagebits >> 3;
> -			len = sdata->tf->read_multiple_byte(&sdata->tb,
> -				sdata->dev, indio_dev->channels[i].address,
> -				bytes_to_read,
> -				buf + total, sdata->multiread_bit);
> -
> -			if (len < bytes_to_read)
> -				return -EIO;
> -
> -			/* Advance the buffer pointer */
> -			total += len;
> -		}
> +	for_each_set_bit(i, indio_dev->active_scan_mask, num_data_channels) {
> +		const struct iio_chan_spec *channel = &indio_dev->channels[i];
> +		unsigned int bytes_to_read = channel->scan_type.realbits >> 3;
> +		unsigned int storage_bytes =
> +			channel->scan_type.storagebits >> 3;
> +
> +		buf = PTR_ALIGN(buf, storage_bytes);
> +		if (sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
> +						  channel->address,
> +						  bytes_to_read, buf,
> +						  sdata->multiread_bit) <
> +		    bytes_to_read)
> +			return -EIO;
> +
> +		/* Advance the buffer pointer */
> +		buf += storage_bytes;
>  	}
>  
> -	return total;
> +	return 0;
>  }
>  
>  irqreturn_t st_sensors_trigger_handler(int irq, void *p)
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 6db12ea..df9d5e8 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -490,7 +490,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
>  	int err;
>  	u8 *outdata;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> -	unsigned int byte_for_channel = ch->scan_type.storagebits >> 3;
> +	unsigned int byte_for_channel = ch->scan_type.realbits >> 3;
>  
>  	outdata = kmalloc(byte_for_channel, GFP_KERNEL);
>  	if (!outdata)
> 

