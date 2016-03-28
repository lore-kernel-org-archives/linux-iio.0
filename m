Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:41901 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046AbcC1Rm6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 28 Mar 2016 13:42:58 -0400
Date: Mon, 28 Mar 2016 19:42:56 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Irina Tirdea <irina.tirdea@intel.com>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 1/1] iio: accel: bmc150: fix endianness when reading
 axes
In-Reply-To: <1459185141-18319-1-git-send-email-irina.tirdea@intel.com>
Message-ID: <alpine.DEB.2.02.1603281937390.4312@pmeerw.net>
References: <1459185141-18319-1-git-send-email-irina.tirdea@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 28 Mar 2016, Irina Tirdea wrote:

> For big endian platforms, reading the axes will return
> invalid values.
> 
> The device stores each axis value in a 16 bit little
> endian register. The driver uses regmap_read_bulk to get
> the axis value, resulting in a 16 bit little endian value.
> This needs to be converted to cpu endianness to work
> on big endian platforms.
> 
> Fix endianness for big endian platforms by converting
> the values for the axes read from little endian to
> cpu.
> 
> This is also partially fixed in commit b6fb9b6d6552 ("iio:
> accel: bmc150: optimize transfers in trigger handler").

looks good

in bmc150_accel_get_axis() the call to regmap_bulk_read() could now pass 
sizeof(raw_val) instead of 2
 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index c73331f7..5b64c3e 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -547,7 +547,7 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
>  {
>  	int ret;
>  	int axis = chan->scan_index;
> -	unsigned int raw_val;
> +	__le16 raw_val;
>  
>  	mutex_lock(&data->mutex);
>  	ret = bmc150_accel_set_power_state(data, true);
> @@ -564,7 +564,7 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
>  		mutex_unlock(&data->mutex);
>  		return ret;
>  	}
> -	*val = sign_extend32(raw_val >> chan->scan_type.shift,
> +	*val = sign_extend32(le16_to_cpu(raw_val) >> chan->scan_type.shift,
>  			     chan->scan_type.realbits - 1);
>  	ret = bmc150_accel_set_power_state(data, false);
>  	mutex_unlock(&data->mutex);
> @@ -988,6 +988,7 @@ static const struct iio_event_spec bmc150_accel_event = {
>  		.realbits = (bits),					\
>  		.storagebits = 16,					\
>  		.shift = 16 - (bits),					\
> +		.endianness = IIO_LE,					\
>  	},								\
>  	.event_spec = &bmc150_accel_event,				\
>  	.num_event_specs = 1						\
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
