Return-Path: <lars@metafoo.de>
Message-ID: <50F6B6B3.4030000@metafoo.de>
Date: Wed, 16 Jan 2013 15:18:27 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/9] iio:common: Add STMicroelectronics common library
References: <1358238660-14929-1-git-send-email-denis.ciocca@st.com> <1358238660-14929-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1358238660-14929-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Just noticed something else while going through the individual drivers.

> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> new file mode 100644
> index 0000000..1c69c63
> --- /dev/null
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -0,0 +1,83 @@
[...]
> +
> +static struct iio_trigger_ops st_sensors_trigger_ops = {
> +	.owner = THIS_MODULE,
> +};
> +
> +int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
> +		int (*set_trigger_state)(struct iio_trigger *trig, bool state),
> +		int (*try_reenable)(struct iio_trigger *trig))
> +{
> +	int err;
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +
> +	sdata->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
> +	if (sdata->trig == NULL) {
> +		err = -ENOMEM;
> +		dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
> +		goto iio_trigger_alloc_error;
> +	}
> +
> +	err = request_threaded_irq(sdata->get_irq_data_ready(indio_dev),
> +			iio_trigger_generic_data_rdy_poll,
> +			NULL,
> +			IRQF_TRIGGER_RISING,
> +			sdata->trig->name,
> +			sdata->trig);
> +	if (err)
> +		goto request_irq_error;
> +
> +	st_sensors_trigger_ops.set_trigger_state = set_trigger_state;
> +	st_sensors_trigger_ops.try_reenable = try_reenable;

This is bad idea. It will break as soon as you have e.g. a gyro and and
accel driver instantiated at the same time. If you need custom trigger ops
callbacks define a custom trigger ops set per driver.

> +	sdata->trig->private_data = indio_dev;
> +	sdata->trig->ops = &st_sensors_trigger_ops;
> +	sdata->trig->dev.parent = sdata->dev;
> +
> +	err = iio_trigger_register(sdata->trig);
> +	if (err < 0) {
> +		dev_err(&indio_dev->dev, "failed to register iio trigger.\n");
> +		goto iio_trigger_register_error;
> +	}
> +	indio_dev->trig = sdata->trig;
> +
> +	return 0;
> 
