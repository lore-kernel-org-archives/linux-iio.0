Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68143EBF31;
	Fri, 23 Jan 2026 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190498; cv=none; b=WssozcaG/C+qcGGy9vOOvL0W3SlqgV7C3ij+0c3z6A0voOGZ8vSZDUKumxEkWUA+wY7VaUqCYQ4RyToyjyMPMICdI4IAqxuorZQxKWxVV5oDRZ3ugvQbJRwypFQHSjMm1bfbz2HA1dnytHDyAuUsfctaZtrKBeEvutUFQGOJf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190498; c=relaxed/simple;
	bh=+SJ2l2db+3r1J8gCRGQRTTpSXpSkztK3iRH1oQNk1QY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCrBB/eYpBR3SQc0oM7d+k3l/maUtBZlFLo6QYDmAi2A7kwcCe+a+R6EotxJ5uXbEoEqxyYfJfS/L2d+f4t95ZnY+kmwBz4OhkFZW4WVb9UuOfCYXrvx5NkxDfZbKblpl37HwOlalyCx65Mw+FhH4GjHIeiAxCt+TVHYY159mho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyQPV2xzZzJ468m;
	Sat, 24 Jan 2026 01:47:42 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FED240086;
	Sat, 24 Jan 2026 01:48:12 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 17:48:11 +0000
Date: Fri, 23 Jan 2026 17:48:10 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Francesco Lavra <flavra@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <20260123174810.00007ce5@huawei.com>
In-Reply-To: <c722a6a28788ee36b5c87b0a98ec29f2f945470c.camel@baylibre.com>
References: <20260122162335.2020006-1-flavra@baylibre.com>
	<20260122162335.2020006-5-flavra@baylibre.com>
	<20260122202943.344e7311@jic23-huawei>
	<c722a6a28788ee36b5c87b0a98ec29f2f945470c.camel@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 23 Jan 2026 12:03:29 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> On Thu, 2026-01-22 at 20:29 +0000, Jonathan Cameron wrote:
> > On Thu, 22 Jan 2026 17:23:35 +0100
> > Francesco Lavra <flavra@baylibre.com> wrote:
> >  =20
> > > Some IMU chips in the LSM6DSX family have sensor fusion features that
> > > combine data from the accelerometer and gyroscope. One of these
> > > features
> > > generates rotation vector data and makes it available in the hardware
> > > FIFO as a quaternion (more specifically, the X, Y and Z components of
> > > the
> > > quaternion vector, expressed as 16-bit half-precision floating-point
> > > numbers).
> > >=20
> > > Add support for a new sensor instance that allows receiving sensor
> > > fusion
> > > data, by defining a new struct st_lsm6dsx_sf_settings (which contains
> > > chip-specific details for the sensor fusion functionality), and adding
> > > this
> > > struct as a new field in struct st_lsm6dsx_settings. In
> > > st_lsm6dsx_core.c,
> > > populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add
> > > the
> > > logic to initialize an additional IIO device if this struct is
> > > populated
> > > for the hardware type being probed.
> > > Note: a new IIO device is being defined (as opposed to adding channels
> > > to
> > > an existing device) because the rate at which sensor fusion data is
> > > generated may not match the data rate from any of the existing device=
s.
> > >=20
> > > Tested on LSMDSV16X.
> > >=20
> > > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> > > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org> =20
> >  =20
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > index ded9a96076e6..3b4fa57bf461 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c =20
> >  =20
> > > @@ -580,6 +584,16 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw
> > > *hw, u8 tag,
> > > =A0=A0=A0=A0=A0=A0=A0=A0case ST_LSM6DSX_EXT2_TAG:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0iio_dev =3D hw->iio_d=
evs[ST_LSM6DSX_ID_EXT2];
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > +=A0=A0=A0=A0=A0=A0=A0case ST_LSM6DSX_ROT_TAG:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * The sensor reports o=
nly the {X, Y, Z} elements of
> > > the
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * quaternion vector; s=
et the W value to 0 (it can be
> > > derived
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * from the {X, Y, Z} v=
alues due to the property that
> > > the vector
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * is normalized). =20
> >=20
> > I'd missed this before.=A0 This is going to really confuse user space.
> > I don't think we can just return it with a 0 in that last entry.
> > At the very least we need an ABI doc update to reflect this oddity.
> >=20
> > I don't think that is enough though. This isn't a quaternion, but
> > rather something we can derive one from. Annoying though it is,
> > we can't realistically fix it up in kernel, so we are probably talking
> > a new MOD_TYPE. =20
>=20
> Quaternion data read from the sensor is expressed in floating-point forma=
t,
> and as such needs to be interpreted by userspace in a "non-standard" way
> (note there is no scale in the channel info, and this is intentional
> because we are not dealing with integers) regardless of whether the W val=
ue
> is present or must be derived.
> Isn't the absence of the scale info enough to let userspace know that this
> data is non-standard?

Given both scale and offset are optional with defaults of 1.0 and 0 if
not there, likely code won't notice that both are missing and under
the ABI that would just make _raw =3D=3D _scale which is odd but not specif=
ically
excluded.

> Only applications that know how to deal specifically
> with this sensor device can make sense of the data (and these applications
> know that the quaternion vector is normalized and the W value must be
> derived from X, Y, Z).

This is the sort of feature that I'm reluctant to support. The only thing
that we have let in (because it was truely obscure) that looks like this
is pulse oximeters - the stuff in drivers/iio/health. It's a complex
many reading maths thing to go from the data to the actual thing being
measured.  The purpose of unified interfaces is being able to use them
across different sensors. Here we can't.  Hence this need some careful
thought.

>=20
> > Also it's been a long time since I did much with quaternions,
> > but isn't the sign of w ambiguous if we are relying on only X, Y and Z?
> > A bit of googling + AI suggests flipping it inverts the direction of
> > rotation around a given axis. Feels like there is a constraint missing
> > in this description. =20
>=20
> Flipping the sign of W doesn't just invert the direction of rotation, it
> basically applies an offset of -360 degrees; if a value w0 indicates a
> rotation by an angle theta0, the value -w0 indicates a rotation by (theta0
> - 360), which is basically the same as rotating by theta0. So knowing the
> {X, Y, Z} values is enough to have a non-ambiguous orientation.

Ok. Taking a while to remember this stuff, but I'm fairly sure it isn't qui=
te
that.
Inverting w is the difference between theta and (360 - theta) not (theta - =
360)
given the 360 doesn't matter as you say, it's a clockwise vs anticlockwise
rotation.

Lets take a vector to rotate (say representing up on a screen represnted
as pure quaternion  v=3D (0 1 0 0). Apply rotation quaternion to rotate tha=
t about the
Y axis by 90 degrees in one direction (I'm too lazy to figure out which but=
 doesn't
matter!)
q =3D (cos(theta/2), 0, sin(theta/2)j, 0)
  =3D (sqrt(2)/2, 0, sqrt(2)/2, 0)

Apply rotation is q v q'=20

So multiplying it out=20
(sqrt(2)/2, 0, (sqrt(2)/2)j, 0) (0, 1i, 0 0) (sqrt(2)/2, 0, -(sqrt(2)/2)j, =
0)
Given it's all multiples of (Sqrt(2)/2) Lets call that A
=3D (A, 0, Aj, 0)(0, 1j, 0, 0)(A, 0, -Aj, 0)
=3D (0, Ai, 0, -Ak) (A, 0, -Aj, 0)
=3D (0, (A*A - (-A)*(-A))i, 0, (A *(-A) + (-A) * A)j)
=3D (0, 0, 0, -1) or down on the z axis

Same again, but now flip the W value

(-A, 0, Aj, 0)(0, 1j, 0, 0)(-A, 0, -Aj, 0)
=3D (0, (-A)i, 0, -(A)k)(-A, 0, -Aj, 0)
=3D (0, ((-A)*(-A) -  (-A)*(-A))j, 0, (-A)*(-A) + (-A)*(-A)
=3D (0, 0, 0, 1) or up on the z axis.

Anyhow, that is moot if we don't figure out what to do about the fact
we are forcing data into a representation a long way from what
user space accepts.

Jonathan









>=20

