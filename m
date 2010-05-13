Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1273697625-9685-3-git-send-email-jic23@cam.ac.uk>
References: <1273697625-9685-1-git-send-email-jic23@cam.ac.uk>
	<1273697625-9685-3-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 13 May 2010 11:06:31 +0800
Message-ID: <AANLkTikFuJnf5AVZHQfEyXmSgE-AGLCD1gpTi4H9WrKc@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging:iio: adis16220 extract bin_attribute
	structures from state
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, May 13, 2010 at 4:53 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
> =C2=A0drivers/staging/iio/accel/adis16220.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 =
=C2=A03 -
> =C2=A0drivers/staging/iio/accel/adis16220_core.c | =C2=A0106 ++++++++++++=
+++-------------
> =C2=A02 files changed, 56 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/adis16220.h b/drivers/staging/iio/=
accel/adis16220.h
> index 6b49f70..2abf485 100644
> --- a/drivers/staging/iio/accel/adis16220.h
> +++ b/drivers/staging/iio/accel/adis16220.h
> @@ -141,9 +141,6 @@ struct adis16220_state {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*indio_dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*tx;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*rx;
> - =C2=A0 =C2=A0 =C2=A0 struct bin_attribute =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0accel_bin;
> - =C2=A0 =C2=A0 =C2=A0 struct bin_attribute =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0adc1_bin;
> - =C2=A0 =C2=A0 =C2=A0 struct bin_attribute =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0adc2_bin;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_lock;
> =C2=A0};
>
> diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging=
/iio/accel/adis16220_core.c
> index 8b845d9..e60de4a 100644
> --- a/drivers/staging/iio/accel/adis16220_core.c
> +++ b/drivers/staging/iio/accel/adis16220_core.c
> @@ -27,8 +27,6 @@
>
> =C2=A0#define DRIVER_NAME =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"adis1=
6220"
>
> -static int adis16220_check_status(struct device *dev);
> -
> =C2=A0/**
> =C2=A0* adis16220_spi_write_reg_8() - write single byte to a register
> =C2=A0* @dev: device associated with child of actual device (iio_dev or i=
io_trig)
> @@ -133,8 +131,6 @@ static int adis16220_spi_read_reg_16(struct device *d=
ev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&st->buf_lock);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0st->tx[0] =3D ADIS16220_READ_REG(lower_reg_add=
ress);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0st->tx[1] =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 st->tx[2] =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 st->tx[3] =3D 0;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spi_message_init(&msg);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spi_message_add_tail(&xfers[0], &msg);
> @@ -275,23 +271,6 @@ static ssize_t adis16220_write_capture(struct device=
 *dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
> =C2=A0}
>
> -static int adis16220_self_test(struct device *dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 int ret;
> - =C2=A0 =C2=A0 =C2=A0 ret =3D adis16220_spi_write_reg_16(dev,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ADIS16220_MSC_CTRL,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ADIS16220_MSC_CTRL_SELF_TEST_EN);
> - =C2=A0 =C2=A0 =C2=A0 if (ret) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "problem =
starting self test");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_ret;
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 adis16220_check_status(dev);
> -
> -err_ret:
> - =C2=A0 =C2=A0 =C2=A0 return ret;
> -}
> -
> =C2=A0static int adis16220_check_status(struct device *dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 status;
> @@ -320,6 +299,23 @@ error_ret:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>
> +static int adis16220_self_test(struct device *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16220_spi_write_reg_16(dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ADIS16220_MSC_CTRL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ADIS16220_MSC_CTRL_SELF_TEST_EN);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "problem =
starting self test");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 adis16220_check_status(dev);
> +
> +err_ret:
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> =C2=A0static int adis16220_initial_setup(struct adis16220_state *st)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> @@ -433,6 +429,15 @@ static ssize_t adis16220_accel_bin_read(struct kobje=
ct *kobj,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16220=
_CAPT_BUFA);
> =C2=A0}
>
> +static struct bin_attribute accel_bin =3D {
> + =C2=A0 =C2=A0 =C2=A0 .attr =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "accel_bin",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .mode =3D S_IRUSR,
Here i can't understand why read permission is only given to
user(probably root). Why not S_IRUGO which means
(S_IRUSR|S_IRGRP|S_IROTH) ?

> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .read =3D adis16220_accel_bin_read,
> + =C2=A0 =C2=A0 =C2=A0 .size =3D ADIS16220_CAPTURE_SIZE,
> +};
> +
> =C2=A0static ssize_t adis16220_adc1_bin_read(struct kobject *kobj,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct bin_attribute *attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf, loff_t off,
> @@ -447,6 +452,15 @@ static ssize_t adis16220_adc1_bin_read(struct kobjec=
t *kobj,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16220=
_CAPT_BUF1);
> =C2=A0}
>
> +static struct bin_attribute adc1_bin =3D {
> + =C2=A0 =C2=A0 =C2=A0 .attr =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "in0_bin",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .mode =3D S_IRUSR,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .read =3D =C2=A0adis16220_adc1_bin_read,
> + =C2=A0 =C2=A0 =C2=A0 .size =3D ADIS16220_CAPTURE_SIZE,
> +};
> +
> =C2=A0static ssize_t adis16220_adc2_bin_read(struct kobject *kobj,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct bin_attribute *attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf, loff_t off,
> @@ -461,6 +475,16 @@ static ssize_t adis16220_adc2_bin_read(struct kobjec=
t *kobj,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16220=
_CAPT_BUF2);
> =C2=A0}
>
> +
> +static struct bin_attribute adc2_bin =3D {
> + =C2=A0 =C2=A0 =C2=A0 .attr =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "in1_bin",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .mode =3D S_IRUSR,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .read =3D =C2=A0adis16220_adc2_bin_read,
> + =C2=A0 =C2=A0 =C2=A0 .size =3D ADIS16220_CAPTURE_SIZE,
> +};
> +
> =C2=A0static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16220_read_12bit_unsig=
ned,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16220_CAPT_SUP=
PLY);
> =C2=A0static IIO_CONST_ATTR(in_supply_scale, "0.0012207");
> @@ -481,12 +505,12 @@ static IIO_DEV_ATTR_IN_RAW(1, adis16220_read_16bit,=
 ADIS16220_CAPT_BUF2);
> =C2=A0static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adis16220_write_re=
set, 0);
>
> -#define IIO_DEV_ATTR_CAPTURE(_store) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> +#define IIO_DEV_ATTR_CAPTURE(_store) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0IIO_DEVICE_ATTR(capture, S_IWUGO, NULL, _store=
, 0)
>
> =C2=A0static IIO_DEV_ATTR_CAPTURE(adis16220_write_capture);
>
> -#define IIO_DEV_ATTR_CAPTURE_COUNT(_mode, _show, _store, _addr) =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\
> +#define IIO_DEV_ATTR_CAPTURE_COUNT(_mode, _show, _store, _addr) =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> =C2=A0 =C2=A0 =C2=A0 =C2=A0IIO_DEVICE_ATTR(capture_count, _mode, _show, _=
store, _addr)
>
> =C2=A0static IIO_DEV_ATTR_CAPTURE_COUNT(S_IWUSR | S_IRUGO,
> @@ -563,33 +587,15 @@ static int __devinit adis16220_probe(struct spi_dev=
ice *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_free_de=
v;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0regdone =3D 1;
>
> - =C2=A0 =C2=A0 =C2=A0 st->accel_bin.attr.name =3D "accel_bin";
> - =C2=A0 =C2=A0 =C2=A0 st->accel_bin.attr.mode =3D S_IRUGO;
> - =C2=A0 =C2=A0 =C2=A0 st->accel_bin.attr.owner =3D THIS_MODULE;
> - =C2=A0 =C2=A0 =C2=A0 st->accel_bin.read =3D adis16220_accel_bin_read;
> - =C2=A0 =C2=A0 =C2=A0 st->accel_bin.size =3D ADIS16220_CAPTURE_SIZE;
> -
> - =C2=A0 =C2=A0 =C2=A0 ret =3D sysfs_create_bin_file(&st->indio_dev->dev.=
kobj, &st->accel_bin);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D sysfs_create_bin_file(&st->indio_dev->dev.=
kobj, &accel_bin);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_free_de=
v;
>
> - =C2=A0 =C2=A0 =C2=A0 st->adc1_bin.attr.name =3D "adc1_bin";
> - =C2=A0 =C2=A0 =C2=A0 st->adc1_bin.attr.mode =3D S_IRUGO;
> - =C2=A0 =C2=A0 =C2=A0 st->adc1_bin.attr.owner =3D THIS_MODULE;
> - =C2=A0 =C2=A0 =C2=A0 st->adc1_bin.read =3D adis16220_adc1_bin_read;
> - =C2=A0 =C2=A0 =C2=A0 st->adc1_bin.size =3D ADIS16220_CAPTURE_SIZE;
> -
> - =C2=A0 =C2=A0 =C2=A0 ret =3D sysfs_create_bin_file(&st->indio_dev->dev.=
kobj, &st->adc1_bin);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D sysfs_create_bin_file(&st->indio_dev->dev.=
kobj, &adc1_bin);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_rm_acce=
l_bin;
>
> - =C2=A0 =C2=A0 =C2=A0 st->adc2_bin.attr.name =3D "adc2_bin";
> - =C2=A0 =C2=A0 =C2=A0 st->adc2_bin.attr.mode =3D S_IRUGO;
> - =C2=A0 =C2=A0 =C2=A0 st->adc2_bin.attr.owner =3D THIS_MODULE;
> - =C2=A0 =C2=A0 =C2=A0 st->adc2_bin.read =3D adis16220_adc2_bin_read;
> - =C2=A0 =C2=A0 =C2=A0 st->adc2_bin.size =3D ADIS16220_CAPTURE_SIZE;
> -
> - =C2=A0 =C2=A0 =C2=A0 ret =3D sysfs_create_bin_file(&st->indio_dev->dev.=
kobj, &st->adc2_bin);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D sysfs_create_bin_file(&st->indio_dev->dev.=
kobj, &adc2_bin);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_rm_adc1=
_bin;
>
> @@ -600,11 +606,11 @@ static int __devinit adis16220_probe(struct spi_dev=
ice *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> =C2=A0error_rm_adc2_bin:
> - =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &s=
t->adc2_bin);
> + =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &a=
dc2_bin);
> =C2=A0error_rm_adc1_bin:
> - =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &s=
t->adc1_bin);
> + =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &a=
dc1_bin);
> =C2=A0error_rm_accel_bin:
> - =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &s=
t->accel_bin);
> + =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &a=
ccel_bin);
> =C2=A0error_free_dev:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (regdone)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_device_unregis=
ter(st->indio_dev);
> @@ -627,9 +633,9 @@ static int adis16220_remove(struct spi_device *spi)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0flush_scheduled_work();
>
> - =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &s=
t->adc2_bin);
> - =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &s=
t->adc1_bin);
> - =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &s=
t->accel_bin);
> + =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &a=
dc2_bin);
> + =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &a=
dc1_bin);
> + =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &a=
ccel_bin);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_device_unregister(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(st->tx);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(st->rx);
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
