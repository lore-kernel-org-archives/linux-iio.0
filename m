Return-Path: <srinivas.pandruvada@intel.com>
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH,] IIO: Add additional modifier names
Date: Wed, 6 Jun 2012 15:04:56 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A91931B3ED@ORSMSX104.amr.corp.intel.com>
References: <1338508298-21748-1-git-send-email-srinivas.pandruvada@intel.com>
 <4FCF2011.4030206@cam.ac.uk>
In-Reply-To: <4FCF2011.4030206@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>


I am going to submit a series of patches for HID sensors, mostly targeted t=
owards slates and tablets. For Accelerometer/Gyro/Magnetometer, I am using
IIO_MOD_X_AND_Y_AND_Z for sending  x, y and z sample in one report. So user=
 space like Android can get all three values together .=20

I can change to more explicit names as you suggested. Let me know if you wa=
nt me to submit patch for this.

Thanks,
Srinivas

-----Original Message-----
From: Jonathan Cameron [mailto:jic23@cam.ac.uk]=20
Sent: Wednesday, June 06, 2012 2:17 AM
To: Pandruvada, Srinivas
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH,] IIO: Add additional modifier names

On 6/1/2012 12:51 AM, srinivas pandruvada wrote:
> Added additional modifier names in the list for the supported types.=20
> Otherwise it substitutes (null) in the filename.
>
> Signed-off-by: srinivas pandruvada<srinivas.pandruvada@intel.com>

When we originally introducted the concept of these, the intent was to have=
 rather more explicit naming. Hence [IIO_MOD_X_AND_Y_AND_Z] =3D "x&y&z", [I=
IO_MOD_X_OR_Y_OR_Z] =3D "x|y|z",

It costs a small amount of effort in escape characters, but gives a much mo=
re meaningful naming to the resulting attributes.

They aren't there in the core code because nothing using chan_spec based re=
gistration was using these (they were needed for modifiers of rather obscur=
e events).  What have you actually needed them for?


Jonathan
> ---
>   drivers/staging/iio/industrialio-core.c |    8 ++++++++
>   1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/staging/iio/industrialio-core.c=20
> b/drivers/staging/iio/industrialio-core.c
> index d303bfb..65d40ce 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -76,6 +76,14 @@ static const char * const iio_modifier_names[] =3D {
>   	[IIO_MOD_Z] =3D "z",
>   	[IIO_MOD_LIGHT_BOTH] =3D "both",
>   	[IIO_MOD_LIGHT_IR] =3D "ir",
> +	[IIO_MOD_X_AND_Y] =3D "xy",
> +	[IIO_MOD_X_AND_Z] =3D "xz",
> +	[IIO_MOD_Y_AND_Z] =3D "yz",
> +	[IIO_MOD_X_AND_Y_AND_Z] =3D "xyz",
> +	[IIO_MOD_X_OR_Y] =3D "x_y",
> +	[IIO_MOD_X_OR_Z] =3D "x_z",
> +	[IIO_MOD_Y_OR_Z] =3D "y_z",
> +	[IIO_MOD_X_OR_Y_OR_Z] =3D "x_y_z",
>   };
>
>   /* relies on pairs of these shared then separate */
