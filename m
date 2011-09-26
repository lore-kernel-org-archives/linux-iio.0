Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 26 Sep 2011 08:51:38 +0100
Subject: RE: [PATCH 07/16] staging:iio:adc:ad799x use the core handling for
 as much of the events as possible.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272AF2@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
 <1316779302-12357-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-8-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-23:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/adc/ad799x_core.c |  142 +++++++++++++++++++------
>  -------- 1 files changed, 82 insertions(+), 60 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad799x_core.c
> b/drivers/staging/iio/adc/ad799x_core.c index a24d695..304d9ae 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c +++
> b/drivers/staging/iio/adc/ad799x_core.c @@ -236,6 +236,61 @@
> error_ret_mutex:
>       return ret ? ret : len;
>  }
> +static int ad799x_read_event_config(struct iio_dev *dev_info, +
> u64 event_code) +{ +  return 1; +} + +static const u8
> ad799x_threshold_addresses[][2] =3D { + { AD7998_DATALOW_CH1_REG,
> AD7998_DATAHIGH_CH1_REG }, +  { AD7998_DATALOW_CH2_REG,
> AD7998_DATAHIGH_CH2_REG }, +  { AD7998_DATALOW_CH3_REG,
> AD7998_DATAHIGH_CH3_REG }, +  { AD7998_DATALOW_CH4_REG,
> AD7998_DATAHIGH_CH4_REG }, +}; + +static int
> ad799x_write_event_value(struct iio_dev *indio_dev, +                    =
         u64
> event_code, +                             int val) +{ +       int ret; + =
     struct ad799x_state *st =3D
> iio_priv(indio_dev); +        int direction =3D
> !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) =3D=3D +                       =
    IIO_EV_DIR_FALLING);
> +     int number =3D IIO_EVENT_CODE_EXTRACT_NUM(event_code); +
> +     mutex_lock(&indio_dev->mlock); +        ret =3D ad799x_i2c_write16(=
st, +
> ad799x_threshold_addresses[number][direction], +                         =
      val);
> +     mutex_unlock(&indio_dev->mlock); + +    return ret; +} + +static in=
t
> ad799x_read_event_value(struct iio_dev *indio_dev, +                     =
         u64
> event_code, +                             int *val) +{ +      int ret; + =
     struct ad799x_state *st =3D
> iio_priv(indio_dev); +        int direction =3D
> !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) =3D=3D +                       =
    IIO_EV_DIR_FALLING);
> +     int number =3D IIO_EVENT_CODE_EXTRACT_NUM(event_code); +  u16 valin=
; +
> +     mutex_lock(&indio_dev->mlock); +        ret =3D ad799x_i2c_read16(s=
t,
> +                             ad799x_threshold_addresses[number][directio=
n], +                                &valin);
> +     mutex_unlock(&indio_dev->mlock); +      if (ret < 0) +          ret=
urn ret; +   *val
> =3D valin; + +  return 0; +} +
>  static ssize_t ad799x_read_channel_config(struct device *dev,
>                                       struct device_attribute *attr,
>                                       char *buf)
> @@ -310,72 +365,24 @@ static irqreturn_t ad799x_event_handler(int irq,
> void *private)
>       return IRQ_HANDLED;
>  }
> -static IIO_DEVICE_ATTR(in_voltage0_thresh_low_value,
> -                    S_IRUGO | S_IWUSR,
> -                    ad799x_read_channel_config,
> -                    ad799x_write_channel_config,
> -                    AD7998_DATALOW_CH1_REG);
> -
> -static IIO_DEVICE_ATTR(in_voltage0_thresh_high_value,
> -                    S_IRUGO | S_IWUSR,
> -                    ad799x_read_channel_config,
> -                    ad799x_write_channel_config,
> -                    AD7998_DATAHIGH_CH1_REG);
> -
>  static IIO_DEVICE_ATTR(in_voltage0_thresh_both_hyst_raw,
>                      S_IRUGO | S_IWUSR,
>                      ad799x_read_channel_config,
>                      ad799x_write_channel_config,
>                      AD7998_HYST_CH1_REG);
> -static IIO_DEVICE_ATTR(in_voltage1_thresh_low_value,
> -                    S_IRUGO | S_IWUSR,
> -                    ad799x_read_channel_config,
> -                    ad799x_write_channel_config,
> -                    AD7998_DATALOW_CH2_REG);
> -
> -static IIO_DEVICE_ATTR(in_voltage1_thresh_high_value,
> -                    S_IRUGO | S_IWUSR,
> -                    ad799x_read_channel_config,
> -                    ad799x_write_channel_config,
> -                    AD7998_DATAHIGH_CH2_REG);
> -
>  static IIO_DEVICE_ATTR(in_voltage1_thresh_both_hyst_raw,
>                      S_IRUGO | S_IWUSR,
>                      ad799x_read_channel_config,
>                      ad799x_write_channel_config,
>                      AD7998_HYST_CH2_REG);
> -static IIO_DEVICE_ATTR(in_voltage2_thresh_low_value,
> -                    S_IRUGO | S_IWUSR,
> -                    ad799x_read_channel_config,
> -                    ad799x_write_channel_config,
> -                    AD7998_DATALOW_CH3_REG);
> -
> -static IIO_DEVICE_ATTR(in_voltage2_thresh_high_value,
> -                    S_IRUGO | S_IWUSR,
> -                    ad799x_read_channel_config,
> -                    ad799x_write_channel_config,
> -                    AD7998_DATAHIGH_CH3_REG);
> -
>  static IIO_DEVICE_ATTR(in_voltage2_thresh_both_hyst_raw,
>                      S_IRUGO | S_IWUSR,
>                      ad799x_read_channel_config,
>                      ad799x_write_channel_config,
>                      AD7998_HYST_CH3_REG);
> -static IIO_DEVICE_ATTR(in_voltage3_thresh_low_value,
> -                    S_IRUGO | S_IWUSR,
> -                    ad799x_read_channel_config,
> -                    ad799x_write_channel_config,
> -                    AD7998_DATALOW_CH4_REG);
> -
> -static IIO_DEVICE_ATTR(in_voltage3_thresh_high_value,
> -                    S_IRUGO | S_IWUSR,
> -                    ad799x_read_channel_config,
> -                    ad799x_write_channel_config,
> -                    AD7998_DATAHIGH_CH4_REG);
> -
>  static IIO_DEVICE_ATTR(in_voltage3_thresh_both_hyst_raw,
>  S_IRUGO | S_IWUSR,                  ad799x_read_channel_config, @@ -388,=
17
>  +395,9 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO, static
>  IIO_CONST_ATTR_SAMP_FREQ_AVAIL("15625 7812 3906 1953 976 488
> 244 0");
>
>  static struct attribute *ad7993_4_7_8_event_attributes[] =3D {
> -     &iio_dev_attr_in_voltage0_thresh_low_value.dev_attr.attr,
> -     &iio_dev_attr_in_voltage0_thresh_high_value.dev_attr.attr,
>       &iio_dev_attr_in_voltage0_thresh_both_hyst_raw.dev_attr.attr,
> -     &iio_dev_attr_in_voltage1_thresh_low_value.dev_attr.attr,
> -     &iio_dev_attr_in_voltage1_thresh_high_value.dev_attr.attr,
>       &iio_dev_attr_in_voltage1_thresh_both_hyst_raw.dev_attr.attr,
> -     &iio_dev_attr_in_voltage2_thresh_low_value.dev_attr.attr,
> -     &iio_dev_attr_in_voltage2_thresh_high_value.dev_attr.attr,
>       &iio_dev_attr_in_voltage2_thresh_both_hyst_raw.dev_attr.attr,
> -     &iio_dev_attr_in_voltage3_thresh_low_value.dev_attr.attr,
> -     &iio_dev_attr_in_voltage3_thresh_high_value.dev_attr.attr,
>       &iio_dev_attr_in_voltage3_thresh_both_hyst_raw.dev_attr.attr,
>       &iio_dev_attr_sampling_frequency.dev_attr.attr,
>       &iio_const_attr_sampling_frequency_available.dev_attr.attr,
> @@ -411,11 +410,7 @@ static struct attribute_group
> ad7993_4_7_8_event_attrs_group =3D {
>  };
>
>  static struct attribute *ad7992_event_attributes[] =3D {
> -     &iio_dev_attr_in_voltage0_thresh_low_value.dev_attr.attr,
> -     &iio_dev_attr_in_voltage0_thresh_high_value.dev_attr.attr,
>       &iio_dev_attr_in_voltage0_thresh_both_hyst_raw.dev_attr.attr,
> -     &iio_dev_attr_in_voltage1_thresh_low_value.dev_attr.attr,
> -     &iio_dev_attr_in_voltage1_thresh_high_value.dev_attr.attr,
>       &iio_dev_attr_in_voltage1_thresh_both_hyst_raw.dev_attr.attr,
>       &iio_dev_attr_sampling_frequency.dev_attr.attr,
>       &iio_const_attr_sampling_frequency_available.dev_attr.attr, @@ -435=
,15
>  +430,24 @@ static const struct iio_info ad7991_info =3D { static const
>  struct iio_info ad7992_info =3D {      .read_raw =3D &ad799x_read_raw,
>       .event_attrs =3D &ad7992_event_attrs_group,
> +     .read_event_config =3D &ad799x_read_event_config,
> +     .read_event_value =3D &ad799x_read_event_value,
> +     .write_event_value =3D &ad799x_write_event_value,
>       .driver_module =3D THIS_MODULE,
>  };
>
>  static const struct iio_info ad7993_4_7_8_info =3D {
>       .read_raw =3D &ad799x_read_raw,
>       .event_attrs =3D &ad7993_4_7_8_event_attrs_group,
> +     .read_event_config =3D &ad799x_read_event_config,
> +     .read_event_value =3D &ad799x_read_event_value,
> +     .write_event_value =3D &ad799x_write_event_value,
>       .driver_module =3D THIS_MODULE,
>  };
> +#define AD799X_EV_MASK (IIO_EV_BIT(IIO_EV_TYPE_THRESH,
> IIO_EV_DIR_RISING) | \
> +                     IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
> +
>  static const struct ad799x_chip_info ad799x_chip_info_tbl[] =3D {
>       [ad7991] =3D {
>               .channel =3D {
> @@ -574,6 +578,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 0,                           .=
scan_index =3D 0,                                .scan_type =3D IIO_ST('u',=
 12,
>  16, 0), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [1] =3D {                           =
      .type =3D
>  IIO_VOLTAGE,
> @@ -582,6 +587,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 1,                           .=
scan_index =3D 1,                                .scan_type =3D IIO_ST('u',=
 12,
>  16, 0), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [2] =3D
>  IIO_CHAN_SOFT_TIMESTAMP(2),          },
> @@ -599,6 +605,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 0,                           .=
scan_index =3D 0,                                .scan_type =3D IIO_ST('u',=
 10,
>  16, 2), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [1] =3D {                           =
      .type =3D
>  IIO_VOLTAGE,
> @@ -607,6 +614,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 1,                           .=
scan_index =3D 1,                                .scan_type =3D IIO_ST('u',=
 10,
>  16, 2), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [2] =3D {                           =
      .type =3D
>  IIO_VOLTAGE,
> @@ -615,6 +623,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 2,                           .=
scan_index =3D 2,                                .scan_type =3D IIO_ST('u',=
 10,
>  16, 2), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [3] =3D {                           =
      .type =3D
>  IIO_VOLTAGE,
> @@ -623,6 +632,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 3,                           .=
scan_index =3D 3,                                .scan_type =3D IIO_ST('u',=
 10,
>  16, 2), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [4] =3D
>  IIO_CHAN_SOFT_TIMESTAMP(4),          },
> @@ -640,6 +650,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 0,                           .=
scan_index =3D 0,                                .scan_type =3D IIO_ST('u',=
 12,
>  16, 0), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [1] =3D {                           =
      .type =3D
>  IIO_VOLTAGE,
> @@ -648,6 +659,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 1,                           .=
scan_index =3D 1,                                .scan_type =3D IIO_ST('u',=
 12,
>  16, 0), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [2] =3D {                           =
      .type =3D
>  IIO_VOLTAGE,
> @@ -656,6 +668,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 2,                           .=
scan_index =3D 2,                                .scan_type =3D IIO_ST('u',=
 12,
>  16, 0), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [3] =3D {                           =
      .type =3D
>  IIO_VOLTAGE,
> @@ -664,6 +677,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 3,                           .=
scan_index =3D 3,                                .scan_type =3D IIO_ST('u',=
 12,
>  16, 0), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [4] =3D
>  IIO_CHAN_SOFT_TIMESTAMP(4),          },
> @@ -681,6 +695,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 0,                           .=
scan_index =3D 0,                                .scan_type =3D IIO_ST('u',=
 10,
>  16, 2), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [1] =3D {                           =
      .type =3D
>  IIO_VOLTAGE,
> @@ -689,6 +704,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 1,                           .=
scan_index =3D 1,                                .scan_type =3D IIO_ST('u',=
 10,
>  16, 2), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [2] =3D {                           =
      .type =3D
>  IIO_VOLTAGE,
> @@ -697,6 +713,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 2,                           .=
scan_index =3D 2,                                .scan_type =3D IIO_ST('u',=
 10,
>  16, 2), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [3] =3D {                           =
      .type =3D
>  IIO_VOLTAGE,
> @@ -705,6 +722,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 3,                           .=
scan_index =3D 3,                                .scan_type =3D IIO_ST('u',=
 10,
>  16, 2), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [4] =3D {                           =
      .type =3D
>  IIO_VOLTAGE,
> @@ -754,6 +772,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 0,                           .=
scan_index =3D 0,                                .scan_type =3D IIO_ST('u',=
 12,
>  16, 0), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [1] =3D {                           =
      .type =3D
>  IIO_VOLTAGE,
> @@ -762,6 +781,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 1,                           .=
scan_index =3D 1,                                .scan_type =3D IIO_ST('u',=
 12,
>  16, 0), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [2] =3D {                           =
      .type =3D
>  IIO_VOLTAGE,
> @@ -770,6 +790,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .address =3D 2,                           .=
scan_index =3D 2,                                .scan_type =3D IIO_ST('u',=
 12,
>  16, 0), +                            .event_mask =3D AD799X_EV_MASK,    =
               },                      [3] =3D {                           =
      .type =3D
>  IIO_VOLTAGE,
> @@ -778,6 +799,7 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
                                .address =3D 3,                           .=
scan_index =3D 3,                                .scan_type =3D IIO_ST('u',=
 12,
 16, 0), +                              .event_mask =3D AD799X_EV_MASK,    =
               },                      [4] =3D {                           =
      .type =3D
 IIO_VOLTAGE,

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
