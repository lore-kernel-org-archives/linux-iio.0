Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C992F25E4
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166217; cv=none; b=tkt4ZQINU8I8+5fb8E2W1e77eHAbikmR9e32f2gQR8Gh3fE89uRW3vv38J+7eBa8CrL39q2h7nd9y81Sxl1OYZvSt61tVp+dsV7ddJeRMgnhZfDPfbR6iWE7rFxomyT7tmv4B3Oc+4ziVO5TXK4lSb90UEpD6lh55tsw71YpD8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166217; c=relaxed/simple;
	bh=O4Nih27iosbIpR9tjlrFXWsPJSLSROkSTpB4yV9z8V8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAYOwgb0VeOQsDrpO88GyOx1sKBmfpGon6kpWwQYxytZW4x/RM/Dut3H97gNZbSHlo/RI4wc5I2KBXTA4lzEBvpq+hjfhFNCHuxSL64o9jh8mZao2TBekNt3A6QX+GwzBIUdPoJo6YGz9wlfB2Rpog2Fc6y8xD+Oi1MdTv9P3Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hV3gmEmZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hV3gmEmZ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8849dc12f6so260725066b.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 03:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769166213; x=1769771013; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O4Nih27iosbIpR9tjlrFXWsPJSLSROkSTpB4yV9z8V8=;
        b=hV3gmEmZyjq84jsLETSBnHVno6wWBBQaMdR7u8msuFS4Z0JWdm8rNNCSKepAdDYZ++
         3zcAWPdi6KOabctKWcECXUhbjxCS6IO6WeNnWWPf805mAv9RZohOTQiuMOMfPZOjDLha
         r0Oo8IhbmV0l/gUVvM8c90Gu+fphybAGmtD7tWt0W1CFo8N9DKAIJjxvRHoEin9buI+b
         mqyQM+MVssQ0yhKF+FC73xXVfCNltmfOJHGKQRCuShIJx7RQDq7X16m8n/lb0XNTG917
         r8BnXQGWbKjuwcDC84pr7GwYJlhqZxWuJY++qpEnU1/r52zpzUZI6R54sAWUIsG89UmC
         BpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769166213; x=1769771013;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4Nih27iosbIpR9tjlrFXWsPJSLSROkSTpB4yV9z8V8=;
        b=iXL5lfKWPNrWGAlKordMkPaNwnJI0HkJF3wi5rfFzXowxcFS6buwqXa20y4xEMnJ8o
         Z1THJMvGOJIFGQ0lF5P5Q5pcbV/+fFWPdBmYCOxLtU89bu1yS+W6qb05XPV0zbeOCbpm
         0wEbWBJqUX/yV9H3UaLxlMo+xon7nVs1q7T2fAQlUpY6ufFR0vdiJUZnI78V7Vgm/BxQ
         ek8Lv89ZJ7gk6tP9Zzf9zgw7B2ywvDRm2Ud24LKb4CC07GPtIkk++s9oKE+8TRqiZANP
         Gp+6Gc/CCa6X1pXLIWbtmkf2STE4oOBQr91hmaHzDWrl8cys3/gcgjhD675MbbCJ9/hf
         ZT4g==
X-Forwarded-Encrypted: i=1; AJvYcCWw6+Ext4kMagRBoSm9Yl4naMyOXESnHbAe0QfU9mNk6ezolq/W2SAv96qzqYaZEgAGL5xYw2hGhfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLuqyNl7s/22VVWDgYkgdMO8dNaIE11QVxQgYnq49srg5luPt
	NBTrKgppWWrhxrc6GIAc+NBEGPSKzaVq924QekBHStJO8xagWtnHzwrZyV6DGV+meks=
X-Gm-Gg: AZuq6aJE74z3Jm6GyTkVCDSQjnLxUdi2SV34xE8PQPu4cAFj0OGupt56EYWNJWOH9yl
	lOlKKP722AQVVNGAD4VxBevurzbJzSmNoIsesQyKV6zxr5g+RYPvxqs+8k4c8BSXv+jkUhxYO72
	trt9yrBHZKHBYPvx+kYQ+qBeA+hFN/rQDrvZYcuii5RRfuPK5cQQ+BLKrIQZJSgkSHN/IWxKMuw
	qBl80cEYZTazaFIWOAc2kAB8TA6Gc3gMb7gUQ1kgnokv82Tl3L+5jhCEG8gHO3g2AkKir6P/wz8
	XI2O8u5q/FP+2+wRshNiFaL5LhfZaErUR2UVaxV489k30WUF/whRhMPI0J47ET6wB7LRyz3albg
	5cRKiqBCqeMq0j3mU4ER+S22kjposQogOqfh2l6c0JxCJVRWC+pxbmwPq7UARxcA0lKqwYBR91c
	Xmugc=
X-Received: by 2002:a17:907:da6:b0:b87:d3af:de68 with SMTP id a640c23a62f3a-b885ac0fad0mr156808266b.7.1769166213265;
        Fri, 23 Jan 2026 03:03:33 -0800 (PST)
Received: from [10.203.83.237] ([151.19.16.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b3eb9f2sm807038a12.14.2026.01.23.03.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 03:03:32 -0800 (PST)
Message-ID: <c722a6a28788ee36b5c87b0a98ec29f2f945470c.camel@baylibre.com>
Subject: Re: [PATCH v5 4/4] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Jan 2026 12:03:29 +0100
In-Reply-To: <20260122202943.344e7311@jic23-huawei>
References: <20260122162335.2020006-1-flavra@baylibre.com>
	 <20260122162335.2020006-5-flavra@baylibre.com>
	 <20260122202943.344e7311@jic23-huawei>
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

On Thu, 2026-01-22 at 20:29 +0000, Jonathan Cameron wrote:
> On Thu, 22 Jan 2026 17:23:35 +0100
> Francesco Lavra <flavra@baylibre.com> wrote:
>=20
> > Some IMU chips in the LSM6DSX family have sensor fusion features that
> > combine data from the accelerometer and gyroscope. One of these
> > features
> > generates rotation vector data and makes it available in the hardware
> > FIFO as a quaternion (more specifically, the X, Y and Z components of
> > the
> > quaternion vector, expressed as 16-bit half-precision floating-point
> > numbers).
> >=20
> > Add support for a new sensor instance that allows receiving sensor
> > fusion
> > data, by defining a new struct st_lsm6dsx_sf_settings (which contains
> > chip-specific details for the sensor fusion functionality), and adding
> > this
> > struct as a new field in struct st_lsm6dsx_settings. In
> > st_lsm6dsx_core.c,
> > populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add
> > the
> > logic to initialize an additional IIO device if this struct is
> > populated
> > for the hardware type being probed.
> > Note: a new IIO device is being defined (as opposed to adding channels
> > to
> > an existing device) because the rate at which sensor fusion data is
> > generated may not match the data rate from any of the existing devices.
> >=20
> > Tested on LSMDSV16X.
> >=20
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index ded9a96076e6..3b4fa57bf461 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>=20
> > @@ -580,6 +584,16 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw
> > *hw, u8 tag,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case ST_LSM6DSX_EXT2_TA=
G:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev =3D hw->iio_devs[ST_LSM6DSX_ID_EXT2];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case ST_LSM6DSX_ROT_TAG:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * The sensor reports only the {X, Y, Z} elements of
> > the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * quaternion vector; set the W value to 0 (it can be
> > derived
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * from the {X, Y, Z} values due to the property that
> > the vector
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * is normalized).
>=20
> I'd missed this before.=C2=A0 This is going to really confuse user space.
> I don't think we can just return it with a 0 in that last entry.
> At the very least we need an ABI doc update to reflect this oddity.
>=20
> I don't think that is enough though. This isn't a quaternion, but
> rather something we can derive one from. Annoying though it is,
> we can't realistically fix it up in kernel, so we are probably talking
> a new MOD_TYPE.

Quaternion data read from the sensor is expressed in floating-point format,
and as such needs to be interpreted by userspace in a "non-standard" way
(note there is no scale in the channel info, and this is intentional
because we are not dealing with integers) regardless of whether the W value
is present or must be derived.
Isn't the absence of the scale info enough to let userspace know that this
data is non-standard? Only applications that know how to deal specifically
with this sensor device can make sense of the data (and these applications
know that the quaternion vector is normalized and the W value must be
derived from X, Y, Z).

> Also it's been a long time since I did much with quaternions,
> but isn't the sign of w ambiguous if we are relying on only X, Y and Z?
> A bit of googling + AI suggests flipping it inverts the direction of
> rotation around a given axis. Feels like there is a constraint missing
> in this description.

Flipping the sign of W doesn't just invert the direction of rotation, it
basically applies an offset of -360 degrees; if a value w0 indicates a
rotation by an angle theta0, the value -w0 indicates a rotation by (theta0
- 360), which is basically the same as rotating by theta0. So knowing the
{X, Y, Z} values is enough to have a non-ambiguous orientation.
