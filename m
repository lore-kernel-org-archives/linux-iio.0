Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 26 Sep 2011 08:40:00 +0100
Subject: RE: [PATCH 02/16] staging:iio:adc:ad799x stop using IIO_CHAN macro.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272ADD@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
 <1316779302-12357-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-3-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-23:
> Preparation for moving driver out of staging.
> That macro is a nightmare to maintain so it is going away.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/adc/ad799x_core.c |  452 ++++++++++++++++++++++++-
>  -------- 1 files changed, 329 insertions(+), 123 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad799x_core.c
> b/drivers/staging/iio/adc/ad799x_core.c index 58f70aa..975a3f7 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c +++
> b/drivers/staging/iio/adc/ad799x_core.c @@ -151,7 +151,7 @@ static int
> ad799x_read_raw(struct iio_dev *dev_info,
>               mutex_lock(&dev_info->mlock);
>               if (iio_buffer_enabled(dev_info))
>                       ret =3D ad799x_single_channel_from_ring(st,
> -                                                           chan->address=
);
> +                                                           chan->scan_in=
dex);
>               else
>                       ret =3D ad799x_scan_direct(st, chan->address);
>               mutex_unlock(&dev_info->mlock);
> @@ -486,167 +486,373 @@ static const struct iio_info ad7993_4_7_8_info
> =3D {
>
>  static const struct ad799x_chip_info ad799x_chip_info_tbl[] =3D {
>       [ad7991] =3D {
> -             .channel[0] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    0, 0, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[1] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    1, 1, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[2] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    2, 2, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[3] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    3, 3, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[4] =3D IIO_CHAN_SOFT_TIMESTAMP(4),
> +             .channel =3D {
> +                     [0] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 0,
> +                             .address =3D 0,
> +                             .scan_index =3D 0,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [1] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 1,
> +                             .address =3D 1,
> +                             .scan_index =3D 1,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [2] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 2,
> +                             .address =3D 2,
> +                             .scan_index =3D 2,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [3] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 3,
> +                             .address =3D 3,
> +                             .scan_index =3D 3,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [4] =3D IIO_CHAN_SOFT_TIMESTAMP(4),
> +             },
>               .num_channels =3D 5,
>               .int_vref_mv =3D 4096,
>               .info =3D &ad7991_info,
>       },
>       [ad7995] =3D {
> -             .channel[0] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    0, 0, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[1] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    1, 1, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[2] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    2, 2, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[3] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    3, 3, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[4] =3D IIO_CHAN_SOFT_TIMESTAMP(4),
> +             .channel =3D {
> +                     [0] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 0,
> +                             .address =3D 0,
> +                             .scan_index =3D 0,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [1] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 1,
> +                             .address =3D 1,
> +                             .scan_index =3D 1,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [2] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 2,
> +                             .address =3D 2,
> +                             .scan_index =3D 2,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [3] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 3,
> +                             .address =3D 3,
> +                             .scan_index =3D 3,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [4] =3D IIO_CHAN_SOFT_TIMESTAMP(4),
> +             },
>               .num_channels =3D 5,
>               .int_vref_mv =3D 1024,
>               .info =3D &ad7991_info,
>       },
>       [ad7999] =3D {
> -             .channel[0] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    0, 0, IIO_ST('u', 8, 16, 4), 0),
> -             .channel[1] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    1, 1, IIO_ST('u', 8, 16, 4), 0),
> -             .channel[2] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    2, 2, IIO_ST('u', 8, 16, 4), 0),
> -             .channel[3] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    3, 3, IIO_ST('u', 8, 16, 4), 0),
> -             .channel[4] =3D IIO_CHAN_SOFT_TIMESTAMP(4),
> +             .channel =3D {
> +                     [0] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 0,
> +                             .address =3D 0,
> +                             .scan_index =3D 0,
> +                             .scan_type =3D IIO_ST('u', 8, 16, 4),
> +                     },
> +                     [1] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 1,
> +                             .address =3D 1,
> +                             .scan_index =3D 1,
> +                             .scan_type =3D IIO_ST('u', 8, 16, 4),
> +                     },
> +                     [2] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 2,
> +                             .address =3D 2,
> +                             .scan_index =3D 2,
> +                             .scan_type =3D IIO_ST('u', 8, 16, 4),
> +                     },
> +                     [3] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 3,
> +                             .address =3D 3,
> +                             .scan_index =3D 3,
> +                             .scan_type =3D IIO_ST('u', 8, 16, 4),
> +                     },
> +                     [4] =3D IIO_CHAN_SOFT_TIMESTAMP(4),
> +             },
>               .num_channels =3D 5,
>               .int_vref_mv =3D 1024,
>               .info =3D &ad7991_info,
>       },
>       [ad7992] =3D {
> -             .channel[0] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    0, 0, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[1] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    1, 1, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[2] =3D IIO_CHAN_SOFT_TIMESTAMP(2),
> +             .channel =3D {
> +                     [0] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 0,
> +                             .address =3D 0,
> +                             .scan_index =3D 0,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [1] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 1,
> +                             .address =3D 1,
> +                             .scan_index =3D 1,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [2] =3D IIO_CHAN_SOFT_TIMESTAMP(2),
> +             },
>               .num_channels =3D 3,
>               .int_vref_mv =3D 4096,
>               .default_config =3D AD7998_ALERT_EN,
>               .info =3D &ad7992_info,
>       },
>       [ad7993] =3D {
> -             .channel[0] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    0, 0, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[1] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    1, 1, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[2] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    2, 2, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[3] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    3, 3, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[4] =3D IIO_CHAN_SOFT_TIMESTAMP(4),
> +             .channel =3D {
> +                     [0] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 0,
> +                             .address =3D 0,
> +                             .scan_index =3D 0,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [1] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 1,
> +                             .address =3D 1,
> +                             .scan_index =3D 1,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [2] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 2,
> +                             .address =3D 2,
> +                             .scan_index =3D 2,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [3] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 3,
> +                             .address =3D 3,
> +                             .scan_index =3D 3,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [4] =3D IIO_CHAN_SOFT_TIMESTAMP(4),
> +             },
>               .num_channels =3D 5,
>               .int_vref_mv =3D 1024,
>               .default_config =3D AD7998_ALERT_EN,
>               .info =3D &ad7993_4_7_8_info,
>       },
>       [ad7994] =3D {
> -             .channel[0] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    0, 0, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[1] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    1, 1, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[2] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    2, 2, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[3] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    3, 3, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[4] =3D IIO_CHAN_SOFT_TIMESTAMP(4),
> +             .channel =3D {
> +                     [0] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 0,
> +                             .address =3D 0,
> +                             .scan_index =3D 0,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [1] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 1,
> +                             .address =3D 1,
> +                             .scan_index =3D 1,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [2] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 2,
> +                             .address =3D 2,
> +                             .scan_index =3D 2,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [3] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 3,
> +                             .address =3D 3,
> +                             .scan_index =3D 3,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [4] =3D IIO_CHAN_SOFT_TIMESTAMP(4),
> +             },
>               .num_channels =3D 5,
>               .int_vref_mv =3D 4096,
>               .default_config =3D AD7998_ALERT_EN,
>               .info =3D &ad7993_4_7_8_info,
>       },
>       [ad7997] =3D {
> -             .channel[0] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -                                       (1 << IIO_CHAN_INFO_SCALE_SHARED)=
,
> -                                       0, 0, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[1] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
> -                                       (1 << IIO_CHAN_INFO_SCALE_SHARED)=
,
> -                                       1, 1, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[2] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
> -                                       (1 << IIO_CHAN_INFO_SCALE_SHARED)=
,
> -                                       2, 2, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[3] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
> -                                       (1 << IIO_CHAN_INFO_SCALE_SHARED)=
,
> -                                       3, 3, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[4] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 4, 0,
> -                                       (1 << IIO_CHAN_INFO_SCALE_SHARED)=
,
> -                                       4, 4, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[5] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 5, 0,
> -                                       (1 << IIO_CHAN_INFO_SCALE_SHARED)=
,
> -                                       5, 5, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[6] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 6, 0,
> -                                       (1 << IIO_CHAN_INFO_SCALE_SHARED)=
,
> -                                       6, 6, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[7] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 7, 0,
> -                                       (1 << IIO_CHAN_INFO_SCALE_SHARED)=
,
> -                                       7, 7, IIO_ST('u', 10, 16, 2), 0),
> -             .channel[8] =3D IIO_CHAN_SOFT_TIMESTAMP(8),
> +             .channel =3D {
> +                     [0] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 0,
> +                             .address =3D 0,
> +                             .scan_index =3D 0,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [1] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 1,
> +                             .address =3D 1,
> +                             .scan_index =3D 1,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [2] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 2,
> +                             .address =3D 2,
> +                             .scan_index =3D 2,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [3] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 3,
> +                             .address =3D 3,
> +                             .scan_index =3D 3,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [4] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 4,
> +                             .address =3D 4,
> +                             .scan_index =3D 4,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [5] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 5,
> +                             .address =3D 5,
> +                             .scan_index =3D 5,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [6] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 6,
> +                             .address =3D 6,
> +                             .scan_index =3D 6,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [7] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 7,
> +                             .address =3D 7,
> +                             .scan_index =3D 7,
> +                             .scan_type =3D IIO_ST('u', 10, 16, 2),
> +                     },
> +                     [8] =3D IIO_CHAN_SOFT_TIMESTAMP(8),
> +             },
>               .num_channels =3D 9,
>               .int_vref_mv =3D 1024,
>               .default_config =3D AD7998_ALERT_EN,
>               .info =3D &ad7993_4_7_8_info,
>       },
>       [ad7998] =3D {
> -             .channel[0] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    0, 0, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[1] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    1, 1, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[2] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    2, 2, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[3] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    3, 3, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[4] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 4, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    4, 4, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[5] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 5, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    5, 5, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[6] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 6, 0,
> -                                    (1 << IIO_CHAN_INFO_SCALE_SHARED),
> -                                    6, 6, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[7] =3D IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 7, 0,
> -                                       (1 << IIO_CHAN_INFO_SCALE_SHARED)=
,
> -                                       7, 7, IIO_ST('u', 12, 16, 0), 0),
> -             .channel[8] =3D IIO_CHAN_SOFT_TIMESTAMP(8),
> +             .channel =3D {
> +                     [0] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 0,
> +                             .address =3D 0,
> +                             .scan_index =3D 0,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [1] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 1,
> +                             .address =3D 1,
> +                             .scan_index =3D 1,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [2] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 2,
> +                             .address =3D 2,
> +                             .scan_index =3D 2,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [3] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 3,
> +                             .address =3D 3,
> +                             .scan_index =3D 3,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [4] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 4,
> +                             .address =3D 4,
> +                             .scan_index =3D 4,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [5] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 5,
> +                             .address =3D 5,
> +                             .scan_index =3D 5,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [6] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 6,
> +                             .address =3D 6,
> +                             .scan_index =3D 6,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [7] =3D {
> +                             .type =3D IIO_VOLTAGE,
> +                             .indexed =3D 1,
> +                             .channel =3D 7,
> +                             .address =3D 7,
> +                             .scan_index =3D 7,
> +                             .scan_type =3D IIO_ST('u', 12, 16, 0),
> +                     },
> +                     [8] =3D IIO_CHAN_SOFT_TIMESTAMP(8),
> +             },
>               .num_channels =3D 9,
>               .int_vref_mv =3D 4096,
>               .default_config =3D AD7998_ALERT_EN,

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
