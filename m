Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59272 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703AbbGEMGr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 08:06:47 -0400
Message-ID: <55991DD4.2020005@kernel.org>
Date: Sun, 05 Jul 2015 13:06:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>,
	Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org
CC: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 4/8] iio: accel: bmc150: optimize i2c transfers in
 trigger handler
References: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com> <1435916017-12859-5-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1435916017-12859-5-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/15 10:33, Irina Tirdea wrote:
> Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
> enable/disable the bus at each i2c transfer and must wait for
> the enable/disable to happen before sending the data.
> 
> When reading data in the trigger handler, the bmc150 accel driver does
> one i2c transfer for each axis. This has an impact on the frequency
> of the accelerometer at high sample rates due to additional delays
> introduced by the i2c bus at each transfer.
> 
> Reading all axis values in one i2c transfer reduces the delays
> introduced by the i2c bus. Uses i2c_smbus_read_i2c_block_data_or_emulated
> that will fallback to reading each axis as a separate word in case i2c
> block read is not supported.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Very nice.  There is an effective userspace ABI change, but if people
are using the ABI wrong, then it's kind of their own fault!
I'll assume Wolfram will pick these up if / when he is happy with the
new function. 

Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/accel/bmc150-accel.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index c6c8416..e686add 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -1082,6 +1082,7 @@ static const struct iio_event_spec bmc150_accel_event = {
>  		.realbits = (bits),					\
>  		.storagebits = 16,					\
>  		.shift = 16 - (bits),					\
> +		.endianness = IIO_LE,					\
Hmm. ABI change of a sort.  Should be fine if userspace is doing things right, but
never a whole lot of certainty about that.  Lets see if anyone screams...
>  	},								\
>  	.event_spec = &bmc150_accel_event,				\
>  	.num_event_specs = 1						\
> @@ -1209,19 +1210,16 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> -	int bit, ret, i = 0;
> +	int ret;
>  
>  	mutex_lock(&data->mutex);
> -	for (bit = 0; bit < AXIS_MAX; bit++) {
> -		ret = i2c_smbus_read_word_data(data->client,
> -					       BMC150_ACCEL_AXIS_TO_REG(bit));
> -		if (ret < 0) {
> -			mutex_unlock(&data->mutex);
> -			goto err_read;
> -		}
> -		data->buffer[i++] = ret;
> -	}
> +	ret = i2c_smbus_read_i2c_block_data_or_emulated(data->client,
> +							BMC150_ACCEL_REG_XOUT_L,
> +							AXIS_MAX * 2,
> +							(u8 *)data->buffer);
>  	mutex_unlock(&data->mutex);
> +	if (ret < 0)
> +		goto err_read;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>  					   data->timestamp);
> 

