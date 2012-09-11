Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Martin =?utf-8?q?Li=C5=A1ka?= <marxin.liska@gmail.com>
Subject: Re: ACPI ambient light sensor
Date: Tue, 11 Sep 2012 11:21:33 +0200
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
 platform-driver-x86@vger.kernel.org,
 linux-iio@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>,
 Corentin Chary <corentin.chary@gmail.com>,
 joeyli <jlee@suse.com>,
 Len Brown <len.brown@intel.com>,
 pavel@denx.de,
 Jonathan Cameron <jic23@kernel.org>,
 Jon Brenner <jbrenner@taosinc.com>,
 Peter Meerwald <pmeerw@pmeerw.net>
References: <CAObPJ3PctmLP56NvmLvJd+4w9e4xeOGSyz24FyBDXBQQVhDhxQ@mail.gmail.com> <4FFADCC2.6080006@cam.ac.uk> <CAObPJ3ORe_MGbmEHzZ4SGqZkn3HCQs+ocSw=Ttb7LbCTNCDkAQ@mail.gmail.com>
In-Reply-To: <CAObPJ3ORe_MGbmEHzZ4SGqZkn3HCQs+ocSw=Ttb7LbCTNCDkAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201209111121.34205.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Martin Li=C5=A1ka,

[...]

> +static int acpi_als_write_raw(struct iio_dev *indio_dev,
> +     struct iio_chan_spec const *chan, int val, int val2, long mask)
> +{
> + return 0;
> +}

Simply set write_raw =3D NULL below (aka. don't put it into the structure a=
t all).

> +static const struct iio_chan_spec acpi_als_channels[] =3D {
> + {
> + .type =3D IIO_LIGHT,
> + .indexed =3D 1,
> + .channel =3D 1,
> + .scan_type.sign =3D 'u',
> + .scan_type.realbits =3D 10,
> + .scan_type.storagebits =3D 16,
> + .info_mask =3D IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
> + IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> + },
> +};
> +
> +static const struct iio_info acpi_als_info =3D {
> + .driver_module =3D THIS_MODULE,
> + .read_raw =3D &acpi_als_read_raw,
> + .write_raw =3D &acpi_als_write_raw,
> +};
[...]
Best regards,
Marek Vasut
