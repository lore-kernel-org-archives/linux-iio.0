Return-Path: <SRS0=YBbj=KZ=gmail.com=marcus.folkesson@kernel.org>
Date: Fri, 10 Aug 2018 21:58:04 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: jic23@kernel.org, broonie@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	mark.rutland@arm.com, davem@davemloft.net,
	mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, robh+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] iio:adxl372: Add sampling frequency support
Message-ID: <20180810195804.GB2723@gmail.com>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
 <1533557087-10401-6-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
In-Reply-To: <1533557087-10401-6-git-send-email-stefan.popa@analog.com>
List-ID: <linux-iio@vger.kernel.org>


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Mon, Aug 06, 2018 at 03:04:46PM +0300, Stefan Popa wrote:
> This patch adds the option for the user to select the sampling frequency.
> Also, the user can read the available frequencies and read the currently
> set frequency via the read_raw function. The frequency can be set via the
> write_raw function.
>=20
> When the frequency is set, the bandwidth is also checked and ensured
> that it is constrained to at most half of the sampling frequency. Also, t=
he
> activity and inactivity timers have to be updated because they depend on
> the selected ODR.
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  drivers/iio/accel/adxl372.c | 74 +++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 623c32d..d991d1c 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -223,7 +223,8 @@ static const struct adxl372_axis_lookup adxl372_axis_=
lookup_table[] =3D {
>  	.modified =3D 1,							\
>  	.channel2 =3D IIO_MOD_##axis,					\
>  	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> -	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |		\
> +				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>  	.scan_index =3D index,						\
>  	.scan_type =3D {							\
>  		.sign =3D 's',						\
> @@ -311,6 +312,19 @@ static int adxl372_set_odr(struct adxl372_state *st,
>  	return ret;
>  }
> =20
> +static int adxl372_find_closest_match(const int *array,
> +				      unsigned int size, int val)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < size; i++) {
> +		if (val <=3D array[i])
> +			return i;
> +	}
> +
> +	return size - 1;
> +}

Hum, would find_closest() work for this?
See include/linux/util_macros.h

> +
>  static int adxl372_set_bandwidth(struct adxl372_state *st,
>  				 enum adxl372_bandwidth bw)
>  {
> @@ -631,6 +645,51 @@ static int adxl372_read_raw(struct iio_dev *indio_de=
v,
>  		*val =3D 0;
>  		*val2 =3D ADXL372_USCALE;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D adxl372_samp_freq_tbl[st->odr];
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int adxl372_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long info)
> +{
> +	struct adxl372_state *st =3D iio_priv(indio_dev);
> +	int odr_index, ret;
> +

Is it worth to make sure that val2 is zero here?

> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		odr_index =3D adxl372_find_closest_match(adxl372_samp_freq_tbl,
> +					ARRAY_SIZE(adxl372_samp_freq_tbl),
> +					val);
> +		ret =3D adxl372_set_odr(st, odr_index);
> +		if (ret < 0)
> +			return ret;
> +		/*
> +		 * The timer period depends on the ODR selected.
> +		 * At 3200 Hz and below, it is 6.6 ms; at 6400 Hz, it is 3.3 ms
> +		 */
> +		ret =3D adxl372_set_activity_time_ms(st, st->act_time_ms);
> +		if (ret < 0)
> +			return ret;
> +		/*
> +		 * The timer period depends on the ODR selected.
> +		 * At 3200 Hz and below, it is 26 ms; at 6400 Hz, it is 13 ms
> +		 */
> +		ret =3D adxl372_set_inactivity_time_ms(st, st->inact_time_ms);
> +		if (ret < 0)
> +			return ret;
> +		/*
> +		 * The maximum bandwidth is constrained to at most half of
> +		 * the ODR to ensure that the Nyquist criteria is not violated
> +		 */
> +		if (st->bw > odr_index)
> +			ret =3D adxl372_set_bandwidth(st, odr_index);
> +
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -763,8 +822,21 @@ static const struct iio_trigger_ops adxl372_trigger_=
ops =3D {
>  	.set_trigger_state =3D adxl372_dready_trig_set_state,
>  };
> =20
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
> +
> +static struct attribute *adxl372_attributes[] =3D {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group adxl372_attrs_group =3D {
> +	.attrs =3D adxl372_attributes,
> +};
> +
>  static const struct iio_info adxl372_info =3D {
> +	.attrs =3D &adxl372_attrs_group,
>  	.read_raw =3D adxl372_read_raw,
> +	.write_raw =3D adxl372_write_raw,
>  	.debugfs_reg_access =3D &adxl372_reg_access,
>  	.hwfifo_set_watermark =3D adxl372_set_watermark,
>  };
> --=20
> 2.7.4


Best regards,
Marcus Folkesson
>=20

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltt7kcACgkQiIBOb1ld
UjKSoRAA30f20bS9ZZIym61gO3ry/CoRw4KxAeJz9Y+Sv02SBtBjMZCawTxK2YV/
H3QzahkFed5Udj/zNXbwm8qeyZQLbk508nM6P6XTJ9Gr52vRBTxceaFLq+DZzRoO
Ut9+3KBvOd4yMHdfFCj+NAZjGuqbWfj1F+1atxmQBrlTSqqZkgffSdByJed5Hxp1
+vBrsYH7XQb3KQAnBQ6stnp3GxdWb3FqvSwTmJxwLvBbWSE3VAho7ZJ3TNShqtZf
Sv6oq8mZ6XpYS2rlZ10iHjqiaqN4i9OhZdGXfflmCfabLkxqlwSgXQ0jvd74AZTj
v6RctgjueC+lbhJJq5XGTee0MfYHrDXF2oEPM+w4mNJjleC8SxSlg/4eRB/NsTq3
SUvo/tcMuYXbdiQPsze8AhEv0MM1soI1vhJ6EgoIRbmc3H8FYx+TZk5zT8RtBpSt
Q7OYasmyAwoaFhjvOtfeDiA/hmqySPYDBt2QdWqDdxnCZ04I5DX7MM2o9S/92PNm
FspiWVYz/xmaEZP6TKK/eg0sBuu/UPUTb7qZgtG5I3af1xjekJ3xJ7D73jrabKf5
DeAhWMt0tAxFg3SAGRIzhGRga84gVHlJ/Y2XVMJ5T4n+Kf9ZugimyNo/EvfJKFUv
bzExintPZybWjcjq3L7YrJ0qZYqDuoR72q79RHAXmzPViE+XkvA=
=NQHc
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
