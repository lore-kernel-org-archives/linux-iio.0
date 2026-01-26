Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16422FD7C6
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426120; cv=none; b=I3XpS3wBHM57m22qSYMnpM8Rt/qpojqrlrAkauNP4JBPOhUS7tvyVpwzdw6mmBtv1WPmOuy8cGoVtmqOYXFkMNwBhd5S1YYxSW4yR6Z5ZT9lvd9gwsHsk8OMgkekr8kJzgCvgVzDLOg8b5X36zPuff08PwlojbZEYwLR1XeeDyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426120; c=relaxed/simple;
	bh=YimQSR5sP06ckYpWEo8BRykCs7uEeWwrSpI+4F9Dj1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BMy/9PPmc0ekyejViA4LCKH0IBLEv9zUyBYPWc2AUS4DFD0YSyOj4WzAap0+aUtUzh96ISuWk9v4vG+1dovB+Z/jpGEPeIvGjPwr/16iCyCCgNOuxm6ZLr1f5xOOoa3Qcy/Y0oBzaM15vr5G/DDOp5PmiqdoXugzAR/3i8bDgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hlnxf2rz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hlnxf2rz"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4358fb60802so2523515f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 03:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769426115; x=1770030915; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YimQSR5sP06ckYpWEo8BRykCs7uEeWwrSpI+4F9Dj1A=;
        b=hlnxf2rz6qeqXoOd//XhVHv5gAWTBbI79dhlMoTUpxeu1c/i0qxcPRZEkh6/38R236
         eSFGMH9bkyZDaOZxAM7vCmKrG/tmVAixOBaS4RWfsYfNw5vv8QDI/G1lNtludD18o5CJ
         J1G4eXh5hDMNd2CABZm5BNZ86gBUco+/9dhOX8440Q/VW08n0Tl49BNT9TLp8gk3kY5e
         KlEOZHa1X4Wno0dgXLnROUAOmJEncL0Wzfk8lN44gNZ91icQVm170z+k7QpmxrJNCV3F
         BPfFYWITIcSkAXivDNTY15P1vj5jNU89cOaM/IdeKqCVLTqMoysaaJAycUMNSq7AnAFv
         JBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769426115; x=1770030915;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YimQSR5sP06ckYpWEo8BRykCs7uEeWwrSpI+4F9Dj1A=;
        b=vVWGSsCLl+JL3xALCmUskEGwnaT0udDt+kLMjMo2ibgbUPskppStxmMq6kHEDGY7RV
         XsIFlADneB0a0r+hUU+/gbNd2KhcTlKB6twGJuc7Mv9ejljKu+/W46G1TJG0k2veDJBK
         /Hq0PfkxIWMbKZ7dqMG267oW+RnFqTaKhk0xHL+Na6TxevQvfCraRW0Rd29sRGQ6y++o
         HAH/evg6eSheQzpPY+WjKNjtg0R1FJA/Z1CvuRS43tPtumLltELYY+LMJXzeu/6OAz4/
         jT89Xr0xu/6EUM9vMvaoiPLAhQVY5aC8ywbJYOROgowl9vlag715/U6hT0xQbqri86Lp
         GI9w==
X-Forwarded-Encrypted: i=1; AJvYcCXvD4RvROMpSaX3Kqv4qibYUQm18fITtHrCc5ybCKBrRgW+fdRAoumZcrKVzsuI1wihGi8tr+GKNtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC2MGSahR5rWPQY2dQskVmRUnCrPxJgQjbWxvfxO779OSU2TRE
	vMi005BTlqL79NL0Bb7bgJ/VHF7WAzM7BWW1xwX6icqHyMVAyUumFglRvAfiJAmXOhw=
X-Gm-Gg: AZuq6aI61Z2kojN8RmKAYUeFT/sgemwDVfqYQXHo6bK1FwecJqskfwf0I29Ez0se/mr
	CDyarIcOOV9DYFLIpYIAnYZfZ9Q5GR/RcxJb4Eh8blYj8+VSl0+6e8w/Ly7h8cMO5J6iVqX+KWZ
	m0AuHwljZV2WGPpfrhaVMXvWxbBaz0eMQIprcyOfvK1PnVmQK9CMH/Fz6KB75rvNh79z7NTpe1P
	+hP4BftCq1rdcz+cR0pRm7b9JXfcu2rW/ueA1p08uG5Xgr3aHdnYuqbncASN83Pr/4Ehfb4Bob8
	XYLMBQGpI92gBvtxC7dzMLnqau2WmAR8z+rOSNXOM7WNr6vw3C9qJUfUmbgVS4RB+E2W6VHXLjW
	nsLHfumpVn15F3fxCPSsuIf6+eII4mqHNPdCWqjhmoRrkEtdT4vqvtlhAQJXXpf5aXSqcOZ4JI+
	jc+Og+RJqv3yv35Q==
X-Received: by 2002:a05:6000:240b:b0:430:fcbc:dc52 with SMTP id ffacd0b85a97d-435c9d22eddmr8491819f8f.30.1769426114924;
        Mon, 26 Jan 2026 03:15:14 -0800 (PST)
Received: from [10.203.83.201] ([151.47.174.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e7156dsm30229443f8f.20.2026.01.26.03.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 03:15:14 -0800 (PST)
Message-ID: <6ae1019a543a744344720840d35c179d7fa3c43c.camel@baylibre.com>
Subject: Re: [PATCH v5 4/4] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Jan 2026 12:15:11 +0100
In-Reply-To: <20260123174810.00007ce5@huawei.com>
References: <20260122162335.2020006-1-flavra@baylibre.com>
	 <20260122162335.2020006-5-flavra@baylibre.com>
	 <20260122202943.344e7311@jic23-huawei>
	 <c722a6a28788ee36b5c87b0a98ec29f2f945470c.camel@baylibre.com>
	 <20260123174810.00007ce5@huawei.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-23 at 17:48 +0000, Jonathan Cameron wrote:
> On Fri, 23 Jan 2026 12:03:29 +0100
> Francesco Lavra <flavra@baylibre.com> wrote:
>=20
> > On Thu, 2026-01-22 at 20:29 +0000, Jonathan Cameron wrote:
> > > On Thu, 22 Jan 2026 17:23:35 +0100
> > > Francesco Lavra <flavra@baylibre.com> wrote:
> > > =C2=A0=20
> > > > Some IMU chips in the LSM6DSX family have sensor fusion features
> > > > that
> > > > combine data from the accelerometer and gyroscope. One of these
> > > > features
> > > > generates rotation vector data and makes it available in the
> > > > hardware
> > > > FIFO as a quaternion (more specifically, the X, Y and Z components
> > > > of
> > > > the
> > > > quaternion vector, expressed as 16-bit half-precision floating-
> > > > point
> > > > numbers).
> > > >=20
> > > > Add support for a new sensor instance that allows receiving sensor
> > > > fusion
> > > > data, by defining a new struct st_lsm6dsx_sf_settings (which
> > > > contains
> > > > chip-specific details for the sensor fusion functionality), and
> > > > adding
> > > > this
> > > > struct as a new field in struct st_lsm6dsx_settings. In
> > > > st_lsm6dsx_core.c,
> > > > populate this new struct for the LSM6DSV and LSM6DSV16X chips, and
> > > > add
> > > > the
> > > > logic to initialize an additional IIO device if this struct is
> > > > populated
> > > > for the hardware type being probed.
> > > > Note: a new IIO device is being defined (as opposed to adding
> > > > channels
> > > > to
> > > > an existing device) because the rate at which sensor fusion data is
> > > > generated may not match the data rate from any of the existing
> > > > devices.
> > > >=20
> > > > Tested on LSMDSV16X.
> > > >=20
> > > > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> > > > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>=C2=A0=20
> > > =C2=A0=20
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > index ded9a96076e6..3b4fa57bf461 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c=C2=A0=20
> > > =C2=A0=20
> > > > @@ -580,6 +584,16 @@ st_lsm6dsx_push_tagged_data(struct
> > > > st_lsm6dsx_hw
> > > > *hw, u8 tag,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case ST_LSM6DSX_EXT=
2_TAG:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev =3D hw->iio_devs[ST_LSM6DSX_ID_EXT2];
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case ST_LSM6DSX_ROT_TAG:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * The sensor reports only the {X, Y, Z} elements
> > > > of
> > > > the
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * quaternion vector; set the W value to 0 (it can
> > > > be
> > > > derived
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * from the {X, Y, Z} values due to the property
> > > > that
> > > > the vector
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * is normalized).=C2=A0=20
> > >=20
> > > I'd missed this before.=C2=A0 This is going to really confuse user sp=
ace.
> > > I don't think we can just return it with a 0 in that last entry.
> > > At the very least we need an ABI doc update to reflect this oddity.
> > >=20
> > > I don't think that is enough though. This isn't a quaternion, but
> > > rather something we can derive one from. Annoying though it is,
> > > we can't realistically fix it up in kernel, so we are probably
> > > talking
> > > a new MOD_TYPE.=C2=A0=20
> >=20
> > Quaternion data read from the sensor is expressed in floating-point
> > format,
> > and as such needs to be interpreted by userspace in a "non-standard"
> > way
> > (note there is no scale in the channel info, and this is intentional
> > because we are not dealing with integers) regardless of whether the W
> > value
> > is present or must be derived.
> > Isn't the absence of the scale info enough to let userspace know that
> > this
> > data is non-standard?
>=20
> Given both scale and offset are optional with defaults of 1.0 and 0 if
> not there, likely code won't notice that both are missing and under
> the ABI that would just make _raw =3D=3D _scale which is odd but not
> specifically
> excluded.
>=20
> > Only applications that know how to deal specifically
> > with this sensor device can make sense of the data (and these
> > applications
> > know that the quaternion vector is normalized and the W value must be
> > derived from X, Y, Z).
>=20
> This is the sort of feature that I'm reluctant to support. The only thing
> that we have let in (because it was truely obscure) that looks like this
> is pulse oximeters - the stuff in drivers/iio/health. It's a complex
> many reading maths thing to go from the data to the actual thing being
> measured.=C2=A0 The purpose of unified interfaces is being able to use th=
em
> across different sensors. Here we can't.=C2=A0 Hence this need some caref=
ul
> thought.

I see. So there are two things that need to be fixed:

1. the floating point format: as David suggested in the other post, the
specification of the scan type could be amended to allow floating point
formats; how about adding a new option to the ABI for the sign character
(which could perhaps be renamed to `format` in struct iio_scan_type)?
Currently we have 's' for signed and 'u' for unsigned: could we add 'f' for
IEEE 754 floats? Then the 'bits' part can have values in the {16,32,64}
set, to indicate half-, single- or double-precision numbers, respectively;
but could also not specify what numbers of bits are allowed in the ABI, and
just refer to the IEEE 754 standard for the available formats.

2. the absence of the W value in the quaternion vector; possible solutions
to this issue could be:
- adding in_rot_{x,y,z}_* (and perhaps in_rot_w_*) to the ABI to represent
the individual components of the quaternion as separate channels; if the w
channel is not present, its sample values could be derived from the other
channels under the assumptions that the vector is normalized and the
rotation angle is in the [-180, 180] range
- adding something like in_rot_reduced_quaternion_*, which would be the
same as in_rot_quaternion_* with the exclusion of the W component, which
could be derived as above

> >=20
> > > Also it's been a long time since I did much with quaternions,
> > > but isn't the sign of w ambiguous if we are relying on only X, Y and
> > > Z?
> > > A bit of googling + AI suggests flipping it inverts the direction of
> > > rotation around a given axis. Feels like there is a constraint
> > > missing
> > > in this description.=C2=A0=20
> >=20
> > Flipping the sign of W doesn't just invert the direction of rotation,
> > it
> > basically applies an offset of -360 degrees; if a value w0 indicates a
> > rotation by an angle theta0, the value -w0 indicates a rotation by
> > (theta0
> > - 360), which is basically the same as rotating by theta0. So knowing
> > the
> > {X, Y, Z} values is enough to have a non-ambiguous orientation.
>=20
> Ok. Taking a while to remember this stuff, but I'm fairly sure it isn't
> quite
> that.
> Inverting w is the difference between theta and (360 - theta) not (theta
> - 360)
> given the 360 doesn't matter as you say, it's a clockwise vs
> anticlockwise
> rotation.
>=20
> Lets take a vector to rotate (say representing up on a screen represnted
> as pure quaternion=C2=A0 v=3D (0 1 0 0). Apply rotation quaternion to rot=
ate
> that about the
> Y axis by 90 degrees in one direction (I'm too lazy to figure out which
> but doesn't
> matter!)
> q =3D (cos(theta/2), 0, sin(theta/2)j, 0)
> =C2=A0 =3D (sqrt(2)/2, 0, sqrt(2)/2, 0)
>=20
> Apply rotation is q v q'=20
>=20
> So multiplying it out=20
> (sqrt(2)/2, 0, (sqrt(2)/2)j, 0) (0, 1i, 0 0) (sqrt(2)/2, 0, -
> (sqrt(2)/2)j, 0)
> Given it's all multiples of (Sqrt(2)/2) Lets call that A
> =3D (A, 0, Aj, 0)(0, 1j, 0, 0)(A, 0, -Aj, 0)
> =3D (0, Ai, 0, -Ak) (A, 0, -Aj, 0)
> =3D (0, (A*A - (-A)*(-A))i, 0, (A *(-A) + (-A) * A)j)
> =3D (0, 0, 0, -1) or down on the z axis
>=20
> Same again, but now flip the W value
>=20
> (-A, 0, Aj, 0)(0, 1j, 0, 0)(-A, 0, -Aj, 0)
> =3D (0, (-A)i, 0, -(A)k)(-A, 0, -Aj, 0)
> =3D (0, ((-A)*(-A) -=C2=A0 (-A)*(-A))j, 0, (-A)*(-A) + (-A)*(-A)
> =3D (0, 0, 0, 1) or up on the z axis.

OK, I got the math wrong, flipping the W value does indeed invert the
direction of rotation as you said. As alluded to above, the missing
constraint is that the amount of rotation is within the [-180, 180] range:
this ensures that cos(theta/2) is always non-negative and removes the
ambiguity, while still allowing all possible orientations in 3D space to be
represented.

> Anyhow, that is moot if we don't figure out what to do about the fact
> we are forcing data into a representation a long way from what
> user space accepts.
>=20
> Jonathan
