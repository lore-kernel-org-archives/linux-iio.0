Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33389 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244AbcE2QFs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 12:05:48 -0400
Subject: Re: [PATCH v2 1/7] iio: inv_mpu6050: Do burst reads using spi/i2c
 directly
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <cover.1463582011.git.leonard.crestez@intel.com>
 <b4ba111a1e33f60ed4d3d21421c3250243d40fba.1463582011.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Ge Gao <ggao@invensense.com>, Peter Rosin <peda@axentia.se>,
	linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cb6859f3-f3ac-68c8-2172-844a4b4b2f40@kernel.org>
Date: Sun, 29 May 2016 17:05:44 +0100
MIME-Version: 1.0
In-Reply-To: <b4ba111a1e33f60ed4d3d21421c3250243d40fba.1463582011.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/05/16 16:00, Crestez Dan Leonard wrote:
> Using regmap_read_bulk is wrong because it assumes that a range of
> registers is being read. In our case reading from the fifo register will
> return multiple values but this is *not* auto-increment.
> 
> This currently works by accident.
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
I'd really prefer to see this in the regmap core.  It really doesn't look like
it will be hard to do.  Basically it's just an cut and paste job from
regmap_bulk_read.

1. Check the register in question is volatile - anything else would be bonkers.
2. The emulation of bulk reads relies on volatile or no caching anyway.


However, that will probably take a while, so I suppose we might want to take this
in the meantime as a fix - be it not a terribly urgent one as you observe it
works by accident at the moment.

Clearly it will be needed for your regcache support though.
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 33 ++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index d070062..8455af0 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -21,6 +21,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kfifo.h>
>  #include <linux/poll.h>
> +#include <linux/spi/spi.h>
>  #include "inv_mpu_iio.h"
>  
>  static void inv_clear_kfifo(struct inv_mpu6050_state *st)
> @@ -128,6 +129,13 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	u16 fifo_count;
>  	s64 timestamp;
>  
> +	struct device *regmap_dev = regmap_get_device(st->map);
> +	struct i2c_client *i2c;
> +	struct spi_device *spi = NULL;
> +
> +	i2c = i2c_verify_client(regmap_dev);
> +	spi = i2c ? NULL: to_spi_device(regmap_dev);
> +
>  	mutex_lock(&indio_dev->mlock);
>  	if (!(st->chip_config.accl_fifo_enable |
>  		st->chip_config.gyro_fifo_enable))
> @@ -160,10 +168,27 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	    fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
>  		goto flush_fifo;
>  	while (fifo_count >= bytes_per_datum) {
> -		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
> -					  data, bytes_per_datum);
> -		if (result)
> -			goto flush_fifo;
> +		/*
> +		 * We need to do a large burst read from a single register.
> +		 *
> +		 * regmap_read_bulk assumes that multiple registers are
> +		 * involved but in our case st->reg->fifo_r_w + 1 is something
> +		 * completely unrelated.
> +		 */
> +		if (spi) {
> +			u8 cmd = st->reg->fifo_r_w | 0x80;
> +			result = spi_write_then_read(spi,
> +					&cmd, 1,
> +					data, bytes_per_datum);
> +			if (result)
> +				goto flush_fifo;
> +		} else {
> +			result = i2c_smbus_read_i2c_block_data(i2c,
> +					st->reg->fifo_r_w,
> +					bytes_per_datum, data);
> +			if (result != bytes_per_datum)
> +				goto flush_fifo;
> +		}
>  
>  		result = kfifo_out(&st->timestamps, &timestamp, 1);
>  		/* when there is no timestamp, put timestamp as 0 */
> 

