Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169995;
	b=sbV1IlzVKdReCkY8UUw+pAKxQzs+hsGkExD/ht/B3rCj4Yab9JJptB5QAwKdSednp7oY
	 7Ul9QNChQAKgQDcXgsD5mzgU2mKzeG9SXzrAdjVkF8dwjtMgrn0HbpTIy8s4dQkI5d94v
	 G1QijCijkrq7zlgbHnDYoNVXcAwazrngPfeLwUWwHpsEnWpcuDdscM6gPbwffgoZzpldR
	 xr8SaMaeGfyq+zptIFYSa5+fQKXBHGa5r03o4zBX+u/c1ztQTyXNlMPcBn+a8R+wt1U6q
	 nfYHosT2r5CrYwxRJu5EUQrvAUtQxMywA27UE1ElcGdlXiyXXt83dbYr6X68gUUzDYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169995;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WEnTIXTYh2l5jjP8NSLhhT1ky4rEJuDjFD55P/8sz1M=;
	b=n8nspwZfLtCk/y7NMzAhkdojh2de6leZ84/vFZmeYElcyH70H/Cz6dT3FrYJ/e4Yz+8Y
	 rS+VOkmu5OV4xkO20XuEwTf592O840vPm8u8ABAYzv0JJZ75MS/ODBOTEvUroV1IDLmIF
	 E3kb/HSxfoYQXz5XcPWa6yDjpet7ecaln4zXNN99gO+NNQjEIX7hgv8/3D0FglVjqmBgi
	 Criz3z8GCnn+oWUf+E4/OvkPurRxJcijL3d4njjV9PCJgJjCQaOCLApBiTnaZqkV2cb+G
	 Ln3nAGdNuJMBNKyCJDUA7vdRGgZZ/YAcRx6xg1zoK9ezBb8v2CF6nY0ISf3TMfkIHMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdQut2Fa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EFC606D805
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdQut2Fa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E05C1F0089F;
	Sun,  8 Nov 2026 20:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169994;
	bh=WEnTIXTYh2l5jjP8NSLhhT1ky4rEJuDjFD55P/8sz1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZdQut2Fap1zr9GLhxJ7pSpw1nsn+HpEJaA/Ng6f9Z7E7/l53zcHEsDFOuqRfJtsC0
	 VEGuFf1bCpJ1Mcgx/f22OpbMEf95UKe7QBZAO+YaVQ1YuPSSvwWzYuJkZSeGa1WfpN
	 cbDnf4BsZ2MhPi2VrnGl+st7c7NnUTikW5toKxLci+Sp9QFPTGIUdEa1ScnhBFMBMF
	 aqUrIG1VFejRdf1eB7VIMvSv2abXXVOCeVNQWTjA7prXYxcVP7RXe4gBhVHfWqCNz2
	 xF/dSMltsKYDOUmpkNZWfzwYtWBi3oMuCQckCq6HBjug7nF+9tI28kLbzA80lJpL9J
	 bUYd9oPT0h8ng==
Date: Sun, 8 Nov 2026 20:33:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?=  <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina  <jikos@kernel.org>, Zhang Lixu <lixu.zhang@intel.com>
Subject: Re: [PATCH 05/39] iio: hid-sensors: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108203306.1599d000@jic23-hlaptop>
In-Reply-To: <60eab26805ad63d1b39d80fb9a47b0ba9bb5789d.camel@linux.intel.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-5-8b136778eedf@oss.qualcomm.com>
	<60eab26805ad63d1b39d80fb9a47b0ba9bb5789d.camel@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Oct 2026 17:06:23 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Mon, 2026-10-26 at 16:05 -0700, Jonathan Cameron wrote:
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> >=20
> > For hid-sensor-magn-3d, use IIO_DECLARE_BUFFER_WITH_TS() to suize the
> > buffer for the maximum number of channels supported avoiding need
> > for separate allocation.
> >=20
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> =20
>=20
> LGTM.
> I will do some quick test on this and let you know.

No huge rush.  This is the only one I'm going to leave unapplied
that doesn't need changes (as far as I know!) for now.

Thanks,

Jonathan

>=20
> Thanks,
> Srinivas
>=20
> > ---
> > Cc: Jiri Kosina <jikos@kernel.org>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Zhang Lixu <lixu.zhang@intel.com>
> > ---
> > =C2=A0drivers/iio/gyro/hid-sensor-gyro-3d.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
> > =C2=A0drivers/iio/humidity/hid-sensor-humidity.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
> > =C2=A0drivers/iio/magnetometer/hid-sensor-magn-3d.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 21 ++++++-----
> > ----------
> > =C2=A0drivers/iio/orientation/hid-sensor-incl-3d.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++---
> > =C2=A0.../iio/position/hid-sensor-custom-intel-hinge.c=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++--
> > =C2=A05 files changed, 18 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > index 66778315e86d..083e82cf561c 100644
> > --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > @@ -182,8 +182,9 @@ static int gyro_3d_proc_event(struct
> > hid_sensor_hub_device *hsdev,
> > =C2=A0		if (!gyro_state->timestamp)
> > =C2=A0			gyro_state->timestamp =3D
> > iio_get_time_ns(indio_dev);
> > =C2=A0
> > -		iio_push_to_buffers_with_timestamp(indio_dev,
> > &gyro_state->scan,
> > -						=C2=A0=C2=A0 gyro_state- =20
> > >timestamp); =20
> > +		iio_push_to_buffers_with_ts(indio_dev, &gyro_state- =20
> > >scan, =20
> > +					=C2=A0=C2=A0=C2=A0 sizeof(gyro_state- =20
> > >scan), =20
> > +					=C2=A0=C2=A0=C2=A0 gyro_state->timestamp);
> > =C2=A0
> > =C2=A0		gyro_state->timestamp =3D 0;
> > =C2=A0	}
> > diff --git a/drivers/iio/humidity/hid-sensor-humidity.c
> > b/drivers/iio/humidity/hid-sensor-humidity.c
> > index 12c88efe66be..c09986346c8f 100644
> > --- a/drivers/iio/humidity/hid-sensor-humidity.c
> > +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> > @@ -132,8 +132,9 @@ static int humidity_proc_event(struct
> > hid_sensor_hub_device *hsdev,
> > =C2=A0	struct hid_humidity_state *humid_st =3D iio_priv(indio_dev);
> > =C2=A0
> > =C2=A0	if (atomic_read(&humid_st->common_attributes.data_ready))
> > -		iio_push_to_buffers_with_timestamp(indio_dev,
> > &humid_st->scan,
> > -						=C2=A0=C2=A0
> > iio_get_time_ns(indio_dev));
> > +		iio_push_to_buffers_with_ts(indio_dev, &humid_st- =20
> > >scan, =20
> > +					=C2=A0=C2=A0=C2=A0 sizeof(humid_st->scan),
> > +					=C2=A0=C2=A0=C2=A0
> > iio_get_time_ns(indio_dev));
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0}
> > diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > index c8b4fa7785c9..f869560b47fc 100644
> > --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > @@ -37,8 +37,8 @@ struct magn_3d_state {
> > =C2=A0	struct hid_sensor_common rot_attributes;
> > =C2=A0	struct hid_sensor_hub_attribute_info
> > magn[MAGN_3D_CHANNEL_MAX];
> > =C2=A0
> > -	/* dynamically sized array to hold sensor values */
> > -	u32 *iio_vals;
> > +	/* array sized to hold maximum set of sensor values */
> > +	IIO_DECLARE_BUFFER_WITH_TS(u32, iio_vals,
> > MAGN_3D_CHANNEL_MAX);
> > =C2=A0	/* array of pointers to sensor value */
> > =C2=A0	u32 *magn_val_addr[MAGN_3D_CHANNEL_MAX];
> > =C2=A0
> > @@ -275,9 +275,10 @@ static int magn_3d_proc_event(struct
> > hid_sensor_hub_device *hsdev,
> > =C2=A0		if (!magn_state->timestamp)
> > =C2=A0			magn_state->timestamp =3D
> > iio_get_time_ns(indio_dev);
> > =C2=A0
> > -		iio_push_to_buffers_with_timestamp(indio_dev,
> > -						=C2=A0=C2=A0 magn_state- =20
> > >iio_vals, =20
> > -						=C2=A0=C2=A0 magn_state- =20
> > >timestamp); =20
> > +		iio_push_to_buffers_with_ts(indio_dev,
> > +					=C2=A0=C2=A0=C2=A0 magn_state->iio_vals,
> > +					=C2=A0=C2=A0=C2=A0 sizeof(magn_state- =20
> > >iio_vals), =20
> > +					=C2=A0=C2=A0=C2=A0 magn_state->timestamp);
> > =C2=A0		magn_state->timestamp =3D 0;
> > =C2=A0	}
> > =C2=A0
> > @@ -379,16 +380,6 @@ static int magn_3d_parse_report(struct
> > platform_device *pdev,
> > =C2=A0		return -ENOMEM;
> > =C2=A0	}
> > =C2=A0
> > -	/* attr_count include timestamp channel, and the iio_vals
> > should be aligned to 8byte */
> > -	st->iio_vals =3D devm_kcalloc(&pdev->dev,
> > -				=C2=A0=C2=A0=C2=A0 ((attr_count + 1) % 2 +
> > (attr_count + 1) / 2) * 2,
> > -				=C2=A0=C2=A0=C2=A0 sizeof(u32), GFP_KERNEL);
> > -	if (!st->iio_vals) {
> > -		dev_err(&pdev->dev,
> > -			"failed to allocate space for iio values
> > array\n");
> > -		return -ENOMEM;
> > -	}
> > -
> > =C2=A0	for (i =3D 0, *chan_count =3D 0;
> > =C2=A0	i < MAGN_3D_CHANNEL_MAX && *chan_count < attr_count;
> > =C2=A0	i++){
> > diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c
> > b/drivers/iio/orientation/hid-sensor-incl-3d.c
> > index b5f70732d035..3880e479a499 100644
> > --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> > +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> > @@ -194,9 +194,10 @@ static int incl_3d_proc_event(struct
> > hid_sensor_hub_device *hsdev,
> > =C2=A0		if (!incl_state->timestamp)
> > =C2=A0			incl_state->timestamp =3D
> > iio_get_time_ns(indio_dev);
> > =C2=A0
> > -		iio_push_to_buffers_with_timestamp(indio_dev,
> > -						=C2=A0=C2=A0 &incl_state- =20
> > >scan, =20
> > -						=C2=A0=C2=A0 incl_state- =20
> > >timestamp); =20
> > +		iio_push_to_buffers_with_ts(indio_dev,
> > +					=C2=A0=C2=A0=C2=A0 &incl_state->scan,
> > +					=C2=A0=C2=A0=C2=A0 sizeof(incl_state- =20
> > >scan), =20
> > +					=C2=A0=C2=A0=C2=A0 incl_state->timestamp);
> > =C2=A0
> > =C2=A0		incl_state->timestamp =3D 0;
> > =C2=A0	}
> > diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> > b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> > index 101d84b533c9..98a5e3e03bba 100644
> > --- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> > +++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> > @@ -198,8 +198,8 @@ static int hinge_proc_event(struct
> > hid_sensor_hub_device *hsdev,
> > =C2=A0		if (!st->timestamp)
> > =C2=A0			st->timestamp =3D iio_get_time_ns(indio_dev);
> > =C2=A0
> > -		iio_push_to_buffers_with_timestamp(indio_dev, &st- =20
> > >scan, =20
> > -						=C2=A0=C2=A0 st->timestamp);
> > +		iio_push_to_buffers_with_ts(indio_dev, &st->scan,
> > +					=C2=A0=C2=A0=C2=A0 sizeof(st->scan), st- =20
> > >timestamp); =20
> > =C2=A0
> > =C2=A0		st->timestamp =3D 0;
> > =C2=A0	} =20
>=20

