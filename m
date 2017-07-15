Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751172AbdGOL4z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Jul 2017 07:56:55 -0400
Date: Sat, 15 Jul 2017 12:56:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/5] iio: imu: inv_mpu6050: use devm_* at init and
 delete remove functions
Message-ID: <20170715125654.62c5f634@kernel.org>
In-Reply-To: <CY4PR1201MB0184A0905790DCD20C76249AC4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <CY4PR1201MB0184A0905790DCD20C76249AC4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 13 Jul 2017 13:33:01 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Use devm_* for iio_triggered_buffer_setup, iio_device_register,
> iio_trigger_register. Delete unneeded inv_mpu6050_remove_trigger,
> inv_mpu_core_remove, and inv_mpu_remove for spi driver.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Looks good to me.  Will pickup when the other patches are sorted.

J
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 32 ++++++---------------------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 12 ++++------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 --
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  6 -----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  7 +-----
>  5 files changed, 12 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 6f36878..3af5877 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -956,10 +956,10 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  	indio_dev->info = &mpu_info;
>  	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
>  
> -	result = iio_triggered_buffer_setup(indio_dev,
> -					    inv_mpu6050_irq_handler,
> -					    inv_mpu6050_read_fifo,
> -					    NULL);
> +	result = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						 inv_mpu6050_irq_handler,
> +						 inv_mpu6050_read_fifo,
> +						 NULL);
>  	if (result) {
>  		dev_err(dev, "configure buffer fail %d\n", result);
>  		return result;
> @@ -967,39 +967,21 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  	result = inv_mpu6050_probe_trigger(indio_dev);
>  	if (result) {
>  		dev_err(dev, "trigger probe fail %d\n", result);
> -		goto out_unreg_ring;
> +		return result;
>  	}
>  
>  	INIT_KFIFO(st->timestamps);
>  	spin_lock_init(&st->time_stamp_lock);
> -	result = iio_device_register(indio_dev);
> +	result = devm_iio_device_register(dev, indio_dev);
>  	if (result) {
>  		dev_err(dev, "IIO register fail %d\n", result);
> -		goto out_remove_trigger;
> +		return result;
>  	}
>  
>  	return 0;
> -
> -out_remove_trigger:
> -	inv_mpu6050_remove_trigger(st);
> -out_unreg_ring:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	return result;
>  }
>  EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
>  
> -int inv_mpu_core_remove(struct device  *dev)
> -{
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -
> -	iio_device_unregister(indio_dev);
> -	inv_mpu6050_remove_trigger(iio_priv(indio_dev));
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(inv_mpu_core_remove);
> -
>  #ifdef CONFIG_PM_SLEEP
>  
>  static int inv_mpu_resume(struct device *dev)
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 6ac5375..d18604b 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -125,14 +125,12 @@ static int inv_mpu_probe(struct i2c_client *client,
>  				 1, 0, I2C_MUX_LOCKED | I2C_MUX_GATE,
>  				 inv_mpu6050_select_bypass,
>  				 inv_mpu6050_deselect_bypass);
> -	if (!st->muxc) {
> -		result = -ENOMEM;
> -		goto out_unreg_device;
> -	}
> +	if (!st->muxc)
> +		return -ENOMEM;
>  	st->muxc->priv = dev_get_drvdata(&client->dev);
>  	result = i2c_mux_add_adapter(st->muxc, 0, 0, 0);
>  	if (result)
> -		goto out_unreg_device;
> +		return result;
>  
>  	result = inv_mpu_acpi_create_mux_client(client);
>  	if (result)
> @@ -142,8 +140,6 @@ static int inv_mpu_probe(struct i2c_client *client,
>  
>  out_del_mux:
>  	i2c_mux_del_adapters(st->muxc);
> -out_unreg_device:
> -	inv_mpu_core_remove(&client->dev);
>  	return result;
>  }
>  
> @@ -155,7 +151,7 @@ static int inv_mpu_remove(struct i2c_client *client)
>  	inv_mpu_acpi_delete_mux_client(client);
>  	i2c_mux_del_adapters(st->muxc);
>  
> -	return inv_mpu_core_remove(&client->dev);
> +	return 0;
>  }
>  
>  /*
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index c3d6225..f680d00 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -288,7 +288,6 @@ enum inv_mpu6050_clock_sel_e {
>  irqreturn_t inv_mpu6050_irq_handler(int irq, void *p);
>  irqreturn_t inv_mpu6050_read_fifo(int irq, void *p);
>  int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev);
> -void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st);
>  int inv_reset_fifo(struct iio_dev *indio_dev);
>  int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask);
>  int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 val);
> @@ -297,5 +296,4 @@ enum inv_mpu6050_clock_sel_e {
>  void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
> -int inv_mpu_core_remove(struct device *dev);
>  extern const struct dev_pm_ops inv_mpu_pmops;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index 74506e5..93fdd17 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -69,11 +69,6 @@ static int inv_mpu_probe(struct spi_device *spi)
>  				  inv_mpu_i2c_disable, chip_type);
>  }
>  
> -static int inv_mpu_remove(struct spi_device *spi)
> -{
> -	return inv_mpu_core_remove(&spi->dev);
> -}
> -
>  /*
>   * device id table is used to identify what device can be
>   * supported by this driver
> @@ -97,7 +92,6 @@ static int inv_mpu_remove(struct spi_device *spi)
>  
>  static struct spi_driver inv_mpu_driver = {
>  	.probe		=	inv_mpu_probe,
> -	.remove		=	inv_mpu_remove,
>  	.id_table	=	inv_mpu_id,
>  	.driver = {
>  		.acpi_match_table = ACPI_PTR(inv_acpi_match),
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 85c2732..6444850 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -149,7 +149,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
>  	st->trig->ops = &inv_mpu_trigger_ops;
>  	iio_trigger_set_drvdata(st->trig, indio_dev);
>  
> -	ret = iio_trigger_register(st->trig);
> +	ret = devm_iio_trigger_register(&indio_dev->dev, st->trig);
>  	if (ret)
>  		return ret;
>  
> @@ -157,8 +157,3 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
>  
>  	return 0;
>  }
> -
> -void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st)
> -{
> -	iio_trigger_unregister(st->trig);
> -}

