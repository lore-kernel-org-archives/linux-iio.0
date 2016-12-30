Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52601 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbcL3Sb3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 13:31:29 -0500
Subject: Re: [PATCH] Revert "iio:st_sensors: align on storagebits boundaries"
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <20161230173620.30851-1-linus.walleij@linaro.org>
Cc: stable@vger.kernel.org, Gregor Boirie <gregor.boirie@parrot.com>,
        Giuseppe Barba <giuseppe.barba@st.com>,
        Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7ccb6107-d7af-2240-5000-800d3cd64205@kernel.org>
Date: Fri, 30 Dec 2016 18:31:26 +0000
MIME-Version: 1.0
In-Reply-To: <20161230173620.30851-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/12/16 17:36, Linus Walleij wrote:
> This reverts commit e7385de5291e347f5bc85985acdce3a3f5096667.
> 
> This change is bad, because it breaks all 12bit sensors and
> breaks userspace such as iio_generic_buffer.
> 
> The commit computes the number of bytes to read out from the
> hardware like this:
> 
> unsigned int bytes_to_read = channel->scan_type.realbits >> 3;
> 
> This works fine with 8 or 16 bit channels resulting in 1 or
> 2 bytes to read respectively.
> 
> But when using this with 12bit sensors such as the LIS3LV02
> this fails since 12 >> 3 = 1 but we need to read 2 bytes!
> Unless we do this, the DRDY signal does not go low and the
> status loop just spins.
> 
> Further, it packs all bytes in the buffer to make it "dense".
> Even if I try to fix the above by using DIV_ROUND_UP(),
> it will result in erroneous data in the buffer for 12bit
> sensors, since the macro ST_SENSORS_LSM_CHANNELS() used by
> all sensors defines scan type shift, storagebits and realbits
> such that the userspace like iio_generic_buffer will read
> 2 bytes, then shift it by 4. This will not work anymore after
> this patch.
> 
> I do not understand the point of the original commit, I
> suggest this be reverted for now.
It's required for 24 bit sensors which were previously broken if
you had a 24 bit channel with anything much after it.

We do have a full fix keeping those working as well, but it was stalled
on getting some actual tests on 24 bit devices (not many people have them).

It's the last (and infact only fix) in my fixes-togreg branch.

iio: common: st_sensors: fix channel data parsing

With combination of end of year / xmas plus merge window I haven't gotten it
out yet. Will fix that in the next day or so.

Could you test and see if it fixes what you are seeing?
At least superficially sounds like the same issue.

Thanks,

Jonathan
> Fixes: e7385de5291e ("iio:st_sensors: align on storagebits boundaries")
> Cc: stable@vger.kernel.org
> Cc: Gregor Boirie <gregor.boirie@parrot.com>
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/common/st_sensors/st_sensors_buffer.c | 37 ++++++++++++-----------
>  drivers/iio/common/st_sensors/st_sensors_core.c   |  2 +-
>  2 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index fe7775bb3740..3c964a106afa 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -24,29 +24,30 @@
>  
>  static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>  {
> -	int i;
> +	int i, len;
> +	int total = 0;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  	unsigned int num_data_channels = sdata->num_data_channels;
>  
> -	for_each_set_bit(i, indio_dev->active_scan_mask, num_data_channels) {
> -		const struct iio_chan_spec *channel = &indio_dev->channels[i];
> -		unsigned int bytes_to_read = channel->scan_type.realbits >> 3;
> -		unsigned int storage_bytes =
> -			channel->scan_type.storagebits >> 3;
> -
> -		buf = PTR_ALIGN(buf, storage_bytes);
> -		if (sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
> -						  channel->address,
> -						  bytes_to_read, buf,
> -						  sdata->multiread_bit) <
> -		    bytes_to_read)
> -			return -EIO;
> -
> -		/* Advance the buffer pointer */
> -		buf += storage_bytes;
> +	for (i = 0; i < num_data_channels; i++) {
> +		unsigned int bytes_to_read;
> +
> +		if (test_bit(i, indio_dev->active_scan_mask)) {
> +			bytes_to_read = indio_dev->channels[i].scan_type.storagebits >> 3;
> +			len = sdata->tf->read_multiple_byte(&sdata->tb,
> +				sdata->dev, indio_dev->channels[i].address,
> +				bytes_to_read,
> +				buf + total, sdata->multiread_bit);
> +
> +			if (len < bytes_to_read)
> +				return -EIO;
> +
> +			/* Advance the buffer pointer */
> +			total += len;
> +		}
>  	}
>  
> -	return 0;
> +	return total;
>  }
>  
>  irqreturn_t st_sensors_trigger_handler(int irq, void *p)
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 975a1f19f747..4abe8aca1b29 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -483,7 +483,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
>  	int err;
>  	u8 *outdata;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> -	unsigned int byte_for_channel = ch->scan_type.realbits >> 3;
> +	unsigned int byte_for_channel = ch->scan_type.storagebits >> 3;
>  
>  	outdata = kmalloc(byte_for_channel, GFP_KERNEL);
>  	if (!outdata)
> 

