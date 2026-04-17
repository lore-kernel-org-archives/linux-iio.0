Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005336CDEF;
	Fri, 17 Apr 2026 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776452382; cv=none; b=pmlltMgpeaNbr8YnPQihm0ameQ3pQ9oCc+UwTNklKyvCttw7dFwBMJrJI/qVfdQNHKyvqoGnYHmE6tD7vZGj4zvmNjvTS0yKuXTXi+vtFRWWyBFFdTXNU/5A0VChjgVFILOAat0z+A9OglqrMtVo2Atq0oUh2hUQZqxy/UrKKTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776452382; c=relaxed/simple;
	bh=roDvPkGwNg7gneNOLPFCzp72VO6WloJahO1P9TmGQmE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hwk3juTGa3tsvfpipg4E7FYp+BF3ZsGn86HKynfYyOci5InX5j6sUpkmfnbLbVZDBIz6Wn3MAUDUQfXSvkQnuOem0RVRHPvzX6b2Os6U+yH+P/6u2se0qKwxifhzhgmxLavtohKS1bwvkiZUtDPhgTKCjgSsgbtVGwVZsXpxnm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vrajashkr.com; spf=pass smtp.mailfrom=vrajashkr.com; dkim=pass (2048-bit key) header.d=vrajashkr.com header.i=@vrajashkr.com header.b=TNaWgoFW; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vrajashkr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrajashkr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrajashkr.com header.i=@vrajashkr.com header.b="TNaWgoFW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vrajashkr.com;
	s=protonmail3; t=1776452362; x=1776711562;
	bh=CqhGAA0pZs6bkhIXTKtF8tnCytLLkcetgcgJUCoZrAs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TNaWgoFWDTYGVmgedC9D04PETXaZjzIYJkq2YNe9E776EZ905V+TJBB00TTFpTNM8
	 jzuLWgzRNqyczN4Rw79BxVmPDc29IOO6eNgYO6xUgFAz9bT104qTB7FvYk6kmJHBqo
	 OylDEQnSjSqjCym+heTBYihL1y7AJcvCVz7L4debMvcGEuMlkMg59r8ncxhOOtKRed
	 Z3EOaJPWKH8gNhmXGrrJ86gBkDwVpi021CeOvI1DhkymhxshtjdkCGNAMaGaNmYCnS
	 T0aRjifwBP57AHlkLvRNZyHxnmGrPz3ZFXfdA3tcawE+KXsYlD/OZqIbOtorRb270u
	 9S3Z8qwqoRq5w==
Date: Fri, 17 Apr 2026 18:59:17 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>
From: Vishwas Rajashekar <vishwas.dev@vrajashkr.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, luca@lucaweiss.eu
Subject: Re: [PATCH] dt-bindings: iio: gyroscope: add mount-matrix for bmg160
Message-ID: <0CVTCE2tOyOjg65uqjNdRXnhcmvaAC79727Ofm72gNOekrf8AeQ1FGhOqMYM1gVaTDdd4md7CVXtbiS8d0IsrgLxYL-7nxM9mQmlm8E_kbw=@vrajashkr.com>
In-Reply-To: <20260416-warping-penguin-of-glory-41d59c@quoll>
References: <20260415-bmg160-mount-matrix-dt-binding-v1-1-0e2c85964ee6@vrajashkr.com> <20260416-warping-penguin-of-glory-41d59c@quoll>
Feedback-ID: 192380685:user:proton
X-Pm-Message-ID: 97b4f6092994f2253a1f594070f38c3f4a05986f
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, April 16th, 2026 at 16:19, Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:

> On Wed, Apr 15, 2026 at 09:13:40PM +0530, Vishwas Rajashekar wrote:
> > Adds mount-matrix as an optional property to dt-bindings
> > for the bmg160 gyroscope as the driver reads this optional
> > property during probe.
> >
> > Signed-off-by: Vishwas Rajashekar <vishwas.dev@vrajashkr.com>
> > ---
> > The bmg160 driver reads an optional mount-matrix using
> > "iio_read_mount_matrix" in "bmg160_core_probe" and stores
> > this orientation data in "struct bmg160_data". As the "mount-matrix"
> > property is used by the driver, this change proposes to add it to
> > the corresponding dt-bindings.
> > ---
> >  Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml | 3 =
+++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg1=
60.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > index 3c6fe74af0b8..ea8689660adf 100644
> > --- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > +++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > @@ -22,6 +22,9 @@ properties:
> >    vdd-supply: true
> >    vddio-supply: true
> >
> > +  mount-matrix:
> > +    description: an optional 3x3 mounting rotation matrix.
> > +
>=20
> Extend also example, please.
>=20
> Best regards,
> Krzysztof
>=20
>=20

Thank you for the feedback! I've extended the existing example in v2.

Regards,
Vishwas
