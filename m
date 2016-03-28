Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44558 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbcC1J5E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 05:57:04 -0400
Subject: Re: [PATCH 4/6] iio: accel: bmg160: optimize transfers in trigger
 handler
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org
References: <1458811771-25217-1-git-send-email-irina.tirdea@intel.com>
 <1458811771-25217-5-git-send-email-irina.tirdea@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Markus Pargmann <mpa@pengutronix.de>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F8FFED.2090703@kernel.org>
Date: Mon, 28 Mar 2016 10:57:01 +0100
MIME-Version: 1.0
In-Reply-To: <1458811771-25217-5-git-send-email-irina.tirdea@intel.com>
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
I forgot to highlight on the earlier driver that there is also 'technically'
a bit of an ABI change here because we are now exporting as LE rather than CPU
order.  However, I 'hope' anyone actually accessing the buffered data is either
doing it through a nice library or hasn't hacked the endian unwinding out of
the generic_buffer example!

Again, fingers crossed this doesn't break anything significant.

Applied,

Thanks,

Jonathan
> ---
>  drivers/iio/gyro/bmg160_core.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 8d6e5b1..43570b8 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -734,6 +734,7 @@ static const struct iio_event_spec bmg160_event = {
>  		.sign = 's',						\
>  		.realbits = 16,					\
>  		.storagebits = 16,					\
> +		.endianness = IIO_LE,					\
>  	},								\
>  	.event_spec = &bmg160_event,					\
>  	.num_event_specs = 1						\
> @@ -773,20 +774,14 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct bmg160_data *data = iio_priv(indio_dev);
> -	int bit, ret, i = 0;
> -	unsigned int val;
> +	int ret;
>  
>  	mutex_lock(&data->mutex);
> -	for (bit = 0; bit < AXIS_MAX; bit++) {
> -		ret = regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(bit),
> -				       &val, 2);
> -		if (ret < 0) {
> -			mutex_unlock(&data->mutex);
> -			goto err;
> -		}
> -		data->buffer[i++] = ret;
> -	}
> +	ret = regmap_bulk_read(data->regmap, BMG160_REG_XOUT_L,
> +			       data->buffer, AXIS_MAX * 2);
>  	mutex_unlock(&data->mutex);
> +	if (ret < 0)
> +		goto err;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>  					   pf->timestamp);
> 

