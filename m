Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD6242D6C;
	Fri, 17 Apr 2026 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776452858; cv=none; b=HKIH/G9auJYM9J1Xb8lMS4D+lRpn36XhiUr9UlN7TmUHWMBljrqsOYOshhsZRWMRqptP9cQeFyKC07bNb7zWZHvAX5K+z/MIKWmsZjNteZBxgBCHIp9iL++7IkEy2zfpYBhyX/McZENfWLHcTJxzVYd/2lu6GDrdjMJnQFQbizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776452858; c=relaxed/simple;
	bh=qAS0e48uAVyRkB1PEyF7MtvwBshJ2+J0XnQwyWlnmUE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhnGEDoDTLxLbTAo+UzSA1na9WvmiTBp5xAOkcMVRI7PUZdEuyWILcFaqtFXITbS2mjHf99T3L3wOxb/HZ5WkEa4kQ9axc3ybFCJHSBGKHGconJXBc5Gby/FkTdtCyVxID05NbxwdaKWznjl43cqIIEvqpmw36j4H7DjSMwOpL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vrajashkr.com; spf=pass smtp.mailfrom=vrajashkr.com; dkim=pass (2048-bit key) header.d=vrajashkr.com header.i=@vrajashkr.com header.b=US5xJZ4v; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vrajashkr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrajashkr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrajashkr.com header.i=@vrajashkr.com header.b="US5xJZ4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vrajashkr.com;
	s=protonmail3; t=1776452848; x=1776712048;
	bh=ReQYU+/EBwCXhXoTvP1t9mmtth4hJCVc+tkZ18BSp9w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=US5xJZ4vXTxQ8CpRxdWVr0CGa6DZ7iKxWmT3H0ftJp2Wdq6YHRRbcErqRTNRaCAwW
	 bPt0Kg5iEulYbj5xvDASlHD//m2/kxOoZhOj4KodipBNYrBqu9KSCLOOxasWDXDg9c
	 ATU6UXMTI7flD+ysHDKN/kKIxJPKL56EfttVJBkIH+j+aOpAlEKAp539me1m75o8gy
	 nayv2QSy1MoV566KpGdEzmEg7DsDWMH2JXVh1H815cQ8+g6eDFW9c9pME9sEZhXAYO
	 PIGEd3h0lbP6nPZAVq3XtAg+eVmDS5cV+JD/pN0BOyMSWt3ylDsuD+0TxD/AIcFIPA
	 G00KwhlZmISbg==
Date: Fri, 17 Apr 2026 19:07:25 +0000
To: Conor Dooley <conor@kernel.org>
From: Vishwas Rajashekar <vishwas.dev@vrajashkr.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, luca@lucaweiss.eu
Subject: Re: [PATCH v2] dt-bindings: iio: gyroscope: add mount-matrix for bmg160
Message-ID: <xt0iLerdioxyPfs9gFZaQbsip_uxDE-hplc8YGNA7BCet-ZT9B0U3Y3TNXZg3gScVK6avywf-3YDK5Psjud3iLqll12DafMyvovfFfUTWAA=@vrajashkr.com>
In-Reply-To: <20260416-level-unbitten-eb3bf8d4a6c7@spud>
References: <20260416-bmg160-mount-matrix-dt-binding-v2-1-e66cf5cff8e8@vrajashkr.com> <20260416-level-unbitten-eb3bf8d4a6c7@spud>
Feedback-ID: 192380685:user:proton
X-Pm-Message-ID: 1bcacc1de08cc8ee01a8e9ac340e5a6e253b51fc
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, April 16th, 2026 at 21:12, Conor Dooley <conor@kernel.org> wro=
te:

> On Thu, Apr 16, 2026 at 08:33:21PM +0530, Vishwas Rajashekar via B4 Relay=
 wrote:
> > From: Vishwas Rajashekar <vishwas.dev@vrajashkr.com>
> >=20
> > Adds mount-matrix as an optional property to dt-bindings
> > for the bmg160 gyroscope as the driver reads this optional
> > property during probe.
>=20
> Ultimately, what the driver does is not relevant here. All that matters
> is that the property is relevant to the hardware. Please come up with a
> commit message that avoids mentioning linux drivers and instead explains
> why it is relevant to the hardware.
>=20
> pw-bot: changes-requested
>=20
> Cheers,
> Conor.
>=20

Thank you for the feedback! I've updated the commit message in v3.

> >=20
> > Signed-off-by: Vishwas Rajashekar <vishwas.dev@vrajashkr.com>
> > ---
> > The bmg160 driver reads an optional mount-matrix using
> > "iio_read_mount_matrix" in "bmg160_core_probe" and stores
> > this orientation data in "struct bmg160_data". As the "mount-matrix"
> > property is used by the driver, this change proposes to add it to
> > the corresponding dt-bindings.
> > ---
> > Changes in v2:
> > - Addressed review feedback: add mount-matrix example for bmg160
> > - Link to v1: https://patch.msgid.link/20260415-bmg160-mount-matrix-dt-=
binding-v1-1-0e2c85964ee6@vrajashkr.com
> >=20
> > To: Jonathan Cameron <jic23@kernel.org>
> > To: David Lechner <dlechner@baylibre.com>
> > To: Nuno S=C3=A1 <nuno.sa@analog.com>
> > To: Andy Shevchenko <andy@kernel.org>
> > To: Rob Herring <robh@kernel.org>
> > To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > To: Conor Dooley <conor+dt@kernel.org>
> > To: "H. Nikolaus Schaller" <hns@goldelico.com>
> > Cc: linux-iio@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml | 6 =
++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg1=
60.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > index 3c6fe74af0b8..ec97778cca78 100644
> > --- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > +++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > @@ -22,6 +22,9 @@ properties:
> >    vdd-supply: true
> >    vddio-supply: true
> > =20
> > +  mount-matrix:
> > +    description: an optional 3x3 mounting rotation matrix.
> > +
> >    spi-max-frequency:
> >      maximum: 10000000
> > =20
> > @@ -52,6 +55,9 @@ examples:
> >              reg =3D <0x69>;
> >              interrupt-parent =3D <&gpio6>;
> >              interrupts =3D <18 IRQ_TYPE_EDGE_RISING>;
> > +            mount-matrix =3D "0", "1", "0",
> > +                           "1", "0", "0",
> > +                           "0", "0", "1";
> >          };
> >      };
> >  ...
> >=20
> > ---
> > base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
> > change-id: 20260414-bmg160-mount-matrix-dt-binding-e76ddde94866
> >=20
> > Best regards,
> > -- =20
> > Vishwas Rajashekar <vishwas.dev@vrajashkr.com>
> >=20
> >=20
>=20

Regards,
Vishwas
