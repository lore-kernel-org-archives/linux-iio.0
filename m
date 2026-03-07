Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C559326B764;
	Sat,  7 Mar 2026 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772897016; cv=none; b=qf5L6fknDUN6q2Vi3Mf/fmdKRlgEUTS1p4UJhsLet/qMyG8l6Dt2jCyrTX16FRDXyYNOOxSaNhguKPDbIHHkI/1DMelimnr5DmuLS3dMcIuYWRgEbxcPatldT0bWC3+1WaJDEWLGR1tPfNJGS8eJbJn4cec5+mOgbLlMhhslCl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772897016; c=relaxed/simple;
	bh=4VQ206BfuEh5PWpvSJN5VmtxwpLd9oXfKC8S+ACsPCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4BIC7/1hgLbmg5GpXu0iq5qOZLmnARo817GoK0axWv2jtiF45Acij2cwHVM/tP64miDRH3WoNWX4iUhxZRlXsPWIyuX66OcfyBM+DF+lNri97bpVpksJ/9rllE7mqcRB/Vv4OGmoR/WNRNLTPubGpHlWYAmBYk9BvCwPmS4St0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UszhFMBa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UszhFMBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E634CC19422;
	Sat,  7 Mar 2026 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772897016;
	bh=4VQ206BfuEh5PWpvSJN5VmtxwpLd9oXfKC8S+ACsPCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UszhFMBaq4fMCDegi6SBjvTbmHDhXLWmBF8eqUUd1Jxg0/JvH/giSLYuEUkTdlV4Y
	 /i+uIXTv0jGWzzSS9FQNMCZymS9DUhBkmlxeCuMSFuvJEIU8g+P6nqHaupugAVERqH
	 zFP3bMeDE4WuZNCuZvm5ocT9MZn+0J6SPCbG1JtLTXebxBpLxm7vBgOEQbX8WsPlCz
	 XBwUnVSmMPb1yxM1kkRlkhDa1JLS8Qt3tAEA0wS94LNMehqI4FoY3aTpu/JOGVOu1I
	 pKRB1VqyFJJH4/6X3297lJFdlauehmdxxiD4QMP2TylNmpDQASE2/orgqz5SWvPtnJ
	 ftv8N2wPjyvTg==
Date: Sat, 7 Mar 2026 16:23:33 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Francesco Lavra <flavra@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/6] iio: imu: st_lsm6dsx: Fix check for invalid
 samples from FIFO
Message-ID: <aaxC9T75dtLR-AD8@lore-desk>
References: <20260304080519.2844101-1-flavra@baylibre.com>
 <20260304080600.2844267-1-flavra@baylibre.com>
 <20260307124629.7b4c3953@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vXEOuhMkRjXBrKRZ"
Content-Disposition: inline
In-Reply-To: <20260307124629.7b4c3953@jic23-huawei>


--vXEOuhMkRjXBrKRZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed,  4 Mar 2026 09:06:00 +0100
> Francesco Lavra <flavra@baylibre.com> wrote:
>=20
> > The DRDY_MASK feature implemented in sensor chips marks gyroscope and
> > accelerometer invalid samples (i.e. samples that have been acquired dur=
ing
> > the settling time of sensor filters) with the special values 0x7FFFh,
> > 0x7FFE, and 0x7FFD.
> > The driver checks FIFO samples against these special values in order to
> > discard invalid samples; however, it does the check regardless of the t=
ype
> > of samples being processed, whereas this feature is specific to gyrosco=
pe
> > and accelerometer data. This could cause valid samples to be discarded.
> >=20
> > Fix the above check so that it takes into account the type of samples b=
eing
> > processed. To avoid casting to __le16 * when checking sample values, cl=
ean
> > up the type representation for data read from the FIFO.
> >=20
> > Fixes: 960506ed2c69 ("iio: imu: st_lsm6dsx: enable drdy-mask if availab=
le")
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Looks fine to me, but looking for a Lorenzo tag ideally given it's not
> a particularly trivial fix!
>=20
> Jonathan

Hi Francesco,

thx for fixing this, I think the patch is fine, just a couple of nits inlin=
e if
you need to repost.

Regards,
Lorenzo

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> > ---
> >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 23 +++++++++++--------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index 5b28a3ffcc3d..a6ee2da5a06c 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -365,8 +365,6 @@ static inline int st_lsm6dsx_read_block(struct st_l=
sm6dsx_hw *hw, u8 addr,
> >  	return 0;
> >  }
> > =20
> > -#define ST_LSM6DSX_IIO_BUFF_SIZE	(ALIGN(ST_LSM6DSX_SAMPLE_SIZE, \
> > -					       sizeof(s64)) + sizeof(s64))
> >  /**
> >   * st_lsm6dsx_read_fifo() - hw FIFO read routine
> >   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
> > @@ -539,14 +537,14 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >  #define ST_LSM6DSX_INVALID_SAMPLE	0x7ffd
> >  static int
> >  st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
> > -			    u8 *data, s64 ts)
> > +			    __le16 *data, s64 ts)
> >  {
> > -	s16 val =3D le16_to_cpu(*(__le16 *)data);
> >  	struct st_lsm6dsx_sensor *sensor;
> >  	struct iio_dev *iio_dev;
> > =20
> >  	/* invalid sample during bootstrap phase */
> > -	if (val >=3D ST_LSM6DSX_INVALID_SAMPLE)
> > +	if ((tag =3D=3D ST_LSM6DSX_GYRO_TAG || tag =3D=3D ST_LSM6DSX_ACC_TAG)=
 &&
> > +	    (s16)le16_to_cpup(data) >=3D ST_LSM6DSX_INVALID_SAMPLE)
> >  		return -EINVAL;

what about moving this check to a dedicated routine? Like
st_lsm6dsx_check_data() or similar?

> > =20
> >  	/*
> > @@ -609,7 +607,13 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_=
hw *hw)
> >  	 * must be passed a buffer that is aligned to 8 bytes so
> >  	 * as to allow insertion of a naturally aligned timestamp.
> >  	 */
> > -	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);
> > +	struct {
> > +		union {
> > +			__le16 data[3];
> > +			__le32 fifo_ts;
> > +		};
> > +		aligned_s64 timestamp;
> > +	} iio_buff =3D { };

you can get rid of space between brackets.

> >  	u8 tag;
> >  	bool reset_ts =3D false;
> >  	int i, err, read_len;
> > @@ -648,7 +652,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_h=
w *hw)
> > =20
> >  		for (i =3D 0; i < pattern_len;
> >  		     i +=3D ST_LSM6DSX_TAGGED_SAMPLE_SIZE) {
> > -			memcpy(iio_buff, &hw->buff[i + ST_LSM6DSX_TAG_SIZE],
> > +			memcpy(&iio_buff, &hw->buff[i + ST_LSM6DSX_TAG_SIZE],
> >  			       ST_LSM6DSX_SAMPLE_SIZE);
> > =20
> >  			tag =3D hw->buff[i] >> 3;
> > @@ -659,7 +663,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_h=
w *hw)
> >  				 * B0 =3D ts[7:0], B1 =3D ts[15:8], B2 =3D ts[23:16],
> >  				 * B3 =3D ts[31:24]
> >  				 */
> > -				ts =3D le32_to_cpu(*((__le32 *)iio_buff));
> > +				ts =3D le32_to_cpu(iio_buff.fifo_ts);
> >  				/*
> >  				 * check if hw timestamp engine is going to
> >  				 * reset (the sensor generates an interrupt
> > @@ -670,7 +674,8 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_h=
w *hw)
> >  					reset_ts =3D true;
> >  				ts *=3D hw->ts_gain;
> >  			} else {
> > -				st_lsm6dsx_push_tagged_data(hw, tag, iio_buff,
> > +				st_lsm6dsx_push_tagged_data(hw, tag,
> > +							    iio_buff.data,
> >  							    ts);
> >  			}
> >  		}
>=20

--vXEOuhMkRjXBrKRZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaaxC9QAKCRA6cBh0uS2t
rFYeAP0d0oLAfUPfJV/zGVW0ODPOpod76++L/0xHuvIOtMZCSAD5AUrl3gSlrApX
6pShZUypdIEaP5CxTHvWDB+21iGooAY=
=xrt5
-----END PGP SIGNATURE-----

--vXEOuhMkRjXBrKRZ--
