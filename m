Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351FF3101D8;
	Sun, 20 Sep 2026 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789945975; cv=none; b=FQM2y0W20p0u1lMICvM0BK3UVNQt20HX2zoa3j3rYmaf22Au51fSYzpm2v7bXCjdSaTRzSZ4Ev9z9rQef61tI8e11VOjirvwKwA4lsY8+i6Z6U08KJG0meRTPezIihULIBCKzhm00ZHnHEpTqyE6tQblHs2I5655FbPfd3/ffWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789945975; c=relaxed/simple;
	bh=LCRUysfsapger5qII5haQW2fZlnZpz54C2CWKa90IYw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIH6/YirO9czbS4DhtRAh0VaJ8Y1TytbOsGwi678i9T6eeNv6FQwu0lIa8H/KE/2XvYoAc2aw517Asp2VSKAHLLz/Y729H2zyphFMi7dLdvYe01nqigvBNL9+SlA0izB2sFO8LHCs8IVwW4xl+TrBz62kMxJPO5yoaGAMAoVOS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvX7J3pp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvX7J3pp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F141F000FF;
	Sun, 20 Sep 2026 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789945973;
	bh=REvsamT6nFuEZGzPZG/booSz80KigYCuietwm5lGnLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PvX7J3ppy2kztjYCWp6K3twn1JRcqUHHgUID9p590ct/osRnbjYWPJws02dOJnxxY
	 NKlf7jJMOrDvqUfLbsOvCRU/3rQsnxQs4/rC3gDLArLajtUer9FYbf5S2XcOuQZXN0
	 vQ1miDJRmYnBAS4QkhQTt1CjbM6F++GyJd8H4ZThX0axOk8zoti+kPgeJXW++WRhNj
	 7QzkypwX1yX+LYUG0tCL1o1X7IDgcLzufZ0lxmoBB8WAC0s/nANkyeIlxwgGeqRM3d
	 6YYQMyVBh+Ckrxth0xhrUzLxr1rF8NoQtt8Hw3VI4jChBcwE5FMkMdq0Ez44DhsJUm
	 9KeJ+dXi9cCbg==
Date: Mon, 21 Sep 2026 00:12:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan	
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Radu Sabau	 <radu.sabau@analog.com>, Salih Erim
 <salih.erim@amd.com>, Jishnu Prakash	 <jishnu.prakash@oss.qualcomm.com>,
 Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
 linux@analog.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/6] iio: adc: ade9000: add ADE9430 support
Message-ID: <20260921001246.72cf14ab@jic23-hlaptop>
In-Reply-To: <9fc012985151b1b79b5d6e3f16738397ac9f837f.camel@gmail.com>
References: <20260918073537.1572-1-antoniu.miclaus@analog.com>
	<9fc012985151b1b79b5d6e3f16738397ac9f837f.camel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Sep 2026 16:27:30 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2026-09-18 at 10:35 +0300, Antoniu Miclaus wrote:
> > The ADE9430 is a polyphase energy metering device from the same family =
as
> > the ADE9000. It is register-compatible with the ADE9000 but omits the
> > on-chip dip/swell detection and has no on-chip digital integrator; it
> > relies on an external analog integrator for Rogowski coil current senso=
rs.
> >=20
> > This series adds ADE9430 support to the existing ade9000 driver, reusing
> > the dip/swell-less channel table introduced for the ADE9078 and adding a
> > matching chip_info for the ADE9430 full-scale codes. A precursor patch
> > gates the DICOEFF register write behind a has_digital_integrator chip_i=
nfo
> > flag so it is skipped on parts without an on-chip digital integrator.
> >=20
> > Patches 1 and 2 are standalone fixes carried with this series. Patch 1
> > corrects the ADE9000 full-scale RMS/PCF codes to the same family-A valu=
es
> > the ADE9430 uses. Patch 2 fixes the DIPC event never being handled or
> > cleared, found by the sashiko review of v1. Both carry Fixes: tags and =
can
> > be applied independently of the rest of the series.
> >=20
> > Changes in v2:
> > - new patch: fix the DIPC event never being handled or cleared, found by
> > =C2=A0 the sashiko review of v1 (patch 2).
> > - new precursor patch: gate the DICOEFF write behind a has_digital_inte=
grator
> > =C2=A0 chip_info flag, split out of the ADE9430 support patch.
> > - reuse ade9078_channels for the ADE9430 instead of adding a duplicate
> > =C2=A0 channel table.
> > - reword the documentation intro to "The supported parts are..." so it =
does
> > =C2=A0 not need updating for each new part.
> >=20
> > v1:
> > https://lore.kernel.org/linux-iio/20260907101623.8730-1-antoniu.miclaus=
@analog.com/
> >=20
> > Antoniu Miclaus (6):
> > =C2=A0 iio: adc: ade9000: fix ADE9000 full-scale RMS and PCF codes
> > =C2=A0 iio: adc: ade9000: fix DIPC event never being handled or cleared
> > =C2=A0 dt-bindings: iio: adc: adi,ade9000: add adi,ade9430 compatible
> > =C2=A0 iio: adc: ade9000: gate the DICOEFF write behind a chip_info flag
> > =C2=A0 iio: adc: ade9000: add support for ADE9430
> > =C2=A0 docs: iio: ade9000: document ADE9430 support
> >=20
> > =C2=A0.../bindings/iio/adc/adi,ade9000.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 22 ++++++-----
> > =C2=A0Documentation/iio/ade9000.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 36 +++++++++=
--------
> > =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0drivers/iio/adc/ade9000.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 39 ++++++++++++++++---
> > =C2=A04 files changed, 67 insertions(+), 31 deletions(-)
> >=20
> >=20
> > base-commit: edb91bc566576f6664a3efbad6bd4205aa1d5259 =20
>=20
> LGTM
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
LGTM2.  Just need to give some time for dt-binding reviewers to
take a look.

Thanks,

J
