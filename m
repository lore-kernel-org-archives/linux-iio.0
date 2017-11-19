Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750814AbdKSL03 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 06:26:29 -0500
Date: Sun, 19 Nov 2017 11:26:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: light: isl76683 add way to adjust irq
 threshold
Message-ID: <20171119112625.073f5d66@archlinux>
In-Reply-To: <1511047230-7021-4-git-send-email-chf.fritz@googlemail.com>
References: <1511047230-7021-1-git-send-email-chf.fritz@googlemail.com>
        <1511047230-7021-4-git-send-email-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 19 Nov 2017 00:20:30 +0100
Christoph Fritz <chf.fritz@googlemail.com> wrote:

> This patch adds sysfs read/write support for upper and lower irq
> thresholds. So it's possible that only on certain lux ranges the
> irq triggered measurement happens.
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>

hmm, this is 'unusual' to say the least...

>From the datasheet it initially looks like a straight forward threshold
interrupt - which should be supported as an IIO event.

However, there seems to not be a generic monitoring mode, but rather the
device has to be polled?  (which makes this a 'funny' sort of interrupt..)

So I think you are ultimately using this threshold interrupt to provide
a dataready signal when there isn't a real one provided?

That's horrible and makes it very hard to fit this device into standard
frameworks.  My gut feeling would be to:

* stop using the interrupt for data ready at all, but dead reckon
  that with a timer delay. 
* use this 'interrupt' (actually a hardware threshold signal rather than
  an interrupt really) for event detection and handle it
  as an event with all the standard infrastructure that is in place
  for that.

I can see the hardware designers logic that you might only want to read
the values back when the light level has changed from your expected value,
but given you have to manually trigger readings, the utility of this is
somewhat limited...

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-light-isl76683       | 17 +++++++
>  drivers/iio/light/isl76683.c                       | 57 ++++++++++++++++++++--
>  2 files changed, 71 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-isl76683
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-isl76683 b/Documentation/ABI/testing/sysfs-bus-iio-light-isl76683
> new file mode 100644
> index 0000000..c7e08d7
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-isl76683
> @@ -0,0 +1,17 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_threshold_low
> +Date:		November 2017
> +KernelVersion:	4.15.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw value of lower threshold for the interrupt.
> +		Reading returns 8-bit MSB data of a 16-bit threshold.
> +		Writing 0...255 represents 8-bit MSB data of a 16-bit threshold.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_threshold_up
> +Date:		November 2017
> +KernelVersion:	4.15.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw value of upper threshold for the interrupt.
> +		Reading returns 8-bit MSB data of a 16-bit threshold.
> +		Writing 0...255 represents 8-bit MSB data of a 16-bit threshold.
> diff --git a/drivers/iio/light/isl76683.c b/drivers/iio/light/isl76683.c
> index 4d158f6..1507158 100644
> --- a/drivers/iio/light/isl76683.c
> +++ b/drivers/iio/light/isl76683.c
> @@ -74,11 +74,14 @@ static const int isl76683_lux_ranges_available[] = {
>  #define ISL76683_KOHM_MAX		1000
>  #define ISL76683_INTPERS_DEFAULT	0x0
>  #define ISL76683_THR_DEFAULT		0x7f
> +#define ISL76683_THR_MAX		0xFF
>  
>  struct isl76683_chip {
>  	enum isl76683_lux_range	luxrange;
>  	int			external_resistor;
>  	enum isl76683_dmode	photodiode;
> +	int			threshold_up;
> +	int			threshold_low;
>  	struct i2c_client	*client;
>  	struct regmap		*rmp;
>  	struct completion	irq_complete;
> @@ -157,13 +160,12 @@ static int isl76683_set_config(struct isl76683_chip *chip)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = regmap_write(chip->rmp, ISL76683_REG_THR_HI,
> -				ISL76683_THR_DEFAULT);
> +	ret = regmap_write(chip->rmp, ISL76683_REG_THR_HI, chip->threshold_up);
>  	if (ret < 0)
>  		return ret;
>  
>  	return regmap_write(chip->rmp, ISL76683_REG_THR_LO,
> -				ISL76683_THR_DEFAULT);
> +				chip->threshold_low);
>  }
>  
>  static int isl76683_power(struct isl76683_chip *chip, bool on)
> @@ -402,11 +404,58 @@ static int isl76683_write_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +#define ISL76683_SYSFS_STORE(ident, _max)				\
> +static ssize_t in_illuminance_##ident##_store(struct device *dev,	\
> +					struct device_attribute *attr,	\
> +					const char *buf, size_t len)	\
> +{									\
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);		\
> +	struct isl76683_chip *chip = iio_priv(indio_dev);		\
> +	unsigned int val;						\
> +	int ret;							\
> +									\
> +	if (kstrtouint(buf, 10, &val))					\
> +		return -EINVAL;						\
> +									\
> +	if (val > _max)							\
> +		return -EINVAL;						\
> +									\
> +	mutex_lock(&chip->lock);					\
> +	chip->ident = val;						\
> +	ret = isl76683_set_config(chip);				\
> +	mutex_unlock(&chip->lock);					\
> +									\
> +	if (ret)							\
> +		return -EIO;						\
> +									\
> +	return len;							\
> +}
> +
> +ISL76683_SYSFS_STORE(threshold_low, ISL76683_THR_MAX)
> +ISL76683_SYSFS_STORE(threshold_up, ISL76683_THR_MAX)
> +
> +#define ISL76683_SYSFS_SHOW(ident, show_val)				\
> +static ssize_t in_illuminance_##ident##_show(struct device *dev,	\
> +			struct device_attribute *attr, char *buf)	\
> +{									\
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);		\
> +	struct isl76683_chip *chip = iio_priv(indio_dev);		\
> +									\
> +	return snprintf(buf, PAGE_SIZE, "%i\n", show_val);		\
> +}
> +
> +ISL76683_SYSFS_SHOW(threshold_up, chip->threshold_up)
> +ISL76683_SYSFS_SHOW(threshold_low, chip->threshold_low)
> +
>  static IIO_CONST_ATTR(in_illuminance_scale_available,
>  		ISL76683_LUXRANGE_STR);
> +static IIO_DEVICE_ATTR_RW(in_illuminance_threshold_up, 0);
> +static IIO_DEVICE_ATTR_RW(in_illuminance_threshold_low, 0);
>  
>  static struct attribute *isl76683_attributes[] = {
>  	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_illuminance_threshold_up.dev_attr.attr,
> +	&iio_dev_attr_in_illuminance_threshold_low.dev_attr.attr,
>  	NULL
>  };
>  
> @@ -508,6 +557,8 @@ static int isl76683_probe(struct i2c_client *client,
>  	chip->luxrange = ISL76683_LUX_RANGE_DEFAULT;
>  	chip->external_resistor = rs;
>  	chip->photodiode = ISL76683_DIODE_DEFAULT;
> +	chip->threshold_up = ISL76683_THR_DEFAULT;
> +	chip->threshold_low = ISL76683_THR_DEFAULT;
>  
>  	chip->rmp = devm_regmap_init_i2c(client, &isl76683_regmap_config);
>  	if (IS_ERR(chip->rmp)) {

