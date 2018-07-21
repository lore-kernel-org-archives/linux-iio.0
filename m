Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbeGURIp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Jul 2018 13:08:45 -0400
Date: Sat, 21 Jul 2018 17:15:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxime =?UTF-8?B?Um91c3Npbi1Cw6lsYW5nZXI=?=
        <maxime.roussinbelanger@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: Re: [PATCH v3 1/2] iio: Add modifier for DUV light
Message-ID: <20180721171525.65fc823b@archlinux>
In-Reply-To: <20180719202625.25060-1-maxime.roussinbelanger@gmail.com>
References: <20180719202625.25060-1-maxime.roussinbelanger@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Jul 2018 16:26:24 -0400
Maxime Roussin-B=C3=A9langer <maxime.roussinbelanger@gmail.com> wrote:

> Signed-off-by: Maxime Roussin-B=C3=A9langer <maxime.roussinbelanger@gmail=
.com>

Applied, Thanks,

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 4 +++-
>  drivers/iio/industrialio-core.c         | 1 +
>  include/uapi/linux/iio/types.h          | 1 +
>  tools/iio/iio_event_monitor.c           | 2 ++
>  4 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/=
testing/sysfs-bus-iio
> index fee35c00cc4e..23b213f87cf5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1263,13 +1263,15 @@ What:		/sys/.../iio:deviceX/in_intensityY_raw
>  What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
>  What:		/sys/.../iio:deviceX/in_intensityY_both_raw
>  What:		/sys/.../iio:deviceX/in_intensityY_uv_raw
> +What:		/sys/.../iio:deviceX/in_intensityY_duv_raw
>  KernelVersion:	3.4
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Unit-less light intensity. Modifiers both and ir indicate
>  		that measurements contains visible and infrared light
>  		components or just infrared light, respectively. Modifier uv indicates
> -		that measurements contain ultraviolet light components.
> +		that measurements contain ultraviolet light components. Modifier duv
> +		indicates that measurements contain deep ultraviolet light components.
> =20
>  What:		/sys/.../iio:deviceX/in_uvindex_input
>  KernelVersion:	4.6
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index fc340ed3dca1..66aba36d7fe1 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -104,6 +104,7 @@ static const char * const iio_modifier_names[] =3D {
>  	[IIO_MOD_LIGHT_GREEN] =3D "green",
>  	[IIO_MOD_LIGHT_BLUE] =3D "blue",
>  	[IIO_MOD_LIGHT_UV] =3D "uv",
> +	[IIO_MOD_LIGHT_DUV] =3D "duv",
>  	[IIO_MOD_QUATERNION] =3D "quaternion",
>  	[IIO_MOD_TEMP_AMBIENT] =3D "ambient",
>  	[IIO_MOD_TEMP_OBJECT] =3D "object",
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/type=
s.h
> index 22e5e589a274..bf037a267c7d 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -80,6 +80,7 @@ enum iio_modifier {
>  	IIO_MOD_CO2,
>  	IIO_MOD_VOC,
>  	IIO_MOD_LIGHT_UV,
> +	IIO_MOD_LIGHT_DUV,
>  };
> =20
>  enum iio_event_type {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index d9b7e0f306c6..328c66d8a892 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -95,6 +95,7 @@ static const char * const iio_modifier_names[] =3D {
>  	[IIO_MOD_LIGHT_GREEN] =3D "green",
>  	[IIO_MOD_LIGHT_BLUE] =3D "blue",
>  	[IIO_MOD_LIGHT_UV] =3D "uv",
> +	[IIO_MOD_LIGHT_DUV] =3D "duv",
>  	[IIO_MOD_QUATERNION] =3D "quaternion",
>  	[IIO_MOD_TEMP_AMBIENT] =3D "ambient",
>  	[IIO_MOD_TEMP_OBJECT] =3D "object",
> @@ -176,6 +177,7 @@ static bool event_is_known(struct iio_event_data *eve=
nt)
>  	case IIO_MOD_LIGHT_GREEN:
>  	case IIO_MOD_LIGHT_BLUE:
>  	case IIO_MOD_LIGHT_UV:
> +	case IIO_MOD_LIGHT_DUV:
>  	case IIO_MOD_QUATERNION:
>  	case IIO_MOD_TEMP_AMBIENT:
>  	case IIO_MOD_TEMP_OBJECT:

