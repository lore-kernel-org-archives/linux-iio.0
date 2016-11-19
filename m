Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46887 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbcKSNIB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Nov 2016 08:08:01 -0500
Subject: Re: [PATCH v2] iio: common: st_sensors: fix channel data parsing
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <1479330928-7208-1-git-send-email-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Linus Walleij <linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c773de82-3e67-871e-93fd-18b3cfe3a492@kernel.org>
Date: Sat, 19 Nov 2016 13:07:58 +0000
MIME-Version: 1.0
In-Reply-To: <1479330928-7208-1-git-send-email-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/11/16 21:15, Lorenzo Bianconi wrote:
> Using realbits as i2c/spi read len, when that value is not byte aligned
> (e.g 12 bits), lead to skip msb part of out data registers.
> Fix this taking into account scan_type.shift in addition to
> scan_type.realbits as read length:
> 
> read_len = DIV_ROUND_UP(realbits + shift, 8)
> 
> This fix has been tested on 8, 12, 16, 24 bit sensors
> 
> Fixes: e7385de5291e ("iio:st_sensors: align on storagebits boundaries")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Do highlight (typically below the --) what changes have occurred.  I'm guessing this
was mostly about testing on the 24 bit sensor and the additions in the core file.

Applied to the fixes-togreg and marked for stable.  I will probably sit on this one
for a few days before sending upstream if anyone has any final comments on it.

Thanks,

Jonathan
> ---
>  drivers/iio/common/st_sensors/st_sensors_buffer.c | 4 +++-
>  drivers/iio/common/st_sensors/st_sensors_core.c   | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index fe7775b..df40452 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -30,7 +30,9 @@ static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>  
>  	for_each_set_bit(i, indio_dev->active_scan_mask, num_data_channels) {
>  		const struct iio_chan_spec *channel = &indio_dev->channels[i];
> -		unsigned int bytes_to_read = channel->scan_type.realbits >> 3;
> +		unsigned int bytes_to_read =
> +			DIV_ROUND_UP(channel->scan_type.realbits +
> +				     channel->scan_type.shift, 8);
>  		unsigned int storage_bytes =
>  			channel->scan_type.storagebits >> 3;
>  
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 975a1f1..d5cf7f3 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -483,8 +483,10 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
>  	int err;
>  	u8 *outdata;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> -	unsigned int byte_for_channel = ch->scan_type.realbits >> 3;
> +	unsigned int byte_for_channel;
>  
> +	byte_for_channel = DIV_ROUND_UP(ch->scan_type.realbits +
> +					ch->scan_type.shift, 8);
>  	outdata = kmalloc(byte_for_channel, GFP_KERNEL);
>  	if (!outdata)
>  		return -ENOMEM;
> 

