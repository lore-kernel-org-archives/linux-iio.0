Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B32227BF93;
	Tue, 21 Apr 2026 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783696; cv=none; b=hgQ3bnQIfe7K3XIm4W4d5FGGYwADkRNc5uDSl/sFiF/bwT7LtJeph9U0rIVMHHk5pp2QY7irfO5EXsTa66HaADcy1ZQrOejpU9YR5BUR4UFHqz1lcDfLhLIoA4co0+/OF5URkI4jdujvKYwxYLvkW3xYC2qgQl9kAVrMKbxkBIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783696; c=relaxed/simple;
	bh=VQeRrmctsGVyMCLDdbIphZuXqI75VCWfyMmoEikg/Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdEG7rQSRCNzC3fby84e4WqBZyv4ewvdKImSPHABd20An6yKCPBkzz34sawojIk9KrHY4fROFii6SarHmFx1bCW6ABSiXZ0x5t48w3jUGT3Da4IaLLv2hGMTncsEYxz9CK1bsOjTKO7ucZnx+plMRuat7rGXkJyUCCYRtDuo2bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5oo9r2V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5oo9r2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA2DC2BCB0;
	Tue, 21 Apr 2026 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776783696;
	bh=VQeRrmctsGVyMCLDdbIphZuXqI75VCWfyMmoEikg/Ks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U5oo9r2VyYRhWGZYLUNQpJExG8UxFqop53AKrkILkrK3o0tbZDMzVG55Dbv4HN3vy
	 22jr3MeXjvZJ3zPjHfsAcgvvXCBxShiM4svCt0mWnVBKKf9oeQ8VwYd4Jeqe1mK1Sd
	 iLt+Nf0F+E5b+LXY2SQBj5H6UjXTmyYsQ4wEZWYm+PZ3AINOzU9f6EhxAU9pXta1/X
	 exfUe4lOCDlB9Mnxs6+VzG0A7woDdarZMUvDFdZARjhZgyPpTm5lmzVxFsbfNWnwi+
	 ZnjW0OIvq35RqCq11aMPe+KSpyErOY3/phIYtdt8zQt6Gb4jGqNrW6I+AAUqGKyWZn
	 WBFG5W4ljwNLg==
Date: Tue, 21 Apr 2026 16:01:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Ariana.Lazar@microchip.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <Conor.Dooley@microchip.com>, <Jonathan.Cameron@huawei.com>,
 <robh@kernel.org>, <linux-iio@vger.kernel.org>, <andy@kernel.org>,
 <krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
 <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: dac: mcp47feb02: Fix I2C address in
 example
Message-ID: <20260421160126.03a410f5@jic23-huawei>
In-Reply-To: <3b12b49f8dfa8bbdd4d19eed8718a2f10a294ecf.camel@microchip.com>
References: <20260420-mcp47feb02-fix6-v1-1-ae1808fea11d@microchip.com>
	<20260420132248.466cdc84@jic23-huawei>
	<3b12b49f8dfa8bbdd4d19eed8718a2f10a294ecf.camel@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Apr 2026 14:09:48 +0000
<Ariana.Lazar@microchip.com> wrote:

> Hello Jonathan,
>=20
> > > @@ -280,23 +280,23 @@ examples:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <=
1>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dac@0 {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =
=3D "microchip,mcp47feb02";
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdd-supply =
=3D <&vdac_vdd>;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vref-supply =
=3D <&vref_reg>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dac@60 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ompatible =3D "microchip,mcp47feb02"; =20
> > Why is this indent changing?
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eg =3D <0x60>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=
dd-supply =3D <&vdac_vdd>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=
ref-supply =3D <&vref_reg>;
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cell=
s =3D <1>;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =
=3D <0>;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel@0 {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eg =3D <0>;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
abel =3D "Adjustable_voltage_ch0";
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #=
address-cells =3D <1>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #=
size-cells =3D <0>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
hannel@0 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 label =3D "Adjustable_voltage_ch0";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel@1 {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eg =3D <0x1>;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
abel =3D "Adjustable_voltage_ch1";
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
hannel@1 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x1>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 label =3D "Adjustable_voltage_ch1";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > =C2=A0=C2=A0=C2=A0=C2=A0 };
> > > =C2=A0... =20
> >  =20
>=20
> Thank you for the review.
>=20
>    1. I updated the example indentation in order to use consistent 4-
>       space indentation, instead of mixing with 2-space as in the
>       previous version.
>=20
If that is needed, two patches.  One that makes the address fix, then
a follow up to fix the indentation with no functional changes.

thanks,

Jonathan

> Best regards,
> Ariana
>=20

