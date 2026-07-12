Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD8415687D
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783870930; cv=none; b=YqkVf4uI6rgopNO1Z22A1F93lgvCx2+/Zeq9XL9pjNGZxOrShl/87TRPIE2ixaszL6tHDZskFcrZMfjJEsi4BGPPAXpEGUSFDPPftRPrFbipb5Rm9IeDKHcyQbuOIUTBdVFzofiN9PQtxJgs4VjNvfWHUitGvc0/0AiMVkjMews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783870930; c=relaxed/simple;
	bh=2AwsVikTQ0Fq3A7BIdDmeEoEXcaWURKy6RZfPuYsct0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FixUQYOUdOMCYcSEnyWtGULFzlKQTTZcrKwXpS9hUuHYijx/BiRNtynWNDKmC3971D/Gv8uM1T4Fnf4oHUoYm5sHCx3ahXH0mPO4rLaxWnsadco+ahUIhd9vhdasOYkEAyS56xbVblV+jWwOXTo4UtIQuO3Iq78/mxlt1EYr06c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=UvdWbuCm; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="UvdWbuCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1783870919; x=1784130119;
	bh=GPwVPgndiL3vQUrrsmdWXJtrIcm/zZTFErr9I8RY0RI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UvdWbuCmVeEHFwU4A4erWTpuRJDpfITGXQkhUhzSqe6bjiyzXvZIAG8XgNCfg47AD
	 ShLpdZI4ivvnXbgMdrwJ6UCAJpso7Tqfq/DS3NaYnO5N4N8MokFC7amRAXnfW5/MFI
	 /4GqjaHXh4WkVgeuj94YX6I4d5x1svxr94Ncddut5xWlmlZ3zwDN3FaFFmp7SvMQc+
	 +TiuQExFloU9Iw1VIUJvO8aSQ2YFuyLn+OT+1DziNQ0aWsEBRByayrItLysX+lh+4N
	 VU5BlKFLLdaHQ4JOxrrfL3637MnVi363oFhoaw9Pu9Vi1VySOE8YYClTY3OnF0L7/o
	 Zw0HnN2s6VU5w==
Date: Sun, 12 Jul 2026 15:41:54 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>
From: dylanliu050903 <dylanliu050903@protonmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dylan Liu <pxyforeverlove1314@gmail.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: =?utf-8?Q?=E5=9B=9E=E5=A4=8D=EF=BC=9A_Re:_=E5=9B=9E=E5=A4=8D=EF=BC=9A_Re:_[PATCH]_Signed-off-by:_Dylan_Liu_<dylanliu050903@protonmail.com>?=
Message-ID: <BKV7Mhbq1o3O_ErHy0kJsAxQU0wPO9BA6L-6CKJlZ9DsyAlGxNQzVfSIokpg-0V4bh0dp7KoAsq34iyjPsGOVDfFX3YSI7d0MozL381XqkA=@protonmail.com>
In-Reply-To: <alOtR-zUc71PORuA@ashevche-desk.local>
References: <20260712141928.559844-1-dylanliu050903@protonmail.com> <2026071227-unspoiled-blatancy-0809@gregkh> <QNymfg8xEp8CU0BQxNJDcXKxDRN_xohHqySr8jzeakn2iJwHaezt4D2ks87ODGRh9227yPZ6dVpvcAa5OghRpS0htIaCUhCS7viUtr9aPgw=@protonmail.com> <alOtR-zUc71PORuA@ashevche-desk.local>
Feedback-ID: 149338405:user:proton
X-Pm-Message-ID: f20212404021f2aa838224ea10c5b0efa6e9500c
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





=E4=BD=BF=E7=94=A8 Proton Mail =E5=AE=89=E5=85=A8=E9=82=AE=E7=AE=B1=
=E5=8F=91=E9=80=81=E3=80=82

2026=E5=B9=B47=E6=9C=8812=E6=97=A5 =E6=98=9F=E6=9C=9F=E6=97=A5 =E4=B8=8B=
=E5=8D=88 11:05=EF=BC=8CAndy Shevchenko <andriy.shevchenko@intel.com> =
=E6=9D=A5=E4=BF=A1=EF=BC=9A

> On Sun, Jul 12, 2026 at 02:56:40PM +0000, dylanliu050903 wrote:
> > =E4=BD=BF=E7=94=A8 Proton Mail =E5=AE=89=E5=85=A8=E9=82=AE=E7=AE=B1=
=E5=8F=91=E9=80=81=E3=80=82
> > 2026=E5=B9=B47=E6=9C=8812=E6=97=A5 =E6=98=9F=E6=9C=9F=E6=97=A5 =
=E4=B8=8B=E5=8D=88 10:27=EF=BC=8CGreg Kroah-Hartman <gregkh@linuxfoundation=
.org> =E6=9D=A5=E4=BF=A1=EF=BC=9A
> > > You just changed the user/kernel api, right?  Are you sure this is ok=
 to
> > > do?
> >
> > I apologize for the oversight; being new to this, I am still learning t=
he
> > ropes and appreciate your patience.
> >
> > You are absolutely right. I acknowledge that changing the sysfs names
> > directly impacts userspace and violates the "never break userspace" rul=
e. I
> > will take a step back and adopt a more conservative approach: I plan to=
 keep
> > the original attribute names as they are to ensure backward compatibili=
ty
> > while introducing the new snake_case names as aliases.
> >
> > Would this be an acceptable way to move forward, or would you prefer I =
handle
> > this cleanup in a different way?
>=20
> You also should stop sending HTML mails.
>=20
> The driver is in staging and most likely more work is needed. As for this=
 ABI
> change, it's possible but it needs to be aligned with IIO maintainers and
> reviewers first to understand why the original driver has it and what wil=
l be
> needed to fulfil the same / similar if driver becomes part of IIO.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
>=20
Hi Andy,

First, I apologize for the HTML email earlier. I have fixed my email client=
 settings.I was using the ProtonMail web client instead of `git send-email`=
, which unexpectedly defaulted to HTML.

Regarding the ABI change: I made a classic beginner mistake. I changed it p=
urely because the `checkpatch.pl` script threw a warning suggesting it shou=
ld be in snake_case. I blindly followed the script's advice without realizi=
ng that I was modifying a user/kernel ABI.=20

I now understand that ABI stability (and aligning with IIO maintainers for =
any necessary staging transitions) absolutely takes precedence over resolvi=
ng style warnings.

Please drop this patch. I will be much more careful with checkpatch warning=
s involving exposed interfaces in the future.I will also dive deeper into t=
he codebase to ensure my future commits provide real value.

Thank you for your time and the guidance!

Best regards,
Dylan Liu
