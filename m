Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39867 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbcFSUQy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2016 16:16:54 -0400
Subject: Re: [PATCH 1/3] toshiba_acpi: Add IIO interface for accelerometer
 axis data
To: Azael Avalos <coproscefalo@gmail.com>,
	Darren Hart <dvhart@infradead.org>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
References: <20160611185710.14234-1-coproscefalo@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d9b7c548-44df-e3b4-2912-95f83b712b1e@kernel.org>
Date: Sun, 19 Jun 2016 21:16:01 +0100
MIME-Version: 1.0
In-Reply-To: <20160611185710.14234-1-coproscefalo@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/06/16 19:57, Azael Avalos wrote:
> This patch adds the accelerometer axis data to the IIO subsystem.
> 
> Currently reporting the X, Y and Z values, as no other data can be
> queried given the fact that the accelerometer chip itself is hidden
> behind the Toshiba proprietary interface.
> 
> Signed-off-by: Azael Avalos <coproscefalo@gmail.com>
Looks pretty good and simple to me.  A few bits and bobs inline.

Jonathan
> ---
> All:
>  This is my first attempt with the IIO subsysem, I'll be looking
>  forward for your valuable input on this.
> 
> Darren:
>  There's a warning about more than 80 columns on this patch, once
>  I get feedback from the IIO guys I'll respin this with that issue
>  corrected.
> 
>  drivers/platform/x86/toshiba_acpi.c | 130 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 126 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 01e12d2..85014a3 100644
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
> @@ -1962,8 +1965,8 @@ static ssize_t position_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
>  	struct toshiba_acpi_dev *toshiba = dev_get_drvdata(dev);
> -	u32 xyval, zval, tmp;
> -	u16 x, y, z;
> +	u32 xyval, zval;
> +	int x, y, z;
>  	int ret;
>  
>  	xyval = zval = 0;
> @@ -1971,10 +1974,14 @@ static ssize_t position_show(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Accelerometer values */
>  	x = xyval & HCI_ACCEL_MASK;
> -	tmp = xyval >> HCI_MISC_SHIFT;
> -	y = tmp & HCI_ACCEL_MASK;
> +	y = (xyval >> HCI_MISC_SHIFT) & HCI_ACCEL_MASK;
>  	z = zval & HCI_ACCEL_MASK;
> +	/* Movement direction */
> +	x *= xyval & HCI_ACCEL_DIRECTION_MASK ? -1 : 1;
> +	y *= (xyval >> HCI_MISC_SHIFT) & HCI_ACCEL_DIRECTION_MASK ? -1 : 1;
> +	z *= zval & HCI_ACCEL_DIRECTION_MASK ? -1 : 1;
This lot is really an unrelated change - do it as a separate precursor patch
to the IIO support.
>  
>  	return sprintf(buf, "%d %d %d\n", x, y, z);
>  }
> @@ -2420,6 +2427,94 @@ static void toshiba_acpi_kbd_bl_work(struct work_struct *work)
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
> +	u32 xyval, zval;
> +	int x, y, z;
> +	int ret;
> +
> +	xyval = zval = 0;
> +	ret = toshiba_accelerometer_get(toshiba_acpi, &xyval, &zval);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Accelerometer values */
> +	x = xyval & HCI_ACCEL_MASK;
> +	y = (xyval >> HCI_MISC_SHIFT) & HCI_ACCEL_MASK;
> +	z = zval & HCI_ACCEL_MASK;
> +	/* Movement direction */
> +	x *= xyval & HCI_ACCEL_DIRECTION_MASK ? -1 : 1;
> +	y *= (xyval >> HCI_MISC_SHIFT) & HCI_ACCEL_DIRECTION_MASK ? -1 : 1;
> +	z *= zval & HCI_ACCEL_DIRECTION_MASK ? -1 : 1;
Wow, that's hideous ;)
> +
> +	switch (chan) {
> +	case AXIS_X:
> +		ret = x;
> +		break;
> +	case AXIS_Y:
> +		ret = y;
> +		break;
> +	case AXIS_Z:
> +		ret = z;
> +		break;
Just compute the one you are returning perhaps?
case AXIS_X:
     return xyval & HCI_ACCEL_DIRECTION_MASK ?
     	    -(xyval & HCI_ACCEL_MASK) :
	    xyval & HCI_ACCEL_MASK;
etc?
Brings all the 'mess' into one location.
Or break it out into steps which is fine, but only compute the one
we care about.
     
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
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
Couple of things here.
* you aren't supporting buffered reads (pushed data flows) so
very unlikely the buffer would be enabled.
* if you were you'd need to be holding indio_dev->mlock to
avoid races around entering buffered mode mid way through this
function.  Note we have the claim_direct functions to handle this
case cleanly if you ever do need them!

Right now just drop this check.

> +
> +		ret = toshiba_accel_get_axis(chan->scan_index);
For this use chan->address as it's not the 'scan_index' as such.

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
> +	.channel2 = IIO_MOD_##axis, \
> +	.output = 1, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.scan_index = chan, \
You don't need scan index unless you are supporting pushed data
flow (rather than polled ones that you have here). 
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
> @@ -2903,6 +2998,11 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
>  	misc_deregister(&dev->miscdev);
>  
>  	remove_toshiba_proc_entries(dev);
> +
> +	if (dev->accelerometer_supported) {
> +		iio_device_unregister(dev->indio_dev);
> +		iio_device_free(dev->indio_dev);
> +	}
>  
>  	if (dev->sysfs_created)
>  		sysfs_remove_group(&dev->acpi_dev->dev.kobj,
> @@ -3051,6 +3151,28 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
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
> +		dev->indio_dev->num_channels = ARRAY_SIZE(toshiba_accel_channels);
> +
> +		ret = iio_device_register(dev->indio_dev);
> +		if (ret < 0) {
> +			pr_err("Unable to register iio device\n");
> +			iio_device_free(dev->indio_dev);
I'm wondering if we want to be a little 'ruder' if this occurs and drop out
hard as it indicates something very nasty happened... Here we are papering
over any failures and users may never notice.  I guess it depends on what
is happening in other similar locations in this driver.

You already drop out if you get a memory allocation failure, so best
to be consistent I think.
> +		}
> +
> +		iio_device_set_drvdata(dev->indio_dev, dev);
There should be no real advantage in setting this as you can always get
to dev via iio_priv(indio_dev)
> +	}
>  
>  	toshiba_usb_sleep_charge_available(dev);
>  
> 

