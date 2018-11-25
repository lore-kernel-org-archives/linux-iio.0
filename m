Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeKYWhI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Nov 2018 17:37:08 -0500
Date: Sun, 25 Nov 2018 11:46:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Staging: iio: adt7316: Add of_device_id table
Message-ID: <20181125114609.6273934f@archlinux>
In-Reply-To: <20181120165230.7079-1-shreeya.patel23498@gmail.com>
References: <20181120165230.7079-1-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 20 Nov 2018 22:22:30 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> When the kernel starts up, it kicks off compiled-in drivers
> that match =E2=80=9Ccompatible=E2=80=9D entries it finds in the device tr=
ee.
> At a later stage (when /lib/modules is available), all kernel modules
> that match =E2=80=9Ccompatible=E2=80=9D entries in the device tree are lo=
aded.
>=20
> But if there is no dt table then there should be a fall back path
> with which desired kernel modules can be loaded. Hence, add
> of_device_id table in the i2c driver to be able to use when there
> is no dt table.
The patch is fine, but this description is confusing.

of_device_id is a device tree table (confusing naming in the
kernel, but of is open firmware, a standard from which device tree
emerged).

I've just dropped this second paragraph from the description to
avoid confusion.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan


>=20
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
>=20
> Changes in v2:
>   - Make the commit message appropriate and assign of_match_table
> in the driver structure.
>=20
>  drivers/staging/iio/addac/adt7316-i2c.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/ii=
o/addac/adt7316-i2c.c
> index 473e5e34ec00..41bc4ca008bc 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -126,9 +126,22 @@ static const struct i2c_device_id adt7316_i2c_id[] =
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
> +		.of_match_table =3D adt7316_of_match,
>  		.pm =3D ADT7316_PM_OPS,
>  	},
>  	.probe =3D adt7316_i2c_probe,
