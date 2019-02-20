Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C527DC43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 16:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174192084D
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 16:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Bhf2Yunq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfBTQI6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:08:58 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:30499 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfBTQI6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Feb 2019 11:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550678934;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=tj/6Tgs22Zv5iXdELkcj2akEm7EPKJK2K5kW/Jls+Cc=;
        b=Bhf2YunqocdhxxGGumwfNpS7oLpgOX8pNhFFjKceshm6yll+gmL0z/9Np6LrXATX1t
        djWWXEHxxZ6TTa45eHSow0D9kqAMH++0/pRkDgbq/JZmCWgSXRkAUQHp2YvXpc8k4Dvm
        mYeTsQHkK4flTAfdWuEiu+GLJag9942PO8SJlq3Uh0DJ8JvbJd+DTjDo/er64SGZia/4
        nX2ppEODLHu3OAeSD0NDlm4siunOTJjdg4P6UbNs5VENtinVLuZuChXt/S9Y6vkceOFP
        PbYkX3I8E8eAMJQzIRC4is+l6pfglOlFC1ihPUlHOMi5K7dwA9cKSJ79Wr4gJd4wKrp3
        nlyQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/ztwDXG"
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KG8rFZZ
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 17:08:53 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] iio: Allow to read mount matrix from ACPI
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190220152052.31901-1-andriy.shevchenko@linux.intel.com>
Date:   Wed, 20 Feb 2019 17:08:52 +0100
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A4C8B4CF-FA03-4330-8B02-6B6DE43CE8BC@goldelico.com>
References: <20190220152052.31901-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

> Am 20.02.2019 um 16:20 schrieb Andy Shevchenko =
<andriy.shevchenko@linux.intel.com>:
>=20
> Currently mount matrix is allowed in Device Tree, though there is
> no technical issue to extend it to support ACPI.
>=20
> Convert the function to use device_property_read_string_array() and
> thus allow to read mount matrix from ACPI if available.
>=20
> At the same time drop the "of" prefix from its name and
> convert current users.

Maybe we can drop the "of" prefix after my earlier patches have been =
accepted?

So that you patch does not break compile of my patch series.

>=20
> No functional change intended.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> drivers/iio/accel/kxsd9.c                  |  2 +-
> drivers/iio/gyro/mpu3050-core.c            |  2 +-
> drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  2 +-
> drivers/iio/industrialio-core.c            | 46 +++++++++-------------
> drivers/iio/magnetometer/ak8974.c          |  2 +-
> drivers/iio/magnetometer/ak8975.c          |  2 +-
> include/linux/iio/iio.h                    |  4 +-
> 7 files changed, 25 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 0c0df4fce420..f73404ca715e 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -420,7 +420,7 @@ int kxsd9_common_probe(struct device *dev,
> 	indio_dev->available_scan_masks =3D kxsd9_scan_masks;
>=20
> 	/* Read the mounting matrix, if present */
> -	ret =3D of_iio_read_mount_matrix(dev,
> +	ret =3D iio_read_mount_matrix(dev,
> 				       "mount-matrix",
> 				       &st->orientation);
> 	if (ret)
> diff --git a/drivers/iio/gyro/mpu3050-core.c =
b/drivers/iio/gyro/mpu3050-core.c
> index 77fac81a3adc..0a7d0dde020e 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -1149,7 +1149,7 @@ int mpu3050_common_probe(struct device *dev,
> 	mpu3050->divisor =3D 99;
>=20
> 	/* Read the mounting matrix, if present */
> -	ret =3D of_iio_read_mount_matrix(dev, "mount-matrix",
> +	ret =3D iio_read_mount_matrix(dev, "mount-matrix",
> 				       &mpu3050->orientation);
> 	if (ret)
> 		return ret;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c =
b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 1e428c196a82..e2c8e8ca324a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -990,7 +990,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int =
irq, const char *name,
>=20
> 	pdata =3D dev_get_platdata(dev);
> 	if (!pdata) {
> -		result =3D of_iio_read_mount_matrix(dev, "mount-matrix",
> +		result =3D iio_read_mount_matrix(dev, "mount-matrix",
> 						  &st->orientation);
> 		if (result) {
> 			dev_err(dev, "Failed to retrieve mounting matrix =
%d\n",
> diff --git a/drivers/iio/industrialio-core.c =
b/drivers/iio/industrialio-core.c
> index 4f5cd9f60870..3baede140d69 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -19,6 +19,7 @@
> #include <linux/device.h>
> #include <linux/fs.h>
> #include <linux/poll.h>
> +#include <linux/property.h>
> #include <linux/sched.h>
> #include <linux/wait.h>
> #include <linux/cdev.h>
> @@ -525,8 +526,8 @@ ssize_t iio_show_mount_matrix(struct iio_dev =
*indio_dev, uintptr_t priv,
> EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
>=20
> /**
> - * of_iio_read_mount_matrix() - retrieve iio device mounting matrix =
from
> - *                              device-tree "mount-matrix" property
> + * iio_read_mount_matrix() - retrieve iio device mounting matrix from
> + *                           device "mount-matrix" property
>  * @dev:	device the mounting matrix property is assigned to
>  * @propname:	device specific mounting matrix property name
>  * @matrix:	where to store retrieved matrix
> @@ -536,40 +537,29 @@ EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
>  *
>  * Return: 0 if success, or a negative error code on failure.
>  */
> -#ifdef CONFIG_OF
> -int of_iio_read_mount_matrix(const struct device *dev,
> -			     const char *propname,
> -			     struct iio_mount_matrix *matrix)
> +int iio_read_mount_matrix(struct device *dev, const char *propname,
> +			  struct iio_mount_matrix *matrix)
> {
> -	if (dev->of_node) {
> -		int err =3D of_property_read_string_array(dev->of_node,
> -				propname, matrix->rotation,
> -				=
ARRAY_SIZE(iio_mount_idmatrix.rotation));
> +	size_t len =3D ARRAY_SIZE(iio_mount_idmatrix.rotation);=20
> +	int err;
>=20
> -		if (err =3D=3D ARRAY_SIZE(iio_mount_idmatrix.rotation))
> -			return 0;
> +	err =3D device_property_read_string_array(dev, propname,
> +						matrix->rotation, len);
> +	if (err =3D=3D len)
> +		return 0;
>=20
> -		if (err >=3D 0)
> -			/* Invalid number of matrix entries. */
> -			return -EINVAL;
> +	if (err >=3D 0)
> +		/* Invalid number of matrix entries. */
> +		return -EINVAL;
>=20
> -		if (err !=3D -EINVAL)
> -			/* Invalid matrix declaration format. */
> -			return err;
> -	}
> +	if (err !=3D -EINVAL)
> +		/* Invalid matrix declaration format. */
> +		return err;
>=20
> 	/* Matrix was not declared at all: fallback to identity. */
> 	return iio_setup_mount_idmatrix(dev, matrix);
> }
> -#else
> -int of_iio_read_mount_matrix(const struct device *dev,
> -			     const char *propname,
> -			     struct iio_mount_matrix *matrix)
> -{
> -	return iio_setup_mount_idmatrix(dev, matrix);
> -}
> -#endif
> -EXPORT_SYMBOL(of_iio_read_mount_matrix);
> +EXPORT_SYMBOL(iio_read_mount_matrix);
>=20
> static ssize_t __iio_format_value(char *buf, size_t len, unsigned int =
type,
> 				  int size, const int *vals)
> diff --git a/drivers/iio/magnetometer/ak8974.c =
b/drivers/iio/magnetometer/ak8974.c
> index 93be1f4c0f27..9bf21e5fe3fc 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -733,7 +733,7 @@ static int ak8974_probe(struct i2c_client *i2c,
> 	ak8974->i2c =3D i2c;
> 	mutex_init(&ak8974->lock);
>=20
> -	ret =3D of_iio_read_mount_matrix(&i2c->dev,
> +	ret =3D iio_read_mount_matrix(&i2c->dev,
> 				       "mount-matrix",
> 				       &ak8974->orientation);
> 	if (ret)
> diff --git a/drivers/iio/magnetometer/ak8975.c =
b/drivers/iio/magnetometer/ak8975.c
> index d430b80808ef..dca20df1310e 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -911,7 +911,7 @@ static int ak8975_probe(struct i2c_client *client,
> 	data->eoc_irq =3D 0;
>=20
> 	if (!pdata) {
> -		err =3D of_iio_read_mount_matrix(&client->dev,
> +		err =3D iio_read_mount_matrix(&client->dev,
> 					       "mount-matrix",
> 					       &data->orientation);
> 		if (err)
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a74cb177dc6f..bb10c1bee301 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -130,8 +130,8 @@ struct iio_mount_matrix {
>=20
> ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t =
priv,
> 			      const struct iio_chan_spec *chan, char =
*buf);
> -int of_iio_read_mount_matrix(const struct device *dev, const char =
*propname,
> -			     struct iio_mount_matrix *matrix);
> +int iio_read_mount_matrix(struct device *dev, const char *propname,
> +			  struct iio_mount_matrix *matrix);
>=20
> typedef const struct iio_mount_matrix *
> 	(iio_get_mount_matrix_t)(const struct iio_dev *indio_dev,
> --=20
> 2.20.1
>=20

BR and thanks,
Nikolaus


