Return-Path: <omaplinuxkernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1342721851-2655-10-git-send-email-srinivas.pandruvada@intel.com>
References: <1342721851-2655-1-git-send-email-srinivas.pandruvada@intel.com>
	<1342721851-2655-10-git-send-email-srinivas.pandruvada@intel.com>
Date: Sat, 21 Jul 2012 19:18:52 +0530
Message-ID: <CAM=Q2cs=Z4OmNmOGg+SOBFmyOJDkXWKiYc=b63w+b9dp4AnZfw@mail.gmail.com>
Subject: Re: [PATCH 9/9] HID-Sensors: Added ALS
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, jkosina@suse.cz
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi ,

On Thu, Jul 19, 2012 at 11:47 PM, srinivas pandruvada
<srinivas.pandruvada@intel.com> wrote:
> Added usage id processing for ALS. This uses IIO
> interfaces for triggerred buffer to present data to user
> mode.This uses HID sensor framework for registering callback
> events from the sensor hub.
>
> Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
> ---
>  drivers/iio/Kconfig                |    1 +
>  drivers/iio/Makefile               |    1 +
>  drivers/iio/light/Kconfig          |   16 ++
>  drivers/iio/light/Makefile         |    6 +
>  drivers/iio/light/hid-sensor-als.c |  397 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 421 insertions(+), 0 deletions(-)
[...]
> +
> +/* Function to deinitialize the processing for usage id */
> +static int als_exit(struct platform_device *pdev)

Can this be merged in the remove function ?
Also the return value is not checked.

> +{
> +       int ret = 0;
> +       struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +       struct hid_sensor_attributes *st = iio_priv(indio_dev);
> +       struct als_state *als_state = st->private;
> +
> +       iio_device_unregister(indio_dev);
> +       hid_sensor_remove_trigger(indio_dev);
> +       iio_triggered_buffer_cleanup(indio_dev);
> +       kfree(indio_dev->channels);
> +       iio_device_free(indio_dev);
> +       kfree(als_state);
> +
> +       return ret;
> +}
> +
> +static struct hid_sensor_hub_callbacks als_callbacks = {
> +       .send_event = als_proc_event,
> +       .capture_sample = als_capture_sample,
> +};
> +
> +static int __devinit hid_als_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> +
> +       ret = als_init(pdev, hsdev, HID_USAGE_SENSOR_ALS);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "als_init failed\n");
> +               return ret;
> +       }
> +       als_callbacks.pdev = pdev;
> +       ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_ALS,
> +                                       &als_callbacks);
> +
> +       return 0;
> +}
> +
> +static int __devinit hid_als_remove(struct platform_device *pdev)
> +{
> +       struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> +
> +       als_exit(pdev);
> +
> +       return sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ALS);
> +}
