Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Date: Fri, 1 Jun 2012 10:23:39 +0100
Subject: RE: [PATCH 2/8] staging:iio:gyro:adis16260 drop sysfs interface for
 manual device reset.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177150C0FE65C2@LIMKCMBX1.ad.analog.com>
References: <1338406866-3833-1-git-send-email-jic23@kernel.org>
 <1338406866-3833-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1338406866-3833-3-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2012-05-30:
> There is no reason for userspace to do this, so lets
> drop this abi.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/gyro/adis16260_core.c |   19 -------------------
>  1 file changed, 19 deletions(-)
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c
> b/drivers/staging/iio/gyro/adis16260_core.c index ec765f9..a19bf44
> 100644 --- a/drivers/staging/iio/gyro/adis16260_core.c +++
> b/drivers/staging/iio/gyro/adis16260_core.c @@ -233,22 +233,6 @@ static
> int adis16260_reset(struct iio_dev *indio_dev)
>       return ret;
>  }
> -static ssize_t adis16260_write_reset(struct device *dev,
> -             struct device_attribute *attr,
> -             const char *buf, size_t len)
> -{
> -     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> -     if (len < 1)
> -             return -EINVAL;
> -     switch (buf[0]) {
> -     case '1':
> -     case 'y':
> -     case 'Y':
> -             return adis16260_reset(indio_dev);
> -     }
> -     return -EINVAL;
> -}
> -
>  int adis16260_set_irq(struct iio_dev *indio_dev, bool enable) {      int
>  ret; @@ -375,8 +359,6 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR |
>  S_IRUGO,             adis16260_read_frequency,               adis16260_w=
rite_frequency);
> -static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16260_write_reset, 0);
> -
>  static IIO_DEVICE_ATTR(sampling_frequency_available,
>                      S_IRUGO, adis16260_read_frequency_available, NULL,
> 0);
>
> @@ -604,7 +586,6 @@ static int adis16260_write_raw(struct iio_dev
> *indio_dev,
>  static struct attribute *adis16260_attributes[] =3D {
>       &iio_dev_attr_sampling_frequency.dev_attr.attr,
>       &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  -    &iio_dev_attr_reset.dev_attr.attr,      NULL };

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
