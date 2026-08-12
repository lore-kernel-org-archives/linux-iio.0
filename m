Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6FE382298;
	Wed, 12 Aug 2026 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786509835; cv=none; b=W2IJgAt4YZ0y+73ACMBgeJO+UZ267tycnvVrnq49HDA1Oau2yo83yFGdHH5i1enm7cj+j2LaCmgtP1+Ehj1MifrubKNMRxFFOBW5raI1ratSkEHbaTHF0hhC2NcjYdvCfdDwwqE7yQbeezaxTUOryNcbrO03IWMIeWOsAXPa09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786509835; c=relaxed/simple;
	bh=L4JMKYx9oQchKHHDX/JJ3OmTebx/rCi6no3TSfYqNio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pC2+v9dXM5j8bQeNHm56wn9CwPsyNJYFj4OErK/HflaYKaUf8G54Zf748Q52841zFRBtwCGtMaqvmCd293MGGerFbHAChXlafrFrNKBQ4DAG8LX72WeLNlH8De0ahyg7MDiKD0Q5Tm6rNawus5E6hcqz5mSJ68GNuwktgIa5qWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbVBSRfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbVBSRfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2811F000E9;
	Wed, 12 Aug 2026 04:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786509833;
	bh=ZEnvUJjIdPKxsrLRosBCY08Bsq9jo0wQmvUIdxNa28Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lbVBSRfbUV23RkWg/2QYmGkRdqozwYhAXpIx4CVGmWix1Ow+B7m79cXtgQuTUuDql
	 fgeHBMKMh/Nkmtnu42fzUt8tWAM0/29rM66MsJ+XXbVMWc6OZoMqnkB4Y6OYFRSL0j
	 V8sueCbIiYCiPiDbxFNKaQAuZ1R+A3E1e+cHEFrckkoYckOV2VZo3mz5grICifqI3m
	 SrkGvGe1XxE495OcIV/2vOJhORVeMQrQ5FAzRzUbaV67W3zDAYTZ/VuefQpOrljFGq
	 zB12I8nvn00a1nv6r/lvJKHDYvy5DmZUArN+GtPwHRWeDneNVy0xe+oX0gNYQ2luhR
	 SjmZsFoAhrb7w==
Date: Wed, 12 Aug 2026 05:43:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: =?UTF-8?B?Tmljb2zDoXM=?= Antinori <nico.antinori.7@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Andy Shevchenko <andy@kernel.org>, Brigham
 Campbell <me@brighamcampbell.com>, Jori Koolstra <jkoolstra@xs4all.nl>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] iio: humidity: am2315: add am2320 to i2c_device_id
 table
Message-ID: <20260812054339.6f58b5fd@jic23-huawei>
In-Reply-To: <125ac6a1-a089-4ce8-9b20-c3448b6b5208@baylibre.com>
References: <20260810183337.451812-1-nico.antinori.7@gmail.com>
	<anqKwJOkl_cxzCT6@debian-BULLSEYE-live-builder-AMD64>
	<anrRkty6ugdJUGmE@ashevche-desk.local>
	<DKM7MV8J10HS.2OIM1TDHB9VHQ@gmail.com>
	<2d7dcced-47f9-4fcf-9668-30acb9e8c9b1@baylibre.com>
	<DKMB5HGIEQCW.3EKGVS7GLRBOF@gmail.com>
	<125ac6a1-a089-4ce8-9b20-c3448b6b5208@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Aug 2026 13:06:50 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/11/26 12:58 PM, Nicol=C3=A1s Antinori wrote:
> > On Tue Aug 11, 2026 at 12:49 PM -03, David Lechner wrote: =20
> >> On 8/11/26 10:12 AM, Nicol=C3=A1s Antinori wrote: =20
> >>> On Mon Aug 10, 2026 at 4:28 PM -03, David Lechner wrote: =20
> >>>> On 8/10/26 1:32 PM, Nicol=C3=A1s Antinori wrote: =20
> >>>>> The AM2320 is fully compatible with the AM2315 sensor in terms of I=
2C
> >>>>> communication protocol and measurement conversions.
> >>>>>
> >>>>> Add the "am2320" entry to the i2c_device_id table. =20
> >>>>
> >>>> Interesting. No devicetree bindings for this one? What kind of
> >>>> system is it on?
> >>>> =20
> >>>
> >>> I am testing this on a Raspberry Pi 3b mounted on a protoboard. =20
> >>
> >> How do you tell the RPi to bind the driver?
> >>
> >> Since Raspberry Pi is ARM-based, usually we would use devicetree
> >> overlay to do this, which would mean that we should write a
> >> dt-bindings .yaml file for these chips. =20
> >=20
> > I do it manually.
> >=20
> > I use that RPi for development, at the moment the kernel I am using is=
=20
> > 7.2.0-rc6-v8+ with CONFIG_AM2315=3Dm. When I need to use the AM2320 I
> > modprobe it with:
> >=20
> > $ sudo modprobe am2315
> >=20
> > And then=20
> >=20
> > $ sudo bash -c "echo am2315 0x5c > /sys/bus/i2c/devices/i2c-1/new_devic=
e"
> >=20
> > (With the modifications I made ... echo am2320 ... works as well)
> > The pins for i2c I am using are GPIO 2 (SDA) and GPIO 3 (SCL).
> >=20
> > If a dt-binding yaml is needed I can send another patch with it!
> >=20
> >  =20
>=20
> Yes please. It will make it easier for others to use as well.

I think (from a quick bit of googling) that these two parts are
at least 'kind of' the same thing with different packaging.
The name is a nice to have and given the packaging may I guess
affect the signal and how it is used it probably makes sense
to add it.

They only have 4 pins. Power, ground, SCL and SDA.  So it
is a rare device simple enough that I think an entry in trivial-devices.yaml
is probably sufficient.

Ideally add an of_device_id table, even though this will work fine
by the fallback path that uses the i2c_device_id table

Jonathan

>=20

