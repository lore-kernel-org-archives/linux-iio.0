Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623A625EF87;
	Sun, 19 Apr 2026 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776615748; cv=none; b=Y+CXdYIajqCE6pIKSwsU9En9uCxwmqJ8lsfU18Qel2IqAnfSziNU/6Mzcn+aeaRq6ky20AiFAiblcv3psSeI0QiPd/ciek7U2Gwhtm/KPKwXO6Xa3wbPEPDzFWaDKFXd510vraX2A94lGLx2WPdg2o2+nggzzRF/yG/clKOky6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776615748; c=relaxed/simple;
	bh=uuX5wbb87BSHGqTmGCjd1pM65NAyqoWXjrA1NFxqpJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bjt3Wh4LjIIZXWR8ZGwH7mZKrdecZSqeRYnNe+eFiTiTMfCNtEJeOEEBeDAOFjDAYszfAI/djkbTV0+6UT+/kz7VDclxEBcwonDYTHuX7ArZrvr0+GfY0wWd/EbNzjEs/UqHP3fPWEAqqZEKpqS5tpPhP5e5EobFjSdAyCvu+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV9C1m9b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV9C1m9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB3FC2BCAF;
	Sun, 19 Apr 2026 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776615748;
	bh=uuX5wbb87BSHGqTmGCjd1pM65NAyqoWXjrA1NFxqpJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jV9C1m9bs18kahYDx4v7Z/3Q5BGZEeZu7w00Y3HNWUS1tfRSwXH2eH1iKi5/L6+t+
	 jtQfuspOHTdeESnvC3zjlQNwZepFkkbSo+8fsvfcvrH6hf0pdjV0VOZCY/RnmD4V+A
	 eeGA3DGqC/OINruJXRalsLXyTyWfEHp8VUcAQnBimeVWFlHTCXfLQIK4oOQi8BGacF
	 ncE3R0mJ2cDN6TIJY1Z2V0e0HQG7F28PJyW5BzsmtX0843+3HFzVNf5L/XYehoTHqF
	 XG2KfkhZxcmhYrR8oReRd/ZOdr5efFuno1AmwFBY/BIR52Xd+3B91SNJXHp6oUYy7h
	 Ehc6rJo6xyA9A==
Date: Sun, 19 Apr 2026 17:22:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] misc: Remove old APDS990x driver
Message-ID: <20260419172216.3cf10e51@jic23-huawei>
In-Reply-To: <CAPVz0n1qrSYr16zSSqRHuTWVkRfdC+c9w+mxAhtzgfHzL41XFw@mail.gmail.com>
References: <20260419083125.35572-1-clamor95@gmail.com>
	<20260419083125.35572-4-clamor95@gmail.com>
	<20260419143346.45ed78c2@jic23-huawei>
	<CAPVz0n1qrSYr16zSSqRHuTWVkRfdC+c9w+mxAhtzgfHzL41XFw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Apr 2026 16:41:24 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BD=D0=B4, 19 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16=
:33 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sun, 19 Apr 2026 11:31:24 +0300
> > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > =20
> > > The Avago APDS9900/9901 ALS/Proximity sensor is now supported by tsl2=
772
> > > IIO driver so there is no need to keep this old implementation. Remov=
e it.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  Documentation/misc-devices/apds990x.rst |  128 --- =20
> > Sashiko AI reviewing is now running on anything that hits linux-iio@vge=
r.kernel.org
> >
> > I'm slowly getting into the habit of checking out what it finds though
> > I'm 500+ emails behind so it might not be that thorough today :*
> >
> > Anyhow, it caught an easy one here.
> >
> > This file is referenced from Documentation/misc-devices/index.rst
> > so that needs an update as well.
> > =20
>=20
> Good catch, index was not updated, I will do so in v3.
>=20
> > There is the obvious point of ABI compatibility raised as well, but giv=
en
> > we don't seem to be getting much push back on that maybe that's not a s=
ignificant
> > concern. =20
>=20
> I did not found any ABI in the Documentation/ABI regarding this sensor
> using grep, maybe you are more familiar?
Doesn't matter if it's documented explicitly (many older drivers are not).
The question is whether anyone has supported parts and userspace code that
makes use of the sysfs files this driver provides.

Their userspace will be broken by dropping it.  The lack of upstream users
makes this less critical but it can be argued it's still a possible regress=
ion.

Jonathan

>=20
> >
> > Jonathan
> > =20
> > >  drivers/misc/Kconfig                    |   10 -
> > >  drivers/misc/Makefile                   |    1 -
> > >  drivers/misc/apds990x.c                 | 1284 ---------------------=
--
> > >  include/linux/platform_data/apds990x.h  |   65 --
> > >  5 files changed, 1488 deletions(-)
> > >  delete mode 100644 Documentation/misc-devices/apds990x.rst
> > >  delete mode 100644 drivers/misc/apds990x.c
> > >  delete mode 100644 include/linux/platform_data/apds990x.h =20

