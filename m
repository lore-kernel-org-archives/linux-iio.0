Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44532 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508AbcC1JxV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 05:53:21 -0400
Subject: Re: [PATCH 2/6] iio: accel: bmc150: optimize transfers in trigger
 handler
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org
References: <1458811771-25217-1-git-send-email-irina.tirdea@intel.com>
 <1458811771-25217-3-git-send-email-irina.tirdea@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Markus Pargmann <mpa@pengutronix.de>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F8FF0E.9040205@kernel.org>
Date: Mon, 28 Mar 2016 10:53:18 +0100
MIME-Version: 1.0
In-Reply-To: <1458811771-25217-3-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/16 09:29, Irina Tirdea wrote:
> Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
> enable/disable the bus at each i2c transfer and must wait for
> the enable/disable to happen before sending the data.
> 
> When reading data in the trigger handler, the bmc150 accel driver does
> one bus transfer for each axis. This has an impact on the frequency
> of the accelerometer at high sample rates due to additional delays
> introduced by the bus at each transfer.
> 
> Reading all axis values in one bus transfer reduces the delays
> introduced by the bus.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Applied to the togreg branch of iio.git.  Thanks.

There is in theory a potential to slow down obscure cases here, but
what are the chances anyone is actually reading a single axis of
one of these accelerometers and cares about absolute maximum throughput.

Ah well, if they do, they may scream and we'll have to do something 
more complex to keep that case fast.  That would make this code
a lot more ugly so *fingers crossed* :)

Anyhow, I like this series and the underlying emulated reading
patch a lot.

Jonathan
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index cc52366..58df97d 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -989,6 +989,7 @@ static const struct iio_event_spec bmc150_accel_event = {
>  		.realbits = (bits),					\
>  		.storagebits = 16,					\
>  		.shift = 16 - (bits),					\
> +		.endianness = IIO_LE,					\
>  	},								\
>  	.event_spec = &bmc150_accel_event,				\
>  	.num_event_specs = 1						\
> @@ -1114,21 +1115,14 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> -	int bit, ret, i = 0;
> -	unsigned int raw_val;
> +	int ret;
>  
>  	mutex_lock(&data->mutex);
> -	for (bit = 0; bit < AXIS_MAX; bit++) {
> -		ret = regmap_bulk_read(data->regmap,
> -				       BMC150_ACCEL_AXIS_TO_REG(bit), &raw_val,
> -				       2);
> -		if (ret < 0) {
> -			mutex_unlock(&data->mutex);
> -			goto err_read;
> -		}
> -		data->buffer[i++] = raw_val;
> -	}
> +	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
> +			       data->buffer, AXIS_MAX * 2);
>  	mutex_unlock(&data->mutex);
> +	if (ret < 0)
> +		goto err_read;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>  					   pf->timestamp);
> 

