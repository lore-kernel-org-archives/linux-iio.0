Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44497 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbcJANaD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 09:30:03 -0400
Subject: Re: [PATCH] iio: common: st_sensors: fix channel data parsing
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <1475093161-7239-1-git-send-email-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com,
        denis.ciocca@st.com, Gregor Boirie <gregor.boirie@parrot.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <45809aef-5396-90fa-1312-677eaeec36da@kernel.org>
Date: Sat, 1 Oct 2016 14:30:00 +0100
MIME-Version: 1.0
In-Reply-To: <1475093161-7239-1-git-send-email-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/09/16 21:06, Lorenzo Bianconi wrote:
> Using realbits as i2c/spi read len, when that value is not byte aligned
> (e.g 12 bits), lead to skip msb part of out data registers.
> Fix this using storagebits as read length
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Hi Lorenzo,

This would ideally have had a fixes tag.

I think it was
Fixes: e7385de5 ("iio:st_sensors: align on storagebits boundaries")
Doing that would also have lead to you to the logic that lead to
this buggy change in the first place. Would also have shown
you that there is another place that probably suffers from the
same sort of issue.

Gregor can you take a look at this please.

If I recall the issue that lead to the original patch it was
that we were miss handling 24 bit values on pressure sensors and
this was intended to pad them?

I think the 'right' fix will be something along the lines of:
unsigned int bytes_to_read = (channel->scan_type.realbits + 7) >> 3;

Should give 2 bytes for a 12 bit and still the 3 bytes needed for a
24 bit read.

Thanks,

Jonathan
> ---
>  drivers/iio/common/st_sensors/st_sensors_buffer.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index fe7775b..d01aa34 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -30,16 +30,15 @@ static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>  
>  	for_each_set_bit(i, indio_dev->active_scan_mask, num_data_channels) {q
>  		const struct iio_chan_spec *channel = &indio_dev->channels[i];
> -		unsigned int bytes_to_read = channel->scan_type.realbits >> 3;
>  		unsigned int storage_bytes =
>  			channel->scan_type.storagebits >> 3;
>  
>  		buf = PTR_ALIGN(buf, storage_bytes);
>  		if (sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
>  						  channel->address,
> -						  bytes_to_read, buf,
> +						  storage_bytes, buf,
>  						  sdata->multiread_bit) <
> -		    bytes_to_read)
> +		    storage_bytes)
>  			return -EIO;
>  
>  		/* Advance the buffer pointer */
> 

