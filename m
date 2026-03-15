Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698FB245014;
	Sun, 15 Mar 2026 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773601045; cv=none; b=rx4LSy8gq8YC6B3mk9X9akF2kw9wHL/UkQQGfcPh1F2lpsQBuYRnWPMrdz1MioRO54cVPw0SZiQbNdg/Fp2hYnu66NRpotLQHwvWlqg2mstTvH/bIb7qVnZQ1SYH4H+qm324B6gl28E0RmBswL+NW+uEVLdRvpg73p60A+t76g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773601045; c=relaxed/simple;
	bh=kZlk9tz7eb5Ii44ZV8HPl05j/xDd2gmkIgWgh6jXmiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQiKygoOBhrjRb2emeCRnQ/AvYC5kCgivLqWFxDXv5A4fMdk/SoaE+lXTuOGouAvLx3iK1P7aoSPR8vYFCtdT+bJ5iPEqEtsKLpAzC/zr4vqTtLuUNAK29uQNHOY49biv6Sph74wt5d6wTV7L87EjQD6wmFMHlxtHjSp6fox+OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBJFFQBn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBJFFQBn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E95C4CEF7;
	Sun, 15 Mar 2026 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773601045;
	bh=kZlk9tz7eb5Ii44ZV8HPl05j/xDd2gmkIgWgh6jXmiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rBJFFQBnY2m1wfqsn94Smf/51IdfIlmmujclu64JY2vMSi0hJkqYB2bcHyodjkwvr
	 T8k8IvFysT94sy5qSqfXazyp9z+9bbE9wV7oaMBlCVoXW8k4aoo3Vo+mXNQOu5Hw7O
	 R1aBFr2ecfbt9XYlWGPmf1cgtcmVCBd+G/cyYBItzOljXLydnVj6W20dWnwDxlGbFF
	 7s3kWc/54nd/LGUiewYzzq87rX1+HLea8Jl6Acggbe+ydrLfwSWW3dGkI89R5urPhN
	 4pWuYODscHVOiBtqBc+OexZTo26I60I8/9J83Nm6oa0ABwi6oZ4Gr6b6J7CSXb3XLq
	 gA/hbFf8Ovl4w==
Date: Sun, 15 Mar 2026 18:57:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sirat <email@sirat.me>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <20260315185715.2f97c496@jic23-huawei>
In-Reply-To: <CANn+LWK2OZ1dm0TAstM2hr6O6h2nEPRrNfje0mC3a2uc0HEwVQ@mail.gmail.com>
References: <20260311224044.21480-1-email@sirat.me>
	<abLNbGUmaA7K0s68@ashevche-desk.local>
	<CANn+LW+F2bVMAGwoF8q9yBpF3x5r_hWDqvE3_JYjcLd16A_cEA@mail.gmail.com>
	<a2486bc7-13be-4567-a53c-b37921df7bcd@baylibre.com>
	<CANn+LWK2OZ1dm0TAstM2hr6O6h2nEPRrNfje0mC3a2uc0HEwVQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Mar 2026 21:25:44 +0600
Sirat <email@sirat.me> wrote:

> On Sat, Mar 14, 2026 at 8:39=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > On 3/12/26 10:12 AM, Sirat wrote: =20
> > > On Thu, Mar 12, 2026 at 8:28=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote: =20
> > >>
> > >> On Thu, Mar 12, 2026 at 04:40:35AM +0600, Siratul Islam wrote: =20
> > > ... =20
> > >>> ---
> > >>> Changes in v3:
> > >>> - Merge DT binding into existing st,vl53l0x.yaml (per Krzysztof).
> > >>> - Use "reset-gpios" in the binding but xshut_gpio in the driver sin=
ce that's the actual pin name. =20
> > >> =20
> >
> > We can modify the existing binding to make the supply required based
> > on the compatible.
> >
> > allOf:
> >   # Technically supply is required to power device, but we keep it
> >   # optional for "st,vl53l0x" for backwards compatibility.
> >   - if:
> >       not:
> >         properties:
> >           compatible:
> >             const: "st,vl53l0x"
> >     then:
> >       required:
> >         vdd-supply
> >
> >
> > And we can add a description to reset-gpios to explain that it is actua=
lly the
> > XSHUT pin.
> > =20
> This will solve the problem, but I'm concerned about someone not
> following the commit history looking at the code.
> Logically, it doesn't make sense as both the devices require the
> supply. In fact it may give the impression that
> the vl53l0x explicitly doesn't need power. We are having to deal with
> too much just to save us from writing a new file.
>=20
> That said, I can still implement this if it's still the prefered way
> to solve our problem. Or leave it optional as it is.
> > =20
Can make it required in the binding. Just explain clearly why
it should be there.  The driver should carry on coping without
it though (and leave a comment so we don't break that in the future).

Jonathan

>=20

