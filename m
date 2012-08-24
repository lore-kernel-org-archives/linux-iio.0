Return-Path: <srinivas.pandruvada@intel.com>
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "jkosina@suse.cz"
	<jkosina@suse.cz>
Subject: RE: [PATCH 1/9] IIO: core: Add hysteresis in channel spec
Date: Fri, 24 Aug 2012 16:47:05 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A9193AD736@ORSMSX104.amr.corp.intel.com>
References: <1344356943-23313-1-git-send-email-srinivas.pandruvada@intel.com>
 <1344356943-23313-2-git-send-email-srinivas.pandruvada@intel.com>
 <502A1FA9.4030407@kernel.org>
In-Reply-To: <502A1FA9.4030407@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

I will submit a patch once it is merged as this document requires kernel ve=
rsion.
Unless merged, I will not know in which kernel version it will be available=
.

Thanks,
Srinivas


-----Original Message-----
From: J.I. Cameron [mailto:jic23@hermes.cam.ac.uk] On Behalf Of Jonathan Ca=
meron
Sent: Tuesday, August 14, 2012 2:52 AM
To: Pandruvada, Srinivas
Cc: linux-iio@vger.kernel.org; jkosina@suse.cz
Subject: Re: [PATCH 1/9] IIO: core: Add hysteresis in channel spec

On 07/08/12 17:28, srinivas pandruvada wrote:
> Added hysteresis to the list of channel info enumeration, shared=20
> /separate bit defines and to postfix channel info strings.

This needs documentation under
Documentation/ABI/testing/sysfs-bus-iio
but it can be a later patch.

>
> Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
> ---
>   drivers/iio/industrialio-core.c |    1 +
>   include/linux/iio/iio.h         |    5 +++++
>   2 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c=20
> b/drivers/iio/industrialio-core.c index 4f947e4..536ba75 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -92,6 +92,7 @@ static const char * const iio_chan_info_postfix[] =3D {
>   	[IIO_CHAN_INFO_FREQUENCY] =3D "frequency",
>   	[IIO_CHAN_INFO_PHASE] =3D "phase",
>   	[IIO_CHAN_INFO_HARDWAREGAIN] =3D "hardwaregain",
> +	[IIO_CHAN_INFO_HYSTERESIS] =3D "hysteresis",
>   };
>  =20
>   const struct iio_chan_spec
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h index=20
> 3a4f6a3..9ed1063 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -35,6 +35,7 @@ enum iio_chan_info_enum {
>   	IIO_CHAN_INFO_FREQUENCY,
>   	IIO_CHAN_INFO_PHASE,
>   	IIO_CHAN_INFO_HARDWAREGAIN,
> +	IIO_CHAN_INFO_HYSTERESIS,
>   };
>  =20
>   #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2) @@ -100,6 +101,10=20
> @@ enum iio_chan_info_enum {
>   	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_HARDWAREGAIN)
>   #define IIO_CHAN_INFO_HARDWAREGAIN_SHARED_BIT			\
>   	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_HARDWAREGAIN)
> +#define IIO_CHAN_INFO_HYSTERESIS_SEPARATE_BIT			\
> +	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_HYSTERESIS)
> +#define IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT			\
> +	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_HYSTERESIS)
>  =20
>   enum iio_endian {
>   	IIO_CPU,
