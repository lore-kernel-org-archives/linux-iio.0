Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47783 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbcFZQgx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 12:36:53 -0400
Subject: Re: [PATCH v2 1/3] toshiba_acpi: Add IIO interface for accelerometer
 axis data
To: Azael Avalos <coproscefalo@gmail.com>,
	Darren Hart <dvhart@infradead.org>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
References: <20160619232804.8875-1-coproscefalo@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e51de271-6d3f-26ea-9b04-61612336c14f@kernel.org>
Date: Sun, 26 Jun 2016 17:36:50 +0100
MIME-Version: 1.0
In-Reply-To: <20160619232804.8875-1-coproscefalo@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/06/16 00:28, Azael Avalos wrote:
> This patch adds the accelerometer axis data to the IIO subsystem.
> 
> Currently reporting the X, Y and Z values, as no other data can be
> queried given the fact that the accelerometer chip itself is hidden
> behind the Toshiba proprietary interface.
> 
> Signed-off-by: Azael Avalos <coproscefalo@gmail.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>

I'm assuming this will go through the relevant tree on the platform side
rather than through iio.

Nothing in here that is flux in the IIO tree so should be no issues in
doing that.

Thanks,

Jonathan
> ---
>  drivers/platform/x86/toshiba_acpi.c | 107 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 01e12d2..7949929 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -53,6 +53,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/miscdevice.h>
>  #include <linux/rfkill.h>
> +#include <linux/iio/iio.h>
>  #include <linux/toshiba.h>
>  #include <acpi/video.h>
>  
> @@ -134,6 +135,7 @@ MODULE_LICENSE("GPL");
>  
>  /* Field definitions */
>  #define HCI_ACCEL_MASK			0x7fff
> +#define HCI_ACCEL_DIRECTION_MASK	0x8000
>  #define HCI_HOTKEY_DISABLE		0x0b
>  #define HCI_HOTKEY_ENABLE		0x09
>  #define HCI_HOTKEY_SPECIAL_FUNCTIONS	0x10
> @@ -178,6 +180,7 @@ struct toshiba_acpi_dev {
>  	struct led_classdev eco_led;
>  	struct miscdevice miscdev;
>  	struct rfkill *wwan_rfk;
> +	struct iio_dev *indio_dev;
>  
>  	int force_fan;
>  	int last_key_event;
> @@ -2420,6 +2423,83 @@ static void toshiba_acpi_kbd_bl_work(struct work_struct *work)
>  }
>  
>  /*
> + * IIO device
> + */
> +
> +enum toshiba_accel_chan {
> +	AXIS_X,
> +	AXIS_Y,
> +	AXIS_Z
> +};
> +
> +static int toshiba_accel_get_axis(enum toshiba_accel_chan chan)
> +{
> +	u32 xyval;
> +	u32 zval;
> +	int ret;
> +
> +	xyval = zval = 0;
> +	ret = toshiba_accelerometer_get(toshiba_acpi, &xyval, &zval);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (chan) {
> +	case AXIS_X:
> +		return xyval & HCI_ACCEL_DIRECTION_MASK ?
> +			-(xyval & HCI_ACCEL_MASK) : xyval & HCI_ACCEL_MASK;
> +	case AXIS_Y:
> +		return (xyval >> HCI_MISC_SHIFT) & HCI_ACCEL_DIRECTION_MASK ?
> +			-((xyval >> HCI_MISC_SHIFT) & HCI_ACCEL_MASK) :
> +			(xyval >> HCI_MISC_SHIFT) & HCI_ACCEL_MASK;
> +	case AXIS_Z:
> +		return zval & HCI_ACCEL_DIRECTION_MASK ?
> +			-(zval & HCI_ACCEL_MASK) : zval & HCI_ACCEL_MASK;
> +	}
> +
> +	return ret;
> +}
> +
> +static int toshiba_accel_read_raw(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int *val, int *val2, long mask)
> +{
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = toshiba_accel_get_axis(chan->channel);
> +		if (ret == -EIO || ret == -ENODEV)
> +			return ret;
> +
> +		*val = ret;
> +
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +#define TOSHIBA_ACCEL_CHANNEL(axis, chan) { \
> +	.type = IIO_ACCEL, \
> +	.modified = 1, \
> +	.channel = chan, \
> +	.channel2 = IIO_MOD_##axis, \
> +	.output = 1, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +}
> +
> +static const struct iio_chan_spec toshiba_accel_channels[] = {
> +	TOSHIBA_ACCEL_CHANNEL(X, AXIS_X),
> +	TOSHIBA_ACCEL_CHANNEL(Y, AXIS_Y),
> +	TOSHIBA_ACCEL_CHANNEL(Z, AXIS_Z),
> +};
> +
> +static const struct iio_info toshiba_accel_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = &toshiba_accel_read_raw,
> +};
> +
> +/*
>   * Misc device
>   */
>  static int toshiba_acpi_smm_bridge(SMMRegisters *regs)
> @@ -2904,6 +2984,11 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
>  
>  	remove_toshiba_proc_entries(dev);
>  
> +	if (dev->accelerometer_supported) {
> +		iio_device_unregister(dev->indio_dev);
> +		iio_device_free(dev->indio_dev);
> +	}
> +
>  	if (dev->sysfs_created)
>  		sysfs_remove_group(&dev->acpi_dev->dev.kobj,
>  				   &toshiba_attr_group);
> @@ -3051,6 +3136,28 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	dev->touchpad_supported = !ret;
>  
>  	toshiba_accelerometer_available(dev);
> +	if (dev->accelerometer_supported) {
> +		dev->indio_dev = iio_device_alloc(sizeof(*dev));
> +		if (!dev->indio_dev)
> +			return -ENOMEM;
> +
> +		pr_info("Registering Toshiba accelerometer iio device\n");
> +
> +		dev->indio_dev->info = &toshiba_accel_info;
> +		dev->indio_dev->name = "Toshiba accelerometer";
> +		dev->indio_dev->dev.parent = &acpi_dev->dev;
> +		dev->indio_dev->modes = INDIO_DIRECT_MODE;
> +		dev->indio_dev->channels = toshiba_accel_channels;
> +		dev->indio_dev->num_channels =
> +					ARRAY_SIZE(toshiba_accel_channels);
> +
> +		ret = iio_device_register(dev->indio_dev);
> +		if (ret < 0) {
> +			pr_err("Unable to register iio device\n");
> +			iio_device_free(dev->indio_dev);
> +			return ret;
> +		}
> +	}
>  
>  	toshiba_usb_sleep_charge_available(dev);
>  
> 

