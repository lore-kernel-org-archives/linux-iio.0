Return-Path: <lars@metafoo.de>
Message-ID: <50AA2D52.10901@metafoo.de>
Date: Mon, 19 Nov 2012 14:00:02 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Denis Ciocca <denis.ciocca@gmail.com>,
 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Pavel Machek <pavel@denx.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "burman.yan@gmail.com" <burman.yan@gmail.com>
Subject: Re: STMicroelectronics accelerometers driver.
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de> <20121008195007.GA32042@elf.ucw.cz> <507338B5.60307@metafoo.de> <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com> <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com> <507D9EA3.4070009@metafoo.de> <5085128C.7020507@st.com> <50858B44.2080006@kernel.org> <5087E2A8.4070304@st.com> <508A7DA6.7050505@metafoo.de> <508E4492.8080000@st.com> <508E48D1.3000703@metafoo.de> <508E5978.5000907@st.com> <508E5AD5.1040907@metafoo.de> <50914366.4090000@st.com> <5091546D.9000601@metafoo.de> <CAEE_umoKvv9ciBfUSahDqsmcbHi9W=93o5YSpE-vxUduCmqWSQ@mail.gmail.com> <50982F71.3060606@kernel.org> <5098F065.1090009@st.com> <50A12D8C.6040207@st.com> <50A14485.2060902@kernel.org> <50A26967.4050102@st.com>
In-Reply-To: <50A26967.4050102@st.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/13/2012 04:38 PM, Denis CIOCCA wrote:
> Hi Jonathan,
> 
> I have reviewed my code and I applied your stylish comment to decrease
> the lines number of the code.
> For now I also deleted the platform_data, I will do this in a future patch.
> 
> I attached to you the new patch, if the code is ok I will send this with
> git.
> 
> Thanks,
> 
> Denis
> 
> 
> 
> 
>  From 8bb6479aa8814ad4b82c359a0aaea99b04a7ecef Mon Sep 17 00:00:00 2001
> From: Denis Ciocca <denis.ciocca@st.com>
> Date: Mon, 22 Oct 2012 11:17:27 +0200
> Subject: [PATCH] iio:accel: Add STMicroelectronics accelerometers driver
> 
> This patch adds generic accelerometer driver for STMicroelectronics
> accelerometers, currently it supports:
> LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC, LSM303D,
> LSM9DS0, LIS331DLH, LSM303DL, LSM303DLM, LSM330
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>

Looks pretty good to me, just a few minor issues.

[...]
> diff --git a/drivers/iio/accel/st_accel_buffer.c
> b/drivers/iio/accel/st_accel_buffer.c
> new file mode 100644
> index 0000000..af5d333
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_buffer.c
[...]
> +
> +static int st_accel_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
> +{
> +       int ret, i, scan_count;
> +       u8 rx_array[ST_ACCEL_BYTE_FOR_CHANNEL*ST_ACCEL_NUMBER_DATA_CHANNELS];
> +       s16 *data = (s16 *)buf;
> +
> +       ret = st_accel_read_all(indio_dev, rx_array);
> +       if (ret < 0)
> +               return ret;
> +
> +       scan_count = bitmap_weight(indio_dev->active_scan_mask,
> +                                                       indio_dev->masklength);
> +
> +       for (i = 0; i < scan_count; i++)
> +               memcpy(data+i, &rx_array[i*2], sizeof(s16));

I think you can just pass in 'data' directly to st_accel_read_all. Just use
st_accel_read_all at all call sites and remove st_accel_get_buffer_element
completely.

> +
> +       return i*sizeof(data[0]);
> +}
> +
[...]
> diff --git a/drivers/iio/accel/st_accel_core.c
> b/drivers/iio/accel/st_accel_core.c
> new file mode 100644
> index 0000000..0a787df
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -0,0 +1,1154 @@
[...]
> +
> +static ssize_t st_accel_sysfs_set_sampling_frequency(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t size)
> +{
> +       int err;
> +       unsigned int freq;
> +       struct st_accel_odr_available odr_out;
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       err = kstrtoint(buf, 10, &freq);
> +       if (err < 0)
> +               goto conversion_error;
> +
> +       mutex_lock(&indio_dev->mlock);
> +       err = st_accel_match_odr(&st_accel_sensors[adata->index],
> +                                                               freq, &odr_out);
> +       if (err < 0)
> +               goto st_accel_sysfs_set_sampling_frequency_error;

It may make sense to return an error in this case to tell userspace that the
desired frequency could not be set.

> +
> +       err = st_accel_set_odr(indio_dev, &odr_out);
> +       if (err < 0) {
> +               dev_err(&indio_dev->dev,
> +                       "failed to set sampling frequency to %d.\n", freq);
> +               goto st_accel_sysfs_set_sampling_frequency_error;

same here. and maybe remove the dev_err(...)

> +       }
> +       adata->odr = odr_out.hz;
> +
> +st_accel_sysfs_set_sampling_frequency_error:
> +       mutex_unlock(&indio_dev->mlock);
> +conversion_error:
> +       return size;
> +}
> +
> +static ssize_t st_accel_sysfs_get_sampling_frequency(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       return sprintf(buf, "%d\n", adata->odr);
> +}
> +
> +static ssize_t st_accel_sysfs_set_powerdown(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t size)
> +{
> +       int err;
> +       bool powerdown;
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +
> +       err = strtobool(buf, &powerdown);
> +       if (err < 0)
> +               goto set_enable_error;
> +
> +       mutex_lock(&indio_dev->mlock);
> +       err = st_accel_set_enable(indio_dev, !powerdown);
> +       if (err < 0)
> +               dev_err(&indio_dev->dev,
> +                       "failed to set powerdown to %d.\n", (int)(powerdown));

Same here, return an error instead of the dev_err.

> +       mutex_unlock(&indio_dev->mlock);
> +
> +set_enable_error:
> +       return size;
> +}
> +

[...]
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/st_accel_i2c.c
> b/drivers/iio/accel/st_accel_i2c.c
> new file mode 100644
> index 0000000..f4680a2
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -0,0 +1,128 @@
> +/*
> + * STMicroelectronics accelerometers driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +
> +#include <linux/iio/accel/st_accel.h>
> +
> +#define ST_ACCEL_I2C_MULTIREAD                 0x80
> +
> +static int st_accel_i2c_read_byte(struct st_accel_data *adata,
> +                                               u8 reg_addr, u8 *res_byte)
> +{
> +       int err;
> +
> +       err = i2c_smbus_read_byte_data(to_i2c_client(adata->dev), reg_addr);
> +       if (err < 0)
> +               goto st_accel_i2c_read_byte_error;
> +
> +       *res_byte = err & 0xff;
> +
> +st_accel_i2c_read_byte_error:
> +       return err;

Shouldn't this return 0 in case of success?

> +}
> +
