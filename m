Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49021 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbcDCKRv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Apr 2016 06:17:51 -0400
Subject: Re: [PATCH v2 1/1] iio: accel: bmc150: fix endianness when reading
 axes
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org
References: <1459254945-2012-1-git-send-email-irina.tirdea@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5700EDCD.7030909@kernel.org>
Date: Sun, 3 Apr 2016 11:17:49 +0100
MIME-Version: 1.0
In-Reply-To: <1459254945-2012-1-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/03/16 13:35, Irina Tirdea wrote:
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
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Applied to the fixes-togreg-post-rc1 branch of iio.git and marked for
stable.
> ---
> 
> Changes from v1:
>  - pass sizeof(raw_val) to regmap_bulk_read instead of
> hardcoded value
> 
>  drivers/iio/accel/bmc150-accel-core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index c73331f7..2072a31 100644
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
> @@ -557,14 +557,14 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
>  	}
>  
>  	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(axis),
> -			       &raw_val, 2);
> +			       &raw_val, sizeof(raw_val));
>  	if (ret < 0) {
>  		dev_err(data->dev, "Error reading axis %d\n", axis);
>  		bmc150_accel_set_power_state(data, false);
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

