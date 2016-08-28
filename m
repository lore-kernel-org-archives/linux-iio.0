Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1472420960.2480.2.camel@linux.intel.com>
Subject: Re: [PATCH] iio: hid-sensors: avoid unused function warning
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 28 Aug 2016 14:49:20 -0700
In-Reply-To: <20160826152956.666025-1-arnd@arndb.de>
References: <20160826152956.666025-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Fri, 2016-08-26 at 17:29 +0200, Arnd Bergmann wrote:
A small rework of the PM code in this driver introduced a harmless
> warning when CONFIG_PM_SLEEP is not set:
> 
> drivers/iio/common/hid-sensors/hid-sensor-trigger.c:212:12: error:
> 'hid_sensor_resume' defined but not used [-Werror=unused-function]
> 
> This removes the #ifdef and instead marks all three PM functions
> as __maybe_unused, which covers all possible cases and is harder
> to get wrong.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7f6cf7414538 ("iio: hid-sensors: use asynchronous resume")
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 5264ed6e03e5..a3cce3a38300 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -199,8 +199,7 @@ error_ret:
>  }
>  EXPORT_SYMBOL(hid_sensor_setup_trigger);
>  
> -#ifdef CONFIG_PM
> -static int hid_sensor_suspend(struct device *dev)
> +static int __maybe_unused hid_sensor_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> @@ -209,7 +208,7 @@ static int hid_sensor_suspend(struct device *dev)
>  	return _hid_sensor_power_state(attrb, false);
>  }
>  
> -static int hid_sensor_resume(struct device *dev)
> +static int __maybe_unused hid_sensor_resume(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> @@ -218,7 +217,7 @@ static int hid_sensor_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static int hid_sensor_runtime_resume(struct device *dev)
> +static int __maybe_unused hid_sensor_runtime_resume(struct device
> *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> @@ -226,8 +225,6 @@ static int hid_sensor_runtime_resume(struct
> device *dev)
>  	return _hid_sensor_power_state(attrb, true);
>  }
>  
> -#endif
> -
>  const struct dev_pm_ops hid_sensor_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(hid_sensor_suspend,
> hid_sensor_resume)
>  	SET_RUNTIME_PM_OPS(hid_sensor_suspend,
