Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Thu, 28 Feb 2013 09:32:20 +0100
Subject: Re: [PATCH 06/67] iio:st_sensors move to
 info_mask_(shared_by_type/separate)
Message-ID: <512F1614.9020501@st.com>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
 <1361997553-31058-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-7-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On 02/27/2013 09:38 PM, Jonathan Cameron wrote:
> The original info_mask is going away in favour of the broken out versions=
.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> cc: Denis Ciocca <denis.ciocca@st.com>
> ---
>   include/linux/iio/common/st_sensors.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/co=
mmon/st_sensors.h
> index 1f86a97..0894b3e 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -45,8 +45,8 @@
>   { \
>   	.type =3D device_type, \
>   	.modified =3D 1, \
> -	.info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
> -			IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
> +	.info_mask_separate =3D IIO_CHAN_INFO_RAW | \
> +			IIO_CHAN_INFO_SCALE, \
>   	.scan_index =3D index, \
>   	.channel2 =3D mod, \
>   	.address =3D addr, \
>

Looks good to me.
Acked-by: Denis Ciocca <denis.ciocca@st.com>=
