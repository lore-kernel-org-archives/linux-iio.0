Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Date: Fri, 1 Jun 2012 10:23:13 +0100
Subject: RE: [PATCH 3/8] staging:iio:imu:adis16400 drop sysfs interface for
 manual device reset.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177150C0FE65BF@LIMKCMBX1.ad.analog.com>
References: <1338406866-3833-1-git-send-email-jic23@kernel.org>
 <1338406866-3833-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1338406866-3833-4-git-send-email-jic23@kernel.org>
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
>  drivers/staging/iio/imu/adis16400_core.c |   22 ----------------------
>  1 file changed, 22 deletions(-)
> diff --git a/drivers/staging/iio/imu/adis16400_core.c
> b/drivers/staging/iio/imu/adis16400_core.c index 1f6bd85..57b165d 100644
> --- a/drivers/staging/iio/imu/adis16400_core.c +++
> b/drivers/staging/iio/imu/adis16400_core.c @@ -268,25 +268,6 @@ static
> int adis16400_reset(struct iio_dev *indio_dev)
>       return ret;
>  }
> -static ssize_t adis16400_write_reset(struct device *dev,
> -             struct device_attribute *attr,
> -             const char *buf, size_t len)
> -{
> -     bool val;
> -     int ret;
> -
> -     ret =3D strtobool(buf, &val);
> -     if (ret < 0)
> -             return ret;
> -     if (val) {
> -             ret =3D adis16400_reset(dev_to_iio_dev(dev));
> -             if (ret < 0)
> -                     return ret;
> -     }
> -
> -     return len;
> -}
> -
>  int adis16400_set_irq(struct iio_dev *indio_dev, bool enable) {      int
>  ret; @@ -454,8 +435,6 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR |
>  S_IRUGO,                           adis16400_read_frequency,
>  adis16400_write_frequency);
> -static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16400_write_reset, 0);
> -
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("409 546 819 1638");
>
>  enum adis16400_chan {
> @@ -1064,7 +1043,6 @@ static const struct iio_chan_spec
> adis16334_channels[] =3D {
>  static struct attribute *adis16400_attributes[] =3D {
>       &iio_dev_attr_sampling_frequency.dev_attr.attr,
>       &iio_const_attr_sampling_frequency_available.dev_attr.attr,
>  -    &iio_dev_attr_reset.dev_attr.attr,      NULL };

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
