Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750896AbdHLMst (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Aug 2017 08:48:49 -0400
Date: Sat, 12 Aug 2017 13:42:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Thierry Escande <thierry.escande@collabora.com>
Cc: Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Hung-yu Wu <hywu@google.com>,
        Vincent Palatin <vpalatin@chromium.org>,
        Wei-Ning Huang <wnhuang@google.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/8] iio: cros_ec: Relax sampling frequency before
 suspending
Message-ID: <20170812134203.6fceef07@archlinux>
In-Reply-To: <1502461385-27564-2-git-send-email-thierry.escande@collabora.com>
References: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
        <1502461385-27564-2-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 11 Aug 2017 16:22:58 +0200
Thierry Escande <thierry.escande@collabora.com> wrote:

> From: Gwendal Grignou <gwendal@chromium.org>
> 
> If an application set a tight sampling frequency, given the interrupt
> use is a wakup source, suspend will not happen: the kernel will receive
> a wake up interrupt and will cancel the suspend process.
> 
> Given cros_ec sensors type is non wake up, this patch adds prepare and
> complete callbacks to set 1s sampling period just before suspend. This
> ensures the sensor hub will not be a source of interrupt during the
> suspend process.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan
> ---
>  .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |  1 +
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 49 ++++++++++++++++++++++
>  .../common/cros_ec_sensors/cros_ec_sensors_core.h  |  2 +
>  drivers/iio/light/cros_ec_light_prox.c             |  1 +
>  4 files changed, 53 insertions(+)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 38e8783..116da2c 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -292,6 +292,7 @@ MODULE_DEVICE_TABLE(platform, cros_ec_sensors_ids);
>  static struct platform_driver cros_ec_sensors_platform_driver = {
>  	.driver = {
>  		.name	= "cros-ec-sensors",
> +		.pm	= &cros_ec_sensors_pm_ops,
>  	},
>  	.probe		= cros_ec_sensors_probe,
>  	.id_table	= cros_ec_sensors_ids,
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 416cae5..a620eb5 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -446,5 +446,54 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
>  
> +static int __maybe_unused cros_ec_sensors_prepare(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +
> +	if (st->curr_sampl_freq == 0)
> +		return 0;
> +
> +	/*
> +	 * If the sensors are sampled at high frequency, we will not be able to
> +	 * sleep. Set sampling to a long period if necessary.
> +	 */
> +	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
> +		mutex_lock(&st->cmd_lock);
> +		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> +		st->param.ec_rate.data = CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY;
> +		cros_ec_motion_send_host_cmd(st, 0);
> +		mutex_unlock(&st->cmd_lock);
> +	}
> +	return 0;
> +}
> +
> +static void __maybe_unused cros_ec_sensors_complete(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +
> +	if (st->curr_sampl_freq == 0)
> +		return;
> +
> +	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
> +		mutex_lock(&st->cmd_lock);
> +		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
> +		st->param.ec_rate.data = st->curr_sampl_freq;
> +		cros_ec_motion_send_host_cmd(st, 0);
> +		mutex_unlock(&st->cmd_lock);
> +	}
> +}
> +
> +const struct dev_pm_ops cros_ec_sensors_pm_ops = {
> +#ifdef CONFIG_PM_SLEEP
> +	.prepare = cros_ec_sensors_prepare,
> +	.complete = cros_ec_sensors_complete
> +#endif
> +};
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_pm_ops);
> +
>  MODULE_DESCRIPTION("ChromeOS EC sensor hub core functions");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> index 8bc2ca3..2edf68d 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> @@ -169,6 +169,8 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  			       struct iio_chan_spec const *chan,
>  			       int val, int val2, long mask);
>  
> +extern const struct dev_pm_ops cros_ec_sensors_pm_ops;
> +
>  /* List of extended channel specification for all sensors */
>  extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
>  
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index 7217223..f8658d4 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -279,6 +279,7 @@ MODULE_DEVICE_TABLE(platform, cros_ec_light_prox_ids);
>  static struct platform_driver cros_ec_light_prox_platform_driver = {
>  	.driver = {
>  		.name	= "cros-ec-light-prox",
> +		.pm	= &cros_ec_sensors_pm_ops,
>  	},
>  	.probe		= cros_ec_light_prox_probe,
>  	.id_table	= cros_ec_light_prox_ids,

