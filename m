Return-Path: <dmitry.torokhov@gmail.com>
Date: Sun, 4 Mar 2012 08:11:01 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, greg@kroah.com,
	broonie@opensource.wolfsonmicro.com, alan@lxorguk.ukuu.org.uk,
	arnd@arndb.de, linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 3/3] staging:iio: Proof of concept input driver.
Message-ID: <20120304161101.GD27647@core.coreip.homeip.net>
References: <1330776551-20301-1-git-send-email-jic23@kernel.org>
 <1330776551-20301-4-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330776551-20301-4-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On Sat, Mar 03, 2012 at 12:09:11PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <jic23@cam.ac.uk>
> 
> This is no where near ready to merge.  Lots of stuff missing.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/Kconfig     |   10 ++++
>  drivers/staging/iio/Makefile    |    1 +
>  drivers/staging/iio/iio_input.c |  106 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+)
> 
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index 4aff125..a599f16 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -11,6 +11,16 @@ menuconfig IIO
>  	  number of different physical interfaces (i2c, spi, etc). See
>  	  drivers/staging/iio/Documentation for more information.
>  if IIO
> +
> +config IIO_ST_INPUT
> +	tristate "Input driver that uses channels specified via iio maps"
> +	depends on INPUT
> +	depends on IIO_BUFFER
> +	select IIO_BUFFER_CB
> +	help
> +	  Proof of concept user of the in kernel push interface.  Not anywhere
> +	  near ready for production use.
> +
>  config IIO_ST_HWMON
>  	tristate "Hwmon driver that uses channels specified via iio maps"
>  	depends on HWMON
> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
> index f55de94..f64c93b 100644
> --- a/drivers/staging/iio/Makefile
> +++ b/drivers/staging/iio/Makefile
> @@ -19,6 +19,7 @@ iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_BUFFER) += iio_simple_dummy_buffer.o
>  obj-$(CONFIG_IIO_DUMMY_EVGEN) += iio_dummy_evgen.o
>  
>  obj-$(CONFIG_IIO_ST_HWMON) += iio_hwmon.o
> +obj-$(CONFIG_IIO_ST_INPUT) += iio_input.o
>  
>  obj-y += accel/
>  obj-y += adc/
> diff --git a/drivers/staging/iio/iio_input.c b/drivers/staging/iio/iio_input.c
> new file mode 100644
> index 0000000..2481901
> --- /dev/null
> +++ b/drivers/staging/iio/iio_input.c
> @@ -0,0 +1,106 @@
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include "buffer.h"
> +#include "consumer.h"
> +
> +struct iio_input_state {
> +	struct iio_cb_buffer *buff;
> +	struct input_dev *idev;
> +};
> +
> +static int iio_input_store_to(u8 *data, void *private)
> +{
> +	struct iio_input_state *st = private;
> +
> +	/* DUMMY - need to put boiler plate conversion code
> +	 * in place */
> +	input_report_abs(st->idev, ABS_X, data[0]);
> +	input_sync(st->idev);
> +
> +	return 0;
> +}
> +
> +static int __devinit iio_input_probe(struct platform_device *pdev)
> +{
> +	struct iio_input_state *st;
> +	int ret;
> +
> +	st = kzalloc(sizeof(*st), GFP_KERNEL);
> +	if (st == NULL)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, st);
> +	st->buff = iio_st_channel_get_all_cb(dev_name(&pdev->dev),
> +					     &iio_input_store_to,
> +					     st);
> +	if (IS_ERR(st->buff)) {
> +		ret = PTR_ERR(st->buff);
> +		goto error_free_state;
> +	}
> +
> +	st->idev = input_allocate_device();
> +	if (!st->idev) {
> +		ret = -ENOMEM;
> +		goto error_channels_release_all;
> +	}
> +
> +	__set_bit(EV_ABS, st->idev->evbit);
> +	/* DUMMY DATA - need to actually make this available */
> +	input_set_abs_params(st->idev, ABS_X, 0, 100, 0, 0);
> +
> +	ret = input_register_device(st->idev);
> +	if (ret < 0)
> +		goto error_free_idev;
> +
> +	/* NORMALLY IN THE OPEN */
> +	iio_st_channel_start_all_cb(st->buff);
> +
> +	return 0;
> +error_free_idev:
> +	input_free_device(st->idev);
> +error_channels_release_all:
> +	iio_st_channel_release_all_cb(st->buff);
> +error_free_state:
> +	kfree(st);
> +	return ret;
> +}
> +
> +static int __devexit iio_input_remove(struct platform_device *pdev)
> +{
> +	struct iio_input_state *st = platform_get_drvdata(pdev);
> +	/* NORMALLY IN THE CLOSE */
> +	iio_st_channel_stop_all_cb(st->buff);
> +	input_unregister_device(st->idev);
> +	iio_st_channel_release_all_cb(st->buff);
> +
> +	kfree(st);
> +	return 0;
> +}
> +
> +static struct platform_driver __refdata iio_input_driver = {

Why is this __refdata?

> +	.driver = {
> +		.name = "iio_snoop",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = iio_input_probe,
> +	.remove = __devexit_p(iio_input_remove),
> +};
> +
> +static int iio_input_init(void)

__init

> +{
> +	return platform_driver_register(&iio_input_driver);
> +}
> +module_init(iio_input_init);
> +
> +static void iio_input_exit(void)

__exit

> +{
> +	platform_driver_unregister(&iio_input_driver);
> +}
> +module_exit(iio_input_exit);
> +
> +MODULE_AUTHOR("Jonathan Cameron <jic23@cam.ac.uk>");
> +MODULE_DESCRIPTION("IIO input buffer driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.9.2
> 

Thanks.

-- 
Dmitry
