Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Mon, 26 Sep 2011 08:32:18 +0100
Subject: RE: [PATCH 09/16] staging:iio:adc:ad799x address and scan_index
 always match so stop using address
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272ACE@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
 <1316779302-12357-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-10-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-23:
> Saves on setting the value of address for the simple situation seen in
> this device. They are already used interchangably to get data from the
> buffer.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/adc/ad799x_core.c |   40 +------------------------
>  -------- 1 files changed, 1 insertions(+), 39 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad799x_core.c
> b/drivers/staging/iio/adc/ad799x_core.c index 879b9d8..982c42c 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c +++
> b/drivers/staging/iio/adc/ad799x_core.c @@ -154,7 +154,7 @@ static int
> ad799x_read_raw(struct iio_dev *dev_info,
>                       ret =3D ad799x_single_channel_from_ring(dev_info,
>                                                             chan->scan_in=
dex);
>               else
> -                     ret =3D ad799x_scan_direct(st, chan->address);
> +                     ret =3D ad799x_scan_direct(st, chan->scan_index);
>               mutex_unlock(&dev_info->mlock);
>
>               if (ret < 0)
> @@ -455,7 +455,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 0,
>  -                            .address =3D 0,                           .=
scan_index =3D 0,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                  },
> @@ -463,7 +462,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 1,
>  -                            .address =3D 1,                           .=
scan_index =3D 1,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                  },
> @@ -471,7 +469,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 2,
>  -                            .address =3D 2,                           .=
scan_index =3D 2,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                  },
> @@ -479,7 +476,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 3,
>  -                            .address =3D 3,                           .=
scan_index =3D 3,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                  },
> @@ -495,7 +491,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 0,
>  -                            .address =3D 0,                           .=
scan_index =3D 0,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                  },
> @@ -503,7 +498,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 1,
>  -                            .address =3D 1,                           .=
scan_index =3D 1,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                  },
> @@ -511,7 +505,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 2,
>  -                            .address =3D 2,                           .=
scan_index =3D 2,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                  },
> @@ -519,7 +512,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 3,
>  -                            .address =3D 3,                           .=
scan_index =3D 3,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                  },
> @@ -535,7 +527,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 0,
>  -                            .address =3D 0,                           .=
scan_index =3D 0,                                .scan_type =3D IIO_ST('u',=
 8,
>  16, 4),                      },
> @@ -543,7 +534,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 1,
>  -                            .address =3D 1,                           .=
scan_index =3D 1,                                .scan_type =3D IIO_ST('u',=
 8,
>  16, 4),                      },
> @@ -551,7 +541,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 2,
>  -                            .address =3D 2,                           .=
scan_index =3D 2,                                .scan_type =3D IIO_ST('u',=
 8,
>  16, 4),                      },
> @@ -559,7 +548,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 3,
>  -                            .address =3D 3,                           .=
scan_index =3D 3,                                .scan_type =3D IIO_ST('u',=
 8,
>  16, 4),                      },
> @@ -575,7 +563,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 0,
>  -                            .address =3D 0,                           .=
scan_index =3D 0,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                          .event_mask =3D AD799X_EV_MASK,
> @@ -584,7 +571,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 1,
>  -                            .address =3D 1,                           .=
scan_index =3D 1,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                          .event_mask =3D AD799X_EV_MASK,
> @@ -602,7 +588,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 0,
>  -                            .address =3D 0,                           .=
scan_index =3D 0,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                          .event_mask =3D AD799X_EV_MASK,
> @@ -611,7 +596,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 1,
>  -                            .address =3D 1,                           .=
scan_index =3D 1,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                          .event_mask =3D AD799X_EV_MASK,
> @@ -620,7 +604,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 2,
>  -                            .address =3D 2,                           .=
scan_index =3D 2,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                          .event_mask =3D AD799X_EV_MASK,
> @@ -629,7 +612,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 3,
>  -                            .address =3D 3,                           .=
scan_index =3D 3,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                          .event_mask =3D AD799X_EV_MASK,
> @@ -647,7 +629,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 0,
>  -                            .address =3D 0,                           .=
scan_index =3D 0,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                          .event_mask =3D AD799X_EV_MASK,
> @@ -656,7 +637,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 1,
>  -                            .address =3D 1,                           .=
scan_index =3D 1,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                          .event_mask =3D AD799X_EV_MASK,
> @@ -665,7 +645,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 2,
>  -                            .address =3D 2,                           .=
scan_index =3D 2,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                          .event_mask =3D AD799X_EV_MASK,
> @@ -674,7 +653,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 3,
>  -                            .address =3D 3,                           .=
scan_index =3D 3,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                          .event_mask =3D AD799X_EV_MASK,
> @@ -692,7 +670,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 0,
>  -                            .address =3D 0,                           .=
scan_index =3D 0,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                          .event_mask =3D AD799X_EV_MASK,
> @@ -701,7 +678,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 1,
>  -                            .address =3D 1,                           .=
scan_index =3D 1,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                          .event_mask =3D AD799X_EV_MASK,
> @@ -710,7 +686,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 2,
>  -                            .address =3D 2,                           .=
scan_index =3D 2,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                          .event_mask =3D AD799X_EV_MASK,
> @@ -719,7 +694,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 3,
>  -                            .address =3D 3,                           .=
scan_index =3D 3,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                          .event_mask =3D AD799X_EV_MASK,
> @@ -728,7 +702,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 4,
>  -                            .address =3D 4,                           .=
scan_index =3D 4,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                  },
> @@ -736,7 +709,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 5,
>  -                            .address =3D 5,                           .=
scan_index =3D 5,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                  },
> @@ -744,7 +716,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 6,
>  -                            .address =3D 6,                           .=
scan_index =3D 6,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                  },
> @@ -752,7 +723,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 7,
>  -                            .address =3D 7,                           .=
scan_index =3D 7,                                .scan_type =3D IIO_ST('u',
>  10, 16, 2),                  },
> @@ -769,7 +739,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 0,
>  -                            .address =3D 0,                           .=
scan_index =3D 0,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                          .event_mask =3D AD799X_EV_MASK,
> @@ -778,7 +747,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 1,
>  -                            .address =3D 1,                           .=
scan_index =3D 1,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                          .event_mask =3D AD799X_EV_MASK,
> @@ -787,7 +755,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 2,
>  -                            .address =3D 2,                           .=
scan_index =3D 2,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                          .event_mask =3D AD799X_EV_MASK,
> @@ -796,7 +763,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 3,
>  -                            .address =3D 3,                           .=
scan_index =3D 3,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                          .event_mask =3D AD799X_EV_MASK,
> @@ -805,7 +771,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 4,
>  -                            .address =3D 4,                           .=
scan_index =3D 4,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                  },
> @@ -813,7 +778,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 5,
>  -                            .address =3D 5,                           .=
scan_index =3D 5,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                  },
> @@ -821,7 +785,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
>                               .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 6,
>  -                            .address =3D 6,                           .=
scan_index =3D 6,                                .scan_type =3D IIO_ST('u',
>  12, 16, 0),                  },
> @@ -829,7 +792,6 @@ static const struct ad799x_chip_info
> ad799x_chip_info_tbl[] =3D {
                                .type =3D IIO_VOLTAGE,                     =
       .indexed =3D 1,                           .channel =3D 7,
 -                              .address =3D 7,                           .=
scan_index =3D 7,                                .scan_type =3D IIO_ST('u',=
 12,
 16, 0),                        },

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
