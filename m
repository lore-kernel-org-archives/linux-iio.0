Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0750C30E0C0;
	Wed, 22 Jul 2026 01:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683847; cv=none; b=Vq3pevUR91McRJnvSiC6kCetswU/uZPpVuQjFGK3vyjwTsd+I40mvv7PBN5cX3Fnc9e8fPCNMVaq4pDmakDwksv5h4NlRUM0t1RG+RclEmqxb442jqvc73F4xOPtTK2Wf1YiYUrjrOF63m2U/d2AwBPQ/Y5SJVy6gBraIEztNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683847; c=relaxed/simple;
	bh=c/hzX8VEjHDYGRzBBhQdUj1/4KmrnTqCIWBCgDnghPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ucs2Q2W/77fqut22pZK2rqQGrb6UQ9spiDvSvq/rD3GJ6ubuJXwFKx/4gKpGtQPNb217uZsI2TnbNkrkIYO1jK7Y7I/+oAQPqHNBY3sHHYvlRlujtmx9vEAPbIKFklYYGWwFs8jdgUYSjmaZQHgkHOKa7B4LYOPHsIQdh6LhDKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOyBVgs7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOyBVgs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AB41F000E9;
	Wed, 22 Jul 2026 01:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784683845;
	bh=uG4Kz4uliUZ5KVz+j/aepLp9XaY4xs8RaE90LkqBj5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OOyBVgs76bsXIjzqTECEkkcxjJTnlg052XBUnPuATmEhVkFxyHQhR1d04dOqAtIKg
	 vhxL1t6En1dmL9qgJ70naRI1hPQw//SKtdumrR30iBszJIPRNuSuESoYdV/pxGdkh+
	 u1VAj8PKIrhDyvB4Wz5FDHWyt+v220YFbMLXMhYyRaC30ec9YnwuCh9tLcii+/LThe
	 AHiHpuOs44EYiOkmSU6S0hWaZIKJ/jYBKTxPsvC44ef+LS0C8n3G74T2hrHsnRYNbA
	 96Y2dbOFG0lmuxRwEvlt5eYIQ4fPC4G/e1C44ZL1Ws7GM0ehxw0SUOeBz+q1YfLQF4
	 1R7+3mPqUE0ow==
Date: Wed, 22 Jul 2026 02:30:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Lee Jones <lee@kernel.org>, Daniel
 Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Pavel
 Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Helge Deller
 <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 08/14] mfd: lm3533: Convert to use OF bindings
Message-ID: <20260722023037.776f4bcb@jic23-huawei>
In-Reply-To: <CAPVz0n2trouADTziWXnpt=-hwKdsZWGQib+-nVCLaSLibTbATg@mail.gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
	<20260617080031.99156-9-clamor95@gmail.com>
	<akeXAOpb13hupUGM@hovoldconsulting.com>
	<CAPVz0n2trouADTziWXnpt=-hwKdsZWGQib+-nVCLaSLibTbATg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Jul 2026 16:57:01 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 14:03 Joh=
an Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Jun 17, 2026 at 11:00:25AM +0300, Svyatoslav Ryhel wrote: =20
> > > Since there are no users of this driver via platform data, remove the
> > > platform data support and switch to using Device Tree bindings.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for bac=
klight
> > >       indio_dev->name =3D dev_name(&pdev->dev);
> > > -     iio_device_set_parent(indio_dev, pdev->dev.parent); =20
> >
> > Why are you reparenting the iio device here?
> > =20
>=20
> Because every cell has its own binding now and using phandle to parent
> when device has its own node is not a good practice.

It is however a good point.  So should at very least the ABI break should
be called out in the patch description with a brief mention of what the
path change actually is.

>=20
> > That's an ABI break.
> > =20
>=20
> This driver does not have any active users in the kernel and no
> activity for more then 2 years.

...

> > > +     u32 count =3D 0, reg, nchilds; =20
> >
> > Don't mix multiple declarations with initialisation like this.
> > =20
>=20
> Checkpatch does not complain on style issue, hence this is not prohibited.

Prohibition vs taste.  I fully agree with John on this one!  Those mixes are
messy and hard to read.

Checkpatch is a helpful tool but there are both rules and preferred style t=
hings
it does not catch.

Jonathan

>=20
> > >       int ret;
> > >
