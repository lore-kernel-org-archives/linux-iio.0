Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: uclinux-dist-devel <uclinux-dist-devel@blackfin.uclinux.org>
Date: Tue, 18 May 2010 14:43:36 +0100
Subject: RE: [PATCH 1/3] staging:iio:max1363 use device_id instead of
 searching on name again
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712E568FC4C2@LIMKCMBX1.ad.analog.com>
References: <1274132150-29256-1-git-send-email-jic23@cam.ac.uk>
 <1274132150-29256-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1274132150-29256-2-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-05-17:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/max1363.h      |    3 +-
>  drivers/staging/iio/adc/max1363_core.c |  152
> +++++++++++++++---------
> --------
>  2 files changed, 75 insertions(+), 80 deletions(-)
> diff --git a/drivers/staging/iio/adc/max1363.h
> b/drivers/staging/iio/adc/max1363.h index 72cf367..eb20c68 100644 ---
> a/drivers/staging/iio/adc/max1363.h +++
> b/drivers/staging/iio/adc/max1363.h @@ -179,7 +179,6 @@ enum

--[snip]--

> +     st->chip_info =3D &max1363_chip_info_tbl[id->driver_data];
> +     st->name =3D kstrdup(id->name, GFP_KERNEL);
> +     if (st->name =3D=3D NULL) {
> +             ret =3D -ENOMEM;


Isn't id->name =3D=3D client->name ?

static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id =
*id,
                                                const struct i2c_client *cl=
ient)
{
        while (id->name[0]) {
                if (strcmp(client->name, id->name) =3D=3D 0)
                        return id;
                id++;
        }
        return NULL;
}

So you don't need an extra copy simply use client->name


Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
