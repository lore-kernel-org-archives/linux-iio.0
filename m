Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50507 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752593AbcL3Krf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 05:47:35 -0500
Subject: Re: [PATCH v2 4/6] iio: bmi160: Protect data transmission with mutex
To: Marcin Niestroj <m.niestroj@grinn-global.com>
References: <20161208142259.26230-1-m.niestroj@grinn-global.com>
 <20161208142259.26230-5-m.niestroj@grinn-global.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <38885189-27b9-4420-1c28-dfd33eb5ac1f@kernel.org>
Date: Fri, 30 Dec 2016 10:47:31 +0000
MIME-Version: 1.0
In-Reply-To: <20161208142259.26230-5-m.niestroj@grinn-global.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/12/16 14:22, Marcin Niestroj wrote:
> There are currently two possible cases for data transmission with the
> sensor: read/write by iio sysfs and read in trigger interrupt
> handler. Hence we need to protect data transmission using regmap_*
> functions with mutex.

Except that the regmap functions themselves have build in protection against
any such clashes.  Hence I don't 'think' this is necessary as we don't
have any open coded read / update loops in here that I can see.

Jonathan
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---
> Patch introduced in v2
> 
>  drivers/iio/imu/bmi160/bmi160_core.c | 39 +++++++++++++++++++++++++++++-------
>  1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index e0251b8..095533c 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -2,6 +2,7 @@
>   * BMI160 - Bosch IMU (accel, gyro plus external magnetometer)
>   *
>   * Copyright (c) 2016, Intel Corporation.
> + * Copyright (c) 2016, Grinn
>   *
>   * This file is subject to the terms and conditions of version 2 of
>   * the GNU General Public License.  See the file COPYING in the main
> @@ -112,6 +113,7 @@ enum bmi160_sensor_type {
>  
>  struct bmi160_data {
>  	struct regmap *regmap;
> +	struct mutex mutex;
>  };
>  
>  const struct regmap_config bmi160_regmap_config = {
> @@ -285,7 +287,9 @@ int bmi160_set_mode(struct bmi160_data *data, enum bmi160_sensor_type t,
>  	else
>  		cmd = bmi160_regs[t].pmu_cmd_suspend;
>  
> +	mutex_lock(&data->mutex);
>  	ret = regmap_write(data->regmap, BMI160_REG_CMD, cmd);
> +	mutex_unlock(&data->mutex);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -298,6 +302,7 @@ static
>  int bmi160_set_scale(struct bmi160_data *data, enum bmi160_sensor_type t,
>  		     int uscale)
>  {
> +	int ret;
>  	int i;
>  
>  	for (i = 0; i < bmi160_scale_table[t].num; i++)
> @@ -307,8 +312,12 @@ int bmi160_set_scale(struct bmi160_data *data, enum bmi160_sensor_type t,
>  	if (i == bmi160_scale_table[t].num)
>  		return -EINVAL;
>  
> -	return regmap_write(data->regmap, bmi160_regs[t].range,
> -			    bmi160_scale_table[t].tbl[i].bits);
> +	mutex_lock(&data->mutex);
> +	ret = regmap_write(data->regmap, bmi160_regs[t].range,
> +			   bmi160_scale_table[t].tbl[i].bits);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
>  }
>  
>  static
> @@ -317,7 +326,9 @@ int bmi160_get_scale(struct bmi160_data *data, enum bmi160_sensor_type t,
>  {
>  	int i, ret, val;
>  
> +	mutex_lock(&data->mutex);
>  	ret = regmap_read(data->regmap, bmi160_regs[t].range, &val);
> +	mutex_unlock(&data->mutex);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -340,7 +351,9 @@ static int bmi160_get_data(struct bmi160_data *data, int chan_type,
>  
>  	reg = bmi160_regs[t].data + (axis - IIO_MOD_X) * sizeof(__le16);
>  
> +	mutex_lock(&data->mutex);
>  	ret = regmap_bulk_read(data->regmap, reg, &sample, sizeof(__le16));
> +	mutex_unlock(&data->mutex);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -353,6 +366,7 @@ static
>  int bmi160_set_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
>  		   int odr, int uodr)
>  {
> +	int ret;
>  	int i;
>  
>  	for (i = 0; i < bmi160_odr_table[t].num; i++)
> @@ -363,10 +377,14 @@ int bmi160_set_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
>  	if (i >= bmi160_odr_table[t].num)
>  		return -EINVAL;
>  
> -	return regmap_update_bits(data->regmap,
> -				  bmi160_regs[t].config,
> -				  bmi160_regs[t].config_odr_mask,
> -				  bmi160_odr_table[t].tbl[i].bits);
> +	mutex_lock(&data->mutex);
> +	ret = regmap_update_bits(data->regmap,
> +				 bmi160_regs[t].config,
> +				 bmi160_regs[t].config_odr_mask,
> +				 bmi160_odr_table[t].tbl[i].bits);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
>  }
>  
>  static int bmi160_get_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
> @@ -374,7 +392,9 @@ static int bmi160_get_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
>  {
>  	int i, val, ret;
>  
> +	mutex_lock(&data->mutex);
>  	ret = regmap_read(data->regmap, bmi160_regs[t].config, &val);
> +	mutex_unlock(&data->mutex);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -402,14 +422,18 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>  	int i, ret, j = 0, base = BMI160_REG_DATA_MAGN_XOUT_L;
>  	__le16 sample;
>  
> +	mutex_lock(&data->mutex);
>  	for_each_set_bit(i, indio_dev->active_scan_mask,
>  			 indio_dev->masklength) {
>  		ret = regmap_bulk_read(data->regmap, base + i * sizeof(__le16),
>  				       &sample, sizeof(__le16));
> -		if (ret < 0)
> +		if (ret < 0) {
> +			mutex_unlock(&data->mutex);
>  			goto done;
> +		}
>  		buf[j++] = sample;
>  	}
> +	mutex_unlock(&data->mutex);
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, buf,
>  					   iio_get_time_ns(indio_dev));
> @@ -575,6 +599,7 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  	data = iio_priv(indio_dev);
>  	dev_set_drvdata(dev, indio_dev);
>  	data->regmap = regmap;
> +	mutex_init(&data->mutex);
>  
>  	ret = bmi160_chip_init(data, use_spi);
>  	if (ret < 0)
> 

