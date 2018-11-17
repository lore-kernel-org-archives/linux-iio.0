Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeKRDWk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Nov 2018 22:22:40 -0500
Date: Sat, 17 Nov 2018 17:05:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] Staging: iio: adt7316: Add of_device_id table
Message-ID: <20181117170517.29ebecdd@archlinux>
In-Reply-To: <20181116225537.24723-1-shreeya.patel23498@gmail.com>
References: <20181116225537.24723-1-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Nov 2018 04:25:37 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> When the kernel starts up, it kicks off compiled-in drivers
> that match =E2=80=9Ccompatible=E2=80=9D entries it finds in the device tr=
ee.
> At a later stage (when /lib/modules is available), all kernel modules
> that match =E2=80=9Ccompatible=E2=80=9D entries in the device tree are lo=
aded.
> Hence to be able to use device tree for ADT7316, add of_device_id
> table which specifies the supported devices through compatible
> property.
> Note that there is a fall back path in i2c that will result
> in i2c_device_id table being used if there is no of_devcie_id table.
of_device_id

Should also assign of_match_table in the driver structure so that
we will use these to match when probing rather than just
for module autoloading which is what this does.  See for
example drivers/adc/max1363.c

Do not use of_match_ptr, just assign directly to avoid blocking
the random ACPI probing with DT bindings route.

This does make me wonder if the adt7518 is compatible or not
as those are fairly random part numbers!

Thanks,

Jonathan
>=20
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
>  drivers/staging/iio/addac/adt7316-i2c.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/ii=
o/addac/adt7316-i2c.c
> index 473e5e34ec00..d4b5060c18ee 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -126,6 +126,18 @@ static const struct i2c_device_id adt7316_i2c_id[] =
=3D {
> =20
>  MODULE_DEVICE_TABLE(i2c, adt7316_i2c_id);
> =20
> +static const struct of_device_id adt7316_of_match[] =3D {
> +	{ .compatible =3D "adi,adt7316" },
> +	{ .compatible =3D "adi,adt7317" },
> +	{ .compatible =3D "adi,adt7318" },
> +	{ .compatible =3D "adi,adt7516" },
> +	{ .compatible =3D "adi,adt7517" },
> +	{ .compatible =3D "adi,adt7519" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, adt7316_of_match);
> +
>  static struct i2c_driver adt7316_driver =3D {
>  	.driver =3D {
>  		.name =3D "adt7316",
