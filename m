Return-Path: <manuel.stahl9cd33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4E0DA881.30608@iis.fraunhofer.de>
Date: Fri, 01 Jul 2011 12:59:13 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 ldewangan@nvidia.com, shubhrajyoti@ti.com
Subject: Re: [PATCH 10/25] staging:iio:magnetometer:hmc5843 iio_chan_spec
 conversion.
References: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk> <1309515076-12323-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309515076-12323-11-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 01.07.2011 12:11, Jonathan Cameron wrote:
> -static IIO_DEVICE_ATTR(magn_scale,
> -			S_IRUGO,
> -			show_scale,
> -			NULL , 0);
> +
> +#define HMC5843_CHANNEL(axis, add)					\
> +	{								\
> +		.type =3D IIO_MAGN,					\
> +		.modified =3D 1,						\
> +		.channel2 =3D IIO_MOD_##axis,				\
> +		.info_mask =3D (1<<  IIO_CHAN_INFO_SCALE_SHARED),		\
> +		.address =3D add						\
> +	}
> +
> +static const struct iio_chan_spec hmc5843_channels[] =3D {
> +	HMC5843_CHANNEL(X, HMC5843_DATA_OUT_X_MSB_REG),
> +	HMC5843_CHANNEL(X, HMC5843_DATA_OUT_Y_MSB_REG),
> +	HMC5843_CHANNEL(X, HMC5843_DATA_OUT_Z_MSB_REG),
> +};
Shouldn't be all X, I guess.

Regards,

--=20
Manuel Stahl
Fraunhofer-Institut IIS
Leistungsoptimierte Systeme

Nordostpark 93
D90411 N=FCrnberg
Telefon  +49 (0)911/58061-6419
Fax      +49 (0)911/58061-6398
E-Mail   manuel.stahl@iis.fraunhofer.de

http://www.iis.fraunhofer.de
http://www.smart-power.fraunhofer.de
