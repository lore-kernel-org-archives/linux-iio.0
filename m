Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32379305E10
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783868220; cv=none; b=ZZ7rbK/O6A2eobNUOAGU5AmSo92ZTvQIiP32USfe5qmvOvCtZmKJWyZJQCsNovfStL/Pt/FTMt/IXXbUyEg5P+ZBadhuSzdkzzi7kuAbtsxnhrqiFMg5lQORP7X1S1UpNREcXcILeTh1p6PTJwruUUCo3J1OEevFYIwNAL+RFGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783868220; c=relaxed/simple;
	bh=TGRPC72Gvys5AV75OPDCquGwy09jz+tfo00bqh+xHas=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peKIGVB5/VM/UP9SI5otJ8FRhTQfIvBqHrfok9TUCkKOTYCEP4ElBLW2q+OjvgRLXQV0Tqr2joyB7x3Cekw8GUDr96I9dujW/iXEqHv/Oiw57uYQnnYM0C76aU+gmq4uD6Eeg5Tj4kr6dOshQbbOGA7LA9EJsJOFsUg8//BTCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=BaO2ShkU; arc=none smtp.client-ip=79.135.106.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="BaO2ShkU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1783868205; x=1784127405;
	bh=Kph/ldNz0ZH173y/id/SbO43lTRApBugzr5x8gMpR6A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BaO2ShkUUlsX1FD8VKoubM1QSXne1UHGT9oTOGd+GiMrH3nyjzGvssKDri4sr/7uX
	 N851metfyHOuts6uCDwxXajyC/f1qrh9JK/k1P8F1rQmAOO7FqT7/vPbGPf20wjtvE
	 LW15F+jz8Ki5wmwj5eaR5CCNBFgHlboDCr/PEn7aVjq3F0KIAsegRxVkUv1IVgbA1R
	 pyPUUyJgxXK90KjyTQq6sMoBn4vV6SOJV7BSPCju+1Nht0amTAhAPPlfGtkfrtT+P9
	 jiDD6Q+UOCTnhE1C8DipYIO9I/9c8K9oWvRazxPvj7JbsICfYb24tGVG3XUPoOKzVQ
	 DZGfFFd/Rre0g==
Date: Sun, 12 Jul 2026 14:56:40 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: dylanliu050903 <dylanliu050903@protonmail.com>
Cc: Dylan Liu <pxyforeverlove1314@gmail.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: =?utf-8?Q?=E5=9B=9E=E5=A4=8D=EF=BC=9A_Re:_[PATCH]_Signed-off-by:_Dylan_Liu_<dylanliu050903@protonmail.com>?=
Message-ID: <QNymfg8xEp8CU0BQxNJDcXKxDRN_xohHqySr8jzeakn2iJwHaezt4D2ks87ODGRh9227yPZ6dVpvcAa5OghRpS0htIaCUhCS7viUtr9aPgw=@protonmail.com>
In-Reply-To: <2026071227-unspoiled-blatancy-0809@gregkh>
References: <20260712141928.559844-1-dylanliu050903@protonmail.com> <2026071227-unspoiled-blatancy-0809@gregkh>
Feedback-ID: 149338405:user:proton
X-Pm-Message-ID: 9097688b3fbbb16a4f1d4312c2850e7fe8ad9fd3
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
=E5=8D=88 10:27=EF=BC=8CGreg Kroah-Hartman <gregkh@linuxfoundation.org> =
=E6=9D=A5=E4=BF=A1=EF=BC=9A
> You just changed the user/kernel api, right?  Are you sure this is ok to
> do?
>=20
> thanks,
>=20
> greg k-h
>=20
Hi Greg,

I apologize for the oversight; being new to this, I am still learning the r=
opes and appreciate your patience.

You are absolutely right. I acknowledge that changing the sysfs names direc=
tly impacts userspace and violates the "never break userspace" rule. I will=
 take a step back and adopt a more conservative approach: I plan to keep th=
e original attribute names as they are to ensure backward compatibility whi=
le introducing the new snake_case names as aliases.

Would this be an acceptable way to move forward, or would you prefer I hand=
le this cleanup in a different way?

Thanks,
Dylan Liu
