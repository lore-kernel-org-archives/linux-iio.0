Return-Path: <pmeerw@pmeerw.net>
Date: Wed, 25 Feb 2015 23:54:08 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Martin Fuzzey <mfuzzey@parkeon.com>
cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 9/9] iio: mma8452: add support for self test.
In-Reply-To: <20150219141612.27001.62858.stgit@localhost>
Message-ID: <alpine.DEB.2.02.1502252351140.6800@pmeerw.net>
References: <20150219141553.27001.18825.stgit@localhost> <20150219141612.27001.62858.stgit@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Thu, 19 Feb 2015, Martin Fuzzey wrote:

> Add a new attribute to activate the self test mode.
> 
> When self test is activated, an electrostatic actuation force is
> applied to the sensor, simulating a small acceleration.

comment below

> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-accel-mma8452        |   10 ++++
>  drivers/iio/accel/mma8452.c                        |   52 ++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-mma8452
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-accel-mma8452 b/Documentation/ABI/testing/sysfs-bus-iio-accel-mma8452
> new file mode 100644
> index 0000000..387ed38
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-accel-mma8452
> @@ -0,0 +1,10 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/self_test
> +KernelVersion:	3.21

bad timing :)

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Allow self test mode to be controlled:
> +			"0" = inactive
> +			"1" = active
> +		When self test is activated, an electrostatic actuation force is
> +		applied to the sensor, simulating a small acceleration.
> +
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 6277b5d..75dcc6e 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -49,6 +49,7 @@
>  #define MMA8452_CTRL_REG1 0x2a
>  #define MMA8452_CTRL_REG2 0x2b
>  #define MMA8452_CTRL_REG2_RST		BIT(6)
> +#define MMA8452_CTRL_REG2_SELFTEST	BIT(7)
>  #define MMA8452_CTRL_REG4 0x2d
>  #define MMA8452_CTRL_REG5 0x2e
>  
> @@ -639,6 +640,56 @@ static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static ssize_t mma8452_show_selftest(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG2);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", ret & MMA8452_CTRL_REG2_SELFTEST ? 1 : 0);
> +}
> +
> +static ssize_t mma8452_store_selftest(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	bool state;
> +	int ret;
> +	u8 val;
> +
> +	ret = strtobool(buf, &state);
> +	if (ret < 0)
> +		return ret;
> +

take mutex?

> +	ret = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG2);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = ret;
> +	if (state)
> +		val |= MMA8452_CTRL_REG2_SELFTEST;
> +	else
> +		val &= ~MMA8452_CTRL_REG2_SELFTEST;
> +
> +	ret = mma8452_change_config(data, MMA8452_CTRL_REG2, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(self_test,
> +			 S_IRUGO | S_IWUSR,
> +			 mma8452_show_selftest,
> +			 mma8452_store_selftest, 0);
> +
>  static const struct iio_event_spec mma8452_transient_event[] = {
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
> @@ -698,6 +749,7 @@ static struct attribute *mma8452_attributes[] = {
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
>  	&iio_dev_attr_in_accel_filter_high_pass_3db_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_self_test.dev_attr.attr,
>  	NULL
>  };
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
