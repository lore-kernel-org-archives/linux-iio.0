Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B9427A92E;
	Sat,  7 Mar 2026 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904004; cv=none; b=jLDrw3WOlpbHuKQ2lYPh3ALW+kpuDAgnSrcMDbmaDy6xv/QE3U+zgV55OZdbkBCTi7lzGgRijic85G8oFND4U0WjljsS/aQDlDZRDn4FqjDi9Ie9GR8Glo6qHmYRBdRNG0O7xyLPk4p8Q2Fjm2VbgPbH+02JtGd/W3XwDBo9R9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904004; c=relaxed/simple;
	bh=K7Uxm/p+skrYxSCimuqS3vpH9nXP0VJVqtdiOaTesn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz/FHqkeR2Jp76lZWFoSe/J3phgLu9kCHce0Apv9W5O9tbysr5GeHEU6XVxdacl9v7eJdMe3vnJFfy9pgDUhY7VZ6Dlj+XAOKttyE5o2OPYMVzCK6gmBO2kPgWWM8NEnKt6zb5Z7e3f3CxgMEDNm6nrOZdwojjE+nXA3CqKG944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I35PzjQp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I35PzjQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA0EC19422;
	Sat,  7 Mar 2026 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772904003;
	bh=K7Uxm/p+skrYxSCimuqS3vpH9nXP0VJVqtdiOaTesn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I35PzjQpvnZv9L3ny7rpEXrc+ZCV/LABOVv81XoNJ0ujQPe11ZGEZUiljl6X9If0A
	 ffbR+eIwcXIJyFZ6J+SWinIg1iaNwyD85MbAaJNG+/Q2S/Mygq99gJPpZvhfC+8EON
	 Qyyu5aUkUeFIPDZkfCKHZctwg7NCeH5gUzt+vQdztr5Lpy2Zi2wThi4C39+kpiACYc
	 vCzoHxdV3aHeZ2510BeCaPOmxeQ1hZGWokvm6uCPbt2LlX2hQPSiIsrI7wsUHYhzy0
	 Yyi5R9N44Ilc/+S1IlWlTmWzGewoTCe0hV2MmWda/8lZ+V2BuVtEw751IKLy/5/x1z
	 luTdnbl5HbUwQ==
Date: Sat, 7 Mar 2026 18:20:00 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Francesco Lavra <flavra@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/6] iio: imu: st_lsm6dsx: Fix check for invalid
 samples from FIFO
Message-ID: <aaxeQCpp-x1l1BU3@lore-desk>
References: <20260304080519.2844101-1-flavra@baylibre.com>
 <20260304080600.2844267-1-flavra@baylibre.com>
 <20260307124629.7b4c3953@jic23-huawei>
 <aaxC9T75dtLR-AD8@lore-desk>
 <20260307170439.6c64be73@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hhUO1IbZpoTq0b1U"
Content-Disposition: inline
In-Reply-To: <20260307170439.6c64be73@jic23-huawei>


--hhUO1IbZpoTq0b1U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 7 Mar 2026 16:23:33 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > > On Wed,  4 Mar 2026 09:06:00 +0100
> > > Francesco Lavra <flavra@baylibre.com> wrote:
> > >  =20
> > > > The DRDY_MASK feature implemented in sensor chips marks gyroscope a=
nd
> > > > accelerometer invalid samples (i.e. samples that have been acquired=
 during
> > > > the settling time of sensor filters) with the special values 0x7FFF=
h,
> > > > 0x7FFE, and 0x7FFD.
> > > > The driver checks FIFO samples against these special values in orde=
r to
> > > > discard invalid samples; however, it does the check regardless of t=
he type
> > > > of samples being processed, whereas this feature is specific to gyr=
oscope
> > > > and accelerometer data. This could cause valid samples to be discar=
ded.
> > > >=20
> > > > Fix the above check so that it takes into account the type of sampl=
es being
> > > > processed. To avoid casting to __le16 * when checking sample values=
, clean
> > > > up the type representation for data read from the FIFO.
> > > >=20
> > > > Fixes: 960506ed2c69 ("iio: imu: st_lsm6dsx: enable drdy-mask if ava=
ilable")
> > > > Signed-off-by: Francesco Lavra <flavra@baylibre.com> =20
> > > Looks fine to me, but looking for a Lorenzo tag ideally given it's not
> > > a particularly trivial fix!
> > >=20
> > > Jonathan =20
> >=20
> > Hi Francesco,
> >=20
> > thx for fixing this, I think the patch is fine, just a couple of nits i=
nline if
> > you need to repost.
> >=20
> > Regards,
> > Lorenzo
> >=20
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >=20
> > > > ---
> > > >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 23 +++++++++++----=
----
> > > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drive=
rs/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > index 5b28a3ffcc3d..a6ee2da5a06c 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > @@ -365,8 +365,6 @@ static inline int st_lsm6dsx_read_block(struct =
st_lsm6dsx_hw *hw, u8 addr,
> > > >  	return 0;
> > > >  }
> > > > =20
> > > > -#define ST_LSM6DSX_IIO_BUFF_SIZE	(ALIGN(ST_LSM6DSX_SAMPLE_SIZE, \
> > > > -					       sizeof(s64)) + sizeof(s64))
> > > >  /**
> > > >   * st_lsm6dsx_read_fifo() - hw FIFO read routine
> > > >   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
> > > > @@ -539,14 +537,14 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw=
 *hw)
> > > >  #define ST_LSM6DSX_INVALID_SAMPLE	0x7ffd
> > > >  static int
> > > >  st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
> > > > -			    u8 *data, s64 ts)
> > > > +			    __le16 *data, s64 ts)
> > > >  {
> > > > -	s16 val =3D le16_to_cpu(*(__le16 *)data);
> > > >  	struct st_lsm6dsx_sensor *sensor;
> > > >  	struct iio_dev *iio_dev;
> > > > =20
> > > >  	/* invalid sample during bootstrap phase */
> > > > -	if (val >=3D ST_LSM6DSX_INVALID_SAMPLE)
> > > > +	if ((tag =3D=3D ST_LSM6DSX_GYRO_TAG || tag =3D=3D ST_LSM6DSX_ACC_=
TAG) &&
> > > > +	    (s16)le16_to_cpup(data) >=3D ST_LSM6DSX_INVALID_SAMPLE)
> > > >  		return -EINVAL; =20
> >=20
> > what about moving this check to a dedicated routine? Like
> > st_lsm6dsx_check_data() or similar?
>=20
> Make sense. Let's do that as part of this fix.
>=20
> >=20
> > > > =20
> > > >  	/*
> > > > @@ -609,7 +607,13 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6=
dsx_hw *hw)
> > > >  	 * must be passed a buffer that is aligned to 8 bytes so
> > > >  	 * as to allow insertion of a naturally aligned timestamp.
> > > >  	 */
> > > > -	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);
> > > > +	struct {
> > > > +		union {
> > > > +			__le16 data[3];
> > > > +			__le32 fifo_ts;
> > > > +		};
> > > > +		aligned_s64 timestamp;
> > > > +	} iio_buff =3D { }; =20
> >=20
> > you can get rid of space between brackets.
>=20
> Prefer not on this.  I'm trying to standardize on having the space as it =
looks
> more normal in some other usecases than no space.  I had to a pick a styl=
e and
> this is the one I went with a year or so back.

ack, that's fine in this case (I missed that).

Regards,
Lorenzo

>=20
> >=20
> > > >  	u8 tag;
> > > >  	bool reset_ts =3D false;
> > > >  	int i, err, read_len;
> > > > @@ -648,7 +652,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6d=
sx_hw *hw)
> > > > =20
> > > >  		for (i =3D 0; i < pattern_len;
> > > >  		     i +=3D ST_LSM6DSX_TAGGED_SAMPLE_SIZE) {
> > > > -			memcpy(iio_buff, &hw->buff[i + ST_LSM6DSX_TAG_SIZE],
> > > > +			memcpy(&iio_buff, &hw->buff[i + ST_LSM6DSX_TAG_SIZE],
> > > >  			       ST_LSM6DSX_SAMPLE_SIZE);
> > > > =20
> > > >  			tag =3D hw->buff[i] >> 3;
> > > > @@ -659,7 +663,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6d=
sx_hw *hw)
> > > >  				 * B0 =3D ts[7:0], B1 =3D ts[15:8], B2 =3D ts[23:16],
> > > >  				 * B3 =3D ts[31:24]
> > > >  				 */
> > > > -				ts =3D le32_to_cpu(*((__le32 *)iio_buff));
> > > > +				ts =3D le32_to_cpu(iio_buff.fifo_ts);
> > > >  				/*
> > > >  				 * check if hw timestamp engine is going to
> > > >  				 * reset (the sensor generates an interrupt
> > > > @@ -670,7 +674,8 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6d=
sx_hw *hw)
> > > >  					reset_ts =3D true;
> > > >  				ts *=3D hw->ts_gain;
> > > >  			} else {
> > > > -				st_lsm6dsx_push_tagged_data(hw, tag, iio_buff,
> > > > +				st_lsm6dsx_push_tagged_data(hw, tag,
> > > > +							    iio_buff.data,
> > > >  							    ts);
> > > >  			}
> > > >  		} =20
> > >  =20
>=20

--hhUO1IbZpoTq0b1U
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaaxeQAAKCRA6cBh0uS2t
rDnXAP0ZCAFa+SgAfZ2uDXjHkLg8GNn++GBTuA4aOM9sV5CdowD/Z4dhpNvvn8ON
jpIkSi2NbE4RezD+agg4Xet3P9/pDQ8=
=f80u
-----END PGP SIGNATURE-----

--hhUO1IbZpoTq0b1U--
